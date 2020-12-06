Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1061C1B0D9
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBA82312F
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgLFHkf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 02:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgLFHkd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 02:40:33 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811CC061A4F;
        Sat,  5 Dec 2020 23:39:47 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b5so1755256pjl.0;
        Sat, 05 Dec 2020 23:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xFdWkIp7aOum4emNi0OOIEbmbd4iIkziHrDfP7ddmnE=;
        b=kRGVIffG8D3UGQqG35RnXGKoRVMU21ND00hzs7S/u7fdx1CjZM3cQzRD11CclN4hJn
         3A2XIWwugO30sUeZNSJUWN8cVLK8kFP76I7ERgyBiLqWi/ThpbNIxpo4gHhjQHGhylCx
         6cKjSTDYzH5b77hH3SX5UD3jWsbDqydDI2XRZyZY9WunHY1WA+z+3+LT114txaDKAOm/
         ZbEBlEJ6HZ7EENbkcxBKKLwz6Afyq2NAs/skqNq5RaK2QtzFcR1wUKj+vH92hYrqJB2N
         eRMPYcWXYMu7Sah3LT6lCo+RKVpXeGChapQ03NmqU3uDCX0zPWv4z/hWUctpyD8qWC8C
         EoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFdWkIp7aOum4emNi0OOIEbmbd4iIkziHrDfP7ddmnE=;
        b=tzzp/cDryu13YZweQ9RVjq3KOIh34WSQYUbv4sucQWVLwBXbUk73NR9WOstJNFXloV
         tawkFyvmlblyRdFcCIzlUFcbUwye2LxjGdcg7/lIVobT06tMo46IeiHYo/GjyUiY6lDd
         0wGNEKwEpa/Y66yn06epjw3qX8lqI7XahBcVt4gI5tzKr0i4Ce8uaDOqvLSrIROJhGWZ
         +JLdLYzRIv/9aWcVOs7Yb4/HBk+N1cU9y95Su2npuMYqNhltTAWnQVoTrwQwkddm/aN0
         8m/jmCzIVBlN3khkXmyMX4GIaK4lPxEIqXZSBQfGjrU6IYAgzQoAFH3qqWybds4URMtq
         Ztnw==
X-Gm-Message-State: AOAM532bihwsyo9j1bRU2q2bHGKQW2CCu3UnVHertQ4boQ4MF1TqYDWh
        Ao2hxzCtFbJJY0X9Ox6DF+uppDPpcyMoBZYf
X-Google-Smtp-Source: ABdhPJzsk2FRvN9Xwo8rM65HTj0D47qJnjthRY26EQ+zg6dTd4Mx0ogwChMOKL6uMAaUYPSs/aZsuw==
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id f12-20020a170902e98cb02900dacb88f11dmr11057996plb.17.1607240387295;
        Sat, 05 Dec 2020 23:39:47 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f092:5562:8d65:7204:31e])
        by smtp.gmail.com with ESMTPSA id mz1sm4101275pjb.33.2020.12.05.23.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 23:39:46 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 3/8] tty: serial: jsm: Fixed file by added more spacing
Date:   Sun,  6 Dec 2020 13:09:27 +0530
Message-Id: <07dcca2606fe86253d14ad47c17044281a319295.1607240285.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
References: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 202d6ba93313..2bc5f32e59f4 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -609,7 +609,7 @@ void jsm_input(struct jsm_channel *ch)
 				 */
 				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
+				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
-- 
2.27.0

