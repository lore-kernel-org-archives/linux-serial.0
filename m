From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2] fix serial console resume-from-suspend
Date: Wed,  9 Jul 2014 09:21:13 -0400
Message-ID: <1404912074-9729-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Greg,

This v2 respin removes the dependency on the patch to which Alan objected
(regarding not hanging up remote serial console modems).

This patch fixes bugzilla #69751, where the serial console is garbled
after resume from suspend.

Although this was originally reported as a regression, this bug is
actually caused when a user-space process (such as setserial or stty)
opens and then closes the associated tty. The resultant tty port shutdown
caused the console termios settings to be lost, and thus uninitialized when
the console was subsequently suspended and then resumed (and there was not
an associated open tty).

This patch preserves the cflag settings from the associated tty as the
console cflags (which reflect the current line settings anyway). The
console cflags are already used to restore the console line settings if
there is not an associated open tty.

The side-effect of this patch is that the serial console line settings
are persistent. Originally, only the first-time initialization of the
associated port inherited the console line settings; now, each time the
associated port is initialized to the most recent line settings.

Peter Hurley (1):
  serial: core: Preserve termios c_cflag for console resume

 drivers/tty/serial/serial_core.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.0.0
