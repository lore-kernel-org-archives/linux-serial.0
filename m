Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BDCC4742C
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E1E20679
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6g1v7xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbgKDTge (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbgKDTgd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:33 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF6C0613D4
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:32 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id x7so23339439wrl.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/gv0SsLI7CnshsO1g6Ee0CY3I2zGh9OhwtyHlvyxPI=;
        b=G6g1v7xnvTEazh/ppcd2E7jvCP9tnex3H3LMRF+WLiV7v1gqyiHTOFHoGlbEghWcLl
         M5Bn/Z403KWlOt57pmj2w0wXo66zrZj1cqd+ahq8abwgEqi7j+5i/2dfLxw++VpKI/Yn
         IiszaeGQ1N+99+Qc8wB7QcRfXvhOzY6Pt8rFbTG34hhUT0aa6Y/kKwHXONYUw+B3dNkd
         phbwSu2SMPbQkI8lwxuZOk9FkQ8KpFStZ9Sm0IrGkPV1I4MzC/2hp6Xp/Fp2sQplHP6l
         aUAaxtYKtbJN0hwUqQJZ02apn7dO8KuluGGFsK8zWngliqyMv+cl4ogsn0b/joa2Q2wt
         1vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/gv0SsLI7CnshsO1g6Ee0CY3I2zGh9OhwtyHlvyxPI=;
        b=lVSOev5cj9/zPLWwOmt3gC/GcgcrRiO2A4u/w07dNRHdGmOfQfbT3dMmegvSi2bbx4
         /wz/lq5McWJImx4n54Ff8R/Ei1RqLDpQl/fcE31Ktl3YON9kWbd/m46koW1T8chutB1E
         aTS+W1sykCCywDf/PyL60SIeodqnWWuzqxxte0q2kWXdjlRBqr70/h75q21+vgr4Yspu
         +U/eBFzt9Rz3acfVzqDHtFU6FamaQPzOe2cybptn9EBg+jC4hO0KRJvYcN91hS7Vo9v0
         Q8cW4VhfEBz9Ed00ymKVXW4RmjJ0pqPtwlCUOGkUg1RAHXP+t80TfC63sUVxe2p4Smm6
         UEGg==
X-Gm-Message-State: AOAM533MMnrurCvBzlN/ag7Uzbt3eYURg7aPqmrEgD7GmSg5tx4jjziq
        sSQxXL07cOZz0ZZq656+5hb0PA==
X-Google-Smtp-Source: ABdhPJzJvYOB3ZWklk3J/n/mJXGJhAX0H9YEbO+QG9lKvohw7OcHOpD65XMl0ZpyDLrHvlIL8OTU3Q==
X-Received: by 2002:adf:8284:: with SMTP id 4mr9105007wrc.386.1604518590885;
        Wed, 04 Nov 2020 11:36:30 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 22/36] tty: serial: xilinx_uartps: Supply description for missing member 'cts_override'
Date:   Wed,  4 Nov 2020 19:35:35 +0000
Message-Id: <20201104193549.4026187-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/xilinx_uartps.c:205: warning: Function parameter or member 'cts_override' not described in 'cdns_uart'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a9b1ee27183a7..a14c5d9964739 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -192,6 +192,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @baud:		Current baud rate
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
+ * @cts_override:	Modem control state override
  */
 struct cdns_uart {
 	struct uart_port	*port;
-- 
2.25.1

