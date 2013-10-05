From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [GIT PATCH] TTY/Serial fixes for 3.12-rc4
Date: Sat, 05 Oct 2013 19:57:02 -0400
Message-ID: <5250A74E.4070805@hurleysoftware.com>
References: <20131005173403.GA4811@kroah.com> <CA+55aFzEtnOOB4yPbWg4tmvWTPjQL1_YsZks6wgpGimaQdOEtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzEtnOOB4yPbWg4tmvWTPjQL1_YsZks6wgpGimaQdOEtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikael Pettersson <mikpelinux@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/05/2013 02:53 PM, Linus Torvalds wrote:
> On Sat, Oct 5, 2013 at 10:34 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> One fixes the reported regression in the n_tty code that a number of
>> people found recently
>
> That one looks broken.
>
> Well, it looks like it might "work", but do so by hiding the issue for
> one case, while leaving it in the more general case.
>
> Why does it do that
>
>      up_read(&tty->termios_rwsem);
>      tty_flush_to_ldisc(tty);
>      down_read(&tty->termios_rwsem);
>
> only if TTY_OTHER_CLOSED is set? If flushing the ldisc can generate
> more data, then we should do it *unconditionally* when we see that we
> currently have no data to read.
>
> As it is, it looks like the patch fixes the TTY_OTHER_CLOSED case
> ("read all pending data before returning -EIO"), but it leaves the
> same broken case for the O_NONBLOCK case and for a hung up tty.
>
> The O_NONBLOCK case is presumably just a performance problem (the data
> will come at _some_ point later), but it just looks bad in general.
> And the tty_hung_up_p() looks actiely buggy, with the same bug as the
> TTY_OTHER_CLOSED case that the patch tried to fix.
>
> Hmm? Am I missing something?

When a slave pty is closed, it's not hung up specifically so the
master pty can be read.

The same is not true for a regular tty; when a regular tty is hung up,
all the pending data is vaporized (ie., what the tty layer refers
to as 'flushed'). So checking for more data when tty_hung_up_p() is
true is pointless.

The distinction is clearer when you consider that even after the slave
pty is closed, the master pty can still be read() even if it wasn't
waiting in n_tty_read() at the time; this is not true of a regular tty, which
cannot be read() after a hangup [tty_hung_up_p() tests if the
file_operations pointer is set to non-operational read/write/ioctl functions].

The patch fixes a race condition which is peculiar to ptys only.

> The code is a bit confusing in *other* ways too: if you look later, it
> does this:
>
>      n_tty_set_room(tty);
>
> which is documented to have to happen inside the termios_rwsem.
> HOWEVER, what does that do? It actually does an _asynchronous_
> queue_work() of &tty->port->buf.work, in case there is now more room,
> and the previous one was blocked. And guess what that workqueue is all
> about? Right: it's flush_to_ldisc() - which is the work that
> tty_flush_to_ldisc() is trying to flush. So we're actually basically
> making sure we've flush the previous pending work.

The flush_to_ldisc() worker no longer re-schedules itself.

The flush_to_ldisc() worker is scheduled when one of two events
happen; 1) the driver has just written received data to the tty
buffers, or 2) space has just become available in the N_TTY line
discipline's read buffer when it was previously full.

The flush_to_ldisc() worker continues to run as long as space
is available in the line discipline's read buffer or until the
tty buffers are empty.

Concurrently with the flush_to_ldisc() worker, a reader may have
an empty read buffer; the flush_to_ldisc() worker may or may not
generate more input to be read.

Generally when a reader has an empty read buffer, it will sleep unless
one of the other conditions is met (TTY_OTHER_CLOSED, tty_hung_up_p,
non-blocking, etc).

Before sleeping, the reader will (re-)schedule the flush_to_ldisc()
worker in case it read some input on the previous loop iteration
(thus creating space in the read buffer when there was none previously).

(That doesn't preclude that flush_to_ldisc() may already be running
but isn't processing as fast as the reader is reading.)


> So even the tty_flush_to_ldisc(tty) that gets done in that patch is
> not necessarily sufficient, because the work might not have been
> scheduled because the flip buffer used to be full. Then flushing the
> work won't do anything, even though there is actually more data. Now,
> that is a very unlikely situation (I think it requires two concurrent
> readers), but it looks like it might be real.

I don't think this condition is possible for a single reader (because
the read condition will be satisfied and the reader will return).
Multiple concurrent readers are excluded by the atomic_read_lock mutex
at the the top of n_tty_read().

> So I suspect we should *unconditionally* do
>
>       n_tty_set_room(tty);
>       up_read(&tty->termios_rwsem);
>       tty_flush_to_ldisc(tty);
>       down_read(&tty->termios_rwsem);
>
> if we don't have any pending input. And then test input_available_p()
> again. And only if we don't have any input after that flushing do we
> start doing the whole TTY_OTHER_CLOSED and tty_hung_up_p() tests.
>
> Hmm?

flush_to_ldisc() should not be rescheduled via n_tty_set_room() after
the tty has been hung up. This will trigger the diagnostic warning that
was introduced back in 3.8 which proved that the line discipline
was still running after the tty had been released.

Maybe that's less of an issue (or a non-issue) now that the port owns
the tty buffers and drivers can push i/o without a tty.
I'll give some thought to that.

Looking at this problem at a higher level, in some situations it
would be desirable for a tty to continue to be readable after hang up
(like after carrier loss) but not in others (like exit()).
This is something I'm (kind of) working around right now in the
tty-over-firewire staging driver by delaying hangup on carrier loss.

Regards,
Peter Hurley
