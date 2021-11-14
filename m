Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE74C433FE
	for <linux-serial@archiver.kernel.org>; Sun, 14 Nov 2021 18:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A42604DC
	for <linux-serial@archiver.kernel.org>; Sun, 14 Nov 2021 18:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhKNSmL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbhKNSmI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 Nov 2021 13:42:08 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B6EC061746
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 10:39:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id n26so8480741pff.3
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 10:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VA+Nf5mnU3mY2GBsE0jbJZKakSMRM1K5SLbV9R5mN2M=;
        b=aMmbNnfLquP7oxgY9WQ9ObrQwPFDgq+J9EoWRmoP/JCEHgOqFjYBZcrVjfPbxWq4YI
         32Ct28XGzpeECxdOV9bNIOu/LxPaP3k6aNKg9yospHrPfTOlXG2FUUp8bVFs60Jv1pLG
         l2HD714beYJsqvx0jBdEGpUhdJtw7g6hUSIXrNy7kSy3s5FcA8a1TLhKQVDAK/zQuJSF
         y1xO343wXOu7g7mYtKKUTAEIpyP/m6ttYGAsUPZ2VLLtd2u+bN7YPhEkY4jMU14SvMwH
         ONi6LOJ5zpRbUibc8MX7mLO0fo5hefeV4xffwp22etRYOFLmclQTMX3c1TQBXkKGX+ZB
         oESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VA+Nf5mnU3mY2GBsE0jbJZKakSMRM1K5SLbV9R5mN2M=;
        b=SMWqYm8lL6TGg3ZjTXUb6Dl7LvYvWYxJB9Kl5WUxzsmVK0ZPX6nfgUcWbeSs6teJgG
         QaaOlq8q4GStneCsmb36fabWh2shtm7Ju1JH6D2DnH3q0i6VnV9o/nWEgoXBhyg9edKP
         iS1uQhZIcR/a9a/8o8iPyMMDbsbjXWLGU370mglMqQ1rE6/HTv40/pEtCqnk8kcMLvlz
         DKpxcH6dXoQURy4DekoMVy5hjOaX30EOobdBJXtB2kovysjpFLnvBKsynPGqhHSHNcE7
         ikwYIcfic18/XfGBgeDpiCEXbtsrbWKYq0WwlPbc0uwhPO29i7UbJC3OaEH9+mp1D0pL
         bUWA==
X-Gm-Message-State: AOAM533gnoiiGuA/tRwfkVgHI3pjMj+oR/NUy9wVeuZevr+raWqPfMjv
        2ahA1Qr3CK2VcuK8qwBX6bnYfw9sDtpRHtmrWp4c8DJqjIVqtRLn9ug/SErBgfxCUK6rE0sssbz
        el0MtzZ/S8C5zyttlvd1mm1/RUdSzJnDVEQTtAIea9xlKD2ZUNL+oHb91E8iIZEBs20egLfk5ie
        uvUkw=
X-Google-Smtp-Source: ABdhPJynfZj+4+wTgNshTSaP4TxxhOK6M06xL0rCy9z63zIg7g74E2MvbeedL97tHZWkMi/jNLdaVg==
X-Received: by 2002:a63:54f:: with SMTP id 76mr20812108pgf.26.1636915153362;
        Sun, 14 Nov 2021 10:39:13 -0800 (PST)
Received: from work-laptop.dolannet.net ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id y130sm12551642pfg.202.2021.11.14.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 10:39:13 -0800 (PST)
From:   Jay Dolan <jay.dolan@accesio.com>
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH 3/3] serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
Date:   Sun, 14 Nov 2021 10:39:08 -0800
Message-Id: <20211114183908.444923-4-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211114183908.444923-1-jay.dolan@accesio.com>
References: <20211114183908.444923-1-jay.dolan@accesio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes: 78d3820b9bd39028727c6aab7297b63c093db343

Fix error in table for PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S that caused it
and PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4 to be missing their fourth port.

Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
---
 drivers/tty/serial/8250/8250_pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 5615ac1d2352..3f792cb44805 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2302,12 +2302,19 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.setup      = pci_pericom_setup_four_at_eight,
 	},
 	{
-		.vendor     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
 		.subvendor  = PCI_ANY_ID,
 		.subdevice  = PCI_ANY_ID,
 		.setup      = pci_pericom_setup_four_at_eight,
 	},
+	{
+		.vendor     = PCI_VENDOR_ID_ACCESIO,
+		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
+		.subvendor  = PCI_ANY_ID,
+		.subdevice  = PCI_ANY_ID,
+		.setup      = pci_pericom_setup_four_at_eight,
+	},
 	{
 		.vendor     = PCI_VENDOR_ID_ACCESIO,
 		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
-- 
2.25.1

