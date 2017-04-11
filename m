From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] serdev: fix broken lifetime assumptions
Date: Tue, 11 Apr 2017 19:07:27 +0200
Message-ID: <20170411170731.4085-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

This series fixes a number of issues with the new serdev code, which was
based on incorrect tty-port lifetime assumptions.

The first patch disables serdev support by reverting the patch which
hooked into the tty layer in a broken way that leads to crashes and
leaks when deregistering devices. This one should probably go into 4.11.

The second patch fixes a specific bug in the tty-port client
registration code, while the third patch adds a new interface for
registering serdev devices. The final patch ultimately enables serdev
again for the serial drivers.

More details can be found in the individual commit messages.

Johan


Johan Hovold (4):
  Revert "tty_port: register tty ports with serdev bus"
  serdev: fix tty-port client deregistration
  tty/serdev: add serdev registration interface
  serial: enable serdev support

 drivers/tty/serdev/serdev-ttyport.c | 21 +++++++----
 drivers/tty/serial/serial_core.c    |  4 +-
 drivers/tty/tty_port.c              | 74 ++++++++++++++++++++++++++++++++++---
 include/linux/serdev.h              |  7 +++-
 include/linux/tty.h                 |  9 +++++
 5 files changed, 99 insertions(+), 16 deletions(-)

-- 
2.12.2
