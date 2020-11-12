Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E533C55ABD
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E1722201
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 11:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIcAU4L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKLLHm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Nov 2020 06:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKLK7I (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Nov 2020 05:59:08 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA7C0613D4
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2020 02:59:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 19so4885725wmf.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2020 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgyLyFchGL7Sp7PDuveL5Dq/jWJMAfMom/lcxhPZFGk=;
        b=OIcAU4L2NY90scoNe97J7Lo3gdQ4brKCLe5fP7yOH2yD67Ofz0aO0Wo5MUjF2m7/2C
         iqhZfqgE7sx7uOpFPy6Ej8kW1KzNWFmtq5SPp7JzD7HcWn46JIHoJagCqfDo1sLnBMmW
         8Ag48q1gpX4QthRyaDE+UI3Mt18iHtxM0E6J81ecjFGOXmqgtNRJkbanRvJMVY+ewKaZ
         yKEIWMnBWpwiUDnYYiK+r6VCsU2UdmV9yTj07zJZJMrzl00HxHjL52MRjrnzsiZLqanr
         olAQRFJvinPjCXmYaWsofa2c+EJTF0jTIVk2+chj6Zx6LKZcVdSbdxxJR5dgoozgc9p4
         XSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgyLyFchGL7Sp7PDuveL5Dq/jWJMAfMom/lcxhPZFGk=;
        b=GOla+nH3HxI/8zBo/cp88AhanXi86Ob2xgovXRqUAXGTXPqgZDJWw8nguppoc25+xe
         OgM7SZTHw63JHCqqRgTE+3xqwxe5MylCVs0e3THkZ9M5eFxGfqwAmyJj9+vBE5ltiheV
         ucPpBl/FLn/spGPuPw47l1dMqTVtC0hkPFBmiyucgyir/Nuhd+jShFdQPeIrLAJq7OXa
         fhFxUc3p+gWuBHxIkvXZhnGSKa/KTQMOLP7z8QtvIDYfoferl2hLLJ8PD4Rs/VDK1VpP
         HWy1Xh+G+obDWgPyn742U4yCsoE5P+EWP2IMc5lSQHvX0IXPclaYSnEwX670J7YBGPvl
         lqqw==
X-Gm-Message-State: AOAM533j1UpLR6aq2YwYkmqfTFAl/T3Ubqz1/bxI9yWgQrdFrnuTm71O
        pgk4Mx+Px1BPx3NOIjCkO5HUcg==
X-Google-Smtp-Source: ABdhPJypm3E5Z4Dtn6FAq2BnkUT91LvIbDHRoSB1aVRFTBICzorGYZNNLlfeGh36eCzBVJ5tkNl0tQ==
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr9042901wmf.55.1605178745182;
        Thu, 12 Nov 2020 02:59:05 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id u5sm1167239wro.56.2020.11.12.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:59:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] tty: serial: pmac_zilog: Remove unused disposable variable 'garbage'
Date:   Thu, 12 Nov 2020 10:58:57 +0000
Message-Id: <20201112105857.2078977-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112105857.2078977-1-lee.jones@linaro.org>
References: <20201112105857.2078977-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/pmac_zilog.h:365:58: warning: variable ‘garbage’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-serial@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/pmac_zilog.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
index bb874e76810e0..fa85b0de5c2fd 100644
--- a/drivers/tty/serial/pmac_zilog.h
+++ b/drivers/tty/serial/pmac_zilog.h
@@ -362,10 +362,10 @@ static inline void zssync(struct uart_pmac_port *port)
 
 /* Misc macros */
 #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
-#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
-				     garbage = read_zsdata(port); \
-				     garbage = read_zsdata(port); \
-				     garbage = read_zsdata(port); \
+#define ZS_CLEARFIFO(port)   do {                       \
+				     read_zsdata(port); \
+				     read_zsdata(port); \
+				     read_zsdata(port); \
 				} while(0)
 
 #define ZS_IS_CONS(UP)			((UP)->flags & PMACZILOG_FLAG_IS_CONS)
-- 
2.25.1

