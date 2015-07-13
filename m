From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 0/7] tty core debug patches
Date: Sun, 12 Jul 2015 22:49:06 -0400
Message-ID: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

This patchset replaces the printk(KERN_DEBUG) uses in the tty core
with a common tty_debug(tty, ...) base macro, folding in the common
elements of tty name and function name.

The many inline #ifdef TTY_SOME_DEBUG_FLAG printk's are replaced
with macro equivalents which reduce to tty_debug().

Several important improvements include:
* patch 1/7 adds the tty count to the tty_open() message
* patch 6/7 improve the ldisc messages to aid in state debugging
* patch 7/7 adds pmtx open (which helps clarify when the master was opened)

An important outcome of a single tty_debug() macro is that it can
be trivially changed to use a different debug facility than console;
for example, for some of my torture tests using the ftrace facility
is much less intrusive. I would expect that to remain a local change though.

Regards,

Peter Hurley (7):
  tty: core: Improve debug message content
  tty: core: Add tty_debug() for printk(KERN_DEBUG) messages
  tty: Replace #ifdef TTY_DEBUG_HANGUP with tty_debug_hangup()
  tty: Use tty_debug() for tty_ldisc_debug()
  tty: Replace inline #ifdef TTY_DEBUG_WAIT_UNTIL_SENT
  tty: core: Improve ldisc debug messages
  pty: Add debug message for ptmx open

 drivers/tty/pty.c       |  8 ++++++
 drivers/tty/tty_io.c    | 67 +++++++++++++++++++------------------------------
 drivers/tty/tty_ioctl.c | 11 +++++---
 drivers/tty/tty_ldisc.c | 15 ++++++-----
 include/linux/tty.h     |  6 +++++
 5 files changed, 55 insertions(+), 52 deletions(-)

-- 
2.4.5
