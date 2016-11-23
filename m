From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: serial: Add LED trigger support
Date: Wed, 23 Nov 2016 11:01:02 +0100
Message-ID: <20161123100106.15969-1-s.hauer@pengutronix.de>
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
To: linux-serial@vger.kernel.org
Cc: kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This series brings LED trigger support to the serial_core layer
and adopts some driver to use it.
This is an updated version of https://patchwork.kernel.org/patch/9212885/
which added LED trigger support to the i.MX serial driver only.

Sascha

----------------------------------------------------------------
Sascha Hauer (4):
      serial: core: Add LED trigger support
      serial: 8250: Add LED trigger support
      serial: cpm_uart: Add LED trigger support
      serial: imx: Add LED trigger support

 drivers/tty/serial/8250/8250_core.c         | 12 ++++-
 drivers/tty/serial/8250/8250_port.c         |  4 ++
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 22 ++++++++-
 drivers/tty/serial/imx.c                    | 24 +++++++++-
 drivers/tty/serial/serial_core.c            | 73 +++++++++++++++++++++++++++++
 include/linux/serial_core.h                 | 10 ++++
 6 files changed, 139 insertions(+), 6 deletions(-)
