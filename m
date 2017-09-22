From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 00/10] use setup_timer() helper function.
Date: Fri, 22 Sep 2017 13:56:42 +0530
Message-ID: <1506068812-8496-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, Allen Pais <allen.lkml@gmail.com>
List-Id: linux-serial@vger.kernel.org

This series uses setup_timer() helper function. The series
addresses the files under drivers/tty/*.

Allen Pais (10):
  drivers: tty: mux: use setup_timer() helper.
  drivers:tty: imx: use setup_timer() helper.
  drivers: tty: vcc: use setup_timer() helper.
  drivers: tty: max3100: use setup_timer() helper.
  drivers: tty: pnx8xxx: use setup_timer() helper.
  drivers: tty: 8250: use setup_timer() helper.
  drivers: tty: sa1100: use setup_timer() helper.
  drivers: tty: n_gsm: use setup_timer() helper.
  drivers: tty: sn_console: use setup_timer() helper.
  drivers: tty: ifx6x60: use setup_timer() helper.

 drivers/tty/n_gsm.c                 | 4 +---
 drivers/tty/serial/8250/8250_core.c | 3 +--
 drivers/tty/serial/ifx6x60.c        | 5 ++---
 drivers/tty/serial/imx.c            | 4 +---
 drivers/tty/serial/max3100.c        | 5 ++---
 drivers/tty/serial/mux.c            | 3 +--
 drivers/tty/serial/pnx8xxx_uart.c   | 5 ++---
 drivers/tty/serial/sa1100.c         | 5 ++---
 drivers/tty/serial/sn_console.c     | 4 +---
 drivers/tty/vcc.c                   | 9 ++-------
 10 files changed, 15 insertions(+), 32 deletions(-)

-- 
2.7.4
