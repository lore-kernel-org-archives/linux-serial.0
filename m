From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 0/8] serial: imx: rework pm support and add runtime pm
Date: Mon, 10 Aug 2015 18:35:41 -0700
Message-ID: <1439256949-626-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hello all,


This is version 2 of a patch series to introduce runtime pm in the imx serial
driver. The difference now is that it is rebased on top of linux-next, given
that some of the work done in v1 was already sent.

Here is the link of v1:
http://marc.info/?l=linux-pm&m=143914435605790&w=2

As always, comments are welcome.

BR

Eduardo Valentin (8):
  serial: imx: remove unbalanced clk_prepare
  serial: imx: introduce serial_imx_enable_wakeup()
  serial: imx: allow waking up on RTSD
  serial: imx: save and restore context in the suspend path
  serial: imx: add a flag to indicate we are in the suspend path
  serial: imx: add runtime pm support
  serial: imx: add pm_qos request
  serial: imx: use SET_*SYSTEM_PM_OPS helper functions

 arch/arm/boot/dts/Makefile |   1 +
 drivers/tty/serial/imx.c   | 352 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 270 insertions(+), 83 deletions(-)

-- 
2.5.0

