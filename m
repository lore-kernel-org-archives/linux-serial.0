Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5254C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 11:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5CC613D0
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 11:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhI2Lcq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 07:32:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:19520 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbhI2Lcq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 07:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632915065; x=1664451065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7bnRKGYR4FJyMBwNxeaNWp8a3KIWMSfYvPSo+4dlHMc=;
  b=JkHLzxqcNhbSxnJiwkktMlbOUzUhnHwMDQHAgqzHVOmZ3ar6pjUve5Y3
   qS2ROoYqtvdKNImkjaCdiroy/zPGi7ZDCeH02NyvX8JUO02f2qHIFuBgp
   JIHSIhkfdfWRJr12u9zZvdlsOSvDs4Nz7xvrfG1q8swHMa/TZzlZ5WYjx
   N0b07fmiIcts1eM5lcXXv7mrJYcK3wDCpbMsgjRxR2HSK6d/mcJ+yVgj9
   C1QJlaCp2llV50YW00klSuq+0TGabyGIJ9Kff7leCWKmHcY/3REduOKVj
   GXQ4PoBBdlU7pZkK+GBsM1cB16cqGdSVuufKEl2Vi7qeb8j0RCQgz83aa
   g==;
IronPort-SDR: 0ejb7fv4bErAwKhTUcSOvt0qIsLs6oFkfHk+FAgzq2fTm3JvjVll0OS19C5T+GkdV+YLgNCeTz
 An6JtKZLC08TM2uW2DE75hALdDZPe8hm5eyN5I72hHidXcSGWlaayIoI5HIjOqSDptraIMvSRk
 aO64OKvTEOkd+NiAq5PoYx4+simFDPr9rdL8NVAY9YChc0LN7hah+CuW03TT1ftqGtxW1C6IJq
 4DevQCOvVvs+QsXYEOvwYln2u8nUbHm+8ayv4PmzuMnLbBS27twmI5fIQPx7jPycI5IKQCMOFk
 cyS38Gr3zezKWpZD+pb6FAt/
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="133601691"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2021 04:31:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 29 Sep 2021 04:31:03 -0700
Received: from CHE-LT-I17972LX.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 29 Sep 2021 04:30:58 -0700
From:   LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <macro@orcam.me.uk>,
        <zev@bewilderbeest.net>, <vigneshr@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <UNGLinuxDriver@microchip.com>
Subject: [PATCH v1 0/3] serial:8250:Add driver support for MCHP PCI1XXXX UART module
Date:   Wed, 29 Sep 2021 17:00:46 +0530
Message-ID: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

PCI1XXXX UART is a PCIe to UART module. It has 5 SKUs, each is
differentiated by the device IDs in the PCIe config space. Each
SKU supports a maximum of 4 UART ports(UART0,1,2,3) with fixed 
offests.Based on the sub device ID, the combinations of UART 
ports shall be enumerated.

The UART port is compatible with the standard 16550A, but has some 
modifications.The modifications includes a change in the baud rate
settings,auto control of RTS signal for RS485 feature and an
increase of TX & RX FIFO size to 256 Bytes.Also, it has a capability
to wake up the CPU. 

These patches adds the support to enumerate and exercise all the
combinations of UART ports in all the SKUs.

LakshmiPraveen Kopparthi (3):
  Add basic driver support for MCHP PCI1XXXX UART
  Add RS485 support for MCHP PCI1XXXX UART
  Add non standard baudrate support for MCHP PCI1XXXX UART module

 drivers/tty/serial/8250/8250_pci.c  | 384 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |   8 +
 include/uapi/linux/serial_core.h    |   3 +
 3 files changed, 395 insertions(+)

-- 
2.25.1

