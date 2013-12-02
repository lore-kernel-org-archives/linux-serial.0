From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 0/4] tty: Fix ^C echo
Date: Mon,  2 Dec 2013 16:12:01 -0500
Message-ID: <1386018725-4781-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Greg,

Sometimes when interrupting terminal output, the '^C' won't be echoed
until more output is echoed. This is fairly repeatable by interrupting
'cat large-file'.

The common reason for this is because the tty write buffer is full,
even though the write buffer _should_ have been flushed already.
Because of a known deadlock, the pty driver does not perform a
write buffer flush in its flush_buffer() method.

[Refer to the FIXME in pty_flush_buffer() from commit
d945cb9cce20ac7143c2de8d88b187f62db99bdc,
'pty: Rework the pty layer to use the normal buffering logic']

Patch 1 fixes a stale comment.
Patch 2 adds the necessary interfaces to avoid direct linkage
between the N_TTY line discipline and the pty driver.
Patch 3 avoids the deadlock while performing the write buffer flush.
Patch 4 fixes a less common condition introduced by the echo batch
processing added in 3.12.

Alan,

I cc'd you because of your recent involvement in other
tty patches/bug fixes and because it's your FIXME comment.
Feel free to ignore and/or let me know you would prefer not to
be bothered.

Regards,

Peter Hurley (4):
  tty: Fix stale tty_buffer_flush() comment
  tty: Add flush_nested() tty driver method and accessor
  tty: Fix pty flush
  n_tty: Flush echoes for signal chars

 drivers/tty/n_tty.c        |  8 +++--
 drivers/tty/pty.c          | 32 ++++++++++++++++++-
 drivers/tty/tty_buffer.c   | 79 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/tty/tty_ioctl.c    | 21 ++++++++++++
 include/linux/tty.h        |  1 +
 include/linux/tty_driver.h |  1 +
 include/linux/tty_flip.h   |  2 ++
 7 files changed, 137 insertions(+), 7 deletions(-)

-- 
1.8.1.2
