From: =?UTF-8?Q?Peter_=C3=85strand?= <astrand@cendio.se>
Subject: Enhancing pty driver to act like a serial port?
Date: Sun, 22 Jun 2008 20:26:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806221455410.18596@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="789237761-531857888-1214139625=:18596"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.69]:61274 "EHLO mail.cendio.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbYFVS5J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 22 Jun 2008 14:57:09 -0400
Content-ID: <Pine.LNX.4.64.0806221500290.18596@maggie.lkpg.cendio.se>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Grant Edwards <grante@visi.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--789237761-531857888-1214139625=:18596
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.0806221500291.18596@maggie.lkpg.cendio.se>


>The question of emulating a serial port in user-space has come
>up a number of times in various contexts during the past few
>years. =20
>
>The current pty driver isn't really sufficient when the
>application actually expects to be connected to a physical
>serial port:=20

A better userspace solution would be great. I'm maintaining=20
cyclades-serial-client. It relies on LD_PRELOAD, which is not very=20
elegant.=20



>you can't set parity or word length, and the modem
>control/status ioctl() calls fail.

Oh. I was just investigating why it's not possible to set "cs7" on the=20
pty. stty fails with:

$ stty cs7 -F /my/pty
stty: /my/pty: unable to perform all requested operations

I guess this explains it.=20



Best regards,=20
---
Peter =C3=85strand=09=09ThinLinc Chief Developer
Cendio AB=09=09http://www.cendio.se
Wallenbergs gata 4
583 30 Link=C3=B6ping=09Phone: +46-13-21 46 00
---
Open Source Developers wanted - http://www.cendio.com/about-cendio/career
--789237761-531857888-1214139625=:18596--
