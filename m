From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] tty: serial: msm_serial: Remove duplicate call to msm_set_baud_rate
Date: Mon, 29 Dec 2014 16:43:31 -0800
Message-ID: <54A1F533.8040208@codeaurora.org>
References: <1419259460-24142-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1419259460-24142-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 12/22/2014 6:44 AM, Pramod Gurav wrote:
> The function 'msm_set_baud_rate' is called twice while setting up
> msm console. Once in msm_console_setup and next when uart_set_options
> calls port->ops->set_termios ie. msm_set_termios().
>
> Remove the duplicate call in msm_console_setup. Tested on IFC6410
> console.
>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
>  drivers/tty/serial/msm_serial.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index dbc278d..4c4a250 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -945,7 +945,6 @@ static int __init msm_console_setup(struct console *co, char *options)
>  
>  	if (baud < 300 || baud > 115200)
>  		baud = 115200;
> -	msm_set_baud_rate(port, baud);
>  
>  	msm_reset(port);
>  

There seems to be more stuff done in this console setup path that is
duplicated by the msm_set_termios() function. Can we clean it all up? I
would bet that the msm_reset() is there because we changed the buad rate
and so if we remove the baud rate setting we can remove the reset as
well (see commit a12f1b406f2d tty: serial: msm: Reset uartdm after baud
rate change, 2014-10-29). We might as well dump the
CR_CMD_PROTECTION_EN  and CR_TX_ENABLE thing as well given that we do
the same in msm_set_baud_rate() already. And maybe we can even get rid
of the baud rate capping and forced 8N1 setting that goes on here too.
Just let the user do what they want?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
