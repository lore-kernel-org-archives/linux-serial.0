From: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH 0/2] sc16is7xx interrupt fixes
Date: Wed, 12 Sep 2018 15:31:54 +0100
Message-ID: <1536762716-30673-1-git-send-email-phil@raspberrypi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Phil Elwell <phil@raspberrypi.org>
List-Id: linux-serial@vger.kernel.org

The interrupt handling of the sc16is7xx driver is broken in a number of ways,
as observed by multiple Raspberry Pi users. The attached patches attempt to
address its failings, with apparent success.

The first is a workaround for a side-effect of the switch away from using a
thread IRQ, a change which has necessitated using what is actually a
level-triggered interrupt as if it were edge-triggered. Doing so is fraught
with potential race conditions, but the patch makes them much less likely.

The second is a workaround for a bug in the design of the SC16IS752 which
requires mutual exclusion between the interrupt handler and access to the
Enhanced Features Register.

Phil Elwell (2):
  sc16is7xx: Fix for multi-channel stall
  sc16is7xx: Fix for "Unexpected interrupt: 8"

 drivers/tty/serial/sc16is7xx.c | 50 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

-- 
2.7.4
