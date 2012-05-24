From: Dmitriy Alekseev <alexeev6@yahoo.com>
Subject: Fw: struct tty_flip_buffer replacement in newer kernels
Date: Thu, 24 May 2012 03:38:42 -0700 (PDT)
Message-ID: <1337855922.24203.YahooMailNeo@web44913.mail.sp1.yahoo.com>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com> <4FBB8742.7050504@fastmail.fm> <20120522151033.33ef577a@pyramind.ukuu.org.uk> <1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com> <20120522172700.02d7915d@pyramind.ukuu.org.uk> <1337855090.9672.YahooMailNeo@web44908.mail.sp1.yahoo.com>
Reply-To: Dmitriy Alekseev <alexeev6@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm7.bullet.mail.sp2.yahoo.com ([98.139.91.77]:40023 "HELO
	nm7.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755564Ab2EXKio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 May 2012 06:38:44 -0400
In-Reply-To: <1337855090.9672.YahooMailNeo@web44908.mail.sp1.yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi, Alan.

Thank You very much for the answer!
So, if I understand correctly, I took for example this:=A0arch/arm/mach=
-omap1/board-voiceblue.c
And made in my board specific file:
static struct plat_serial8250_port exar_ports[] =3D {
=A0 =A0 =A0 =A0 {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mapbase =A0 =A0 =A0 =A0=3D (unsigned l=
ong)(0x30000300), // according to at91rm9200 CS2 memory map
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT_=
AUTOCONF | UPF_IOREMAP, // I don't know, what kind of flags is suitable=
 for me
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM, /=
/ similar problem
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .regshift =A0 =A0 =A0 =3D 1,=A0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uartclk =A0 =A0 =A0 =A0=3D 14745600, /=
/ Our chip clock frequency
=A0 =A0 =A0 =A0 },
=A0 =A0 =A0 =A0 {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mapbase =A0 =A0 =A0 =A0=3D (unsigned l=
ong)(0x30000200),
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT_=
AUTOCONF | UPF_IOREMAP,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .regshift =A0 =A0 =A0 =3D 1,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uartclk =A0 =A0 =A0 =A0=3D 14745600,
=A0 =A0 =A0 =A0 },
=A0 =A0 =A0 =A0 {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mapbase =A0 =A0 =A0 =A0=3D (unsigned l=
ong)(0x30000100),
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT_=
AUTOCONF | UPF_IOREMAP,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .regshift =A0 =A0 =A0 =3D 1,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uartclk =A0 =A0 =A0 =A0=3D 14745600,
=A0 =A0 =A0 =A0 },
=A0 =A0 =A0 =A0 {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .mapbase =A0 =A0 =A0 =A0=3D (unsigned l=
ong)(0x30000000),
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT_=
AUTOCONF | UPF_IOREMAP,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .regshift =A0 =A0 =A0 =3D 1,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uartclk =A0 =A0 =A0 =A0=3D 14745600,
=A0 =A0 =A0 =A0 },
=A0 =A0 =A0 =A0 { },
};
static struct platform_device serial_device =3D {
=2Ename =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "serial8250",
=A0 =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D PLAT825=
0_DEV_EXAR_ST16C554,
=A0 =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D exar_ports,
=A0 =A0 =A0 =A0 =A0},
};

in my board __init func:
platform_device_register(&serial_device);

at .config I made:
#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_MANY_PORTS=3Dy
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set


dmesg gives:
[ =A0 =A00.695312] Serial: 8250/16550 driver, 4 ports, IRQ sharing disa=
bled =A0 =A0 =A0 =A0=A0


New devices in filesystem has been registered, but they didn't related =
with hardware chip yet.
#cat /proc/tty/driver/serial =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0=A0
serinfo:1.0 driver revision: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
0: uart:unknown mmio:0x30000000 irq:0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0
1: uart:unknown port:00000000 irq:0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0
2: uart:unknown port:00000000 irq:0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0
3: uart:unknown port:00000000 irq:0 =A0 =A0

What shoud I check, learn, do for solving this problem?


Very grateful,
Dmitriy Alekseev


----- Original Message -----
=46rom: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitriy Alekseev <alexeev6@yahoo.com>
Cc: "linux-serial@vger.kernel.org"
<linux-serial@vger.kernel.org>
Sent: Tuesday, May 22, 2012 8:27 PM
Subject: Re: struct tty_flip_buffer replacement in newer kernels

On Tue, 22 May 2012 07:38:28 -0700 (PDT)
Dmitriy Alekseev <alexeev6@yahoo.com> wrote:

> This is driver source I found:
> http://www.codeforge.com/read/118181/st16c554_serial.c__html
>=20
> It was written for quad uart st16c554 for arm chip s3c2410, which I t=
ried to adapt for at91rm9200 board and newer kernel version.

Why not use the in kernel 8250 driver (which will drive a stamdard
16540/550/554 as well ?)

To ressurect one you'll need to add kref handling, rework the termios c=
ode
and maybe some other bits too.

Take a look how other arm boards use struct plat_serial8250_port and th=
e
serial8250 platform driver. You should just be able to declare the
structures and register the platform device.

Alan

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a
message to majordomo@vger.kernel.org
More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
