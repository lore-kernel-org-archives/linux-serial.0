From: "Francisco M. Marzoa Alonso" <fmmarzoa@softronica.org>
Subject: Saving the port settings to restore later
Date: Wed, 25 Aug 2004 11:34:48 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200408251134.48158.fmmarzoa@softronica.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 55.Red-213-4-20.pooles.rima-tde.net ([213.4.20.55]:46210 "EHLO
	softronica.org") by vger.kernel.org with ESMTP id S265477AbUHYJ0B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Aug 2004 05:26:01 -0400
Received: from 10.10.0.21 (unknown [10.10.0.21])
	by softronica.org (Postfix) with ESMTP id 328117D12
	for <linux-serial@vger.kernel.org>; Wed, 25 Aug 2004 11:18:20 +0200 (CEST)
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I want my program to save serial port settings at the beggining to rest=
ore=20
them when done.

Usually I use an struct termios and a call to tcgetattr to do that, but=
 now I=20
set the ASYNC_LOW_LATENCY flag throug a ioctl using  an struct serial_s=
truct=20
and I think termios does not store this data, so... What's the best man=
ner to=20
save the status of a serial port? only through termios? only through=20
serial_struct? both?

Thx.


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
