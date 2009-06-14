From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date: Sun, 14 Jun 2009 13:18:36 +0200
Message-ID: <200906141318.38376.florian@openwrt.org>
References: <200906041622.47591.florian@openwrt.org> <200906111028.41222.florian@openwrt.org> <20090611093022.GA14510@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:55529 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075AbZFNLSm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Jun 2009 07:18:42 -0400
In-Reply-To: <20090611093022.GA14510@alpha.franken.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Le Thursday 11 June 2009 11:30:22 Thomas Bogendoerfer, vous avez =E9cri=
t=A0:
> On Thu, Jun 11, 2009 at 10:28:39AM +0200, Florian Fainelli wrote:
> > Le Friday 05 June 2009 00:20:20 Thomas Bogendoerfer, vous avez =E9c=
rit=A0:
> > > On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
> > > > We discussed that in private, there are a couple of things
> > > > to fix in order to get 8250 working properly with TI AR7 HW.
> > > > If you can still merge that bit, this would ease future work, t=
hanks
> > > > !
> > >
> > > I still have a tree here, which works without any changes to the =
8250
> > > serial driver on a TNETD7300 device.
> >
> > Could you show me how you register the 8250 driver ? Without the
> > 8250-specific
>
> static struct plat_serial8250_port uart0_data =3D {
>         .mapbase =3D AR7_REGS_UART0,
>         .irq =3D AR7_IRQ_UART0,
>         .regshift =3D 2,
>         .iotype =3D UPIO_MEM,
>         .flags =3D UPF_BOOT_AUTOCONF | UPF_IOREMAP,
> };
>
>         uart_port[0].type =3D PORT_16550A;
>         uart_port[0].line =3D 0;
>         uart_port[0].irq =3D AR7_IRQ_UART0;
>         uart_port[0].uartclk =3D ar7_bus_freq() / 2;
>         uart_port[0].iotype =3D UPIO_MEM;
>         uart_port[0].mapbase =3D AR7_REGS_UART0 + 3;
>         uart_port[0].membase =3D ioremap(uart_port[0].mapbase, 256);
>         uart_port[0].regshift =3D 2;
>         res =3D early_serial_setup(&uart_port[0]);
>         if (res)
>                 return res;
>
>
> the +3 comes from the fact, that this machine is configured to run bi=
g
> endian.
>
> Here is the boot log:
>
> Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disa=
bled
> serial8250: ttyS0 at MMIO 0x8610e03 (irq =3D 15) is a 16550A
> console handover: boot [early0] -> real [ttyS0]
> serial8250: ttyS1 at MMIO 0x8610f00 (irq =3D 19) is a 16550A
> loop: module loaded
> Fixed MDIO Bus: probed
>
>
> ttyS1 uses the wrong address, but there is nothing connected to
> that port on the box.
>
> Do you see the problem on TNETD7200 devices as well ?

I no longer have TNETD7200 devices to test on unfortunately.

What I just found is that TNETD7300GDU revision 5 does not have this bu=
g,=20
while TNETD7300GDU revision 4 has. This seems to confirm the HW bug=20
hypothesis. Let's just clean the serial console registration and we wil=
l keep=20
in OpenWrt the 8250 workaround for older TNETD7300 revisions.
--=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
