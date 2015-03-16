From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add overrun handling of SCIFA and SCIFB
Date: Mon, 16 Mar 2015 22:55:57 +0900
Message-ID: <CAH1o70Lwoyr8b=qHsd9kQc6DECNWo468JAaxTiFgv7_=6Lsi5g@mail.gmail.com>
References: <1426429695-2993-1-git-send-email-ykaneko0929@gmail.com>
	<5505A50C.70802@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5505A50C.70802@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello,

2015-03-16 0:28 GMT+09:00 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> Hello.
>
> On 3/15/2015 5:28 PM, Yoshihiro Kaneko wrote:
>
>> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>
>
>> SCIFA and SCIFB can detect the overrun, but it does not support.
>> This adds overrun handling of SCIFA and SCIFB.
>
>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>
>
>> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
>> tree.
>
>
>>   drivers/tty/serial/sh-sci.c | 34 +++++++++++++++++++++++-----------
>>   1 file changed, 23 insertions(+), 11 deletions(-)
>
>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 5b50c79..d165b21 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -844,14 +844,26 @@ static int sci_handle_fifo_overrun(struct uart_port
>> *port)
>>         struct tty_port *tport = &port->state->port;
>>         struct sci_port *s = to_sci_port(port);
>>         struct plat_sci_reg *reg;
>> -       int copied = 0;
>> +       int copied = 0, offset;
>> +       u16 status, bit;
>> +
>> +       if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
>> +               offset = SCLSR;
>> +       else if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
>> +               offset = SCxSR;
>> +       else
>> +               return 0;
>
>
>    This is asking to be a *switch* statement instead.

I certainly think so.

>
> [...]
>>
>> @@ -1005,7 +1016,10 @@ static irqreturn_t sci_mpxed_interrupt(int irq,
>> void *ptr)
>>         ssr_status = serial_port_in(port, SCxSR);
>>         scr_status = serial_port_in(port, SCSCR);
>>         if (port->type == PORT_SCIF || port->type == PORT_HSCIF)
>> -               slr_status = serial_port_in(port, SCLSR);
>> +               orer_status = serial_port_in(port, SCLSR);
>> +       else if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
>> +               orer_status = ssr_status;
>
>
>    This one too...

I also revise this one.


Thanks,
Kaneko

>
> [...]
>
> WBR, Sergei
>
