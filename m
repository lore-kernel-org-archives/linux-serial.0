From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/10] Resend: tty updates
Date: Thu, 12 Jul 2012 14:35:33 -0700
Message-ID: <20120712213533.GA10361@kroah.com>
References: <20120712115643.1321.63498.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36186 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964803Ab2GLVff (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 17:35:35 -0400
Content-Disposition: inline
In-Reply-To: <20120712115643.1321.63498.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Thu, Jul 12, 2012 at 12:58:37PM +0100, Alan Cox wrote:
> TTY cleanups and pre-requisites for the lock handling change.
>=20
> Resending as it seems these got lost given the stuff before and after
> them is already applied (including stuff in -next that depends on the=
se).

No, they were not lost, I rejected them as they were broken, didn't you
get that email showing what was wrong with them?

=46or example, the 01/10 patch is broken with:
drivers/usb/serial/f81232.c: In function =E2=80=98f81232_set_termios=E2=
=80=99:
drivers/usb/serial/f81232.c:180:2: warning: passing argument 1 of =E2=80=
=98tty_termios_copy_hw=E2=80=99 from incompatible pointer type [enabled=
 by default]
include/linux/tty.h:455:13: note: expected =E2=80=98struct ktermios *=E2=
=80=99 but argument is of type =E2=80=98struct ktermios **=E2=80=99

So I can't include that one :(

Should I look at the others as well?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
