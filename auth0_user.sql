create user auth0 with password '<password>';
grant connect on database modernlogic to auth0;
grant select, update on users to auth0;
