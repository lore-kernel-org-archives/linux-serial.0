Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC0AC3F2CD
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E39F24699
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 13:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1NiL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:38:11 -0500
Received: from mailout1.hostsharing.net ([83.223.95.204]:41073 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1NiL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 08:38:11 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 08:38:10 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id CF9511003DBEC;
        Fri, 28 Feb 2020 14:31:00 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 8E22161249E4;
        Fri, 28 Feb 2020 14:31:00 +0100 (CET)
X-Mailbox-Line: From 65edffce4670a19e598015c03cbe46f1ffd93e43 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1582895077.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 28 Feb 2020 14:31:00 +0100
Subject: [PATCH 0/8] rs485 support for Raspberry Pi aux uart
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Heiko Schocher <hs@denx.de>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The objective of this series is to add rs485 support for the
Raspberry Pi auxiliary uart (patch [6/8] and [7/8]).

But I'm taking the opportunity to improve rs485 support for any
8250-compatible uart:

* rs485 devicetree properties support (patch [2/8]).
* rs485 serial console support (patch [8/8]).
* various fixes and cleanups.

Please review and test.  Thanks!


Lukas Wunner (8):
  serial: 8250: Don't touch RTS modem control while in rs485 mode
  serial: 8250: Support rs485 devicetree properties
  serial: 8250: Deduplicate ->rs485_config() callback
  serial: 8250: Sanitize rs485 config harder
  serial: 8250: Deduplicate rs485 active_timer assignment
  serial: 8250: Generalize rs485 software emulation
  serial: 8250_bcm2835aux: Support rs485 software emulation
  serial: 8250: Support console on software emulated rs485 ports

 drivers/tty/serial/8250/8250.h            |   4 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c |  62 ++++++++-
 drivers/tty/serial/8250/8250_core.c       |   6 +-
 drivers/tty/serial/8250/8250_of.c         |  39 +-----
 drivers/tty/serial/8250/8250_omap.c       |  34 +----
 drivers/tty/serial/8250/8250_port.c       | 157 +++++++++++++++++-----
 include/linux/serial_8250.h               |   3 +
 7 files changed, 204 insertions(+), 101 deletions(-)

-- 
2.24.0

