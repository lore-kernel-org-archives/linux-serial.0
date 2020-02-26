Return-Path: <SRS0=ccOi=4O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF2C4BA24
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4B724670
	for <linux-serial@archiver.kernel.org>; Wed, 26 Feb 2020 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="HaBgGRpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBZWXf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:23:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44711 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgBZWXf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Feb 2020 17:23:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so998645otj.11
        for <linux-serial@vger.kernel.org>; Wed, 26 Feb 2020 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yb2q4X4Xx+glvFsWCo9267jdvni3P/dXk3VwL89q0Aw=;
        b=HaBgGRpHQIdnP8pik4bwPj/b10/F8/6Sm2uGY3+Rm5uLMsi9tVdQT2CONFhpGlXClU
         4J41WAL41R+Lek2oZcTAy/h0N0noZVPY9kZXBtj3RZYCa6xXhWegzSEd7CzNwPOBolCx
         a+vjGx4CZk6p7FnH/MtNeWZ6kVJp1m+4NeN8YO01BbnmuQmuS7ih+qWJDHn/Fnq/LJ8d
         Lc26HOuG6+uqp9oyEkvBg1YxZV/ZFJufr5ftjSaRLKy45vso/4hd9tjP1WYb5vLUZtwU
         i8V2TWofH4WICz7iZKD+1nunUo0YtZeT4l09Du0ORprj14GpRBkh/bF9fEnBfMZuY5Dz
         TwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb2q4X4Xx+glvFsWCo9267jdvni3P/dXk3VwL89q0Aw=;
        b=ZyowUiloM5EBemY1DDYMQxnlQQE4Jx6jpuy+oyQnLKpOQfN+TScQIl3OZGH1/QpKej
         +14pPetxz1sVF7M4PENwRsb/btZS7W1Fsh6aZ6eWuKYrh4ksrbCTlln0kyAIm320I6Fj
         hNSuaDmp/8zjeK8MjBzOrOk9E9zr/3ngaZttcHxE6Lile2bPnlzpFqzgjKtEsCiJ9Q8n
         QGY9UMm/z/sepoG9++eQae8gETj/eyz9xbaCFfuzaNHWVoC97pCg8F4FyFLQWzcQ6cjr
         qxsb/p9wjaLzSwjign1ClAQI38bNprDwmbkZZeM5K3afYkTPUJ6uqwoTcb1k8vCkPqKN
         c+kQ==
X-Gm-Message-State: APjAAAWYEfoCV2eWsn+6LlPXrDZXFBOHBuQ5AoPkg37Px5wfzReS2bTJ
        FPWsVarI70Zdrh3X8/nr6eGcVg==
X-Google-Smtp-Source: APXvYqwhplybHXKtCb6GgbBzVooPdmL6iQu7bhv1LQ83CQ2U1wKBh6AYAM4FYPRPHnuItSRLxu1gPQ==
X-Received: by 2002:a9d:730e:: with SMTP id e14mr836501otk.62.1582755813671;
        Wed, 26 Feb 2020 14:23:33 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id z21sm1237614oto.52.2020.02.26.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:23:33 -0800 (PST)
From:   George Hilliard <ghilliard@kopismobile.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <ghilliard@kopismobile.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: serial: document fsl,inverted-tx and -rx options
Date:   Wed, 26 Feb 2020 16:23:18 -0600
Message-Id: <20200226222319.18383-2-ghilliard@kopismobile.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226222319.18383-1-ghilliard@kopismobile.com>
References: <20200226222319.18383-1-ghilliard@kopismobile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a description for the new fsl,inverted-tx and fsl,inverted-rx
options for the i.MX UART peripheral.

Signed-off-by: George Hilliard <ghilliard@kopismobile.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v1..v2: Removed confidentiality spam
v2..v4: No changes

 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
index 35957cbf1571..c8d677f9491f 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
@@ -8,6 +8,10 @@ Required properties:
 Optional properties:
 - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
                   in DCE mode by default.
+- fsl,inverted-tx , fsl,inverted-rx : Indicate that the hardware attached
+  to the peripheral inverts the signal transmitted or received,
+  respectively, and that the peripheral should invert its output/input
+  using the INVT/INVR registers.
 - rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
   linux,rs485-enabled-at-boot-time: see rs485.txt. Note that for RS485
   you must enable either the "uart-has-rtscts" or the "rts-gpios"
-- 
2.25.0

