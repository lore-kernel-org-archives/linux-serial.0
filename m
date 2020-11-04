Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE671C4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984A1221FA
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+SGLyXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgKDTiF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730877AbgKDTgT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA1C061A4A
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:18 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c16so3418818wmd.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTLE3fDx+u6VjTzT6dpTTPCm/8rHPP6boBELCTFmpBg=;
        b=n+SGLyXNvdQU4rjj4mubZsi4hwbLwsTcsnnLwzYDMPIhbwe63+nVO1NWaX3aS6dmUx
         3L/2agKl25gvbYPSbv11aqzMRSZv7UekzcbL2Z9mLOgjzaBviP2JGHkvIB+ENAsZBE24
         p+G+FPrfRxa40tohZRpg7hUd5mVHby44jPtaARISzVZpbjgyuZPQHOBKD5nTwEqQI0Vq
         gwqlnt1aDiKbnT7CSkc1eH3UIV2qVrmFfe3YtZAnDa/D9H5yuzEfaEHhkfLYk5ETcxc0
         3JKmbCti5Dkc3YvISF1bIqsTEKyvNXpzwSmk+IOF2D2nIHjg2/CPkBhUfTe60fEefXKq
         h4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTLE3fDx+u6VjTzT6dpTTPCm/8rHPP6boBELCTFmpBg=;
        b=k5xf1QxAwV9WPRCsk0G+UHxGKHai0znZdpRGVORS6J3pXOXhGx+VPJYk3uOgouR8un
         83R7uVJB/QNXa4AxfRzo80dCTWTOPTRetZBCyW5Nc6fNj3W6BdG/PKP/AMYIaFBk31cM
         dW2zF5ZmfpsKCrIGkyugMh/0l4qqoXT3Wf/DuEw/HgfMpkq0Y4C0qqKNpPCeNFU7tS9X
         3Iqs7stvyHb+lXOM9gNtoLOkMOfzQ5mjgmM/jUPjCBonVH4KNqJVN8dWuVSXJEz7EM3o
         1BS4d+IVXohIr41S+0le2nksUwxR0pgB0MUhcOo+ZQRCp+Y+WmSw5fwhLzWp/kYFui4p
         819g==
X-Gm-Message-State: AOAM532WE4iaZLFeeE82WZAbf5D45tWmrE6OaU1j+Pa9ynKGsFA7eUls
        Nmfg90ikSEeGDmFVhLozULT+Yg==
X-Google-Smtp-Source: ABdhPJwiMgTaKQBz/vW+Q77lWF+7EeqsbsMelVL8C6QvCfsvxmsIndZmwUuB1UXHj60cFSp3ozaydA==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr6115133wmf.47.1604518577576;
        Wed, 04 Nov 2020 11:36:17 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mike Hudson <Exoray@isys.ca>, linux-serial@vger.kernel.org
Subject: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions referenced by pointers
Date:   Wed,  4 Nov 2020 19:35:26 +0000
Message-Id: <20201104193549.4026187-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/8250/8250_port.c:349:14: warning: no previous prototype for ‘au_serial_in’ [-Wmissing-prototypes]
 drivers/tty/serial/8250/8250_port.c:359:6: warning: no previous prototype for ‘au_serial_out’ [-Wmissing-prototypes]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Hudson <Exoray@isys.ca>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b0af13074cd36..ebce4406dc289 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -346,7 +346,7 @@ static const s8 au_io_out_map[8] = {
 	-1,	/* UART_SCR (unmapped) */
 };
 
-unsigned int au_serial_in(struct uart_port *p, int offset)
+static unsigned int au_serial_in(struct uart_port *p, int offset)
 {
 	if (offset >= ARRAY_SIZE(au_io_in_map))
 		return UINT_MAX;
@@ -356,7 +356,7 @@ unsigned int au_serial_in(struct uart_port *p, int offset)
 	return __raw_readl(p->membase + (offset << p->regshift));
 }
 
-void au_serial_out(struct uart_port *p, int offset, int value)
+static void au_serial_out(struct uart_port *p, int offset, int value)
 {
 	if (offset >= ARRAY_SIZE(au_io_out_map))
 		return;
-- 
2.25.1

