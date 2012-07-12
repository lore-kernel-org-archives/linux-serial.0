From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 03/10] usb, kobil: Sort out some bogus tty handling
Date: Thu, 12 Jul 2012 14:38:26 -0700
Message-ID: <20120712213826.GA18316@kroah.com>
References: <20120712115643.1321.63498.stgit@localhost.localdomain>
 <20120712115928.1321.42145.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56558 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964796Ab2GLVi3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jul 2012 17:38:29 -0400
Content-Disposition: inline
In-Reply-To: <20120712115928.1321.42145.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Thu, Jul 12, 2012 at 12:59:33PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
>=20
> Stuff noticed while doing the termios conversion.
>=20
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>=20
>  drivers/usb/serial/kobil_sct.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

This breaks the build with:

drivers/usb/serial/kobil_sct.c: In function =E2=80=98kobil_set_termios=E2=
=80=99:
drivers/usb/serial/kobil_sct.c:591:37: error: =E2=80=98old_termios=E2=80=
=99 undeclared (first use in this function)
drivers/usb/serial/kobil_sct.c:591:37: note: each undeclared identifier=
 is reported only once for each function it appears in

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
