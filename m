Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD5C2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D044E2065D
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxWQRFEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgKDTgc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbgKDTgb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:31 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F36C0613D3
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:36:30 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c16so3419302wmd.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+W+IzJVlcwSw8IRMXBzJb1dzB3GDzrAyqgcs95IwTfA=;
        b=VxWQRFEV0vC/Lf0jlmwNBvW8/0FLvKwzZEu+uH7X7FkNBGaGg76oETtihBzGB6HVq2
         XK4SJALNsE0+8RJw6V9q4QjSsOGtnVDGq3e8I8p/X/R5VgutNA7Q50JpK+MLy1su0nFL
         WNHLL9q3oM3G68w/0/99xDzA24KWCw0JLP3sZb20mex9BpL1V3jUrsoCzosgJPpAH7t9
         MAyfOM2MiBBC5vKlcUH05ngWxEKclBvMkAmwYQ15XI360iUMoZeNQTaLWxLFJvKsuOyC
         3nE9SEcMceJi5iN9U9n45tzdaucar/krRG6kuL23V8brq8Q3XZqLmK1ix+SV4gvPnj9U
         llRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+W+IzJVlcwSw8IRMXBzJb1dzB3GDzrAyqgcs95IwTfA=;
        b=esFqyKSpDPg0R4/tNDxfR2HcByVbFZRzkSLzFuQ5a0Ktbzjl5STdP8hT2x43JhsgBu
         robUDUunaTQjbYBwW4OJMdt6KRpzyqdDjcDQb2K+XsaPFzU90ktsIxb1RzwbUbHpfFnA
         MsmsDu7UqTj+RxfIyhUFoVAGYghR1vOYooUscV4jzhTriqv2EYyzxGwMiu2qhk2VkcCk
         p6mAybqJymy91LMOdvFZmCIjto9CJt7SVL482mqCbhNN53dEgSHKHiRGSEJYHnLZMwr5
         ZJ+o6EImy2gA2JAFwwd+3eLf8mjrEE6InC1O/hZyfJkrkS1SAABf3HJGydg6XYE5DD+y
         dDcA==
X-Gm-Message-State: AOAM532kE+tUXxrofLT/4SNIw1reC6a2ozImVojRRyT5gVBnfIcxHsa7
        sAasR+08Yq0uCQEnyWTINiOABw==
X-Google-Smtp-Source: ABdhPJzdsHB0gRKZUlixDWWHCwavM98eiP6QAn36+VXXgHdWKN98UOhPp3e0gizULhrigHzF6tsHyA==
X-Received: by 2002:a1c:81d7:: with SMTP id c206mr6119967wmd.140.1604518588914;
        Wed, 04 Nov 2020 11:36:28 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Filip Aben <f.aben@option.com>,
        Joseph Barrow <d.barow@option.com>,
        Jan Dumon <j.dumon@option.com>,
        Russ Gorby <russ.gorby@intel.com>, linux-serial@vger.kernel.org
Subject: [PATCH 21/36] tty: serial: ifx6x60: Fix function documentation headers
Date:   Wed,  4 Nov 2020 19:35:34 +0000
Message-Id: <20201104193549.4026187-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/ifx6x60.c:553: warning: Function parameter or member 'tty' not described in 'ifx_port_activate'
 drivers/tty/serial/ifx6x60.c:728: warning: Function parameter or member 't' not described in 'ifx_spi_io'
 drivers/tty/serial/ifx6x60.c:728: warning: Excess function parameter 'data' description in 'ifx_spi_io'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Filip Aben <f.aben@option.com>
Cc: Joseph Barrow <d.barow@option.com>
Cc: Jan Dumon <j.dumon@option.com>
Cc: Russ Gorby <russ.gorby@intel.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/ifx6x60.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 21d519c804cb9..182e0ccd60b2c 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -545,6 +545,7 @@ static void ifx_spi_hangup(struct tty_struct *tty)
 /**
  *	ifx_port_activate
  *	@port: our tty port
+ *	@tty: our tty device
  *
  *	tty port activate method - called for first open. Serialized
  *	with hangup and shutdown by the tty layer.
@@ -719,7 +720,7 @@ static void ifx_spi_complete(void *ctx)
 
 /**
  *	ifx_spio_io		-	I/O tasklet
- *	@data: our SPI device
+ *	@t: tasklet construct used to fetch the SPI device
  *
  *	Queue data for transmission if possible and then kick off the
  *	transfer.
-- 
2.25.1

