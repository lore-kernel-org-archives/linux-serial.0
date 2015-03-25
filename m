From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] serial: sh-sci: Add overrun handling of SCIFA and SCIFB
Date: Wed, 25 Mar 2015 14:57:25 +0300
Message-ID: <5512A2A5.7040406@cogentembedded.com>
References: <1427266818-10985-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1427266818-10985-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello.

On 3/25/2015 10:00 AM, Nobuhiro Iwamatsu wrote:

> SCIFA and SCIFB can detect the overrun, but it does not support.

    s/it/the driver/.

> This adds overrun handling of SCIFA and SCIFB.

    s/of/for/.

> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>   drivers/tty/serial/sh-sci.c | 33 +++++++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 10 deletions(-)

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 5b50c79..0a78e1d 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
[...]
> @@ -1005,7 +1017,10 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
>   	ssr_status = serial_port_in(port, SCxSR);
>   	scr_status = serial_port_in(port, SCSCR);
>   	if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
> -		slr_status = serial_port_in(port, SCLSR);
> +		orer_status = serial_port_in(port, SCLSR);
> +	else if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
> +		orer_status = ssr_status;
> +

    I think the above *if*'s are asking to be *switch* statement instead.

[...]

WBR, Sergei

