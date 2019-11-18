Return-Path: <SRS0=fJeH=ZK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C471BC432C0
	for <linux-serial@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0392068D
	for <linux-serial@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="CcHL/wr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKRLYW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46395 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfKRLYS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so18979440wrs.13
        for <linux-serial@vger.kernel.org>; Mon, 18 Nov 2019 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8f4zkDbM2vRjhOU8bSiNRa1yRbCbXojjY2BLWPzI+4=;
        b=CcHL/wr1MdHVku5NXqYEh205MsV8nNbDhvOTjyrzGp7E05+OZTj+AZ65Mq6w5E7fC4
         QUUsnYvwWfYNPoDOFKaiWLBxE8orb1Uaokk6+Yh/3Va8yKkEh4CwI3Bvmo4RGmqS5LuR
         7JMzpGl4mSsJFAgOgGnawmUsoJc5NQxoI5Jzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8f4zkDbM2vRjhOU8bSiNRa1yRbCbXojjY2BLWPzI+4=;
        b=pPzafdVAU3pMV+VgYVTFP4ItL2e7M9bKKuUCKV8DPzFJnACr70Dlio7RDwRtXHc01n
         Nk4t1FOOkdcVuHJB2Anr6m1pRg72X2pCpJhnjdITLqaMYXf/W1IwlEBXOij/wHNVAyQ+
         ldpP8tO0eoh2goQvjQV7YRGjq5iOQJM0yTT7VDda7WX47VXowbfFg97TV5XQlREyzt5E
         W8BG1gDQadsDu+xb1IB35qsXTUT7oPCD90tX480UCFv3X1xfdjg8+sx6azbonO7+8VZX
         XO8C/OvWqjRVNpSy5tcKKlf9kEfOHmgecFi4j2gDvWoKhmvuTGTaDSthdW9ZrCGVSb9Q
         Bnww==
X-Gm-Message-State: APjAAAV2oIY6a65A+PbRDOy0R8VQ1pttJHHqIqfIaUuHkhv6x4n4lC+O
        QznrLURBLY1GDvaIkjBFuBo7vg==
X-Google-Smtp-Source: APXvYqxiVIfcvMPElvIDiGYFueIrSfkJiIqk8i4Ft8HAmwqiGb21aiYg0hu8lk7xe2G5zIrvZe7G8Q==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr31691608wru.342.1574076255340;
        Mon, 18 Nov 2019 03:24:15 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:14 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 33/48] serial: ucc_uart: limit brg-frequency workaround to PPC32
Date:   Mon, 18 Nov 2019 12:23:09 +0100
Message-Id: <20191118112324.22725-34-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

According to Timur Tabi

    This bug in older U-Boots is definitely PowerPC-specific

So before allowing this driver to be built for platforms other than
PPC32, make sure that we don't accept malformed device trees on those
other platforms.

Suggested-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index c055abf4c919..9436b93d5cfa 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1392,6 +1392,13 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	if (val)
 		qe_port->port.uartclk = val;
 	else {
+		if (!IS_ENABLED(CONFIG_PPC32)) {
+			dev_err(&ofdev->dev,
+				"invalid brg-frequency in device tree\n");
+			ret = -EINVAL;
+			goto out_np;
+		}
+
 		/*
 		 * Older versions of U-Boot do not initialize the brg-frequency
 		 * property, so in this case we assume the BRG frequency is
-- 
2.23.0

