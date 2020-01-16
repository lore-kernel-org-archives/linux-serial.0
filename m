Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A0C33CB6
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11643207FF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 12:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgAPMVC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:21:02 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:59633 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPMVC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 07:21:02 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 07:21:01 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id BCB30101F2565;
        Thu, 16 Jan 2020 13:15:26 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 78D5E60AE1B8;
        Thu, 16 Jan 2020 13:15:26 +0100 (CET)
X-Mailbox-Line: From aea363c27fd541dba96d2ebfeee4f596c6d34932 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1579175223.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 16 Jan 2020 13:14:00 +0100
Subject: [PATCH 0/6] Raspberry Pi auxiliary UART fixes & cleanups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Here's a collection of fixes & cleanups for the Raspberry Pi auxiliary UART
to prepare for upcoming feature work on the driver.

With compliments from Revolution Pi labs (https://revolution.kunbus.com/).

Lukas Wunner (5):
  serial: 8250_bcm2835aux: Fix line mismatch on driver unbind
  serial: 8250_bcm2835aux: Suppress register_port error on -EPROBE_DEFER
  serial: 8250_bcm2835aux: Allocate uart_8250_port on stack
  serial: 8250_bcm2835aux: Use generic remapping code
  serial: 8250_bcm2835aux: Document struct bcm2835aux_data

Phil Elwell (1):
  serial: 8250_bcm2835aux: Suppress clk_get error on -EPROBE_DEFER

 drivers/tty/serial/8250/8250_bcm2835aux.c | 50 ++++++++++++-----------
 1 file changed, 26 insertions(+), 24 deletions(-)

-- 
2.24.0

