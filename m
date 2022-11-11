Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A887C4332F
	for <linux-serial@archiver.kernel.org>; Fri, 11 Nov 2022 16:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiKKQLH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Nov 2022 11:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKQLH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Nov 2022 11:11:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED65F5B2;
        Fri, 11 Nov 2022 08:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668183065; x=1699719065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kmc8i17raTrE43RZ874eLzh3n+igMYXFyGNItktzJzY=;
  b=tXDauwKH0HRhYNzpvvyuwjGl1UiyHkc222waYEgXysOMk96BeLqxbLxM
   k9F45nOXBEudpr4l9xRDMhdyh3gee3GWUor8DLPcchkXCDrVY2CQuu19g
   x0CWXWIpWCLWYxlL7hJL8+rsj0I12B8+laGFQ0VErfbUCa9makqPOw+0w
   L63CzGeFLeTDKevHGk5G+AfMkGOlw5vnYN7zJa3jKImfsA8gUyjb0lc4d
   E/iky6cjTDLcUy5irvLXnf+1E81WPhwMyQn96e+sT57PZh8BElTs1f/Lk
   kLBjKK980j/J6YMg1oiDY5Sh9S+adDD5TYk7uevjnYagb0t+7t51qFw9n
   w==;
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="123027573"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2022 09:11:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 11 Nov 2022 09:11:01 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 11 Nov 2022 09:10:55 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v4 tty-next 0/3] 8250: microchip: pci1xxxx: Add driver for the pci1xxxx's quad-uart function
Date:   Fri, 11 Nov 2022 21:41:27 +0530
Message-ID: <20221111161130.2043882-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
downstream ports. Quad-uart is one of the functions in the multi-function
endpoint. This patch adds device driver for the quad-uart function and
enumerates between 1 to 4 instances of uarts based on the PCIe subsystem
device ID.

The changes from v1->v2->v3->v4 are mentioned in each patch in the patchset.

Thanks to Andy Shevchenko, Ilpo Jarvinen, Chritophe JAILLET, Geert
Uytterhoeven, Greg KH for their review comments.

Kumaravel Thiagarajan (3):
  8250: microchip: pci1xxxx: Add driver for quad-uart support.
  8250: microchip: pci1xxxx: Add rs485 support to quad-uart driver
  8250: microchip: pci1xxxx: Add power management functions to quad-uart
    driver

 MAINTAINERS                             |   7 +
 drivers/tty/serial/8250/8250_pci.c      |  24 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c | 536 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c   |  34 ++
 drivers/tty/serial/8250/8250_pcilib.h   |   5 +
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  15 +
 drivers/tty/serial/8250/Makefile        |   2 +
 include/uapi/linux/serial_core.h        |   3 +
 9 files changed, 612 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

-- 
2.25.1

