From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Mon, 9 May 2005 11:43:12 -0400
Message-ID: <20050509154312.GA19091@thunk.org>
References: <20050509095903.A5674@flint.arm.linux.org.uk> <001701c5547e$5bd9cca0$2e01a8c0@acksys.fr> <20050509111338.C5674@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:10426 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261406AbVEIPnX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 May 2005 11:43:23 -0400
Content-Disposition: inline
In-Reply-To: <20050509111338.C5674@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Tosoni <jp.tosoni@acksys.fr>, linux-serial@vger.kernel.org

On Mon, May 09, 2005 at 11:13:38AM +0100, Russell King wrote:
> 
> There are many different styles of use of RTS.  The conventional one
> and your one are only two.  There are more than two, and all of them
> are exclusive.  I don't see why you made the above comment, since we
> obviously agree.
> 

It's worse than this.  Even with the ancient/historic RTS/CTS toggle
approach, I've heard all sorts of different timing constraints.  For
example, in some implementations the implementation must wait at
_least_ (or in other cases no more than) some time period before
toggling CTS.  The old RS-422 devices were so crufty that they all had
their own idiosyncratic requirements.

My suggestion would be to do this as a new line discpline, and have
the line displine act as a pass-through to the N_TTY line displine for
those things that it doesn't need to do differently.

						- Ted
