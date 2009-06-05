From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date: Fri, 5 Jun 2009 15:52:24 +0200
Message-ID: <200906051552.25529.florian@openwrt.org>
References: <200906041622.47591.florian@openwrt.org> <20090604222020.GA14843@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36856 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbZFENw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Jun 2009 09:52:27 -0400
In-Reply-To: <20090604222020.GA14843@alpha.franken.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Hallo Thomas,

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

That specific patch just adds an AR7 port to the 8250 uart driver. My=20
TNETD7300 really needs patching in the 8250 driver to work properly, Al=
an=20
already suggested to perform some testing. I still think there is a HW =
bug=20
with different silicon revisions.
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
