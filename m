From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] Add device tree probe support for tty/serial/imx
Date: Sun,  3 Jul 2011 15:55:58 +0800
Message-ID: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45955 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab1GCHp3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 3 Jul 2011 03:45:29 -0400
Received: by iwn6 with SMTP id 6so3768707iwn.19
        for <linux-serial@vger.kernel.org>; Sun, 03 Jul 2011 00:45:29 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org

The first patch removes the use of cpu_is_mx1().  It has no dependency
on other patches, and can be merged right away after review gets done.
I assume it will go through Sascha's tree with Alan's ack, since it
touches quite some arch codes.  Please let me know if it's not the case.

The second patch adds device tree probe, and depends on the patch
below.

  http://article.gmane.org/gmane.linux.drivers.devicetree/6128

Grant, how does the above patch look to you?  I have been seeing
a number of drivers depending on it when migrating to device tree.
It will be good if we can git it settled soon.

Shawn Guo (2):
      serial/imx: get rid of the uses of cpu_is_mx1()
      serial/imx: add device tree probe support

 .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++
 arch/arm/mach-imx/clock-imx1.c                     |    6 +-
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |    2 +-
 drivers/tty/serial/imx.c                           |  131 +++++++++++++++++--
 4 files changed, 140 insertions(+), 18 deletions(-)
