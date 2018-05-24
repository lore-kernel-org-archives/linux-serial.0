From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/2] serial: imx: more shutdown cleanups
Date: Thu, 24 May 2018 19:30:22 +0200
Message-ID: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

Hi,

Here are two more cleanup patches for imx-serial. Both
issues were found by code reading, no real-world issues
are known.

-- Sebastian

Sebastian Reichel (2):
  serial: imx: drop CTS/RTS handling from shutdown
  serial: imx: disable UCR4_OREN on shutdown

 drivers/tty/serial/imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.17.0
