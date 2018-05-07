From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/2] serial: imx: cleanup shutdown
Date: Mon,  7 May 2018 23:36:08 +0200
Message-ID: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

Hi,

Here is a simple cleanup patch for the imx serial driver. The second
one fixes a missing dma resource free. I tested both patches on imx53
based GE PPD device.

-- Sebastian

Sebastian Reichel (2):
  serial: imx: cleanup imx_uart_disable_dma()
  serial: imx: dma_unmap_sg buffers on shutdown

 drivers/tty/serial/imx.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.17.0
