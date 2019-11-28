Return-Path: <SRS0=ezJB=ZU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2BEC43215
	for <linux-serial@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7465321771
	for <linux-serial@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DA9W24cK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfK1O5p (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42301 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfK1O5p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so20246788lfl.9
        for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2019 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/uGhuZC6bGDe/vY5pHErjTk2s243PKPkhdUERJxYak=;
        b=DA9W24cKzldoyLYNRJ2Y6/1zVnkA1lJTOnZNVCGLnBtLy9SDw6v1MH1Lm6m8gUytky
         c/CaDP3iN1dNJBfmYpol42g9n5EFLkk812cLsAvU7B2qNvOG91C4+6uQAfeMnsMVXDe4
         rOJD9KS0Hi/+zmyHdu2abRIo6OPt5+3pur4ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/uGhuZC6bGDe/vY5pHErjTk2s243PKPkhdUERJxYak=;
        b=t2sWoPxFMAECBW0Gta9WTznjbNIbskP/x4sEfmL9aWrWyXpiVdSFMCfuWz8Bu4q5Pn
         YHSn7tt2WKe9tqONkk2OyRRNqoLxpUI6rvOsTNGo896LJC7mZoYUh3tKJv997QrGDS1A
         PviMHchv/8XZCpg8IPjLd8N9dTO7OG1ilolrpUfPy6I+dKYVqO7Y3f4H+UjJoy7D2O5t
         5oos8SMv5QQlayG8hGYu3o8yDvTC1PHyuPpyCqBJHFFF2/QlJ8OTAR0ENwjhltsBU9yz
         89rsM/8rmQZWBzL6K70/TcGW+5sLB8frjeJVVJK3Tq0sbzRacrkED9VC4nnTNmKJaO5e
         3bjg==
X-Gm-Message-State: APjAAAWdr+2Ay/8HaiuKiBfuXpRRyx95Ja9oWsZuQnK0dKVD49Ttqxwm
        Uba355+ReqG76mv3i+LQ4heoKQ==
X-Google-Smtp-Source: APXvYqzw/jYuIoVJsHxaPiDPkjZLXx2+FnqCB2evJQRnfVYU2j3q8zmQHgBLElskKwZbaunbylGJGw==
X-Received: by 2002:a19:756:: with SMTP id 83mr6610746lfh.173.1574953061494;
        Thu, 28 Nov 2019 06:57:41 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:41 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 28/49] serial: ucc_uart: explicitly include soc/fsl/cpm.h
Date:   Thu, 28 Nov 2019 15:55:33 +0100
Message-Id: <20191128145554.1297-29-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly. This is
preparation for allowing this driver to build on ARM.

Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..7e802616cba8 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -32,6 +32,7 @@
 #include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
+#include <soc/fsl/cpm.h>
 #include <asm/reg.h>
 
 /*
-- 
2.23.0

