From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 0/8] serial: imx: rework pm support and add runtime pm
Date: Tue, 11 Aug 2015 10:21:19 -0700
Message-ID: <1439313687-28502-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hello all,


This is version 3 of a patch series to introduce runtime pm in the imx serial
driver. The idea is to get runtime pm to handle ipg and per clocks, idling
the device when possible, configuring wakeups, and saving and restoring
context when needed.

A minor refactoring was needed to get things done. On top of it I am also
adding pm_qos support in the driver too.

Changelog:

V2->V3:
- error checking handling on clk_*enable functions
- added a missing return
- moved some of the code from the runtime pm patch to the pm qos patch, which
were causing compilation issues.
V2: http://marc.info/?l=linux-pm&m=143925695931624&w=2

V1->V2:
- The difference now is that it is rebased on top of linux-next, given
that some of the work done in v1 was already sent.
V1: http://marc.info/?l=linux-pm&m=143914435605790&w=2

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
 drivers/tty/serial/imx.c   | 368 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 286 insertions(+), 83 deletions(-)

-- 
2.5.0

