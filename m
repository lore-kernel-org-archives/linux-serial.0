From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/25] tty: serial: drop uart_port->lock before calling
Date: Fri, 16 Aug 2013 17:13:01 +0530
Message-ID: <cover.1376651114.git.viresh.kumar@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:35175 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3HPLng (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 07:43:36 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so1900575pbc.35
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 04:43:35 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

The -rt patch triggers a lockdep warning for serial drivers if
tty_flip_buffer_push() is called with uart_port->lock locked. This never shows
up on UP kernels.

Release the port lock before calling tty_flip_buffer_push() and reacquire it
after the call.

Similar stuff was already done for few other drivers in the past, like:

commit 2389b272168ceec056ca1d8a870a97fa9c26e11a
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue May 29 21:53:50 2007 +0100

    [ARM] 4417/1: Serial: Fix AMBA drivers locking

This is neither tested nor compiled. I was working on Samsung's Arndale board
and so was required to samsung serial driver. Then thought why not others :)

Rebased over: v3.11-rc5

Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: Tony Prisk <linux@prisktech.co.nz>

Viresh Kumar (25):
  tty: serial: altera_jtag: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: altera: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: apbuart: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: ar933x: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: arc: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: bcm63xx: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: bfin_sport: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: efm32: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: icom: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: lpc32xx_hs: don't call tty_flip_buffer_push() twice
  tty: serial: lpc32xx_hs: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: m32r_sio: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: mcf: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: mfd: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: mpsc: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: msm: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: netx: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: nwpserial: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: pnx8xxx: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: rp2: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: sa1100: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: samsung: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: tegra: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: sirfsoc: drop uart_port->lock before calling
    tty_flip_buffer_push()
  tty: serial: vt8500: drop uart_port->lock before calling
    tty_flip_buffer_push()

 drivers/tty/serial/altera_jtaguart.c |  2 ++
 drivers/tty/serial/altera_uart.c     |  2 ++
 drivers/tty/serial/apbuart.c         |  2 ++
 drivers/tty/serial/ar933x_uart.c     |  2 ++
 drivers/tty/serial/arc_uart.c        |  2 ++
 drivers/tty/serial/bcm63xx_uart.c    |  2 ++
 drivers/tty/serial/bfin_sport_uart.c |  5 +++--
 drivers/tty/serial/efm32-uart.c      |  4 ++--
 drivers/tty/serial/icom.c            |  3 +++
 drivers/tty/serial/lpc32xx_hs.c      |  7 ++++---
 drivers/tty/serial/m32r_sio.c        |  3 +++
 drivers/tty/serial/mcf.c             |  2 ++
 drivers/tty/serial/mfd.c             | 14 ++++++++++----
 drivers/tty/serial/mpsc.c            | 11 ++++++++---
 drivers/tty/serial/msm_serial.c      |  5 +++++
 drivers/tty/serial/netx-serial.c     |  6 ++++--
 drivers/tty/serial/nwpserial.c       |  3 +++
 drivers/tty/serial/pnx8xxx_uart.c    |  3 +++
 drivers/tty/serial/rp2.c             |  2 ++
 drivers/tty/serial/sa1100.c          |  3 +++
 drivers/tty/serial/samsung.c         |  5 ++++-
 drivers/tty/serial/serial-tegra.c    | 10 ++++++++--
 drivers/tty/serial/sirfsoc_uart.c    |  3 +++
 drivers/tty/serial/vt8500_serial.c   |  2 ++
 24 files changed, 84 insertions(+), 19 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

