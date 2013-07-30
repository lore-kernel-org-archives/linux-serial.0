From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial/efm32-uart: don't use pdev->id to determine
 the port's line
Date: Tue, 30 Jul 2013 07:51:09 -0700
Message-ID: <20130730145109.GA29971@kroah.com>
References: <20130730082146.GP1754@pengutronix.de>
 <1375172593-24345-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130730083441.GQ1754@pengutronix.de>
 <20130730140250.GG27962@kroah.com>
 <20130730143739.GV1754@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40880 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab3G3Otx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Jul 2013 10:49:53 -0400
Content-Disposition: inline
In-Reply-To: <20130730143739.GV1754@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

On Tue, Jul 30, 2013 at 04:37:39PM +0200, Uwe Kleine-K=F6nig wrote:
> Hi Greg,
>=20
> On Tue, Jul 30, 2013 at 07:02:50AM -0700, Greg Kroah-Hartman wrote:
> > On Tue, Jul 30, 2013 at 10:34:41AM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Tue, Jul 30, 2013 at 10:23:12AM +0200, Uwe Kleine-K=F6nig wrot=
e:
> > > > pdev->id is not a valid choice for device-tree probed devices. =
So use
> > > > the (properly determined) line from efm32_uart_probe consistenl=
y
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.=
de>
> > > > Forwarded: id:1374043721-30677-1-git-send-email-u.kleine-koenig=
@pengutronix.de
> > > I forgot to drop these lines that I use for tracking which patche=
s were
> > > sent for inclusion into mainline. I don't care much, but you migh=
t want
> > > to drop them.
> >=20
> > Please resend so I don't have to hand-edit the messages.  I handle
> > thousands of patches a month, hand-editing is a pain and slows me
> > down...
> ok, just resent to you only after doing
>=20
> 	git filter-branch -f --msg-filter 'grep -v "^Forwarded:"' next/maste=
r..
>=20
> (Maybe this is even easier than replying about your pain? No offense
> intended, just wondering.)

Easier for you, yes :)

But I don't see how that would help me out when applying patches in a
mbox format to a git tree, do you?  What am I missing?

Having to craft a custom grep -v pattern for every message would be a
pain, as people do lots of silly things in patches that need to be
edited out at times...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
