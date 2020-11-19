Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A760C388F9
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 10:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED45246B0
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 10:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKTM83cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgKSK6n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgKSK6n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Nov 2020 05:58:43 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5559C0613CF
        for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2020 02:58:42 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id oq3so7277777ejb.7
        for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2020 02:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yXed+0a74u3qm8TIqk9+SjxVFtPdt7Ar5Nm2jWwjYjo=;
        b=IKTM83cPtwxniUW1z5nCG1FLZodxV3UoUwIedv+ri9QPLvCAxb23C+HhgXlRPWv2UK
         sq3V81YvvR1ViDbORPNwY7b6yOXcFyIbRfOnrL55LK38l8zf6RX6AewZNBKPKt968SDQ
         kMyiG1cX33Z8CuGKdnAcITY5+1iDEzlDnN7jOnwDTyK+GcqtXobEgE29urfRyISfNkan
         EFTxCx+4WJCSOsAV442OofQewH8XCU0b0ARAMj2kSO59/4d6zDzHff3ju5NtrlPSnjWR
         N3MHxneVN131yYrROecAVfW6M4MtBZxSArzkiM/BJ1xKYCDkmShjOldApN86xQFs5ZgL
         HIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yXed+0a74u3qm8TIqk9+SjxVFtPdt7Ar5Nm2jWwjYjo=;
        b=W7TvZcvP7UeXrzsNo4iLcOzUL5Z0svt3OIlbDJxKGElVzxctLdgJ5v4eIngY313tRn
         XQe2oF/V0kuYxtyVTTo8rrTo9jvZH1e82mICnecd6hrRrRTL7zH7Y6lKSG5OrM7MyC7n
         P/V2VmsESTtPcppdM78GOuC1WBNN8sw4FaHK8e/DsYF9v8uNMVIz62o9jul0TqAWTVWY
         Hx0AYYwDC34aQoVpmbN4jBObY87pyaKLAdf14QWaVDTJOeWZ2UUmu+LY14uTMP2HP10G
         CnbOpuh1ssn3Z6KgOd2VndbReSHBLmqRP7l3Mq8fIjrfeFUVH+15IhvIE72+ziqKKkZZ
         US5A==
X-Gm-Message-State: AOAM531ijcwlm9Wk45BdTBSLcBhvFUY5TWS0YOZ+b4+ZZW0rXNGRkdnp
        82AY/4GOOm1BeGnWI1gXGPNjB2tQp5I=
X-Google-Smtp-Source: ABdhPJyNCDz7gsTWMaa1VLJTvbYchiCseTI4o+c3OGM/A/Y+negmDvTegGR1zeMAN1o22RpYe/8FQw==
X-Received: by 2002:a17:907:2063:: with SMTP id qp3mr28920817ejb.314.1605783521218;
        Thu, 19 Nov 2020 02:58:41 -0800 (PST)
Received: from gci-Precision-M2800.fritz.box ([2a02:8109:8b00:c24:8af:bf85:ef0f:2ed7])
        by smtp.googlemail.com with ESMTPSA id j9sm14199963ejf.105.2020.11.19.02.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 02:58:40 -0800 (PST)
From:   Giacinto Cifelli <gciofono@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] option: added support for Thales Cinterion MV31 option port.
Date:   Thu, 19 Nov 2020 11:58:37 +0100
Message-Id: <20201119105837.17735-1-gciofono@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is a single option port in this modem, and it is used as debug port

Signed-off-by: Giacinto Cifelli <gciofono@gmail.com>
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 54ca85cc920d..3ad86a6e8487 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -424,6 +424,7 @@ static void option_instat_callback(struct urb *urb);
 #define CINTERION_PRODUCT_AHXX_2RMNET		0x0084
 #define CINTERION_PRODUCT_AHXX_AUDIO		0x0085
 #define CINTERION_PRODUCT_CLS8			0x00b0
+#define CINTERION_PRODUCT_EXS82			0x006c
 
 /* Olivetti products */
 #define OLIVETTI_VENDOR_ID			0x0b3c
@@ -1908,6 +1909,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC25_MDMNET) },
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC28_MDM) }, /* HC28 enumerates with Siemens or Cinterion VID depending on FW revision */
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, CINTERION_PRODUCT_HC28_MDMNET) },
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_EXS82, 0xff),
+	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) },
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD100),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD120),
-- 
2.17.1

