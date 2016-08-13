#!/usr/bin/perl 
 use DBI;
 use File::Basename;

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
sub log10 {
  my $n = shift;
  return log($n)/log(10);
}
$table_App_score_Permissions="Apps_score_Permissions";
if (does_table_exist($dbh, $table_App_score_Permissions)) {
		print "table $table_App_score_Permissions exists!\n";
		

}else {
		$sql_create_table_Permissions_score = "CREATE TABLE $table_App_score_Permissions (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,App_Name VARCHAR(400) , Score double)";
		$sth = $dbh->prepare($sql_create_table_Permissions_score);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
}
$table_App_score_APIs="Apps_score_APIs";
if (does_table_exist($dbh, $table_App_score_APIs)) {
		print "table $table_App_score_APIs exists!\n";
		

}else {
		$sql_create_table_APIs_score = "CREATE TABLE $table_App_score_APIs (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,App_Name VARCHAR(400) , Score double)";
		$sth = $dbh->prepare($sql_create_table_APIs_score);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
}

$table_App_score_Total="Apps_score_Total";
if (does_table_exist($dbh, $table_App_score_Total)) {
		print "table $table_App_score_Total exists!\n";
		

}else {
		$sql_create_table_score_Total = "CREATE TABLE $table_App_score_Total (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,App_Name VARCHAR(400) , Score double)";
		$sth = $dbh->prepare($sql_create_table_score_Total);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
}

foreach my $file (@files) {
	$file=~ s/.*\///;
	$file=~ s/\.[^.]+$//;
	$file=~ tr/./_/;
	$file=~ tr/ /_/;
        $app_name= $file;
        $table_permission_Vector= $app_name . "_permissionVector\n";
 	$table_APIs_Vector=$app_name . "_APIsVector\n";




	my $sth = $dbh->prepare("SELECT COUNT(*),SUM(value)FROM $table_permission_Vector");
	$sth->execute or die "SQL Error: $DBI::errstr\n";

	while(my @name = $sth->fetchrow_array){
		$num_Rows_Permissions=$name[0];
		$sum_Ones_Permissions=$name[1];


	}
        my $sth = $dbh->prepare("SELECT COUNT(*),SUM(value)FROM $table_APIs_Vector");
	$sth->execute or die "SQL Error: $DBI::errstr\n";

	while(my @name = $sth->fetchrow_array){
		$num_Rows_APIs=$name[0];
		$sum_Ones_APIs=$name[1];


	}
         
		
#	while (@row = $sth->fetchrow_array) {  # retrieve one row
#   		print join(", ", @row), "\n";
#
#
#	}
#	$ref=$sth->fetchall_array_ref;
#	print $ref;
	my $sum_Permissions=0;
	my $propability_Permissions=1/$num_Rows_Permissions;

	for my $i (0..$sum_Ones_Permissions-1){
				
		$sum_Permissions+=-$propability_Permissions*log10($propability_Permissions);

	}
			print "\n$file\t$sum_Permissions\n";


        my $sum_APIs=0;
	my $propability_APIs=1/$num_Rows_APIs;

	for my $i (0..$sum_Ones_APIs-1){
				
		$sum_APIs+=-$propability_APIs*log10($propability_APIs);

	}
			print "\n$file\t$sum_APIs\n";


        $sum_Total=$sum_Permissions + $sum_APIs;

	
	print "\n$file\t$sum_Total\n";


	my $sth = $dbh->prepare("INSERT INTO $table_App_score_Permissions(App_Name, Score) VALUES ('$app_name', '$sum_Permissions')");
	$sth->execute or die "SQL Error: $DBI::errstr\n";

        my $sth = $dbh->prepare("INSERT INTO $table_App_score_APIs(App_Name, Score) VALUES ('$app_name', '$sum_APIs')");
	$sth->execute or die "SQL Error: $DBI::errstr\n";

	 my $sth = $dbh->prepare("INSERT INTO $table_App_score_Total(App_Name, Score) VALUES ('$app_name', '$sum_Total')");
	$sth->execute or die "SQL Error: $DBI::errstr\n";
	
	#my $sth = $dbh->prepare("SELECT App_Name, Score FROM $table_App_score ORDER BY Score DESC");
	#$sth->execute or die "SQL Error: $DBI::errstr\n";
	

}



