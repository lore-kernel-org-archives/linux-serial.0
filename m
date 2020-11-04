Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC10C4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD0B20679
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdLzplEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgKDTgZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731018AbgKDTgY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:24 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F65C0613D3
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:24 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so881740wmm.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCthp+iIayFdO+hk3LjcuMh49TMSV9TDkGCxD2U2U74=;
        b=tdLzplErGzlsTMvA24FKwL+xCV7IDZGYkhg0Ou03OOiOpukQUndtoqdN4Btssu+uh5
         pHqlPj6YXHeaWY3svCwI+7BVuZnpLg9kcBdM3/i04heoyrJMQNzzUhmNBeh8Yx1aNXF9
         zfq84NfJovwoP6B0NFVL4tsiXIWzvB3qmeFTQP1QCxQ/Jsk/MR9hKniaUp9Hnjz3XE88
         pvWufpKWRjTPPVPfazBFWwYRfO50piv+Fff8KFd1J6zfTrJfwY9nT65ktGWC6K+/eWMX
         NMTU5EATHwcZAsh3okG6nCEDbMWxSQN4ts5Y5s9aEIz0sXJZ8GY2v+CtagQdWeVvYYyH
         ce5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCthp+iIayFdO+hk3LjcuMh49TMSV9TDkGCxD2U2U74=;
        b=N2RSUH9MbU0+WkrM3BfAY8ijIVQSVbmikDGwzdmwxtz9flVTEQmj6/4mUw/rRMCaBb
         a9KFxFQjLPVoR2ZByLfoNRlz0JnV65NSBrRoVaCC+WBeZY2sdbqKEC2lg42npXkRn+9h
         kYi1cNlL2n4h4YGU+X17qWMb7IzAVR8qo5b4QvkfRVs8ZeJjA1bzQU4kv39CmDWpzexr
         gEYMlxjsSXXrmToWd3DGks5kCk2+/HxD67SlZKwFhMXnCkMM9yoG0gmh65fhbPAVGJjW
         C3RJo/BdykyJMinodcQ93IgUVshX4fvRXU0fH8ty2hsn1e7+BNPJRzhjtiy3YdFTL/yY
         n+Uw==
X-Gm-Message-State: AOAM531I9a+24Fdj04gK6co6bTgWUi4f0RMyeiQBSrEswyDUVs5UfyLf
        gwOM13bzG7F4ehiEh3QfPguKcQ==
X-Google-Smtp-Source: ABdhPJxDQR/qW6NmTWHEpSz51ngDxQ9A5uFFVjpceis1t/O+rnkxd10E6YYGgu5C0ahzzXDmBT9mmg==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr6582229wmi.78.1604518583103;
        Wed, 04 Nov 2020 11:36:23 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH 17/36] tty: serial: amba-pl011: Mark 'sbsa_uart_acpi_match' as __maybe_unused
Date:   Wed,  4 Nov 2020 19:35:30 +0000
Message-Id: <20201104193549.4026187-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When !ACPI 'sbsa_uart_acpi_match' is not referenced.

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/amba-pl011.c:2792:36: warning: ‘sbsa_uart_acpi_match’ defined but not used [-Wunused-const-variable=]

Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 87dc3fc15694a..c255476cce287 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2789,7 +2789,7 @@ static const struct of_device_id sbsa_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
 
-static const struct acpi_device_id sbsa_uart_acpi_match[] = {
+static const struct acpi_device_id __maybe_unused sbsa_uart_acpi_match[] = {
 	{ "ARMH0011", 0 },
 	{},
 };
-- 
2.25.1

