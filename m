Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77142C61DA4
	for <linux-serial@archiver.kernel.org>; Sat, 11 Feb 2023 15:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBKPqq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Feb 2023 10:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBKPqp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Feb 2023 10:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6A274AB
        for <linux-serial@vger.kernel.org>; Sat, 11 Feb 2023 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676130364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O7XkEjMNE8+iiPDaPqXuL/eN3ShpzX6KK4M/D+SJvvE=;
        b=iscWVRCvWWO/bgcmDwWFnmPz0eH1uHPZTg0HAN8DTzoAXYk/n5mFvUV2EaBewX2tWE4r46
        KvqjZ79iB75urkRf4MWw9j/4dWtyKxzrRtaVPlNyeZA4MqMBPqmmSukSfRHNJ7p569shVM
        ssb609fdPVr8X6FoHIpIPHx8DgVghf0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-Qu75kHI-OyS92CGiOZSpQA-1; Sat, 11 Feb 2023 10:46:01 -0500
X-MC-Unique: Qu75kHI-OyS92CGiOZSpQA-1
Received: by mail-qt1-f197.google.com with SMTP id t5-20020a05622a180500b003b9c03cd525so4925031qtc.20
        for <linux-serial@vger.kernel.org>; Sat, 11 Feb 2023 07:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7XkEjMNE8+iiPDaPqXuL/eN3ShpzX6KK4M/D+SJvvE=;
        b=NzzvZtvk0Gb189Ede76oXeMvUCl466V4JQRuZFJ4JCCtXg3ClxqJVb9wE/3MJdjFGq
         1aflQRUFpDUSvlpiNTQa1xYal21B8s3ivinSsQUiimBWSQKATT8oza1eEk4KtEQG/Khw
         HDq69PrOVYalb8kEWQoYoZnW5sQ4yWInCJHJQ8H5TTEdWMxwKOLWSGxYE6b0IVwvyGxb
         UxWAfC2oa9pWcin2Se2ns+GR/ZUar9FHq5d2b4Mf+2SqgSrJ5WQUeZzlsA0XlXZpR5wD
         BCiYx/O336kZM4pRJIHK6fIPt26aPUsXmxfbgHBcAptg68AzOzlsxmQCsWqBylj+JJG0
         /LaA==
X-Gm-Message-State: AO0yUKUkNWkSuS5wCFLhaFuyboND1hJVpHd5CgaZdZzZx5wdR8v+6wOs
        lkvEWQNBa6HUxLDgvEGHHoCDXkT9tJWckzbNYP9oZK1DAlyEnFGsin0MEdfrC9OBaOpR7dFznFT
        Q72mR7wqVXhgWc7oNxexhI7Yo
X-Received: by 2002:a05:622a:64b:b0:3bb:89be:8b45 with SMTP id a11-20020a05622a064b00b003bb89be8b45mr12440596qtb.65.1676130361197;
        Sat, 11 Feb 2023 07:46:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8TgpagNQyMM/EhhmI5d/iFi5OKGZteX6jyu06UbjTHrtPOUeLawnKurMDXLzcWPn3V5YiZCA==
X-Received: by 2002:a05:622a:64b:b0:3bb:89be:8b45 with SMTP id a11-20020a05622a064b00b003bb89be8b45mr12440558qtb.65.1676130360863;
        Sat, 11 Feb 2023 07:46:00 -0800 (PST)
Received: from borg.redhat.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t187-20020ae9dfc4000000b0073902217c00sm4697750qkf.23.2023.02.11.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 07:46:00 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] serial: imx: remove a redundant check
Date:   Sat, 11 Feb 2023 07:45:50 -0800
Message-Id: <20230211154550.2130670-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

cpp_check reports
drivers/tty/serial/imx.c:1207:15: style: Condition 'r_bytes>0' is always true [knownConditionTrueFalse]
  if (r_bytes > 0) {

r_byte is set to
  r_bytes = rx_ring->head - rx_ring->tail;

The head - tail calculation is also done by the earlier check
  if (rx_ring->head <= sg_dma_len(sgl) &&
      rx_ring->head > rx_ring->tail) {

so r_bytes will always be > 0, so the second check is not needed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/imx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 363c77a140f0..523f296d5747 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1204,11 +1204,9 @@ static void imx_uart_dma_rx_callback(void *data)
 		r_bytes = rx_ring->head - rx_ring->tail;
 
 		/* If we received something, check for 0xff flood */
-		if (r_bytes > 0) {
-			spin_lock(&sport->port.lock);
-			imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
-			spin_unlock(&sport->port.lock);
-		}
+		spin_lock(&sport->port.lock);
+		imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
+		spin_unlock(&sport->port.lock);
 
 		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
 
-- 
2.26.3

