From: Peter Astrand <peter@cendio.se>
Subject: sredird fork: sercd
Date: Fri, 19 Dec 2003 14:39:35 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0312191428390.8980-100000@maggie.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.cendio.se ([193.12.253.66]:34038 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S263343AbTLSNjj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Dec 2003 08:39:39 -0500
List-Id: linux-serial@vger.kernel.org
To: Denis Sbragion <d.sbragion@infotecna.it>, jaltman@columbia.edu, mario@viara.info, russell@coker.com.au, linux-serial@vger.kernel.org, Corey Minyard <minyard@acm.org>


I've created a new project for a RFC2217 serial redirection daemon:=20
"sercd" (Serial Communications Daemon). This is basically a fork of=20
sredird. Compared to sredird, this project includes:

* Public CVS repository

* Mailing list

* Homepage

* Autoconf-based build system

* Bugfixes. For example, sredird contains a bug hard-to-find bug which
causes occasional data corruption (a byte is sometimes lost).


So, why not work on ser2net instead? Because:

* ser2net does not work with inetd yet

* ser2net requires a configuration file, which I don't need

* And most importantly: ser2net does not work with cyclades-serial-clie=
nt,
and I haven't been able to track down why.


The homepage for sercd is=20
http://www.lysator.liu.se/~astrand/projects/sercd/.=20

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
