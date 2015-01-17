From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 0/3] Fix buffer flush in signal char handling
Date: Sat, 17 Jan 2015 15:42:03 -0500
Message-ID: <1421527326-4368-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Greg,

This series fixes a long-standing problem with Ctrl-C interruption
of pty output. A while back I tried to fix this in a really ugly
way that Alan ixnay'd.

Quick background: the FIXME in pty_flush_buffer() relates to the
potential for deadlock if tty_buffer_flush() is done in parallel
by both ptys. The two potential sources for deadlock were the
tty->ldisc_sem and the tty_buffer lock.

The first source of deadlock, the tty->ldisc_sem, can/is avoided
by not waiting for the ldisc ref; ie., the buffer flush is simply
not performed if the ldisc ref is not acquired. In this context,
not acquiring the ldisc_sem is only possible when changing the
line discipline. Although this approach is not perfect, I feel
it's a > 99% solution.

The second source of deadlock stems from the fact that the
input worker is holding the tty buffer lock while processing
input. While this prevents a concurrent buffer flush of its
own tty buffer, this also threatens a lock order inversion:

 CPU 0                                 | CPU 1
 flush_to_ldisc()                      | flush_to_ldisc()
   claim slave buffer lock             |   claim master buffer lock
   - process input -                   |   - process input -
   n_tty_receive_signal_char           |   n_tty_receive_signal_char
     tty_driver_flush_buffer           |     tty_driver_flush_buffer
       pty_flush_buffer                |       pty_flush_buffer
         tty_buffer_flush(other)       |         tty_buffer_flush(other)
           try to claim other buf lock |           try to claim other buf lock

                                 * DEADLOCK *

_Except_ the CPU1 call chain is not possible because the
pty master can never have termios settings of either BRKINT or
ISIG, so the lock order inversion is not possible.

So patch 2 re-enables the tty_buffer_flush() in pty_flush_buffer() and
adds lockdep annotation for the tty buffer lock; normal ttys and pty
masters use the subclass 0 lock and pty slaves use the subclass 1 lock.

This will still warn of any lock order inversions that are actually
a problem.

Patch 1 just generalizes the existing lockdep annotation used for the
tty_lock(), so that patch 2 and 3 can use it.

Patch 3 fixes the very obvious problems that shows up when pty slaves start
flushing data; all kinds of i/o ordering issues show up. For example, if you
interrupt a 'cat large-text-file', the echoed '^C' appears out-of-order, or a
chunk of output is missing before the trailing out (because that is now
flushed by pty_flush_buffer() but the writer hasn't processed the signal yet).
FWIW, these same problems exist with regular ttys, but the speed of ptys
makes it way more obvious.

Regards,

Peter Hurley (3):
  tty: Make lock subclasses available for other tty locks
  pty: Fix buffer flush deadlock
  n_tty: Fix signal handling flushes

 drivers/tty/n_tty.c      | 45 ++++++++++++++++++++++++++++++---------------
 drivers/tty/pty.c        | 11 ++++++++++-
 drivers/tty/tty_buffer.c |  6 ++++++
 drivers/tty/tty_mutex.c  | 12 +-----------
 include/linux/tty.h      | 24 ++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 27 deletions(-)

-- 
2.2.2
