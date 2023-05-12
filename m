Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DFC77B75
	for <linux-serial@archiver.kernel.org>; Fri, 12 May 2023 17:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbjELRiv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 May 2023 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbjELRiu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 May 2023 13:38:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699491718
        for <linux-serial@vger.kernel.org>; Fri, 12 May 2023 10:38:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWil-0004jz-32; Fri, 12 May 2023 19:38:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWig-0031HJ-Qu; Fri, 12 May 2023 19:38:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxWif-003nru-TC; Fri, 12 May 2023 19:38:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@amd.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 0/2] serial: Make uart_remove_one_port() return void
Date:   Fri, 12 May 2023 19:38:08 +0200
Message-Id: <20230512173810.131447-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Vax8qKrHs4Gg+inxaybO9VSOevVZbn78AXGxPoOWfRs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXnl7GQba5f5/U9cBAKa1hjmTkzHwcbmipUsOS R9QOs4EtJaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZF55ewAKCRCPgPtYfRL+ TkTLB/0TZE6vdhOclWvy8SNtqKjv+Rn0YSIBBG4CWqadlJ+ZNF98QzZYOK9mq+DMx9Nlh0SliR3 9IEkl9LfM1AwaHuutbbVFHSmIPmFAVDlglYyrXfPGkNqAmGz5HguCTdhhYA8ttnwFsiqRaKS7eI 2U3Y3SZoNHKLbdL9raPKYgE+kPZdENXdZ00Mfi/X+pEd7YoDPQsLR0n56HmA7djs6vgCygf0vQ7 2qkqKcQWzGq6cLNkrfEnHU6FOSbZ8g+Ok2fZM5CbG3fOBMrvpi5D7G3pRbIBLjmjUbdxJ+jw1N+ wCxIzQKFofDjbhJWFzrnx6pFew81qeYnzzF4mdbuJfeeSwXQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

this is part of a quest to make struct platform_driver::remove return
void. But this series can be considered a cleanup on its own.

The motivation to make the remove callback of platform drivers return
void is that returning an int make driver authors (wrongly) assume there
is some kind of error handling in the core and it's a good idea to
return an error code. In reality a returned error code is ignored which
yields to leaked resources and in some cases also use-after-free
situations because for example the device isn't disabled and so later an
irq might trigger while the register mapping is already gone.

Best regards
Uwe

Uwe Kleine-König (2):
  serial: stm32: Ignore return value of uart_remove_one_port() in
    .remove()
  serial: Make uart_remove_one_port() return void

 drivers/tty/serial/atmel_serial.c           |  5 ++---
 drivers/tty/serial/clps711x.c               |  4 +++-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  5 ++++-
 drivers/tty/serial/imx.c                    |  4 +++-
 drivers/tty/serial/lantiq.c                 |  4 +++-
 drivers/tty/serial/serial_core.c            |  6 +-----
 drivers/tty/serial/st-asc.c                 |  4 +++-
 drivers/tty/serial/stm32-usart.c            |  5 +----
 drivers/tty/serial/uartlite.c               | 12 ++++--------
 drivers/tty/serial/xilinx_uartps.c          |  5 ++---
 include/linux/serial_core.h                 |  2 +-
 11 files changed, 27 insertions(+), 29 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

