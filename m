Return-Path: <SRS0=jHyV=6T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC160C47247
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 14:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FEB206B9
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 14:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgEEOtO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 May 2020 10:49:14 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:58149 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgEEOtO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 10:49:14 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2020 10:49:13 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id E541C101E6A30;
        Tue,  5 May 2020 16:42:06 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 61B0D610EE1A;
        Tue,  5 May 2020 16:42:06 +0200 (CEST)
X-Mailbox-Line: From a91b9392e8e7914cae16f59beb1ffe6b335f81c9 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1588505407.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 5 May 2020 16:42:00 +0200
Subject: [PATCH 0/4] rs485 bus termination GPIO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Codrin Ciubotariu <Codrin.Ciubotariu@microchip.com>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        Radu Pirea <radu.pirea@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bich HEMON <bich.hemon@st.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit e8759ad17d41 ("serial: uapi: Add support for bus termination"),
allowed user space to change rs485 bus termination through a flag in
struct serial_rs485.  But so far only a single driver, 8250_exar.c,
supports the flag:  It hardcodes a GPIO specific to Siemens IOT2040
products.

Provide for a more generic solution:  Define a device tree binding
for an rs485 bus termination GPIO (patch [3/4]), amend the serial core
to retrieve the GPIO from the device tree and amend the default
->rs485_config() callback for 8250 drivers to change the GPIO on
request from user space (patch [4/4]).

Retrieving the GPIO from the device tree may fail, so allow
uart_get_rs485_mode() to return an errno and change all callers
to check for failure (patch [2/4]).

Testing has exposed a bug in the 8250 core if retrieval of the GPIO
initially fails with -EPROBE_DEFER and is later retried.  That bug
is fixed by patch [1/4].


Lukas Wunner (4):
  serial: 8250: Avoid error message on reprobe
  serial: Allow uart_get_rs485_mode() to return errno
  dt-bindings: serial: Add binding for rs485 bus termination GPIO
  serial: 8250: Support rs485 bus termination GPIO

 .../devicetree/bindings/serial/rs485.yaml     |  4 +++
 drivers/tty/serial/8250/8250_core.c           | 16 +++++++---
 drivers/tty/serial/8250/8250_port.c           |  4 +++
 drivers/tty/serial/ar933x_uart.c              |  6 ++--
 drivers/tty/serial/atmel_serial.c             |  6 ++--
 drivers/tty/serial/fsl_lpuart.c               |  5 +++-
 drivers/tty/serial/imx.c                      |  6 +++-
 drivers/tty/serial/omap-serial.c              |  4 ++-
 drivers/tty/serial/serial_core.c              | 30 ++++++++++++++++++-
 drivers/tty/serial/stm32-usart.c              |  8 ++---
 include/linux/serial_core.h                   |  4 ++-
 11 files changed, 76 insertions(+), 17 deletions(-)

-- 
2.26.2

