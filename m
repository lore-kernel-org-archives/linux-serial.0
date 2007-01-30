From: Theodore Tso <tytso@mit.edu>
Subject: Re: New IOCTL for Modem Control Lines monitoring
Date: Mon, 29 Jan 2007 21:39:02 -0500
Message-ID: <20070130023902.GB28035@thunk.org>
References: <45B8E44D.5050005@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:54240 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965236AbXA3EvU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Jan 2007 23:51:20 -0500
Content-Disposition: inline
In-Reply-To: <45B8E44D.5050005@loria.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dominique Larchey-Wendling <Dominique.Larchey-Wendling@loria.fr>
Cc: linux-serial@vger.kernel.org

On Thu, Jan 25, 2007 at 06:09:33PM +0100, Dominique Larchey-Wendling wrote:
> Even tough such an event would have a low probability to occur
> if the 2 ioctl are close enough, it is still possible. This is
> a race condition (outside the kernel but possibly locking some
> process).
> 
> I propose the introduction of a new ioctl to solve this race,
> implemented through the NEW function uart_wait_new_status associated
> to a NEW ioctl.
> 
> The idea is that this new call would detect a change not compared
> to the status at the beginning of the call but compared to some
> previously recorded state. This way, the new ioctl would not
> miss a status change, even if it occurs before the call to the
> ioctl.

You're right that this is a technical flaw in TIOCMIWAIT.  When it was
originally implemented, it was done to retain compatibility with older
implementations in other OS's.

The question is why do you need such functionality?  The only way to
implement what you propose would be pass a structure containing the
previous counts into your proposed new ioctl(), which won't be well
received by the folks who have to maintain 32/64-bit translation
tables for ioctl's for use by supporting architectures that have to
support 32 and 64 bit ABI's simultaneously.  Because of this issue
some folks have proposed killing off ioctl's entirely, which is
probably not the right answer, but the fact remains that adding new
ioctl's that require passing in pointers to arbitrary data structures
is definitely not going to be well received.

So what are you actually trying to *do*?  Is this just to fix a
theoretical shortcoming?  What does your application really need to
do, and perhaps there's a another way we can address it with perhaps a
cleaner interface.

					- Ted
