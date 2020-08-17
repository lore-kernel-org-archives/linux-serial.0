Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817F4C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D9720758
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj0uFBXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgHQI7g (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgHQI7f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 04:59:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E2C061388;
        Mon, 17 Aug 2020 01:59:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so1202083plp.4;
        Mon, 17 Aug 2020 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9jh4puMhgeiMZ3rzGFgQjwsdsyWmQe0ttiWIm0JITM4=;
        b=mj0uFBXj+jw+H27fWkWeNRZS2nOhB4fImITyYnhg1OaP5qif/T2TUeKNR0cIsyjue9
         atzRQ0a1ak6eEVgjRDh0WR5kXlL9xC8oATl2TZwEnByiBW6clPSDUBcTRPgGTplVAXT5
         Np3JbfP82998B2DGkdQuxw+46PCJmjrJMGGurltynWB5G51JuU9D8Hjby7r98/Guz2cL
         V4rrdBxssMfuRC/eo3dMuheNUTlTDIwB4Zc9syhSOy0LRfjg1eGu5zKFg8MkUqv2ILSK
         Uva+yg/fLyBDclmIPbM3fyuc9R1Yl/5RM9stH2yjB1rn+LUO2si+tWgvo9KPIE+kGiK0
         gYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9jh4puMhgeiMZ3rzGFgQjwsdsyWmQe0ttiWIm0JITM4=;
        b=hEMqcEFbhEZBiWSt1KsIfnMx1cUiTUdfBHW6c42LX84bTFXF8R3Pdy2wTa9mwwQN9j
         Xuhpa8VnfAasJHOaIF5O6FzWDQ/8hecCFbAtPyG7QHpatwO3y+yAHBsdbD1rV3u/LBYv
         yOMpbWXHWkPvm1J25gjFNOBOQ3OmVqqfIOBW+vYFwt2GaStBzk1megkww/6Z/0NceXBH
         ipxxGPqCC4szYs1l/4QI9aWTR+l7aa/Oh3JUqKtm4E0C/mb1abjtPO1iIBz+Qx1OZQCx
         KgECdsNBNdazrBNRvWzp+I06jP7yW+RIiYicLh4bpFqI/kVH3Zp7Gz8uzZSqMgLQN621
         KOmQ==
X-Gm-Message-State: AOAM530wgTklJl57uxKVQSENRh44LKnDNlsHwuk/k+hQ4mpD+iv3U2G/
        yg8UClg/y+wb5yNKVrdyMso=
X-Google-Smtp-Source: ABdhPJzo9UPhNvnvPmU3y8T7AQLcroYdlkm0uftFO1IFxAx2reHjpM5JgBI6PqxH4nuI8ks9OFH25A==
X-Received: by 2002:a17:902:a607:: with SMTP id u7mr10645996plq.45.1597654775217;
        Mon, 17 Aug 2020 01:59:35 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j13sm18508547pfn.166.2020.08.17.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:59:34 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     richard.genoud@gmail.com, gregkh@linuxfoundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 1/4] tty: ipwireless: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:29:18 +0530
Message-Id: <20200817085921.26033-2-allen.cryptic@gmail.com>
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
 drivers/tty/ipwireless/hardware.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
index 6bbf35682d53..f5d3e68f5750 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -1006,9 +1006,9 @@ static int send_pending_packet(struct ipw_hardware *hw, int priority_limit)
 /*
  * Send and receive all queued packets.
  */
-static void ipwireless_do_tasklet(unsigned long hw_)
+static void ipwireless_do_tasklet(struct tasklet_struct *t)
 {
-	struct ipw_hardware *hw = (struct ipw_hardware *) hw_;
+	struct ipw_hardware *hw = from_tasklet(hw, t, tasklet);
 	unsigned long flags;
 
 	spin_lock_irqsave(&hw->lock, flags);
@@ -1635,7 +1635,7 @@ struct ipw_hardware *ipwireless_hardware_create(void)
 	INIT_LIST_HEAD(&hw->rx_queue);
 	INIT_LIST_HEAD(&hw->rx_pool);
 	spin_lock_init(&hw->lock);
-	tasklet_init(&hw->tasklet, ipwireless_do_tasklet, (unsigned long) hw);
+	tasklet_setup(&hw->tasklet, ipwireless_do_tasklet);
 	INIT_WORK(&hw->work_rx, ipw_receive_data_work);
 	timer_setup(&hw->setup_timer, ipwireless_setup_timer, 0);
 
-- 
2.17.1

