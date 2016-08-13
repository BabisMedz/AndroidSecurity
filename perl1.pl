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
foreach my $file (@files) {

	$table_startActivities=$app_name."_StartingActivities";
	$table_startServices=$app_name."_StartingSevices";
	$table_sendingBroadcasts=$app_name."_SendingBroadcasts";
	$table_receivingBroadcasts=$app_name."_ReceivingBroadcasts";
	$table_DisallowedBroadcasts=$app_name."_DisallowedBroadcasts";
	$table_ContentProvider=$app_name."_ContentProviders";
	$table_startActivitiesVector=$app_name."_StartingActivitiesVector";
	$table_startServicesVector=$app_name."_StartingServicesVector";
	$table_sendingBroadcastsVector=$app_name."_SendingBroadcastsVector";
	$table_receivingBroadcastsVector=$app_name."_ReceivingBroadcastsVector";
	$table_DisallowedBroadcastsVector=$app_name."_DisallowedBroadcastsVector";
	$table_ContentProviderVector=$app_name."_ContentProvidersVector";

#pinakas me ta permission gia ta activities
        if (does_table_exist($dbh, $table_startActivities)) {
		print "table $table_startActivities exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/startingActivitiesv2.txt' INTO TABLE $table_startActivities";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_startActivities (permissionName VARCHAR(600) NOT NULL KEY)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/startingActivitiesv2.txt' INTO TABLE $table_startActivities";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}
	

	   
	#pinakas me ta permission gia ta services
	 if (does_table_exist($dbh, $table_startServices)) {
		print "table $table_startServices exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/startingServicesv2.txt' INTO TABLE $table_startServices";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_startServices (permissionName VARCHAR(600) NOT NULL KEY)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/startingServicesv2.txt' INTO TABLE $table_startServices";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}
	
	#pinakas me ta permission gia ta sending Broadcasts
	if (does_table_exist($dbh, $table_sendingBroadcasts)) {
		print "table $table_sendingBroadcasts exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/sendingBroadcastsv2.txt' INTO TABLE $table_sendingBroadcasts";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_sendingBroadcasts (permissionName VARCHAR(600) NOT NULL KEY)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/sendingBroadcastsv2.txt' INTO TABLE $table_sendingBroadcasts";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}

	#pinakas me ta permission gia ta receiving Broadcasts
	if (does_table_exist($dbh, $table_receivingBroadcasts)) {
		print "table $table_receivingBroadcasts exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/receivingBroadcastsv2.txt' INTO TABLE $table_receivingBroadcasts";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_receivingBroadcasts (permissionName VARCHAR(600) NOT NULL KEY)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/receivingBroadcastsv2.txt' INTO TABLE $table_receivingBroadcasts";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}
	
	#pinakas me ta permission gia ta disallowed permission
	
        if (does_table_exist($dbh, $table_DisallowedBroadcasts)) {
		print "table $table_DisallowedBroadcasts exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/DisallowedBroadcastsv2.txt' INTO TABLE $table_DisallowedBroadcasts";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_DisallowedBroadcasts (permissionName VARCHAR(600) NOT NULL KEY)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/DisallowedBroadcastsv2.txt' INTO TABLE $table_DisallowedBroadcasts";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}

	#pinakas me ta permission gia ta content provider
	if (does_table_exist($dbh, $table_ContentProvider)) {
		print "table $table_ContentProvider exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/contentProvidersv2.txt' INTO TABLE $table_ContentProvider";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_ContentProvider (permissionName VARCHAR(600) NOT NULL KEY)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/permissionElements/contentProvidersv2.txt' INTO TABLE $table_ContentProvider";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}
	 
	#pinakas vector me ta permission gia ta activities
        if (does_table_exist($dbh, $table_startActivitiesVector)) {
		print "table $table_startActivities exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_startActivitiesVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_startActivitiesVector (permName VARCHAR(400) NOT NULL PRIMARY KEY, used INT DEFAULT 0)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_startActivitiesVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}

	#pinakas vector me ta permission gia ta services
        if (does_table_exist($dbh, $table_startServicesVector)) {
		print "table $table_startServicesVector exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_startServicesVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_startServicesVector (permName VARCHAR(400) NOT NULL PRIMARY KEY, used INT DEFAULT 0)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_startServicesVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}

	#pinakas vector me ta permission gia ta sending Broacasts
        if (does_table_exist($dbh, $table_sendingBroadcastsVector)) {
		print "table $table_sendingBroadcastsVector exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_sendingBroadcastsVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_sendingBroadcastsVector (permName VARCHAR(400) NOT NULL PRIMARY KEY, used INT DEFAULT 0)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_sendingBroadcastsVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}
	

	#pinakas vector me ta permission gia ta receiving Broacasts
	if (does_table_exist($dbh, $table_receivingBroadcastsVector)) {
		print "table $table_receivingBroadcastsVector exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_receivingBroadcastsVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_receivingBroadcastsVector (permName VARCHAR(400) NOT NULL PRIMARY KEY, used INT DEFAULT 0)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_receivingBroadcastsVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}
	 
	
	#pinakas vector me ta permission gia ta disallowed Broacasts
	if (does_table_exist($dbh, $table_DisallowedBroadcastsVector)) {
		print "table $table_DisallowedBroadcastsVector exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_DisallowedBroadcastsVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_DisallowedBroadcastsVector (permName VARCHAR(400) NOT NULL PRIMARY KEY, used INT DEFAULT 0)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_DisallowedBroadcastsVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}

	#pinakas vector me ta permission gia ta content Providers
	if (does_table_exist($dbh, $table_ContentProviderVector)) {
		print "table $table_ContentProviderVector exists!\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_ContentProviderVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";

	}else {
		$sql_create_table_instr = "create table $table_ContentProviderVector (permName VARCHAR(400) NOT NULL PRIMARY KEY, used INT DEFAULT 0)";
		$sth = $dbh->prepare($sql_create_table_instr);
		$sth->execute or die "SQL Error: $DBI::errstr\n";
		$load_instr = "LOAD DATA LOCAL INFILE '~/Έγγραφα/Διπλωματική/perlScript/ΑΡΙ-permissionΓενικάΠουΥπάρχουν/APICalls2.txt' INTO TABLE $table_ContentProviderVector";
 		#$dbh->do($load_instr) or die "SQL Error: $DBI::errstr\n"; 
		#exit;
 		$sth = $dbh->prepare($load_instr);
 		$sth->execute or die "SQL Error: $DBI::errstr\n";
	}
	

 

	

        $updateQuery="UPDATE $table_startActivities, $table_startActivitiesVector SET $table_startActivitiesVector.used=1 WHERE $table_startActivities.permissionName=$table_startActivitiesVector.permName";
	$sth = $dbh->prepare($updateQuery);
  	$sth->execute or die "SQL Error: $DBI::errstr\n";

	$updateQuery="UPDATE $table_startServices, $table_startServicesVector SET $table_startServicesVector.used=1 WHERE $table_startServices.permissionName=$table_startServicesVector.permName";
	$sth = $dbh->prepare($updateQuery);
  	$sth->execute or die "SQL Error: $DBI::errstr\n";
	
	$updateQuery="UPDATE $table_sendingBroadcasts, $table_sendingBroadcastsVector SET $table_sendingBroadcastsVector.used=1 WHERE $table_sendingBroadcasts.permissionName=$table_sendingBroadcastsVector.permName";
	$sth = $dbh->prepare($updateQuery);
  	$sth->execute or die "SQL Error: $DBI::errstr\n";
	
	$updateQuery="UPDATE $table_receivingBroadcasts, $table_receivingBroadcastsVector SET $table_receivingBroadcastsVector.used=1 WHERE $table_receivingBroadcasts.permissionName=$table_receivingBroadcastsVector.permName";
	$sth = $dbh->prepare($updateQuery);
  	$sth->execute or die "SQL Error: $DBI::errstr\n";

	$updateQuery="UPDATE $table_DisallowedBroadcasts, $table_DisallowedBroadcastsVector SET $table_DisallowedBroadcastsVector.used=1 WHERE $table_DisallowedBroadcasts.permissionName=$table_DisallowedBroadcastsVector.permName";
	$sth = $dbh->prepare($updateQuery);
  	$sth->execute or die "SQL Error: $DBI::errstr\n";

	$updateQuery="UPDATE $table_ContentProvider, $table_ContentProviderVector SET $table_ContentProviderVector.used=1 WHERE $table_ContentProvider.permissionName=$table_ContentProviderVector.permName";
	$sth = $dbh->prepare($updateQuery);
  	$sth->execute or die "SQL Error: $DBI::errstr\n";




}
