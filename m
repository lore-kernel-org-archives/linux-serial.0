Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405DCC54E4A
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E78206DD
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgELMkU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 08:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELMkU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 08:40:20 -0400
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B2C061A0C
        for <linux-serial@vger.kernel.org>; Tue, 12 May 2020 05:40:20 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 4DC951037030B;
        Tue, 12 May 2020 14:40:18 +0200 (CEST)
Received: from localhost (pd95be530.dip0.t-ipconnect.de [217.91.229.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id ED7D5627549D;
        Tue, 12 May 2020 14:40:17 +0200 (CEST)
X-Mailbox-Line: From dafe8ecb9897efdbe530667657377ba96c43b8c7 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1589285873.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 12 May 2020 14:40:00 +0200
Subject: [PATCH v2 0/4] rs485 bus termination GPIO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Define a device tree binding for an rs485 bus termination GPIO
(patch [3/4]), amend the serial core to retrieve the GPIO from
the device tree and amend the default ->rs485_config() callback
for 8250 drivers to change the GPIO on request from user space
(patch [4/4]).

Retrieving the GPIO from the device tree may fail, so allow
uart_get_rs485_mode() to return an errno and change all callers
to check for failure (patch [2/4]).

Fix a bug in the 8250 core if retrieval of the GPIO initially
fails with -EPROBE_DEFER and is later retried (patch [1/4]).


Changes v1 -> v2:

Patch [1/4]:
* Drop unnecessary "else" after "if ... goto" statement. (Andy)
* Document applicability to older kernels in commit message. (Andy)
* Add Fixes tag. (Andy)

Patch [4/4]:
* Drop unnecessary devm_gpiod_put(). (Andy)
* Use GPIOD_OUT_LOW macro for brevity. (Andy)
* Document the rationale for disabling termination by default.
* Drop nonsensical read of GPIO after setting its direction to out.


Link to v1:
https://lore.kernel.org/linux-serial/cover.1588505407.git.lukas@wunner.de/


Lukas Wunner (4):
  serial: 8250: Avoid error message on reprobe
  serial: Allow uart_get_rs485_mode() to return errno
  dt-bindings: serial: Add binding for rs485 bus termination GPIO
  serial: 8250: Support rs485 bus termination GPIO

 .../devicetree/bindings/serial/rs485.yaml     |  4 ++++
 drivers/tty/serial/8250/8250_core.c           | 18 ++++++++++-----
 drivers/tty/serial/8250/8250_port.c           |  4 ++++
 drivers/tty/serial/ar933x_uart.c              |  6 +++--
 drivers/tty/serial/atmel_serial.c             |  6 +++--
 drivers/tty/serial/fsl_lpuart.c               |  5 ++++-
 drivers/tty/serial/imx.c                      |  6 ++++-
 drivers/tty/serial/omap-serial.c              |  4 +++-
 drivers/tty/serial/serial_core.c              | 22 ++++++++++++++++++-
 drivers/tty/serial/stm32-usart.c              |  8 +++----
 include/linux/serial_core.h                   |  4 +++-
 11 files changed, 69 insertions(+), 18 deletions(-)

-- 
2.26.2

