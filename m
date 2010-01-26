From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: request for assistance:  accessing ttys from kernel space
Date: Tue, 26 Jan 2010 02:13:06 +0000
Message-ID: <20100126021306.16809e71@lxorguk.ukuu.org.uk>
References: <20100126020203.GA23551@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54307 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753320Ab0AZCMA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Jan 2010 21:12:00 -0500
In-Reply-To: <20100126020203.GA23551@linux1>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: William Hubbs <w.d.hubbs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@suse.de, Samuel Thibault <samuel.thibault@ens-lyon.org>, Chris Brannon <cmbrannon79@gmail.com>, Kirk Reiser <kirk@reisers.ca>

> Currently, speakup is using direct hardware access to communicate with
> serial ports.  Doing so, however, has limitations since we are hard
> coding port addresses and IRQ numbers.  For example, we have a user

I pointed this out several years ago

> What I would like to discuss is how we can access ttys from kernel
> space.  If we could do this, it would definitely make things much easier
> for us in speakup.

Basically - use a line discipline, that lets you sit on top of a tty and
interact with the hardware

> We need to be able to access the ttys as early as possible in the boot
> sequence.  Any help, suggestions, or guidance you could give us would be
> greatly appreciated.

We may need to make some special provision for that aspect - we already
do so for the early serial console support. The ldisc is the start point
then there may be some bits that need to be extended around it.

A bigger problem is going to be the fact non USB serial is vanishing bit
by bit. We do have a USB console but it's truely crazy stuff and
extending it scares me 8)
