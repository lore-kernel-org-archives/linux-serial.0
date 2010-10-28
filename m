From: Greg KH <greg@kroah.com>
Subject: Re: [SERIAL]blacklist si3052 chip
Date: Wed, 27 Oct 2010 18:20:10 -0700
Message-ID: <20101028012010.GC29960@kroah.com>
References: <4CC73085.2070304@o2.pl> <20101026224940.22b4ac93@lxorguk.ukuu.org.uk> <4CC74E04.7080407@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:47006 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757995Ab0J1BUh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 21:20:37 -0400
Content-Disposition: inline
In-Reply-To: <4CC74E04.7080407@o2.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Maciej Szmigiero <mhej@o2.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 26, 2010 at 11:54:12PM +0200, Maciej Szmigiero wrote:
> W dniu 26.10.2010 23:49, Alan Cox pisze:
> > On Tue, 26 Oct 2010 21:48:21 +0200
> > Maciej Szmigiero <mhej@o2.pl> wrote:
> > 
> >> [SERIAL]blacklist si3052 chip
> >>
> >> Si3052-based softmodems aren't serial ports so don't bind serial driver to them.
> >> Allows proper driver to bind to them.
> > 
> > Which is the proper driver ?
> > 
> > Alan
> > 
> 
> Awaiting final review on the DAHDI reviewboard.

What does this mean?

confused,

greg k-h
