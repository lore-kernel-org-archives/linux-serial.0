From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4] linux,stdout-path helper
Date: Thu, 15 Nov 2012 10:31:03 +0100
Message-ID: <1352971866-540-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

The following adds a helper for matching the linux,stdout-path property
in the chosen node and makes use of it in the i.MX serial driver.

changes since v3:

- move code from separate files to drivers/of/base.c and include/linux/of.h

changes since v2:

- move helper to OF core and make it independent of serial devices

changes since v1:

- move it out of the i.MX serial driver and make it generic for serial
  devices.
