From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700 serial port
Date: Wed, 03 Feb 2016 16:58:46 +0100
Message-ID: <87vb654wg9.fsf@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
	<1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
	<20160202181935.19b4ab7e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160202181935.19b4ab7e@lxorguk.ukuu.org.uk> (One Thousand
	Gnomes's message of "Tue, 2 Feb 2016 18:19:35 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Wilson Ding <dingwei@marvell.com>, Nadav Haklai <nadavh@marvell.com>
List-Id: linux-serial@vger.kernel.org

Hi,
=20
 On mar., f=C3=A9vr. 02 2016, One Thousand Gnomes <gnomes@lxorguk.ukuu.=
org.uk> wrote:

>> +static void mvebu_uart_set_termios(struct uart_port *port,
>> +				   struct ktermios *termios,
>> +				   struct ktermios *old)
>> +{
>> +	unsigned long flags;
>> +	unsigned int baud;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	port->read_status_mask =3D STAT_RX_RDY | STAT_OVR_ERR |
>> +		STAT_TX_RDY | STAT_TX_FIFO_FUL;
>> +
>> +	if (termios->c_iflag & INPCK)
>> +		port->read_status_mask |=3D STAT_FRM_ERR | STAT_PAR_ERR;
>> +
>> +	port->ignore_status_mask =3D 0;
>> +	if (termios->c_iflag & IGNPAR)
>> +		port->ignore_status_mask |=3D
>> +			STAT_FRM_ERR | STAT_PAR_ERR | STAT_OVR_ERR;
>> +
>> +	if ((termios->c_cflag & CREAD) =3D=3D 0)
>> +		port->ignore_status_mask |=3D STAT_RX_RDY | STAT_BRK_ERR;
>
> If you don't support parity or charactive size then you should be for=
cing
> those bits in the tty->termios so that the caller sees what settings =
they
> get. tty_termios_copy_hw is close to what you need except that you ca=
n
> support IGNPAR.

OK thanks for the pointer.

>
> You also want to provide the actual baud rate chosen (see how 8250.c =
does
> it using tty_termios_encode_baud_rate().
>
>
>> +static struct uart_driver mvebu_uart_driver =3D {
>> +	.owner			=3D THIS_MODULE,
>> +	.driver_name		=3D "serial",
>> +	.dev_name		=3D "ttyS",
>> +	.major			=3D TTY_MAJOR,
>> +	.minor			=3D 64,
>
> NAK
>
> TTY_MAJOR 64+ is the 8250 driver and ttyS is the 8250 driver name. Yo=
u
> should be using a dynamic major (0) for all new drivers and you need =
to
> pick a different and unused ttyXXX format name.

I missed this one, I will remove .major and .minor and use our own
ttyXX.

Thanks,

Gregory

>
> Alan

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
