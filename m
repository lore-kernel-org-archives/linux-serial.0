From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: WCH CH-382 support: help with patching
Date: Wed, 09 Jul 2014 18:47:44 +0400
Message-ID: <lpjkmg$uru$1@ger.gmane.org>
References: <87iotc6xph.wl%ml@sergej.pp.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38488 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349AbaGIOr4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jul 2014 10:47:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1X4tA3-00068y-4J
	for linux-serial@vger.kernel.org; Wed, 09 Jul 2014 16:47:55 +0200
Received: from 92.243.181.209 ([92.243.181.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 09 Jul 2014 16:47:55 +0200
Received: from matwey.kornilov by 92.243.181.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 09 Jul 2014 16:47:55 +0200
In-Reply-To: <87iotc6xph.wl%ml@sergej.pp.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hi,

I am just received the similar board, but it is strange that I have
different device-id, which is 3050.

Where did you get vendor driver from?


22.01.2014 15:51, Sergej Pupykin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
> Hi,
>=20
> I have wch ch382 board which is mostly similar to already supported
> ch353 I think. But 382 works in PCI-E slot whereas 353 in PCI.
>=20
> I've written a patch and LPT looks working with
> parport_serial. (Actually it works even using "modprobe parport_pc
> io=3D0xe100")
>=20
> But I have some problems with ttyS*.
>=20
> Here are changes between CH353-2S1P and CH382-2S1P in vendor driver:
>=20
>            CH353  CH382
> type       16550  16750
> IntrBar    3      0
> IntrOffset 0x0F   0xE9
> ofs1       0,0    0xC0,0xC8
>=20
> As I understand last line is offset to uart I/O ports, so I put 0xC0
> to pci_parport_serial_boards[].first_offset and uart_offset is 8, so
> /sys/class/tty/ttyS0/port is 0xE0C0
> /sys/class/tty/ttyS1/port is 0xE0C8
> and lspci -v reports "I/O ports at e000 [size=3D256]"
>=20
> But I cannot find where should I put interrupt parameters IntrBar and
> IntrOffset. Probably this is the reason why ttyS* don't work.
>=20
> Here is vendor WCH driver:
> https://home.p5n.pp.ru/~sergej/files/wch-driver.tar.gz
>=20
> My patch is in attachment.
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
