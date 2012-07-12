From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/10] Resend: tty updates
Date: Fri, 13 Jul 2012 00:16:16 +0100
Message-ID: <20120713001616.25f17b26@pyramind.ukuu.org.uk>
References: <20120712115643.1321.63498.stgit@localhost.localdomain>
	<20120712213533.GA10361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60730 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162784Ab2GLXMg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 19:12:36 -0400
In-Reply-To: <20120712213533.GA10361@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

On Thu, 12 Jul 2012 14:35:33 -0700
Greg KH <greg@kroah.com> wrote:

> On Thu, Jul 12, 2012 at 12:58:37PM +0100, Alan Cox wrote:
> > TTY cleanups and pre-requisites for the lock handling change.
> >=20
> > Resending as it seems these got lost given the stuff before and aft=
er
> > them is already applied (including stuff in -next that depends on t=
hese).
>=20
> No, they were not lost, I rejected them as they were broken, didn't y=
ou
> get that email showing what was wrong with them?

I didn't.

> For example, the 01/10 patch is broken with:
> drivers/usb/serial/f81232.c: In function =E2=80=98f81232_set_termios=E2=
=80=99:
> drivers/usb/serial/f81232.c:180:2: warning: passing argument 1 of =E2=
=80=98tty_termios_copy_hw=E2=80=99 from incompatible pointer type [enab=
led by default]
> include/linux/tty.h:455:13: note: expected =E2=80=98struct ktermios *=
=E2=80=99 but argument is of type =E2=80=98struct ktermios **=E2=80=99

Ok I see whats happened - patches are right but in the wrong order. Wil=
l
go fix.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
