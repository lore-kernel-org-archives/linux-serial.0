From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/6] clocksource: em_sti: convert to clk_prepare/unprepare
Date: Tue, 1 Oct 2013 18:05:50 +0900
Message-ID: <CANqRtoRUy=Fi3-YeMLpiCinOw+0bkVUbjUMYUo7Lv85+b8=UPg@mail.gmail.com>
References: <52410F86.4040301@renesas.com>
	<20130924130924.61d4ecedf3d4fca5952d55fc@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130924130924.61d4ecedf3d4fca5952d55fc-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 24, 2013 at 1:09 PM,  <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org> wrote:
> From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> migrate to the common clock framework.
>
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/clocksource/em_sti.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looking good, thanks!

Acked-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
