From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] serial/8250: remove comment about schedule_timeout
Date: Thu, 5 Jan 2017 16:59:40 -0500
Message-ID: <20170105215940.nzezqi5qmubaw56x@thunk.org>
References: <20170105154840.24795-1-cascardo@canonical.com>
 <20170105164016.79c6e594@lxorguk.ukuu.org.uk>
 <20170105171744.qgax752sxcwqod2w@calabresa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105171744.qgax752sxcwqod2w@calabresa>
Sender: linux-kernel-owner@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 05, 2017 at 03:17:45PM -0200, Thadeu Lima de Souza Cascardo wrote:
> Okay. At first, I wanted to simply use msleep there, then realized there
> was the spinlock. I thought I got a good writeup of the history that was
> not in git yet, maybe we should just add a better comment and more
> details in the commit log. How about this as the comment?

Could you look at fixing this, instead?  I was taking a look at the
code, and it so very.... 1990's.  It looks like it was written during
the days before SMP, and then locking was smashed in a very
blunt-force way ---- probably because that's how it happened.  :-)

What we should **really** be doing with autoconfiguration, is instead
of using the spinlock to prevent it from being accessed, is to lock
out any attempt to transmit from the top-half, and remove it from the
linked list of ports to prevent the interrupt handler from accessing
it, make sure that any active interrupt handler has exited (and you
can use the spinlock for the preceeding bits), but then we can safely
do the autoconfiguration without having the deal with the spinlock at
all, afterwards.

It should't be *that* hard to just fix it for real.

Cheers,

						- Ted
