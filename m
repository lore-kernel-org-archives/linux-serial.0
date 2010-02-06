From: Greg KH <greg@kroah.com>
Subject: Re: Review and minor fixes for ftdi_sio.c
Date: Sat, 6 Feb 2010 02:40:29 -0800
Message-ID: <20100206104029.GB8377@kroah.com>
References: <6efe08af1002060218i614eebe8w860ec063878e0564@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:36340 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab0BFKle (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Feb 2010 05:41:34 -0500
Content-Disposition: inline
In-Reply-To: <6efe08af1002060218i614eebe8w860ec063878e0564@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
Cc: USB list <linux-usb@vger.kernel.org>, linux-serial@vger.kernel.org, kuba@mareimbrium.org

On Sat, Feb 06, 2010 at 12:18:04PM +0200, Vitaly V. Ch wrote:
> On Fri, Feb 5, 2010 at 6:38 PM, Greg KH <greg@kroah.com> wrote:
> > On Fri, Feb 05, 2010 at 11:54:56AM +0200, Vitaly V. Ch wrote:
> >> Hi all!
> >>
> >> I'm find then ftdi_sio.c in 2.4.37.8 kernel have next bug: if I have
> >> three ftdi-232 simultaneously connected to middle-loaded host,
> >> application which use one of them will hung in driver, usually during
> >> few hour.
> >
> > Can you look at the version in 2.6.33-rc6, and also in the linux-next
> > tree? ?Both of those have changes to this driver already done, and
> > hopefully this fixes your problem.
> 
> 1)
> Yes, I will see in that files but I can't use 2.6.xx kernel. I will
> backport fixes to 2.4.37.8.

Ah, my fault, I missed the "2.4" portion of your email above, sorry
about that.

And if you are stuck with 2.4, sorry, but you really are on your own.

good luck,

greg k-h
