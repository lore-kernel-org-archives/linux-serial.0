From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] tty/serial: fix invalid user-pointer checks
Date: Tue,  8 Nov 2016 13:24:52 +0100
Message-ID: <1478607895-23447-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

This series drop invalid user-pointer checks from ioctl handlers (which
tend to get replicated in new drivers).

Note that only the rocket driver has been compile tested.

Johan


Johan Hovold (3):
  tty: amiserial: fix invalid user-pointer check
  tty: rocket: fix invalid user-pointer checks
  serial: crisv10: fix invalid user-pointer check

 drivers/tty/amiserial.c      | 2 --
 drivers/tty/rocket.c         | 4 ----
 drivers/tty/serial/crisv10.c | 2 --
 3 files changed, 8 deletions(-)

-- 
2.7.3
