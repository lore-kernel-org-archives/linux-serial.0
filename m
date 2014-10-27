From: =?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?= <kyosti.malkki@gmail.com>
Subject: Re: [PATCH 2/2] usb: gadget serial: Honour termios CLOCAL on disconnect
Date: Mon, 27 Oct 2014 17:43:06 +0200
Message-ID: <544E680A.9010700@gmail.com>
References: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com> <1414346490-19307-3-git-send-email-kyosti.malkki@gmail.com> <20141027133837.GC8537@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:57455 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbaJ0Pkz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Oct 2014 11:40:55 -0400
In-Reply-To: <20141027133837.GC8537@saruman>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On 10/27/2014 03:38 PM, Felipe Balbi wrote:
> Hi,
>
> On Sun, Oct 26, 2014 at 08:01:30PM +0200, Ky=F6sti M=E4lkki wrote:
>> There are applications where it is desirable to not hangup ttyGS* wh=
en
>> USB disconnect is detected. USB host side of communication may
>> power-cycle periodically or there may be the actual need to physical=
ly
>> disconnect and reconnect USB cable temporarily.
>>
>> USB disconnects on serial gadget are comparable to loss of Carrier D=
etect
>> of conventional UARTs. With the change, if ttyGS* has termios CLOCAL=
 flag
>> set, disconnect on USB does not hangup the TTY.
>>
>> Signed-off-by: Ky=F6sti M=E4lkki <kyosti.malkki@gmail.com>
>> ---
>>   drivers/usb/gadget/function/u_serial.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/ga=
dget/function/u_serial.c
>> index 491082a..e68ffd7 100644
>> --- a/drivers/usb/gadget/function/u_serial.c
>> +++ b/drivers/usb/gadget/function/u_serial.c
>> @@ -1254,8 +1254,13 @@ void gserial_disconnect(struct gserial *gser)
>>   	gser->ioport =3D NULL;
>>   	if (port->port.count > 0 || port->openclose) {
>>   		wake_up_interruptible(&port->drain_wait);
>> -		if (port->port.tty)
>> -			tty_hangup(port->port.tty);
>> +		struct tty_struct *tty =3D port->port.tty;
>
> declare above as Sergei said.
>
>> +		if (tty) {
>
> is there any situation where tty would be NULL here ?
>
>> +			if (tty->termios.c_cflag & CLOCAL)
>> +				stop_tty(tty);
>> +			else
>> +				tty_hangup(tty);
>
> this I'll defer to Greg who also maintains tty.
>

My main concern is if someone runs getty on ttyACM without explicitly=20
clearing CLOCAL. With the patch here login session would no longer get=20
SIGHUP if cable is disconnected. And it is not possible to tell if it i=
s=20
the same cable that is plugged back in.

KM




--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
