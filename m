From: Peter Astrand <peter@cendio.se>
Subject: Serial port redirection
Date: Mon, 1 Dec 2003 15:32:56 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0312011300480.8142-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.66]:49137 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S262887AbTLAOdD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Dec 2003 09:33:03 -0500
List-Id: linux-serial@vger.kernel.org
To: ltsp-discuss@lists.sourceforge.net
Cc: Corey Minyard <minyard@acm.org>, d.sbragion@infotecna.it, linux-serial@vger.kernel.org


Hi. I'm trying to find a generic serial port redirection solution for a
Linux terminal server environment. I'd like a solution based on RFC2217=
=2E =20
I'm particularly interested in syncing Palm Pilot PDAs.=20

I've found these two servers:

* ser2net
* sredird

Both looks fine. Clients seems to be rare, though. C-Kermit seems to be
the only common client. However, I'd like to be able provide "virtual"
serial port devices on the terminal servers (something like
/dev/xterminals/1/ttyS0). After much searching, I've found
"cyclades-serial-client" (http://www.coker.com.au/cyclades/). This pack=
age
has a few problems, though:

* The software is hard to find.=20

* No public CVS repository

* Pretty much assumes you are using a Cyclades terminal server

* The author (russell@coker.com.au) does not answer mail or accept patc=
hes


I've tried cyclades-serial-client both with sredird and ser2net, with s=
ome
applications, but it doesn't work very good:

sredird + cyclades-ser-cli + pilot-link
---------------------------------------
I'm able to use "pilot-xfer -l" to list a few databases, but then the
transmissions ends prematurely with errors.


ser2net + cyclades-ser-cli + pilot-link
---------------------------------------
"pilot-xfer" is unable to establish an connection. cyclades-ser-cli=20
complains about "Unimplemented command 1" etc. Later, it says "Buffer=20
overflow".=20


ser2net/sredird + Kermit
------------------------
Kermit has built-in RFC2217 support, but it doesn't work for me:

---
C-Kermit>set host localhost:4911
 DNS Lookup...  Trying 127.0.0.1...  Reverse DNS Lookup... (OK)
 localhost.localdomain connected on port 4911
C-Kermit>set speed 2400
localhost.localdomain:4911, 2400 bps
C-Kermit>connect
Connecting to host localhost.localdomain:4911
 Escape character: Ctrl-\ (ASCII 28, FS): enabled
Type the escape character followed by C to get back,
or followed by ? to see other options.
----------------------------------------------------
,
Communications disconnect
---

Kermit disconnects me as soon as I type any character.=20


Comments? Has anyone successfully used the cyclades-serial-client packa=
ge=20
with sredird or ser2net? cyclades-serial-client is included in Debian, =
so=20
I think it's a bit strange that it has never been tried with a Linux=20
RFC2217 server before.=20



--=20
Peter =C5strand		www.thinlinc.com
Cendio			www.cendio.se
Teknikringen 3		Phone: +46-13-21 46 00
583 30 Link=F6ping


-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
