From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] serial: sh-sci: Fix R-Car SCIF and HSCIF overrun handling
Date: Sun, 25 Jan 2015 19:57:09 +0300
Message-ID: <54C52065.8030600@cogentembedded.com>
References: <1422200281-22518-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1422200281-22518-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello.

On 01/25/2015 06:38 PM, Yoshihiro Kaneko wrote:

> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

> When fifo overrun happened, the interrupt status refers to
> SCLSR register in R-Car SCIF and HSCIF.
> Thus, overrun handling takes SCLSR register into account.

> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

[...]

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 8204306..69f6bf3 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
[...]
> @@ -1032,6 +1038,12 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
>   	if ((ssr_status & SCxSR_BRK(port)) && err_enabled)
>   		ret = sci_br_interrupt(irq, ptr);
>
> +	/* Overrun Interrupt */
> +	if (port->type == PORT_SCIF || port->type == PORT_HSCIF) {
> +		if ((slr_status & 0x01))

    No need for double parens.

WBR, Sergei

