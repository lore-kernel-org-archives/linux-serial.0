From: Peter Astrand <peter@cendio.se>
Subject: Re: sredird fork: sercd
Date: Sun, 1 Aug 2004 16:46:13 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0408011633480.12619-100000@maggie.lkpg.cendio.se>
References: <200408020023.55246.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cheddar.cendio.se ([193.12.253.77]:52207 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id S266002AbUHAOqP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Aug 2004 10:46:15 -0400
In-Reply-To: <200408020023.55246.russell@coker.com.au>
List-Id: linux-serial@vger.kernel.org
To: Russell Coker <russell@coker.com.au>
Cc: Denis Sbragion <d.sbragion@infotecna.it>, jaltman@columbia.edu, mario@viara.info, linux-serial@vger.kernel.org, Corey Minyard <minyard@acm.org>

> On Sat, 20 Dec 2003 00:39, Peter Astrand <peter@cendio.se> wrote:
> > I've created a new project for a RFC2217 serial redirection daemon:
> > "sercd" (Serial Communications Daemon). This is basically a fork of
> > sredird. Compared to sredird, this project includes:
>=20
> I've just had a look at the sercd project.  It seems like nothing has=
 happened=20
> since December last year.  The only apparent differences between serc=
d.c and=20
> sredird.c are comments and code style.

Yes, pretty much. sercd fixed a buffer handling code, which was later a=
lso
fixed in sredird. The main reason for creating the fork was the lack of
CVS repository. The sredird maintainer also said that he "no longer hav=
e
any spare time to dedicate to this project."


> Which is the most live of these projects? =20

Wrt sercd: No development is going on currently, but I accept patches,=20
answer mail etc. I have some plans (and some code) for a native Win32=20
port, but don't expect anything soon.=20

(sercd/sredird is actually quite feature-complete. cyclades-serial-clie=
nt=20
is more spotty.)


> As there have been security bugs reported against sredird I want to p=
ut
> a replacement in Debian which has the bugs fixed.  I would prefer to
> avoid any serious coding on this myself due to lack of time.  If one =
of
> the two projects could issue a new release to fix the security issues
> (in a separate message) then I'll put it in Debian.

I'll take a look at it.=20


--=20
Peter =C5strand		Chief Developer
Cendio			www.thinlinc.com
Teknikringen 3		www.cendio.se
583 30 Link=F6ping        Phone: +46-13-21 46 00



-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
