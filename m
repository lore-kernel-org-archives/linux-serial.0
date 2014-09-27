From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/4] serial: mxs-auart: enable PPS support
Date: Sat, 27 Sep 2014 16:47:44 +0400
Message-ID: <5426B1F0.9050006@cogentembedded.com>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl> <1411811197-12638-5-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:44850 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaI0Mrr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 27 Sep 2014 08:47:47 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so4126057lbi.27
        for <linux-serial@vger.kernel.org>; Sat, 27 Sep 2014 05:47:45 -0700 (PDT)
In-Reply-To: <1411811197-12638-5-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org

Hello.

On 9/27/2014 1:46 PM, Janusz Uzycki wrote:

> Enables PPS support in mxs-auart serial driver to make PPS API working.

> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> ---
>   drivers/tty/serial/mxs-auart.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index ab127a2..4f1ab98 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -787,6 +787,15 @@ static void mxs_auart_settermios(struct uart_port *u,
>   		mxs_auart_disable_ms(u);
>   }
>
> +static void mxs_auart_set_ldisc(struct uart_port *port, int new)
> +{
> +	if (new == N_PPS) {
> +		port->flags |= UPF_HARDPPS_CD;
> +		mxs_auart_enable_ms(port);
> +	} else
> +		port->flags &= ~UPF_HARDPPS_CD;

    The kernel coding style dictates that {} should be in both arms of the 
*if* statement.

[...]

WBR, Sergei

