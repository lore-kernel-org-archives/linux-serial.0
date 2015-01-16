From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 0/6] N_TTY input path fixes
Date: Fri, 16 Jan 2015 15:05:33 -0500
Message-ID: <1421438739-29672-1-git-send-email-peter@hurleysoftware.com>
References: <1421113668-20468-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421113668-20468-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Christian Riesch <christian.riesch@omicron.at>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Denis Du <dudenis2000@yahoo.ca>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Greg,

Here's the unordered access fix blown up to a series :(

The first patch removes receive_room() from the non-producer code
paths; this avoids the complication of read_head access from the
consumer-side. Exclusive-use paths (where the termios_rwsem is write-locked,
such as n_tty_set_termios(), n_tty_ioctl() and n_tty_flush_buffer()) can
access any of the buffer indexes without racing, since both the input
worker and reader are excluded by the write lock.

The second patch fixes a failure to make forward progress if an
unterminated line longer than 3967 chars is received in canonical mode; the
tty will mistakenly be throttled and thus potentially never receive the
line termination.

The third patch simplifies the throttle threshold calculation, _and_
removes the last-but-one receive_room() call site.

The fourth patch fixes the unordered read buffer accesses with weakly-
ordered arches.

The fifth patch fixes the space calculation issue noted by Christian;
while this is low priority, the subsequent patch requires it.

The sixth patch fixes input handling when a line termination has
not been received and the read buffer is full.

I'll send a separate email for which stables these can be directly applied;
then I'll get to work on backporting these fixes to the other longterm
stable trees.

Regards,

Peter Hurley (6):
  n_tty: Eliminate receive_room() from consumer/exclusive paths
  n_tty: Fix throttle for canon lines > 3967 chars
  n_tty: Simplify throttle threshold calculation
  n_tty: Fix unordered accesses to lockless read buffer
  n_tty: Fix PARMRK over-throttling
  n_tty: Fix read buffer overwrite when no newline

 drivers/tty/n_tty.c | 209 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 119 insertions(+), 90 deletions(-)

-- 
2.2.2
