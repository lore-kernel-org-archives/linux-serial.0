From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
Date: Fri, 29 Mar 2019 11:51:40 -0500
Message-ID: <20190329165140.GD31733@minyard.net>
References: <20190305171231.22133-1-minyard@acm.org>
 <eea0ad95-8344-371a-1dd0-58c8366a355b@infradead.org>
 <20190306015149.GD4290@minyard.net>
 <041e137e-0b9d-04f9-255d-b1f402b23c17@infradead.org>
 <447407be-0f49-f29d-6e81-bf4ed0a6e56b@zytor.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <447407be-0f49-f29d-6e81-bf4ed0a6e56b@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, cminyard@mvista.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 28, 2019 at 12:39:12PM -0700, H. Peter Anvin wrote:
> Dumb question: this is basically a pty on steroids. Wouldn't this be
> better done by enhancing the pty devices?

I did look at that, but it would be pretty invasive to pty.  There's
no modem control stuff, none of the other special serial ioctls.  And
the locking in this driver is fairly strange because you have two
serial ports looking at each other's data for modem control.  But
that might not be a big deal.

Adding the speed simulation to ptys would also be really strange.
That's not a deal-breaker, I suppose, but it's not much of a serial
port simulation without it.

-corey
