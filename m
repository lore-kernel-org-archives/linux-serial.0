From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Serial driver related problems on Linux
Date: Mon, 14 Mar 2005 21:11:28 -0500
Message-ID: <20050315021128.GC15418@thunk.org>
References: <20050310154125.GB12846@magick.macroped.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from thunk.org ([69.25.196.29]:38037 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261414AbVCOCLf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Mar 2005 21:11:35 -0500
Content-Disposition: inline
In-Reply-To: <20050310154125.GB12846@magick.macroped.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bob Bell <bbell@users.sourceforge.net>
Cc: linux-serial@vger.kernel.org

On Thu, Mar 10, 2005 at 10:41:27AM -0500, Bob Bell wrote:
> 
> I'm contacting you because I'm experiencing a problem on Linux with a
> serial line, and I've traced the problem as far as the Linux kernel.
> I'm hoping that this is the best way to further troubleshoot this
> problem; I noted that Ted T'so is listed as the maintainer for the 2.4
> series (I'm running a 2.4.21 kernel) and Russell for the 2.6 series, so
> I'm hoping a message sent to this mailing list gets the attention of
> whomever is currently actively maintaining the serial/tty code.
> 
> The user-visible symptoms of this problem are that after typing in a
> username and hitting enter, the serial login prompt hangs.  I've traced
> this hang to an ioctl in the login code (TCSETSF, a result of calling
> tcsetattr(,TCSAFLUSH,)).  I've further traced that ioctl to being stuck
> in tty_wait_until_sent().
> 
> The debugging output has a lot of references to "pts", which is not
> surprising as I'm running `crash`, etc. from an ssh login.  Filtering
> those out leaves the following from the time of the login:
>     ttyS wait until sent...
>     waiting ttyS...(1)
>     waiting ttyS...(62)
>     interrupted

It's possible this was caused by a lost transmitter interrupt, so the
transmit queue never drained; it's also possible that some UART's are
wired to not signal a transmitter interrupt while the serial port is
flow controlled.  In order to figure out what is going on, you'd have
to add debugging logic into the interrupt handler as well (i.e.,
#define SERIAL_DEBUG_INTR).

						- Ted
