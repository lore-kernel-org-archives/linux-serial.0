From: Samuel Jobin <sjobin@gniinc.net>
Subject: Serious problem with MAKEDEV and setserial command
Date: Mon, 05 May 2003 15:53:21 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3EB6C131.9090109@gniinc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:44008 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261259AbTEETlL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 May 2003 15:41:11 -0400
Received: from gniinc.net ([67.68.181.130]) by tomts13-srv.bellnexxia.net
          (InterMail vM.5.01.04.19 201-253-122-122-119-20020516) with ESMTP
          id <20030505195341.NFHN22698.tomts13-srv.bellnexxia.net@gniinc.net>
          for <linux-serial@vger.kernel.org>;
          Mon, 5 May 2003 15:53:41 -0400
Received: from gniinc.net (unknown [192.168.100.158])
	by gniinc.net (Postfix) with ESMTP id 42C963E87
	for <linux-serial@vger.kernel.org>; Mon,  5 May 2003 15:53:41 -0400 (EDT)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi!

I have a serious problem with the MAKEDEV and setserial command.  I'm=20
trying to put a lots of multimodem card into a standard linux pc=20
(Slakware 8.1).  I have to associate the modem by myself with the=20
setserial command.  For this, I do:

setserial /dev/ttyS20 irq 10 port 0xd000 ^auto_irq ^fourport skip_test=20
autoconfig

Everything works fine.  The problem is that there's no enough ttyS.  On=
=20
my linux box, I have ttyS1 to ttyS31, but I want more of them.

I triyed the /dev/MAKEDEV command (and I changed the group for uucp).=20
The new dev was created (ttyS32).  I tried to make a setserial it and I=
 got:

Cannot set serial info: Invalid argument

Tried a lot of time, from different method; nothing to do.  I always=20
have the same error message.  I think it's my /dev/ttyS32 that doesn't=20
work (because the same instruction with a ttyS that wasn't created by m=
e=20
works great).

Does somebody could help me please?  I just don't what to do.  (and yes=
,=20
I RTFM! :)  In fact, 2 books and the serial howto...

Thx,

Sam
--=20
Samuel Jobin
   sjobin@gniinc.net
   Software Development
_____________________
  --=3D=3D GNI inc.=3D=3D--
5075 Wilfrid-Hamel O.
Suite 220
Qu=E9bec (QC), G2E 5G3
Phone: (418) 864-7721
=46ax:   (418) 263-3150

-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
