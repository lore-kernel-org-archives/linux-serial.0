From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 00/11] constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:39 +0200
Message-ID: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

---

 drivers/tty/serial/21285.c                  |    2 +-
 drivers/tty/serial/apbuart.c                |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    2 +-
 drivers/tty/serial/m32r_sio.c               |    2 +-
 drivers/tty/serial/meson_uart.c             |    2 +-
 drivers/tty/serial/mpc52xx_uart.c           |    2 +-
 drivers/tty/serial/mux.c                    |    2 +-
 drivers/tty/serial/owl-uart.c               |    2 +-
 drivers/tty/serial/sunsab.c                 |    2 +-
 drivers/tty/serial/sunsu.c                  |    2 +-
 drivers/tty/serial/ucc_uart.c               |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)
