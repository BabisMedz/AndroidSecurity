#!/usr/bin/perl -w
 use DBI;
 $dbh = DBI->connect('dbi:mysql:mobileapps;mysql_local_infile=1','root','νοοβ')
 or die "Connection Error: $DBI::errstr\n";



$num_args = $#ARGV + 1;
if ($num_args != 1) {
  print "\nUsage: db.pl application-name\n";
  exit;
}

$app_name=$ARGV[0];
#print $app_name;
$file_instr_static = "$app_name.output-static.txt";
$file_manif = "$app_name.manifest.txt";
#file_manif.$app


$table_instr= $app_name . "Static";
$table_manif= $app_name . "Manifest";
$table_view = $app_name . "ViewStatic";


 
#I should also create the table
$sql_create_table_instr = "create table $table_instr (apiName VARCHAR(600) NOT NULL PRIMARY KEY)";

$sth = $dbh->prepare($sql_create_table_instr);
$sth->execute or die "SQL Error: $DBI::errstr\n";

$load_instr = "LOAD DATA LOCAL INFILE '$file_instr_static' INTO TABLE $table_instr FIELDS TERMINATED BY \' \' LINES TERMINATED BY '\n' (apiName)";

 #$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
 #exit;

 $sth = $dbh->prepare($load_instr);
 $sth->execute
 or die "SQL Error: $DBI::errstr\n";

$sql_create_table_manif = "create table $table_manif (permName VARCHAR(400) NOT NULL PRIMARY KEY, used INT DEFAULT 0)";
$sth = $dbh->prepare($sql_create_table_manif);
  $sth->execute
 or die "SQL Error: $DBI::errstr\n";

$load_manifest = "LOAD DATA LOCAL INFILE '$file_manif' INTO TABLE $table_manif FIELDS TERMINATED BY ' ' LINES TERMINATED BY '\n' (permName)";

$sth = $dbh->prepare($load_manifest);
$sth->execute or die "SQL Error: $DBI::errstr\n";

#exit;

$mapquery= "select $table_instr.apiName, permissionMap.permission from $table_instr,permissionMap where $table_instr.apiName=permissionMap.API and permission!=''";

$sth = $dbh->prepare($mapquery);
$sth->execute or die "SQL Error: $DBI::errstr\n";

 #I should make some kind of processing  
 #$outputtmp = 
 open (MYFILE, '>'.$app_name.'.static-mapping.txt');
 
 print "Static Analysis Against the Map of Stowaway\n";
 
 while (@row = $sth->fetchrow_array) {
	print "@row\n";	
	print MYFILE "@row\n";
	# print "@row\n";
	 #print "first  field:" .  $row[0] . "\n"; #method
	 #print "second field:" .  $row[1] . "\n"; #permission
	 #$permission = $row[1];
	# i need to make an update statement
	#$updatestmt = "UPDATE $table_manif SET used='1' where $table_manif.permName='$permission'";
	#print $updatestmt;
	#$sth2 = $dbh->prepare($updatestmt);
	#sth2->execute or die "SQL Error: $DBI::errstr\n";
	#grep? I should identify if in the manifest exist this permission at the end I should have identify
 	# if any of the permission is unmarked this will means that there are permission that are not used...
	#xrisimopoiwntas ta permission tha mporousame na kanoume ena query 
 } 
 close(MYFILE);

 #$final = "select * from $table_manif where used='0'";
 #$sth = $dbh->prepare($final);
 #$sth->execute or die "SQL Error: $DBI::errstr\n";
 #open (MYFILE, '>overprivileged.txt');
 #print "Permissions do not used:\n";
 #while (@row = $sth->fetchrow_array) {
#	print "@row\n";	
#	print MYFILE "@row\n";
# }
#close (MYFILE);

#print "Creating the view\n";


$permSQL="create view $table_view as select $table_instr.apiName, permissionMap.permission from $table_instr,permissionMap where $table_instr.apiName=permissionMap.API and permission!=''";

#print $permSQL; 

$sth = $dbh->prepare($permSQL);
$sth->execute or die "SQL Error: $DBI::errstr\n";

open (MYFILE, '>'.$app_name.'.permissionMap-static.txt');

print "Permission Mapping\n";

$permSQL="select $table_instr.apiName, permissionMap.permission from $table_instr,permissionMap 
where $table_instr.apiName=permissionMap.API and permission!=''";

$sth = $dbh->prepare($permSQL);
$sth->execute or die "SQL Error: $DBI::errstr\n";
 
while (@row = $sth->fetchrow_array) {
	print "@row\n";	
	
print MYFILE "@row\n";
}
close (MYFILE);

#print "Undeclared permission\n";

#proopen (MYFILE, '>undeclared.txt');

#$undeclaredPerm = "select * from  $table_view where EXISTS (select * from $table_manif where $table_view.permission=$table_manif.permName";
#, 
# where EXIST (select * from $table_manif, where $table_view.permission=$table_manif.permName";

#$undeclaredPerm = "select * from  $table_view where permission not in (select $table_manif.permName from $table_manif)";

#$sth = $dbh->prepare($undeclaredPerm);
#$sth->execute or die "SQL Error: $DBI::errstr\n";

#while (@row = $sth->fetchrow_array) {
#	print "@row\n";
#	print MYFILE "@row\n";
#}

#close (MYFILE);

#print "Declared permission\n";
#$declaredPerm = "select * from  $table_view where permission  in (select $table_manif.permName from $table_manif)";
$declaredPerm = "select $table_view.apiName, $table_view.permission from  $table_view, $table_manif where $table_view.permission=$table_manif.permName"; 
 $sth = $dbh->prepare($declaredPerm);
 $sth->execute or die "SQL Error: $DBI::errstr\n";
 
print "Static Final Analysis (Declared)\n";

open (MYFILE, '>'.$app_name.'.static-final-analysis.txt');


while (@row = $sth->fetchrow_array) {
	print "@row\n";
	print MYFILE "@row\n";
}

close(MYFILE);


#$undeclaredPerm = "select * from  $table_view where EXISTS (select * from $table_manif where $table_view.permission=$table_manif.permName";
#, 
# where EXIST (select * from $table_manif, where $table_view.permission=$table_manif.permName";

$unusedApis = "select $table_view.apiName, $table_view.permission from $table_view where $table_view.permission not in (select $table_manif.permName from $table_manif)";
#$unusedPerm = "select * from $table_view where $table_view.permission not in (select $table_manif.permName from $table_manif)";

$sth = $dbh->prepare($unusedApis);
$sth->execute or die "SQL Error: $DBI::errstr\n";

#open (MYFILE, '>api-without-permission-in-manifest.'.$app_name.'.txt');
open (MYFILE, '>'.$app_name.'api-without-permission-in-manifest.txt');

print "APIs without permissions\n";

while (@row = $sth->fetchrow_array) {
	print "@row\n";
	print MYFILE "@row\n";
}

close (MYFILE);

open (MYFILE, '>'.$app_name.'.unused-permissions-static.txt');

print "Unused Permissions\n" ;

#$unusedApis = "select $table_view.apiName, $table_view.permission from $table_view where $table_view.permission not in (select $table_manif.permName from $table_manif)";
$unusedPerm="select permName from  $table_manif where permName not in (select  $table_view.permission from  $table_view)";
$sth = $dbh->prepare($unusedPerm);
$sth->execute or die "SQL Error: $DBI::errstr\n";



while (@row = $sth->fetchrow_array) {
	print "@row\n";
	print MYFILE "@row\n";
}


 $drop1 = "drop table $table_instr";
 $drop2 = "drop table $table_manif";
 $drop3 = "drop view  $table_view";

 $sth = $dbh->prepare( $drop1);
 $sth->execute or die "SQL Error: $DBI::errstr\n";

 $sth = $dbh->prepare( $drop2);
 $sth->execute or die "SQL Error: $DBI::errstr\n";

 $sth = $dbh->prepare( $drop3);
 $sth->execute or die "SQL Error: $DBI::errstr\n";

