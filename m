From: Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date: Thu, 11 Jun 2009 12:27:19 +0100
Message-ID: <n967g6-i6b.ln1@woodchuck.wormnet.eu>
References: <200906041622.47591.florian@openwrt.org> <20090604222020.GA14843@alpha.franken.de> <200906111028.41222.florian@openwrt.org> <20090611093022.GA14510@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762885AbZFKMI2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.orglinux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In gmane.linux.ports.mips.general Thomas Bogendoerfer <tsbogend@alpha.f=
ranken.de> wrote:
>
> On Thu, Jun 11, 2009 at 10:28:39AM +0200, Florian Fainelli wrote:
>> Le Friday 05 June 2009 00:20:20 Thomas Bogendoerfer, vous avez =E9cr=
it=A0:
>> > On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
>> > > We discussed that in private, there are a couple of things
>> > > to fix in order to get 8250 working properly with TI AR7 HW.
>> > > If you can still merge that bit, this would ease future work, th=
anks !
>> >
>> > I still have a tree here, which works without any changes to the 8=
250
>> > serial driver on a TNETD7300 device.
>>=20
>> Could you show me how you register the 8250 driver ? Without the 825=
0-specific=20
>=20
> static struct plat_serial8250_port uart0_data =3D {
>        .mapbase =3D AR7_REGS_UART0,
>        .irq =3D AR7_IRQ_UART0,
>        .regshift =3D 2,
>        .iotype =3D UPIO_MEM,
>        .flags =3D UPF_BOOT_AUTOCONF | UPF_IOREMAP,
> };
>=20
>        uart_port[0].type =3D PORT_16550A;
>        uart_port[0].line =3D 0;
>        uart_port[0].irq =3D AR7_IRQ_UART0;
>        uart_port[0].uartclk =3D ar7_bus_freq() / 2;
>        uart_port[0].iotype =3D UPIO_MEM;
>        uart_port[0].mapbase =3D AR7_REGS_UART0 + 3;
>        uart_port[0].membase =3D ioremap(uart_port[0].mapbase, 256);
>        uart_port[0].regshift =3D 2;
>        res =3D early_serial_setup(&uart_port[0]);
>        if (res)
>                return res;
>=20
>=20
> the +3 comes from the fact, that this machine is configured to run bi=
g
> endian.
>
Alternatively you could not use the byte ordering macro/functions as pe=
r=20
the 'Byte Order' section in:

http://lwn.net/images/pdf/LDD3/ch11.pdf

Makes the code portable, understandable and...well neater.

Cheers

--=20
Alexander Clouter
=2Esigmonster says: Life is like a diaper -- short and loaded.
