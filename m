From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 -next 10/13] serial: earlycon: Allow earlycon params
 with name only
Date: Thu, 5 Mar 2015 09:46:44 -0600
Message-ID: <CAL_Jsq+bL4qB797M0s+ZHSSrh=d_7bhP2AZQxAbqjmp5Gd0MXg@mail.gmail.com>
References: <1425225958-17908-1-git-send-email-peter@hurleysoftware.com> <1425225958-17908-11-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425225958-17908-11-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Mar 1, 2015 at 10:05 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Allow earlycon param strings of the form
>    earlycon=<name>

Humm, that should already be the case with ARM semihosting (smh).

Rob

>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/serial/earlycon.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index da5e8c8..025ea01 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -109,13 +109,16 @@ int __init setup_earlycon(char *buf, const char *match,
>         len = strlen(match);
>         if (strncmp(buf, match, len))
>                 return 0;
> -       if (buf[len] && (buf[len] != ','))
> -               return 0;
>
> -       buf += len + 1;
> +       if (buf[len]) {
> +               if (buf[len] != ',')
> +                       return 0;
> +               buf += len + 1;
> +       } else
> +               buf = NULL;
>
>         /* On parsing error, pass the options buf to the setup function */
> -       if (!parse_options(&early_console_dev, buf))
> +       if (buf && !parse_options(&early_console_dev, buf))
>                 buf = NULL;
>
>         port->uartclk = BASE_BAUD * 16;
> --
> 2.3.0
>
