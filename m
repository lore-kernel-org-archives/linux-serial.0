Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E5C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C53207D8
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 14:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgEROpF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgEROpF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 10:45:05 -0400
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f236:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A2C061A0C;
        Mon, 18 May 2020 07:45:05 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 37BFB101E6B73;
        Mon, 18 May 2020 16:45:03 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id BBB1D626CE30;
        Mon, 18 May 2020 16:45:02 +0200 (CEST)
X-Mailbox-Line: From 94c6c800d1ca9fa04766dd1d43a8272c5ad4bedd Mon Sep 17 00:00:00 2001
Message-Id: <cover.1589811297.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 18 May 2020 16:45:00 +0200
Subject: [PATCH v3 0/2] rs485 bus termination GPIO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Define a device tree binding for an rs485 bus termination GPIO
(patch [1/2]), amend the serial core to retrieve the GPIO from
the device tree and amend the default ->rs485_config() callback
for 8250 drivers to change the GPIO on request from user space
(patch [2/2]).


Changes v2 -> v3:

* Patch [2/2]:
  * Drop unnecessary NULL pointer check preceding gpiod_set_value(). (Heiko)
  * Amend commit message to suggest moving 8250_exar.c to new binding. (Andy)
    Add Jan to Cc and Andy's R-b tag.

Changes v1 -> v2:

* Patch [2/2]:
  * Drop unnecessary devm_gpiod_put(). (Andy)
  * Use GPIOD_OUT_LOW macro for brevity. (Andy)
  * Document the rationale for disabling termination by default.
  * Drop nonsensical read of GPIO after setting its direction to out.


Link to v2:
https://lore.kernel.org/linux-serial/cover.1589285873.git.lukas@wunner.de


Lukas Wunner (2):
  dt-bindings: serial: Add binding for rs485 bus termination GPIO
  serial: 8250: Support rs485 bus termination GPIO

 .../devicetree/bindings/serial/rs485.yaml        |  4 ++++
 drivers/tty/serial/8250/8250_port.c              |  3 +++
 drivers/tty/serial/serial_core.c                 | 16 ++++++++++++++++
 include/linux/serial_core.h                      |  2 ++
 4 files changed, 25 insertions(+)

-- 
2.26.2

