From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Sat, 23 Feb 2013 16:20:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302231615140.8229-100000@netrider.rowland.org>
References: <20130223181225.GE30855@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:47196 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758268Ab3BWVUw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Feb 2013 16:20:52 -0500
In-Reply-To: <20130223181225.GE30855@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, 23 Feb 2013, Johan Hovold wrote:

> > Right.  More precisely, registration mustn't be deferred _and_ we
> > mustn't have any broken devpaths.  Currently usb-serial gets one of
> > these wrong and cdc-acm gets the other one wrong.
> 
> Maybe I misunderstand you, but it seems to me that ubs-serial gets both
> right and cdc-acm both wrong, as non-deferred registration guarantees
> non-broken uevent devpaths?

Sorry, yes, you are right.  I wasn't thinking clearly.

> > No, unregistration cannot be deferred.  However the usb-serial core 
> > could try to compensate for the problem by refusing to pass callbacks 
> > through to the subdriver after the port has been unregistered.  I don't 
> > know if that would work -- it wouldn't if some of the callback routines 
> > are located in the subdriver itself as opposed to usb-serial.c.
> 
> It should be ok as all tty callbacks are made through usb serial core.
> 
> I have a pretty good overview over what callbacks we can be expecting
> when, and those that we cannot prevent tty from making, we'll deal with
> in usb-serial core.
> 
> My fix for the dtr_rts case is in 3.9-rc, and I try to reduce some of
> the callbacks with my TTY patches (which would for example make the
> dtr_rts fix unnecessary).

So you could do it that way.  But IMO changing the tty layer would be
preferable, if it can be done without too much difficulty.  That would
allow both usb-serial and cdc-acm to be fixed fairly easily.

Alan Stern

