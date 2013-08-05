From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6] linux,stdout-path helper
Date: Mon,  5 Aug 2013 14:40:43 +0200
Message-ID: <1375706445-15375-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, devicetree@vger.kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com
List-Id: linux-serial@vger.kernel.org

The following adds a helper for matching the linux,stdout-path property
in the chosen node and makes use of it in the i.MX serial

This is a series originally created by me. It was hijacked and then abandoned
by Jean-Christophe for v5. I reverted the changes by Jean-Christophe since
they introduced changes to the devicetree binding. Instead I'd like to have
the existing binding implemented first before changing it.

Sascha

changes since v5:
- reverted changes from v4
- parse linux,stdoutpath property in of_alias_scan as suggested by Grant
changes since v4:
- add option support and check stdout-path too
changes since v3:
- move code from separate files to drivers/of/base.c and include/linux/of.h
changes since v2:
- move helper to OF core and make it independent of serial devices
changes since v1:
- move it out of the i.MX serial driver and make it generic for serial devices.
