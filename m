From: "Francisco M. Marzoa Alonso" <fmmarzoa@softronica.org>
Subject: Migrating from Windows to LiNUX speed problems
Date: Wed, 25 Aug 2004 08:48:17 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408250848.17379.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 55.Red-213-4-20.pooles.rima-tde.net ([213.4.20.55]:48000 "EHLO
	softronica.org") by vger.kernel.org with ESMTP id S268575AbUHYGjb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2004 02:39:31 -0400
Received: from 10.10.0.21 (unknown [10.10.0.21])
	by softronica.org (Postfix) with ESMTP id 4664A7E26
	for <linux-serial@vger.kernel.org>; Wed, 25 Aug 2004 08:31:50 +0200 (CEST)
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi again,

I've "solved" my problems with communications under LiNUX for my progra=
m, but=20
it still does not run as well as in Windows. In Windows the same progra=
m with=20
the same hardware, same baudrate and same configuration parameters (I=20
think...) works three or four times faster. This is really a problem be=
cause=20
the goal of my program is to update the firmware of a device, and the=20
device's fan is stopped during firmware transmission, so it gets hotter=
 than=20
Hell if the transmission takes much time -and it does-.

This is the process:

The program read an .h86 file line by line. There're some lines that me=
ans=20
special operations like changing memory address, but the majority of th=
ey are=20
a chunk of bytes that must be transmitted to the device in the followin=
g way:

Send a "WRITE_TO_FLASH" command to the device (Writing a char to serial=
 port)
Send a pair of bytes to the device (Writing two chars to serial port)
Get the answer from the device (Reading one char from serial port)

I've oppened the port with NON_BLOCK option and I've test several combi=
nations=20
of values for c_cc[VMIN] and c_cc[VTIME]. I perform a call to select in=
 every=20
read char operation anyway for wait for data, I do NOT perform now a ca=
ll to=20
select in write char operations because after several tests it seems to=
 be=20
unuseful on my program.=20

So... from where could I begin to find the source of the lag?

Thx. a lot.


--=20
=46rancisco M. Marzoa Alonso
Responsable de Software - Softr=F3nica S.A.
http://www.softronica.org/
C/Herrer=EDas, 14 - 28760 Tres Cantos (Madrid)
tfno. +34 918 038 600  fax. +34 918 032 297
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
