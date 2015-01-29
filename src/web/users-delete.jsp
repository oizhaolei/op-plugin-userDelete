<%@ page import="org.jivesoftware.util.ParamUtils,
				 org.jivesoftware.util.TaskEngine,
				 org.jivesoftware.openfire.XMPPServer,
				 org.tttalk.openfire.plugin.UserDeletePlugin"
%>

<html>
    <head>
        <title>Quick Users Delete</title>
        <meta name="pageID" content="users-delete"/>
    </head>
    <body>

<%
    final String usernames = ParamUtils.getParameter(request, "usernames");

    boolean running = false;

    if (usernames != null) {

        final UserDeletePlugin plugin =
                (UserDeletePlugin) XMPPServer.getInstance().getPluginManager().getPlugin("tttalk.userdelete");
        TaskEngine.getInstance().submit(new Runnable() {
            public void run() {
                plugin.deleteUsers(usernames);
            }
        });
        running = true;
    }
%>

<%  if (running) { %>

    <div class="jive-success">
    <table cellpadding="0" cellspacing="0" border="0">
    <tbody>
        <tr><td class="jive-icon"><img src="/images/success-16x16.gif" width="16" height="16" border="0"></td>
        <td class="jive-icon-label">
        Users being deleted in background. Check the stdout for more information.
        </td></tr>
    </tbody>
    </table>
    </div><br>

<%  } %>

<form name="f" action="users-delete.jsp">
    <fieldset>
        <legend>Comma-separated</legend>
        <div>
        <table cellpadding="3" cellspacing="1" border="0" width="600">
        <tr class="c1">
            <td width="1%" colspan="2" nowrap>
                <textarea rows="10" cols="100" name="usernames"><%= (usernames != null ? usernames : "") %></textarea>
	        </td>
        </tr>
            <tr class="c1">
                <td width="1%" colspan="2" nowrap>
                    <input type="submit" name="Delete"/>
                </td>
            </tr>
        </table>
        </div>
    </fieldset>
</form>

</body>
</html>