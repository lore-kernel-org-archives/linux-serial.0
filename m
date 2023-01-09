Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C5CC54EBD
	for <linux-serial@archiver.kernel.org>; Mon,  9 Jan 2023 15:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjAIPW6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Jan 2023 10:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjAIPWj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Jan 2023 10:22:39 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956A032195
        for <linux-serial@vger.kernel.org>; Mon,  9 Jan 2023 07:22:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso4159474wmq.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Jan 2023 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vOTKWnDZmwehJAU6Nl1hb49nz4Cs660rzRHE7sjmWA=;
        b=AGc30VpVOrKwF+dKIvUbevde6oEnt0lII78VVfHLfyT53Wz0n1Yh/KCOEybIswI2zD
         2xxjsJidh6GvzQ2K1+Oxy5V4RKPOVuLgTexEgK1e/MEJIMRqfTjWKjQvFVE7e1XEnxSA
         Ns3U7whvAy8xH9apVcq6bypl6/NrOj1V1hz7bu0TVBxinqNgwQT7SUgoxl2RuYroxL0/
         3QPhi9+xNcKCelo5p1EJ++1aQvXHGU80JKC7ZazNkAG+d/rlhmUzpqRtOinhTctxZEUm
         l7BiIN0qNf9jrqlFznod+Yo1bi4BVSZav2FDu4G1YF6N1r3rHbJGTsrgki87TCzb8MXm
         tUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vOTKWnDZmwehJAU6Nl1hb49nz4Cs660rzRHE7sjmWA=;
        b=0yxjZxZvDlAqGeALByt+0vN/d4hu5QkR5Ipll/JuXl5N/XiF4xwBOv2H604HOGjzlB
         PlI8RqPeSW4D1ui3Basv//Vj7hVp/baDe+duaU/h72F5RIHb0+Zv6ovvLE2rECmeKRWb
         U5/0opVc6klJWMaNF+aPY68zbbuOy3WQrnb2U3YbKtCQqu6Fs6G0q5uVnxFGi83jAmT5
         1eTGv9Q1QVa59uPCPU6BMHtiJYNdlbyUE7nEwz8jD0LbFIKfdiX3bwvmJbFY/34kw+QT
         OlFQ4FxbPDNgVs26+IIcjEruy0xEg+oTy0OsT8tpCw0R2Pii/cJtMQmVy4/KSWP7zCgw
         C9iA==
X-Gm-Message-State: AFqh2kor75uV8/gyOsld5GDbKrtB+GteD/Ha8JykK+1x0IvOSOl6rLW9
        WUms3LW3XniXEkv34tDCqChqsQ==
X-Google-Smtp-Source: AMrXdXtRAL3NMvlUqZrrkSZbPdNqDQn6dQLhR41NfSr1it0b0iJqWDDrRJBt7KxQZX/oUuox/jGqyA==
X-Received: by 2002:a05:600c:1d20:b0:3d2:2aaf:316 with SMTP id l32-20020a05600c1d2000b003d22aaf0316mr47036944wms.36.1673277737004;
        Mon, 09 Jan 2023 07:22:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b003d35acb0fd7sm17314027wmo.34.2023.01.09.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:22:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] serial: msm: add lock annotation to msm_set_baud_rate()
Date:   Mon,  9 Jan 2023 16:22:12 +0100
Message-Id: <20230109152212.343476-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

msm_set_baud_rate() releases and re-acquires the port->lock, thus add
lock annotation for Sparse static code checks.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 7dd19a281579..44e1e83127ac 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1125,6 +1125,7 @@ msm_find_best_baud(struct uart_port *port, unsigned int baud,
 
 static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 			     unsigned long *saved_flags)
+	__must_hold(&port->lock)
 {
 	unsigned int rxstale, watermark, mask;
 	struct msm_port *msm_port = to_msm_port(port);
-- 
2.34.1

