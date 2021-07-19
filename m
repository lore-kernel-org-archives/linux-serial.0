Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121CEC07E9D
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 10:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E661E6113A
	for <linux-serial@archiver.kernel.org>; Mon, 19 Jul 2021 10:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhGSJnn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 19 Jul 2021 05:43:43 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:59552
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235416AbhGSJnm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 19 Jul 2021 05:43:42 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C20B6408AC;
        Mon, 19 Jul 2021 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626690261;
        bh=/JBcKsCAbvLS/jGaoHAwAJn9H+K+APuZd6w9Cs1hFM0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=qo/CuGv8V5FYn2fkdtH4QqfD2Hl+AyBjizdXL2ZGuglndyXuZe0S9rnS7Oe8yj2XT
         uDxHVO1inJcUSSL20u/bPLwRaNu/uRVNNHH3q9xq9ej1wAAcrdT5/grvY81rzxzfM/
         EYFC7AMGhj4E4Iyh6hMRheQ1XQ3+abesKFL7c6umW/5xW2h7MU/Sxugj74s8D2nPpI
         1/yFJOaSfsagVmQDs4IddeevyZU88ULJYFq+MEiWaUy6ufncXpSokQPfYiG5jdKIF3
         u14A/xzP+M//E3VPiqZy1AmolDrUUiLfhcKyXoJjN4+J8I5GaA377f2vx6avBf6YqM
         ziZuKQFjkC4ww==
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: Fix spelling mistake "Asychronous" -> "Asynchronous"
Date:   Mon, 19 Jul 2021 11:24:21 +0100
Message-Id: <20210719102421.14813-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 24282ad99d85..e0f6d5bfdc94 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1382,7 +1382,7 @@ config SERIAL_ST_ASC
 	select SERIAL_CORE
 	depends on ARM || COMPILE_TEST
 	help
-	  This driver is for the on-chip Asychronous Serial Controller on
+	  This driver is for the on-chip Asynchronous Serial Controller on
 	  STMicroelectronics STi SoCs.
 	  ASC is embedded in ST COMMS IP block. It supports Rx & Tx functionality.
 	  It support all industry standard baud rates.
-- 
2.31.1

