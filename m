From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/8] serdev: receive_buf and locking fixes
Date: Fri,  3 Nov 2017 15:30:51 +0100
Message-ID: <20171103143059.20749-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

This series addresses a few issues with the serdev code, including
potential information leaks due to missing sanity checks in the receive
path, a NULL-deref in write_wakeup() due to missing reference handling,
and missing tty locking in close().

Johan


Johan Hovold (8):
  serdev: ttyport: add missing receive_buf sanity checks
  serdev: fix receive_buf return value when no callback
  serdev: document driver callbacks
  serdev: ttyport: fix NULL-deref on hangup
  serdev: ttyport: fix tty locking in close
  serdev: ttyport: release tty lock sooner on open
  serdev: ttyport: ignore carrier detect to avoid hangups
  serdev: ttyport: do not used keyed wakeup in write_wakeup

 drivers/tty/serdev/serdev-ttyport.c | 32 ++++++++++++++++++++++++++++----
 include/linux/serdev.h              |  8 +++++---
 2 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.15.0
