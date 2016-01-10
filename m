From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 0/3] Remove ASYNC_CLOSING
Date: Sun, 10 Jan 2016 14:51:37 -0800
Message-ID: <1452466300-4372-1-git-send-email-peter@hurleysoftware.com>
References: <1449956976-4784-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449956976-4784-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Changes for v2: rebased on top of tty-next

Hi Greg,

This series removes ASYNC_CLOSING from kernel use. However, the definition
is in a uapi header so I think it needs to stay.

The mxser driver used ASYNC_CLOSING to purge its fifo _with each
byte received_ while closing. This is clearly unnecessary but the
hangup/shutdown sequence in that driver is spaghetti and I don't have
the hardware to test (what I would consider to be) the proper fix:
cleaning up its hangup/shutdown so that clearing the fifo can be
done once in shutdown.

The isdn subsystem used ASYNC_CLOSING for unclear purposes; the
immediate effect was to prevent sending AT commands from the
emulator, but its not clear why that's necessary when closing.
Since idsn does not use the tty_port helpers, I simply added
to isdn the equivalent of an ASYNC_CLOSING flag.

Regards,

Peter Hurley (3):
  tty: mxser: Remove ASYNC_CLOSING
  isdn: Remove ASYNC_CLOSING
  tty: Remove ASYNC_CLOSING

 drivers/isdn/i4l/isdn_tty.c      | 12 ++++++------
 drivers/s390/char/con3215.c      |  3 +--
 drivers/tty/mxser.c              |  9 +++++----
 drivers/tty/rocket.c             |  2 +-
 drivers/tty/serial/68328serial.c |  3 +--
 drivers/tty/serial/crisv10.c     |  3 +--
 drivers/tty/serial/serial_core.c |  1 -
 drivers/tty/tty_port.c           |  3 +--
 include/linux/isdn.h             |  1 +
 net/irda/ircomm/ircomm_tty.c     |  4 ----
 10 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.7.0
