From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 05/05] serial: sh-sci: Expose SCIFA/SCIFB CTS pin
Date: Wed, 18 Mar 2015 19:18:50 -0700
Message-ID: <CANqRtoSo_AKkE5D20DtdyiDCHQ+2rhsoWGGgsr8ZMP_7bRrbgA@mail.gmail.com>
References: <20141217125236.14480.78833.sendpatchset@w520>
	<20141217125325.14480.79285.sendpatchset@w520>
	<6657739.eAlEu9S4Iu@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <6657739.eAlEu9S4Iu@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Sun, Jan 4, 2015 at 11:53 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Wednesday 17 December 2014 21:53:25 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Expose CTS pin to serial core for the SCIFA/SCIFB case.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  drivers/tty/serial/sh-sci.c |   17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> --- 0023/drivers/tty/serial/sh-sci.c
>> +++ work/drivers/tty/serial/sh-sci.c  2014-12-17 18:46:44.000000000 +0900
>> @@ -564,6 +564,11 @@ static void sci_init_pins_default(struct
>>       serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
>>  }
>>
>> +static bool sci_cts_asserted_scifab(struct uart_port *port)
>> +{
>> +     return !(serial_port_in(port, SCPDR) & BIT(3));
>
> Could you please define SCPDR_CTSD to replace BIT(3) ?

Done in V2!

Thanks,

/ magnus
