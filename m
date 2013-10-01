From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] serial8250-em: convert to clk_prepare/unprepare
Date: Tue, 1 Oct 2013 18:07:08 +0900
Message-ID: <CANqRtoQBnPCy8xCsn37yYweKH0rpwbUupdEnBrnqH3owJ_mbjA@mail.gmail.com>
References: <52410F86.4040301@renesas.com>
	<20130924131039.3c871cad7acb2a068a988d0f@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130924131039.3c871cad7acb2a068a988d0f-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 24, 2013 at 1:10 PM,  <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org> wrote:
> From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> migrate to the common clock framework.
>
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> [takashi.yoshii.ze-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org: edited for conflicts]
> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/tty/serial/8250/8250_em.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This looks fine to me, thanks!

Acked-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
