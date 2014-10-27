From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: gadget serial: Honour termios CLOCAL on disconnect
Date: Mon, 27 Oct 2014 13:11:14 -0400
Message-ID: <544E7CB2.2020200@hurleysoftware.com>
References: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com> <1414346490-19307-3-git-send-email-kyosti.malkki@gmail.com> <20141027133837.GC8537@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141027133837.GC8537@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, =?UTF-8?B?S3nDtnN0aSBNw6Rsa2tp?= <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 10/27/2014 09:38 AM, Felipe Balbi wrote:
> Hi,
>=20
> On Sun, Oct 26, 2014 at 08:01:30PM +0200, Ky=C3=B6sti M=C3=A4lkki wro=
te:
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
>> Signed-off-by: Ky=C3=B6sti M=C3=A4lkki <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/usb/gadget/function/u_serial.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/ga=
dget/function/u_serial.c
>> index 491082a..e68ffd7 100644
>> --- a/drivers/usb/gadget/function/u_serial.c
>> +++ b/drivers/usb/gadget/function/u_serial.c
>> @@ -1254,8 +1254,13 @@ void gserial_disconnect(struct gserial *gser)
>>  	gser->ioport =3D NULL;
>>  	if (port->port.count > 0 || port->openclose) {
>>  		wake_up_interruptible(&port->drain_wait);
>> -		if (port->port.tty)
>> -			tty_hangup(port->port.tty);
>> +		struct tty_struct *tty =3D port->port.tty;
>=20
> declare above as Sergei said.
>=20
>> +		if (tty) {
>=20
> is there any situation where tty would be NULL here ?
>=20
>> +			if (tty->termios.c_cflag & CLOCAL)
>> +				stop_tty(tty);
>> +			else
>> +				tty_hangup(tty);
>=20
> this I'll defer to Greg who also maintains tty.

I'm curious what happens without stop_tty().

The tty is restartable from userspace with
    tcflow(fd, TCOOFF);
    tcflow(fd, TCOON);

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
