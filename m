From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/2] serdev: fix broken lifetime assumptions
Date: Thu, 18 May 2017 17:32:59 +0200
Message-ID: <20170518153301.28885-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

This series fixes a number of issues with the new serdev code, which was
based on incorrect tty-port lifetime assumptions.

The first patch in v1 of this series disables serdev support by reverting the
patch which hooked into the tty layer in a broken way that leads to crashes and
leaks when deregistering devices. That one has now been applied to tty-linus
with a stable tag (for v4.11).

The remaining two patches again re-enables serdev (first enabled in 4.11, but
soon reverted in stable) for a subset of tty drivers by adding adding a new
interface for registering serdev devices and using that in serial core only.

More details can be found in the individual commit messages.

Johan


Changes in v2
 - rebase on tty-linus
 - drop first two patches that have already been applied
 - remove a stray newline in patch 1/2
 - add Rob's reviewed-by tag


Johan Hovold (2):
  tty/serdev: add serdev registration interface
  serial: enable serdev support

 drivers/tty/serdev/serdev-ttyport.c |  6 ++-
 drivers/tty/serial/serial_core.c    |  4 +-
 drivers/tty/tty_port.c              | 75 +++++++++++++++++++++++++++++++++++++
 include/linux/serdev.h              |  7 +++-
 include/linux/tty.h                 |  9 +++++
 5 files changed, 95 insertions(+), 6 deletions(-)

-- 
2.13.0
