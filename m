Return-Path: <SRS0=CtGi=5G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626B2C4332B
	for <linux-serial@archiver.kernel.org>; Sat, 21 Mar 2020 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3292072C
	for <linux-serial@archiver.kernel.org>; Sat, 21 Mar 2020 20:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCUUki (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:40:38 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:58798 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCUUki (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Mar 2020 16:40:38 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 9BC37939DB7; Sat, 21 Mar 2020 21:40:36 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH] serial: omap: drop unused dt-bindings header
Date:   Sat, 21 Mar 2020 21:40:31 +0100
Message-Id: <20200321204031.30369-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The definitons in the dt-binding's gpio header only contains some
constants to be used in device trees. It is not relevant for omap-serial
(as the gpio API hides the details) and in fact unused so it can just be
dropped.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/tty/serial/omap-serial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 48017cec7f2f..80e5149d3182 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -37,8 +37,6 @@
 #include <linux/of_gpio.h>
 #include <linux/platform_data/serial-omap.h>
 
-#include <dt-bindings/gpio/gpio.h>
-
 #define OMAP_MAX_HSUART_PORTS	10
 
 #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
-- 
2.25.0

