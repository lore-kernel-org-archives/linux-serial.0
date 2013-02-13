From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH] USB: serial: fix null-pointer dereferences on disconnect
Date: Wed, 13 Feb 2013 15:48:56 +0100
Message-ID: <20130213144856.GB21078@localhost>
References: <20130213142513.GA21078@localhost>
 <1360765731-23164-1-git-send-email-jhovold@gmail.com>
 <20130213143436.GE4819@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:44668 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759024Ab3BMOuT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Feb 2013 09:50:19 -0500
Content-Disposition: inline
In-Reply-To: <20130213143436.GE4819@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Johan Hovold <jhovold@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, stable@vger.kernel.org

On Wed, Feb 13, 2013 at 04:34:36PM +0200, Felipe Balbi wrote:
> On Wed, Feb 13, 2013 at 03:28:51PM +0100, Johan Hovold wrote:
> > Make sure serial-driver dtr_rts is called with disc_mutex held after
> > checking the disconnected flag.
> > 
> > Due to a bug in the tty layer, dtr_rts may get called after a device has
> 
> why don't you fix the bug in the tty layer instead ?

I'm workin on it. ;)

As I mentioned earlier I'll send a follow up mail with some more details
on the tty issue and some RFC patches which would actually fix the
immediate issue as well.

There is nothing wrong with checking the disconnected flag either way.
In fact, it could be considered an optimisation as it will be set once
the physical device is gone which is some time before the hangup is
complete and the tty device unregistered. We already use the flag to
prevent further opens after a disconnect.

/Johan
