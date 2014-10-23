From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH -next 11/27] tty: Don't release tty locks for wait queue
 sanity check
Date: Thu, 23 Oct 2014 12:30:36 +0100
Message-ID: <20141023123036.659e8478@alan.etchedpixels.co.uk>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
	<1413491125-20134-12-git-send-email-peter@hurleysoftware.com>
	<20141022162911.432c9bcc@alan.etchedpixels.co.uk>
	<5447EA9F.1070401@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5447EA9F.1070401@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> (and -- don't laugh -- explore why printk disables interrupts and prevents
> cpu migration while calling the console drivers. Seems ok to me...)

It disables interrupts so that the chance of the oops getting out is
maximised, it locks down some of the other bits to try and stop
interleaved oopses producing garbage when say a 16 way server goes pop and
all the cpus oops at once.

Not sure about the migration 8)

Alan
