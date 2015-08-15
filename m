From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 0/4] serial: imx: rework pm support and add runtime pm
Date: Fri, 14 Aug 2015 21:37:44 -0700
Message-ID: <1439613468-22366-1-git-send-email-edubezval@gmail.com>
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

V3->V4:
- Remove *dev from sport and reused sport->port.dev.
- Rebased on top of tty-testing (initial 4 patches were already applied by greg)

V3: https://lkml.org/lkml/2015/8/11/581

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

BR,

Eduardo Valentin (4):
  serial: imx: add a flag to indicate we are in the suspend path
  serial: imx: add runtime pm support
  serial: imx: add pm_qos request
  serial: imx: use SET_*SYSTEM_PM_OPS helper functions

 drivers/tty/serial/imx.c | 296 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 244 insertions(+), 52 deletions(-)

-- 
2.5.0

