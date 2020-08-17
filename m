Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97463C433E3
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D48020758
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auEcpVle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHQI7o (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgHQI7m (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 04:59:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE52C061389;
        Mon, 17 Aug 2020 01:59:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so7183893plt.3;
        Mon, 17 Aug 2020 01:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4/hpWacXzg752w756gSyrpUVLzy+WB4RJa2GSP/+9j0=;
        b=auEcpVlecmTzXj7OggiVoMdBj0jRijTiGrF/U2SMXHJLXUFPcimRoSxlPOhWzjsymv
         tbWzYiD145VNZe3FvkJxHFPyYQcpNLRit1aXK0I/hcXMmuzYug1MHfKDMD8/Z/SJ6L1J
         9x/ozt05NLarjVrhKMgfOz0S9OWUcwIlA5NwOnjK45IZmBNrbnz43YWeX6N1wJfXhJGx
         dwdhiAbZxecKnD/JloZSzlYXHuowiUEz7xbkkVQI4vGDjwQVEVc7tLuRLEoAgqMtMmx+
         +zaImGLg1Y741z2rLE5Mr1axt9xfLGvNIaj4AWRCNrv6VRzkztOAAQx5y4ze8/Mxr8vH
         Nu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4/hpWacXzg752w756gSyrpUVLzy+WB4RJa2GSP/+9j0=;
        b=C2dlpTvTvo/Nv4NviSZsqEM0y0D4FtCyxwrP+KM78K1p1XbIdyZBbviFf687qn82Gj
         Y1wrrumt1yjLKEBouvIXws8AQUElGUZk8m/66jIwO4vMOvRlYHy+uJ7EhClgG5jzYK0C
         1RLMOtSpzKqdNTuLbvUbX5nbrxSYAgIkqZ0eZ3W2h+AFqT2GIO5AkHAAQiWgzZEG4rig
         trp15w8CEIPQvqIXFFLL/gPDmxRf3AB7IeTArmGeyAePY++qCckAWC39XwVFrBhiMSiO
         eKMCXs6PnrUjYmgskRtrkaRFUEDBk5lN44l161WLvRYJC0UBP0GhcJcJJxHr3w1hYnix
         HzqA==
X-Gm-Message-State: AOAM531rpmJSgt3e41SxKC9GC0+BVltfq5mzLxI6wPywxh1xvsXWPjAI
        HRNDvrj8U9z9H2XpJTeujIQ=
X-Google-Smtp-Source: ABdhPJy7SzASHehEpfjff0m7qfksRabhhEePmE484gqg2MRXGyG6iKLa92zNti7GDJ3fI+sV2JpQtA==
X-Received: by 2002:a17:90a:2a84:: with SMTP id j4mr11844533pjd.135.1597654781701;
        Mon, 17 Aug 2020 01:59:41 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j13sm18508547pfn.166.2020.08.17.01.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:59:41 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     richard.genoud@gmail.com, gregkh@linuxfoundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 3/4] tty: ifx6x60: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:29:20 +0530
Message-Id: <20200817085921.26033-4-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817085921.26033-1-allen.cryptic@gmail.com>
References: <20200817085921.26033-1-allen.cryptic@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/tty/serial/ifx6x60.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 7d16fe41932f..37d5b8516880 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -725,10 +725,11 @@ static void ifx_spi_complete(void *ctx)
  *	Queue data for transmission if possible and then kick off the
  *	transfer.
  */
-static void ifx_spi_io(unsigned long data)
+static void ifx_spi_io(struct tasklet_struct *t)
 {
 	int retval;
-	struct ifx_spi_device *ifx_dev = (struct ifx_spi_device *) data;
+	struct ifx_spi_device *ifx_dev = from_tasklet(ifx_dev, t,
+						      io_work_tasklet);
 
 	if (!test_and_set_bit(IFX_SPI_STATE_IO_IN_PROGRESS, &ifx_dev->flags) &&
 		test_bit(IFX_SPI_STATE_IO_AVAILABLE, &ifx_dev->flags)) {
@@ -1067,8 +1068,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	init_waitqueue_head(&ifx_dev->mdm_reset_wait);
 
 	spi_set_drvdata(spi, ifx_dev);
-	tasklet_init(&ifx_dev->io_work_tasklet, ifx_spi_io,
-						(unsigned long)ifx_dev);
+	tasklet_setup(&ifx_dev->io_work_tasklet, ifx_spi_io);
 
 	set_bit(IFX_SPI_STATE_PRESENT, &ifx_dev->flags);
 
-- 
2.17.1

