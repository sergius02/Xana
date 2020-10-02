public class Xana.WebContext : WebKit.WebContext {

    public WebContext () {
        set_process_model (WebKit.ProcessModel.MULTIPLE_SECONDARY_PROCESSES);
        get_cookie_manager ().set_accept_policy (
            WebKit.CookieAcceptPolicy.NO_THIRD_PARTY
        );
    }

}
