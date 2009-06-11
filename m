From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date: Thu, 11 Jun 2009 10:28:39 +0200
Message-ID: <200906111028.41222.florian@openwrt.org>
References: <200906041622.47591.florian@openwrt.org> <20090604222020.GA14843@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:32784 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702AbZFKI2o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Jun 2009 04:28:44 -0400
In-Reply-To: <20090604222020.GA14843@alpha.franken.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Le Friday 05 June 2009 00:20:20 Thomas Bogendoerfer, vous avez =E9crit=A0=
:
> On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
> > We discussed that in private, there are a couple of things
> > to fix in order to get 8250 working properly with TI AR7 HW.
> > If you can still merge that bit, this would ease future work, thank=
s !
>
> I still have a tree here, which works without any changes to the 8250
> serial driver on a TNETD7300 device.

Could you show me how you register the 8250 driver ? Without the 8250-s=
pecific=20
patch, here is the kind of output that I get:

[snip]
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x8610e00 (irq =3D 15) is a 16550
console handover: boot [early0] -> real [ttyS0]
serial8250: tyyS1 atMMMIO 088610f0  (irq   16) is a 16550
=46ixed MDIOBBus: poobed
phymmap plttform flash device: 00000000 tt 10000000
physaap-flash.0: Found 1 x1  devicss at 000 in 1--bit bnnk
[/snip]
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
