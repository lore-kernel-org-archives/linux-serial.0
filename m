Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C1CC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 30 Mar 2022 10:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245509AbiC3Ksu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Mar 2022 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245557AbiC3Kso (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Mar 2022 06:48:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8C3269363
        for <linux-serial@vger.kernel.org>; Wed, 30 Mar 2022 03:46:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVql-0002vF-V5; Wed, 30 Mar 2022 12:46:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqi-003y65-Gj; Wed, 30 Mar 2022 12:46:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZVqk-00Clkt-Bo; Wed, 30 Mar 2022 12:46:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Tremblay <etremblay@distech-controls.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 3/3] serial: 8250: add compatible for fsl,16550-FIFO64
Date:   Wed, 30 Mar 2022 12:46:42 +0200
Message-Id: <20220330104642.229507-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
References: <20220330104642.229507-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zg1mYFKEi7NUtCVWk9gz66yWZrk40rl82QhudSASHvg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiRDUJrdlGL9/ef20smz9PqsjP3cOViERLAkbtVVQx ytGW4WyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYkQ1CQAKCRDB/BR4rcrsCXBcB/ 9MBtwbpr3lh0VQJofEJrt+zClcFqq2d0E2sVgGyC3uQ6DdEcHQcDcE4Hg/fO/gx9oNp7lJ99lNXGOg SOmjqgs75fOH1Khx5cWm/g1a2iKiwFumNG3LZ6FYW43eKZ+7QMFjCkuYQYfx+CnNRGtUpvOpmRK4+q S47hyGvBC7qIhp+7nR6gLfKnNPkrhbuT4fCwl94Fu09qhf6WFe5B4E/1P+wKToUJ3p5e4LuYwaDbLu 1YAgryg5lXQRWQxrSIIvZ3kebrZqOyWnOnI1XDeUJJmWzjH9dS+amcy4Evvi2WUUEsLDUolET7C8qe 7yfe8hcf5MuFO2Ub+V/o3ZlsLU4Xif
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Eric Tremblay <etremblay@distech-controls.com>

Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/8250/8250_of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index be8626234627..5a699a1aa79c 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -326,6 +326,8 @@ static const struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_ALTR_16550_F64, },
 	{ .compatible = "altr,16550-FIFO128",
 		.data = (void *)PORT_ALTR_16550_F128, },
+	{ .compatible = "fsl,16550-FIFO64",
+		.data = (void *)PORT_16550A_FSL64, },
 	{ .compatible = "mediatek,mtk-btif",
 		.data = (void *)PORT_MTK_BTIF, },
 	{ .compatible = "mrvl,mmp-uart",
-- 
2.30.2

