From: Dmitriy Alekseev <alexeev6@yahoo.com>
Subject: Using quad uart st16c554 on at91rm9200 linux 2.6.30 board
Date: Fri, 4 May 2012 01:34:23 -0700 (PDT)
Message-ID: <1336120463.81282.YahooMailNeo@web44901.mail.sp1.yahoo.com>
Reply-To: Dmitriy Alekseev <alexeev6@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm21.bullet.mail.sp2.yahoo.com ([98.139.91.91]:28600 "HELO
	nm21.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752131Ab2EDIeY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 May 2012 04:34:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hello, Developers.



Trying to add support of st16c554 quad uart in at91rm9200 based board.
=46irst, doing menuconfig...
=46rom /drivers/serial/Konfig:
config SERIAL_8250_EXAR_ST16C554
tristate "Support Exar ST16C554/554D Quad UART"
depends on SERIAL_8250 !=3D n && ISA && SERIAL_8250_MANY_PORTS
ISA required, but isn't avaiable for at91 system type:
Symbol: ISA [=3Dn] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
=A0 Type =A0: boolean =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
=A0 =A0 =A0Selected by: ARCH_EBSA110 [=3Dn] && <choice> || ARCH_SA1100 =
[=3Dn] && ...=A0no AT91


Nevertheless, this message=A0http://www.spinics.net/lists/arm-kernel/ms=
g55077.html=A0gives hope that it is possible.
But how?=A0
If this device is not supporting, suggest me please, what better to use=
 instead.

Thanks.
Best regards,
Dmitriy Alekseev
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
