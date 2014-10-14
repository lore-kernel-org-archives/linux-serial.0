From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: [PATCH v2] WCH CH-382 support
Date: Tue, 14 Oct 2014 22:21:31 +0400
Message-ID: <m1jpjb$kaa$1@ger.gmane.org>
References: <87vbnmr831.wl-ml@sergej.pp.ru> <878ukimyle.wl-ml@sergej.pp.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44588 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460AbaJNSVs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Oct 2014 14:21:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1Xe6j9-0001xv-Sp
	for linux-serial@vger.kernel.org; Tue, 14 Oct 2014 20:21:43 +0200
Received: from 92.243.181.209 ([92.243.181.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2014 20:21:43 +0200
Received: from matwey.kornilov by 92.243.181.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2014 20:21:43 +0200
In-Reply-To: <878ukimyle.wl-ml@sergej.pp.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

14.10.2014 19:59, Sergej Pupykin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
> At Tue, 14 Oct 2014 19:20:50 +0400,
> Sergej Pupykin <ml@sergej.pp.ru> wrote:
>> Hi,
>>
>> finally I've made patch that supports CH-382 2S1P card except IRQ. S=
o
>> it uses FL_NOIRQ meanwhile.
>=20
> Non-working IRQ was caused by VirtualBox PCI passing. (I passed PCI
> card to vbox guest for debugging). So FL_NOIRQ can be safely removed.
>=20

The following is really worth reading:
https://www.kernel.org/doc/Documentation/SubmittingPatches


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
