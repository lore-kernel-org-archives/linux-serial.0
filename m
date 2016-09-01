From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/9] constify uart_ops structures
Date: Thu,  1 Sep 2016 19:51:29 +0200
Message-ID: <1472752298-981-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Constify uart_ops structures.

---

 drivers/tty/serial/altera_jtaguart.c |    2 +-
 drivers/tty/serial/altera_uart.c     |    2 +-
 drivers/tty/serial/arc_uart.c        |    2 +-
 drivers/tty/serial/atmel_serial.c    |    2 +-
 drivers/tty/serial/bcm63xx_uart.c    |    2 +-
 drivers/tty/serial/fsl_lpuart.c      |    4 ++--
 drivers/tty/serial/imx.c             |    2 +-
 drivers/tty/serial/jsm/jsm_tty.c     |    2 +-
 drivers/tty/serial/max3100.c         |    2 +-
 drivers/tty/serial/men_z135_uart.c   |    2 +-
 drivers/tty/serial/mxs-auart.c       |    2 +-
 drivers/tty/serial/pch_uart.c        |    2 +-
 drivers/tty/serial/sh-sci.c          |    2 +-
 drivers/tty/serial/st-asc.c          |    2 +-
 drivers/tty/serial/timbuart.c        |    2 +-
 drivers/tty/serial/uartlite.c        |    2 +-
 drivers/tty/serial/xilinx_uartps.c   |    2 +-
 17 files changed, 18 insertions(+), 18 deletions(-)
