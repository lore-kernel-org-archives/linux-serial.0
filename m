From: =?UTF-8?B?S3nDtnN0aSBNw6Rsa2tp?= <kyosti.malkki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] usb: gadget serial: Honour termios CLOCAL on disconnect
Date: Tue, 04 Nov 2014 01:49:48 +0200
Message-ID: <5458149C.8050203@gmail.com>
References: <1414346490-19307-1-git-send-email-kyosti.malkki@gmail.com> <1415027885-2181-1-git-send-email-kyosti.malkki@gmail.com> <1415027885-2181-3-git-send-email-kyosti.malkki@gmail.com> <5457A062.50306@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5457A062.50306-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 11/03/2014 05:33 PM, Peter Hurley wrote:
> Hi Ky=C3=B6sti,
>
> On 11/03/2014 10:18 AM, Ky=C3=B6sti M=C3=A4lkki wrote:
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
>>   drivers/usb/gadget/function/u_serial.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/ga=
dget/function/u_serial.c
>> index 491082a..dabc165 100644
>> --- a/drivers/usb/gadget/function/u_serial.c
>> +++ b/drivers/usb/gadget/function/u_serial.c
>> @@ -1253,9 +1253,16 @@ void gserial_disconnect(struct gserial *gser)
>>   	port->port_usb =3D NULL;
>>   	gser->ioport =3D NULL;
>>   	if (port->port.count > 0 || port->openclose) {
>> +		struct tty_struct *tty;
>> +
>>   		wake_up_interruptible(&port->drain_wait);
>> -		if (port->port.tty)
>> -			tty_hangup(port->port.tty);
>> +		tty =3D port->port.tty;
>> +		if (tty) {
>> +			if (tty->termios.c_cflag & CLOCAL)
>> +				stop_tty(tty);
>> +			else
>> +				tty_hangup(tty);
>
> It seems you missed my earlier email: what happens if you leave
> out the stop_tty() call here?
>

Hi Peter

I did not miss it. My intro to the patch series says I am not familiar=20
with tty infra, so I did not realize the question was directed to me.
Also my setup with serial gadget runs kernel 3.12.6 so I cannot really=20
tell or test if tty changes since that would make my patch invalid or=20
unnecessary.

In the previous change for gserial_disconnect(), where the tty_hangup()=
=20
call was added, commit message described it fixes an endless loop on tt=
y=20
device read and select. Would we be back at that situation without call=
=20
to stop_tty()?

> I ask because the tty is still restartable from userspace after you
> stop_tty() here. So if your goal is to prevent write() from
> happening, this won't work.

There was no goal to prevent write() on the tty device, should there be=
?=20
Or should it silently just drop any characters while in the disconnecte=
d=20
state instead of buffering (some of) them?

Thanks,
KM

>
> Regards,
> Peter Hurley
>
>> +		}
>>   	}
>>   	spin_unlock_irqrestore(&port->port_lock, flags);
>>
>>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
