Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3567EC4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C668E20657
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDTWv8+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgKDThX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbgKDTgq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:46 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541AC0401C2
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:44 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so264619wmh.4
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJlyn82FOfM7EXjR0q74MRu42lgfKXYpFARoLgEcKcw=;
        b=CDTWv8+b7Pc7euhcDEsYBH2s0hgrrGZ9dFeeb26B0gMt0vQRbHOkNYq12S81R2kSIb
         BkAZElbMwbidJp0VR2ZQrpMuxtaij6l4SS3iiFsKW8QQicUO0kgIo+9bHizDrHJSN/7i
         8aOmvSrphp4pnAsk4raJf8eABmQqhcqbtF86lo5/LYL3HQ5u/y5vVtfwc19HNURBk39W
         TmrGK+eFMC0IBsAxiOCp5WoexunKFDgC+MdbkeMV3/YLnbC7GDLyFT1NlqdhgeAJKI2T
         ZxTy7SwCJ2VQzBXSlfn77lrnQBilU8LpnRRDY2CaseHey2g0t+xd3ZnRCPrqr5TSTd3/
         jHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJlyn82FOfM7EXjR0q74MRu42lgfKXYpFARoLgEcKcw=;
        b=RXL13LF/XI91DKqBnTmcH98Ks6H27IldoKEBDD7p9nlKfC/h9VLaC0u0jlgejtD19r
         g2d8mKzfzV022F7LuTasWflTRnlxL4CGRFtdQMCZ4yWBg+46puKaJusLL2ZhZICDz7Mb
         SLAdWUqo97P+dItEAEfwoAenZOISSmDicI4arwb0P0VPiBn/BZVKETw0/AhPG3nvwuxR
         dT3lL/UKcMdQouIaZsLlkwLVNngNdUgVwZUSEsRONjS4lu/PlqxnZaW/ICOOWT1Dkc8K
         /uXDEnW6muthwQgbuLmnw4lhOGpw6vltsJBw+wfA7sR2Rvp4/7P/9qHmSMvxtjENZPBk
         T0oQ==
X-Gm-Message-State: AOAM531Kr7quCn4GxF+804VTzpc9DCXsh8dp+x/nupcNdSaF7YkVL5XT
        Lji/Q2Qhp3RIxlXl7r+/wTAu9Q==
X-Google-Smtp-Source: ABdhPJwCKoSo/a5+S17lYgSHyM7aF0XsUIOUlkwoI96HWyiOrIZnl0nWmrJK04DiKb1xktIaygjjXQ==
X-Received: by 2002:a1c:4c0a:: with SMTP id z10mr5105765wmf.96.1604518603201;
        Wed, 04 Nov 2020 11:36:43 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 30/36] tty: serial: serial-tegra: Provide some missing struct member descriptions
Date:   Wed,  4 Nov 2020 19:35:43 +0000
Message-Id: <20201104193549.4026187-31-lee.jones@linaro.org>
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

 drivers/tty/serial/serial-tegra.c:94: warning: Function parameter or member 'fifo_mode_enable_status' not described in 'tegra_uart_chip_data'
 drivers/tty/serial/serial-tegra.c:94: warning: Function parameter or member 'uart_max_port' not described in 'tegra_uart_chip_data'
 drivers/tty/serial/serial-tegra.c:94: warning: Function parameter or member 'max_dma_burst_bytes' not described in 'tegra_uart_chip_data'
 drivers/tty/serial/serial-tegra.c:94: warning: Function parameter or member 'error_tolerance_low_range' not described in 'tegra_uart_chip_data'
 drivers/tty/serial/serial-tegra.c:94: warning: Function parameter or member 'error_tolerance_high_range' not described in 'tegra_uart_chip_data'

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/serial-tegra.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index c363ee0470f45..bbae072a125db 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -81,6 +81,11 @@
  * @allow_txfifo_reset_fifo_mode: allow_tx fifo reset with fifo mode or not.
  *			Tegra30 does not allow this.
  * @support_clk_src_div: Clock source support the clock divider.
+ * @fifo_mode_enable_status: Is FIFO mode enabled?
+ * @uart_max_port: Maximum number of UART ports
+ * @max_dma_burst_bytes: Maximum size of DMA bursts
+ * @error_tolerance_low_range: Lowest number in the error tolerance range
+ * @error_tolerance_high_range: Highest number in the error tolerance range
  */
 struct tegra_uart_chip_data {
 	bool	tx_fifo_full_status;
-- 
2.25.1

