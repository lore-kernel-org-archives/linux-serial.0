From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 01/05] serial: sh-sci: Break out default CTS/RTS pin setup
Date: Wed, 18 Mar 2015 19:16:59 -0700
Message-ID: <CANqRtoRhwGRR-+Fa8x4LZ5KRJh27nnAkvJjtsPyZKYaJs=yKXg@mail.gmail.com>
References: <20141217125236.14480.78833.sendpatchset@w520>
	<20141217125246.14480.41876.sendpatchset@w520>
	<2156158.vJVakP2u8e@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2156158.vJVakP2u8e@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Mon, Jan 5, 2015 at 12:25 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Wednesday 17 December 2014 21:52:46 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Break out CTS/RTS pin setup for the default case. We only
>> care about those pins in case SCIx_HAVE_RTSCTS is set.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  drivers/tty/serial/sh-sci.c |   45 +++++++++++++++++++++++++++-------------
>>  1 file changed, 31 insertions(+), 14 deletions(-)
>>
>> --- 0001/drivers/tty/serial/sh-sci.c
>> +++ work/drivers/tty/serial/sh-sci.c  2014-12-16 14:40:31.000000000 +0900
>> @@ -509,10 +509,29 @@ static void sci_poll_put_char(struct uar
>>  }
>>  #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
>>
>> -static void sci_init_pins(struct uart_port *port, unsigned int cflag)
>> +static void sci_init_pins_default(struct uart_port *port, bool
>> hwflow_enabled) {
>
> What would you think about renaming the function to sci_init_ctsrts_default ?
> I find having both sci_init_pins and sci_init_pins_default a bit confusing.

Thanks for your comments. I agree with you and I've changed the name
in V2 that I just posted.

>>       struct sci_port *s = to_sci_port(port);
>>       struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
>> +     unsigned short status;
>> +
>> +     /* If no SCSPTR register exists then skip. Same if hardware flow
>> +      * control has been enabled, in such case SCFCR.MCE will be set
>> +      * and the SCSPTR configuration is assumed to be overridden.
>> +      */
>> +     if (!reg->size || hwflow_enabled)
>> +             return;
>> +
>> +     status = serial_port_in(port, SCSPTR);
>> +     status &= ~SCSPTR_CTSIO;
>> +     status |= SCSPTR_RTSIO;
>> +     serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
>> +}
>> +
>> +static void sci_init_pins(struct uart_port *port, unsigned int cflag)
>> +{
>> +     struct sci_port *s = to_sci_port(port);
>> +     bool hwflow_enabled = cflag & CRTSCTS;
>>
>>       /*
>>        * Use port-specific handler if provided.
>> @@ -522,22 +541,20 @@ static void sci_init_pins(struct uart_po
>>               return;
>>       }
>>
>> -     /*
>> -      * For the generic path SCSPTR is necessary. Bail out if that's
>> -      * unavailable, too.
>> +     /* SCIF hardware with RTS/CTS support needs special setup below.
>> +      *
>> +      * Please note that if RTS/CTS is available for the hardware
>> +      * platform depends on the particular SCIF channel on a certain
>> +      * SoC, and how this channel has been hooked up on the actual board.
>
> How do you plan to convey that information to the driver in the DT case ? If
> I'm not mistaken the SCIx_HAVE_RTSCTS flag is only set through platform data
> at the moment. Do you have a list of which SCIF channels support RTS/CTS on
> which SoC ?

Good question. It seems that other drivers use the DT "ctsrts"
property to flag just this, and maybe it makes sense to simply use
such a property in the board DTS file to opt-in on modem control on a
board-basis.

Something similar is included in my prototype hack that I just posted:
[PATCH] sh73a0 KZM9G CTS/RTS prototype

Thanks for your help!

Cheers,

/ magnus
