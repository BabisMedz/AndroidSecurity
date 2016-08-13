#!/usr/bin/perl 
 use DBI;
 use File::Basename;
 use File::Copy qw(move);

$dbh = DBI->connect('dbi:mysql:mobileapps;mysql_local_infile=1','root','νοοβ')
 or die "Connection Error: $DBI::errstr\n";

@files=</home/babis/apks/*>;
sub does_table_exist {
    my ($db_handle, $table_name) = @_;
    my $query_handle = $db_handle->prepare("DESC $table_name");
    $query_handle->{RaiseError} = 0;
    $query_handle->{PrintError} = 0;
    return $query_handle->execute();
}


foreach $file (@files) {
	$file=~ s/.*\///;
	$file=~ s/\.[^.]+$//;
	$file=~ tr/./_/;

	$app_name= $file;


	

	$table_permissions= $app_name . "_permissions\n";   
	$table_permissionVector= $app_name . "_permissionVector\n";
	$filename=$file."_permissionF";

        $table_appAPIs=$app_name. "_APIs\n";
        $table_APIsVector=$app_name . "_APIsVector\n";
	

	

        #pinakas me ta permission ths efarmoghs
        
        if (does_table_exist($dbh, $table_permissions)) {
		print "table $table_permissions exists!\n";
		$load_permissions = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/diassemplyManifestScript/permission/$filename.txt' INTO TABLE $table_permissions";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_permissions);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_permissions = "create table $table_permissions (Permissions VARCHAR(600) NOT NULL KEY)";
		$sth = $dbh->prepare($sql_create_table_permissions);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_permissions = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/diassemplyManifestScript/permission/$filename.txt' INTO TABLE $table_permissions";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_permissions);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}


        #pinakas- dianysma gia thn kathe efarmogh me bash ta permission

	if (does_table_exist($dbh, $table_permissionVector)) {
		print "table $table_permissionVector exists!\n";
		$load_permissionVector = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/διάνυσμαΚάθεΕφαρμογής/new_21-android-v2' INTO TABLE $table_permissionVector";
		$sth = $dbh->prepare($load_permissionVector);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		#exit;
	}else {
		$sql_create_table_permissionVector = "CREATE TABLE $table_permissionVector (permissionName VARCHAR(400) NOT NULL PRIMARY KEY, value INT DEFAULT 0)";
		$sth = $dbh->prepare($sql_create_table_permissionVector);
  		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_permissionVector = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/διάνυσμαΚάθεΕφαρμογής/new_21-android-v2' INTO TABLE $table_permissionVector";
		$sth = $dbh->prepare($load_permissionVector);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		#exit;
	}
  
         #elegxw an poia apo ta permission yparxoyn sthn efarmogh kai allazw to dianysma antistoixa
 
	$updatePermissionVector="UPDATE $table_permissions, $table_permissionVector SET $table_permissionVector.value=1 WHERE $table_permissions.Permissions= $table_permissionVector.permissionName";
	$sth = $dbh->prepare($updatePermissionVector);
  	$sth->execute or die "SQL Error: $DBI::errstr\n";

	#pinakas me ta API's ths efarmoghs
        
        if (does_table_exist($dbh, $table_appAPIs)) {
		print "table $table_appAPIs exists!\n";
		$load_appAPIs = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/diassemplyManifestScript/smali-analysis-names-$file.txt' INTO TABLE $table_appAPIs";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_appAPIs);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_appAPIs= "create table $table_appAPIs (ApiName VARCHAR(600) NOT NULL KEY)";
		$sth = $dbh->prepare($sql_create_table_appAPIs);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_appAPIs = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/diassemplyManifestScript/smali-analysis-names-$file.txt' INTO TABLE $table_appAPIs";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_appAPIs);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}

        #pinakas- dianysma gia thn kathe efarmogh me bash ta APIs

	if (does_table_exist($dbh, $table_APIsVector)) {
		print "table $table_APIsVector exists!\n";
		$load_APIsVector = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/GeneralListOfAPIs.txt' INTO TABLE $table_APIsVector";
		$sth = $dbh->prepare($load_APIsVector);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		#exit;
	}else {
		$sql_create_table_APIsVector = "CREATE TABLE $table_APIsVector (ApiName VARCHAR(400) NOT NULL PRIMARY KEY, value INT DEFAULT 0)";
		$sth = $dbh->prepare($sql_create_table_APIsVector);
  		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_APIsVector = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/GeneralListOfAPIs.txt' INTO TABLE $table_APIsVector";
		$sth = $dbh->prepare($load_APIsVector);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		#exit;
	}
         
         #elegxw an poia apo ta APIs yparxoyn sthn efarmogh kai allazw to dianysma antistoixa
 
	$updateAPIsVector="UPDATE $table_appAPIs, $table_APIsVector SET $table_APIsVector.value=1 WHERE $table_APIsVector.ApiName=$table_appAPIs.ApiName";
	$sth = $dbh->prepare($updateAPIsVector);
  	$sth->execute or die "SQL Error: $DBI::errstr\n";

        
}
