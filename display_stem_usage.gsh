grouperSession = GrouperSession.startRootSession();


stem = StemFinder.findByName(grouperSession,
                              "path:to:tree:to:remove:empty:groups"
                             );

children = stem.getChildGroups(Stem.Scope.SUB);

System.out.println( "Recursing under: " + stem.name + " (" + children.size() + " groups)");

i = 0;

for(child in children) {
    i++;

    if ( i % 100 == 0) {
        System.out.println( i );
    }

    // group = GroupFinder.findByName(grouperSession, child.getName(), true);
    subject = child.toSubject();
    containers = 
        new MembershipFinder().addSubject(subject).findMembershipResult().getMembershipSubjectContainers()
    ;
    if ( containers.size() > 0 ) {
        System.out.println(child.getName() + " used " + containers.size() +
                           " times.  Used in:" );
    }
    for (
         edu.internet2.middleware.grouper.membership.MembershipSubjectContainer membershipSubjectContainer : containers
         ) {
            System.out.println( "  " + membershipSubjectContainer.getGroupOwner().getName());
    }
}
