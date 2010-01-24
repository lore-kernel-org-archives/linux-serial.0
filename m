From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: Auto RS485 half-duplex control
Date: Sun, 24 Jan 2010 17:06:36 +0100
Message-ID: <201001241706.37479.mfuchs@ma-fu.de>
References: <001801ca8c76$d7654bd0$862fe370$@cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:58566 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0AXQZi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 24 Jan 2010 11:25:38 -0500
In-Reply-To: <001801ca8c76$d7654bd0$862fe370$@cx>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christian Magnusson <mag@mag.cx>
Cc: linux-serial@vger.kernel.org

Christian,

>=20
> I have searched in the lists for some kernel support to control the R=
TS-pin
> while sending characters to through an external RS232->RS485 adapter.
> The RS485 device I=92m writing to, respond with an answer within appr=
oximately
> 2ms after my last sent character, and therefore I need to release the
> RTS-pin before that.
> If not, the returning characters will be unreadable due to the
> send-collision.
>=20
> Will this feature be implemented in the i386 arch (as it is for chris=
), or
> is there any reason to never include it in the future?
>=20
manually controlling the RTS (or any other pin) pin for RS485 duplex
control has been discussed here several time. Because it is not possibl=
e
to guarantee the correct timing in any situation this was always nack'd=
=2E

The only chance you have is to use a proper UART that is capable to do =
this
by hardware (e.g. some Exar UARTs or some UARTs that can be found on so=
me
SoCs that are used in the embedded world).

Matthias
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
