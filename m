From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: request for assistance:  accessing ttys from kernel space
Date: Thu, 28 Jan 2010 01:45:47 +0100
Message-ID: <20100128004547.GQ4887@const.famille.thibault.fr>
References: <20100126020203.GA23551@linux1> <20100126021306.16809e71@lxorguk.ukuu.org.uk> <20100126024049.GQ21492@const.famille.thibault.fr> <20100126133958.49e660a5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:53608 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753434Ab0A1Apx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jan 2010 19:45:53 -0500
Content-Disposition: inline
In-Reply-To: <20100126133958.49e660a5@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Hubbs <w.d.hubbs@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@suse.de, Chris Brannon <cmbrannon79@gmail.com>, Kirk Reiser <kirk@reisers.ca>

Alan Cox, le Tue 26 Jan 2010 13:39:58 +0000, a =E9crit :
> > Is there another way to set up a line discipline from the kernel it=
self
> > without the need from userland intervention, even before any / is
> > mounted?
>=20
> There is no fundamental reason you can't do that once the tty object
> itself exists.

I know.

> Currently there is no path for doing it in the kernel.

That's my concern :)

Thanks,
Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
