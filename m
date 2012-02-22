From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 0/4] pch_uart: Cleanups, board quirks, and user uartclk
 parameter
Date: Wed, 22 Feb 2012 01:55:42 -0800
Message-ID: <4F44BB9E.7060108@linux.intel.com>
References: <cover.1329875301.git.dvhart@linux.intel.com> <CANKRQni9E6NO39MFSak6MjQ0DtmQeviGo966Ex9ZUvai56wCjg@mail.gmail.com> <20120222085830.1ed8c25e@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6815 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab2BVJ4Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 04:56:16 -0500
In-Reply-To: <20120222085830.1ed8c25e@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org



On 02/22/2012 12:58 AM, Alan Cox wrote:
>>> assume a 192 MHz clock on all boards. The problem with this approac=
h is
>>> that the CLKCFG register may have been set to something other than =
the
>>> 192MHz configuration by the firmware.
>=20
> So you can use the early PCI hooks or even bash the register directly=
 in
> your early bootup code. You won't be the only early boot console that
> does this sort of thing. There are even people bitbanging PCI I=B2C
> interfaces at boot time for such purpose.
>=20
>> So, I think default uart_clock 192MHz setting is better than Darren'=
s opinion.
>=20
> It's certainly easier to maintain, but it would be good to know if th=
e
> setting can be written or retrieved directly in the early console set=
up
> using the early PCI ops or similar.

OK, I'm not opposed to forcing everything to 192MHz, that would clean u=
p
pch_uart.c quite a bit. I have heard different things about the
specification for this chipset. One statement was that 64MHz was the
maximum UART clock. Feng suggests that 192MHz is the recommended UART
clock. I need to dig up this spec and determine what it actually says.

I have V2 with Alan's feedback from 2/4 incorporated, but I'll hold off
unless people want to see it now. Seems like it will change a lot if we
force 192MHz everywhere.

--=20
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
