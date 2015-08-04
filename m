From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] tty: serial: men_z135_uart.c: Fix race between IRQ and set_termios()
Date: Tue, 04 Aug 2015 09:02:42 +0200
Message-ID: <mqdbnenv8ml.fsf@c203.arch.suse.de>
References: <1438610285-1441-1-git-send-email-jthumshirn@suse.de>
	<55BF893C.1000901@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BF893C.1000901@hurleysoftware.com> (Peter Hurley's message of
	"Mon, 03 Aug 2015 11:31:08 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Werner <andreas.werner@men.de>
List-Id: linux-serial@vger.kernel.org


Hi Peter,
Peter Hurley <peter@hurleysoftware.com> writes:

> Hi Johannes,
>
> On 08/03/2015 09:58 AM, Johannes Thumshirn wrote:
>> Fix panic caused by a race between men_z135_intr() and men_z135_set_=
termios().
>>=20
>> men_z135_intr() and men_z135_set_termios() both hold the struct uart=
_port::lock
>> spinlock, but men_z135_intr() does a spin_lock_irqsave() and
>> men_z135_set_termios() does a normal spin_lock(), which can lead to =
a deadlock
>> when an interrupt is called while the lock is being helt by
>> men_z135_set_termios().
>
>
> The irq handler can and should use normal spin_lock()/unlock().

I always thought an irq handler _must_ use the irqsave versions. Good t=
o
know that.

>
> The set_termios() method should used spin_lock_irq(); there's no need=
 to save the
> interrupt state because that method will never be called from interru=
pt context.
>
> So the 'flags' local can be dropped from the patch.

Given that the irqsave variant isn't needed that sounds reasonable.

>
> Also, the port lock is already initialized in uart_add_one_port() and=
 should
> not be initialized by the probe() function.

OK, do you prefer (or better Greg and Jiri) prefer that change folded
into this patch or an extra patch?

>
> Regards,
> Peter Hurley
>
>> This was discovered using a insmod, hardware looppback send/receive,=
 rmmod
>> stress test.
>>=20
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>> Cc: Andreas Werner <andreas.werner@men.de>
>> ---
>>  drivers/tty/serial/men_z135_uart.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial=
/men_z135_uart.c
>> index 35c5550..d020435 100644
>> --- a/drivers/tty/serial/men_z135_uart.c
>> +++ b/drivers/tty/serial/men_z135_uart.c
>> @@ -656,6 +656,7 @@ static void men_z135_set_termios(struct uart_por=
t *port,
>>  				struct ktermios *old)
>>  {
>>  	struct men_z135_port *uart =3D to_men_z135(port);
>> +	unsigned long flags;
>>  	unsigned int baud;
>>  	u32 conf_reg;
>>  	u32 bd_reg;
>> @@ -717,7 +718,7 @@ static void men_z135_set_termios(struct uart_por=
t *port,
>> =20
>>  	baud =3D uart_get_baud_rate(port, termios, old, 0, uart_freq / 16)=
;
>> =20
>> -	spin_lock(&port->lock);
>> +	spin_lock_irqsave(&port->lock, flags);
>>  	if (tty_termios_baud_rate(termios))
>>  		tty_termios_encode_baud_rate(termios, baud, baud);
>> =20
>> @@ -725,7 +726,7 @@ static void men_z135_set_termios(struct uart_por=
t *port,
>>  	iowrite32(bd_reg, port->membase + MEN_Z135_BAUD_REG);
>> =20
>>  	uart_update_timeout(port, termios->c_cflag, baud);
>> -	spin_unlock(&port->lock);
>> +	spin_unlock_irqrestore(&port->lock, flags);
>>  }
>> =20
>>  static const char *men_z135_type(struct uart_port *port)
>>=20
>

--=20
Johannes Thumshirn                                           Storage
jthumshirn@suse.de                                 +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600  D0D0 0393 969D 2D76 0850
