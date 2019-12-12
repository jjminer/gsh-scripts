DRY_RUN = 1;

grouperSession = GrouperSession.startRootSession();


stem = StemFinder.findByName(grouperSession,
                              "path:to:tree:to:remove:empty:groups"

                            );

children = stem.getChildGroups(Stem.Scope.SUB);
num_children = children.size();
num_hours = 12;
min_sleep_secs = 10;

available_seconds = num_hours * 60 * 60;

sleep_iteration = available_seconds.intdiv(num_children);
System.out.println( "Sleep time: " + sleep_iteration );
if ( sleep_iteration < min_sleep_secs ) {
    sleep_iteration = min_sleep_secs;
    System.out.println( "Less than minimum, updating to " + min_sleep_secs );
}

System.out.println( "Recursing under: " + stem.name + " (" + children.size() + " groups)");

i = 0;

for(child in children) {
    i++;

    if ( i % 100 == 0) {
        System.out.println( i );
    }

    subject = child.toSubject();
    containers = 
        new MembershipFinder().addSubject(subject).findMembershipResult().getMembershipSubjectContainers()
    ;
    if ( containers.size() > 0 ) {
        System.out.println("*** SKIPPED DELETE *** " + child.getName() + " used " + containers.size() +
                           " times.  Used in:" );
        for (
             edu.internet2.middleware.grouper.membership.MembershipSubjectContainer membershipSubjectContainer : containers
            ) {
            System.out.println( "                     " + membershipSubjectContainer.getGroupOwner().getName());
        }

    }
    else {
        System.out.println( "Deleting " + child.getName() );
        if ( DRY_RUN == 0 ) {
            // System.out.println( "  ** FOR REALS ** " );
            child.delete()
        }
        else {
            System.out.println( "  ** DRY RUN ** " );
        }

        sleep( sleep_iteration * 1000 ); // Translate seconds to ms
    }
}
