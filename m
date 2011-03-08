From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] n_gsm: add a documentation
Date: Tue, 8 Mar 2011 12:52:08 +0000
Message-ID: <20110308125208.3ed69f49@lxorguk.ukuu.org.uk>
References: <1299543872-14580-1-git-send-email-eric@eukrea.com>
	<1299543872-14580-2-git-send-email-eric@eukrea.com>
	<4D7577F0.2030901@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36697 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753175Ab1CHMwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Mar 2011 07:52:01 -0500
In-Reply-To: <4D7577F0.2030901@eukrea.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Eric =?ISO-8859-14?B?QuluYXJk?= <eric@eukrea.com>
Cc: linux-serial@vger.kernel.org

On Tue, 08 Mar 2011 01:27:28 +0100
Eric B=E9nard <eric@eukrea.com> wrote:

> Hi,
>=20
> On 08/03/2011 01:24, Eric B=E9nard wrote:
> > +6- first close all virtual ports before closing the physical port.
> > +
>=20
> here is what I get when closing the physical serial port and when a v=
irtual=20
> port is still open :

That looks like it wants reporting to Arnd as it looks like fall out fr=
om
the tty_lock/unlock changes removing the big kernel lock.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
