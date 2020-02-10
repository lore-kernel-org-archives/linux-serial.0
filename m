Return-Path: <SRS0=+uUE=36=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21107C3F68F
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 17:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB932173E
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 17:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="OihE4KgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgBJRuk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:50:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41037 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbgBJRuh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 12:50:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so9992262oie.8
        for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2020 09:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=V32zSJvuwZW0sQ7+BEi24f7xdXL9W83fv79Z3HiobAI=;
        b=OihE4KgCvjfYq7v1iZQJoeEgpPkT68yCFBmEVtsKAOCNKF+iK5b0vLDlFDLlCnzLf4
         FJ0Ocm90z9mGQHkRfmbhGIaOAxFRsKlMzqogTKZI3Rg2pNpmQLdOftD+mU/PSQIyvuql
         T5Dqn+I5lhJdzy7lhqA3M4oKRNR8bGj1/cJTO4OtvuWjAODI2Cx/ZfS8f/W2iU6bofhH
         R41z6uB8UvNT7Mo91EeOi1a6RU4wmWZD7qgk6n2ktkb5IvVx0sVpT8I6sPOzFy4h5BfE
         YQdCKGpeResU4x4ulXKCUZbgA6gSeOFJpMEKgbr8dzSbmIwnO6/SqR97PoaTtcjJlQft
         QyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=V32zSJvuwZW0sQ7+BEi24f7xdXL9W83fv79Z3HiobAI=;
        b=VMZB0DGU/pJKi0pnrsag1oxPueg1tIuLgaNK/h3ozsFEkRCequl/XMPACFewpgCn2N
         yc+VWTn1gKzT8OdN4AuMXbvYKcSQfRlZTybqkdMDCFF2Toa0js3MFne3S7qZAzuj0kNw
         QzQj/YGGQhLewQwaHBg1G0O8U5PJuZSkklpMwK3bzIXGanaFgm/007zGioFEbkTeH3Pu
         cX061/+zJmV4EPpcuA1NfxN5490nO+ShC8eR8aQ+K9GZq+ftvws+3c4HloeZfMkiWPUu
         7t/MN4aK4WplV9wO3jjfEphzbVVJtYqDpoliRipLulE0meulLf5fSAW6AAurJ1WLBQuz
         d/Dg==
X-Gm-Message-State: APjAAAUoGkG2gB+XWuZGfUe92aZMQTvfRDmOtVcd8KDt40/nxTKYDyF9
        Lte0OoYpLK3dnbrQAAYoUaB0nTq1m1Yy2uqtTMY/ejCbeaLuEjDPBW5rZmN14OB3cZknip5dGIt
        weu1uEuenl3DdNHo5Hw==
X-Google-Smtp-Source: APXvYqyZQTwhFMLIcyHQZWJJjvlmTmF8K9VxQoq9g/8gca7rrxoNg8/zDOhrkj5jzh5eJ+rKXAXGIA==
X-Received: by 2002:aca:1c01:: with SMTP id c1mr172004oic.18.1581357037179;
        Mon, 10 Feb 2020 09:50:37 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id r205sm293189oih.54.2020.02.10.09.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 09:50:36 -0800 (PST)
From:   George Hilliard <ghilliard@kopismobile.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     George Hilliard <ghilliard@kopismobile.com>
Subject: [PATCH 1/2] dt-bindings: serial: document fsl,inverted-tx and -rx options
Date:   Mon, 10 Feb 2020 11:49:41 -0600
Message-Id: <20200210174942.14182-2-ghilliard@kopismobile.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210174942.14182-1-ghilliard@kopismobile.com>
References: <20200210174942.14182-1-ghilliard@kopismobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a description for the new fsl,inverted-tx and fsl,inverted-rx
options for the i.MX UART peripheral.

Signed-off-by: George Hilliard <ghilliard@kopismobile.com>
---
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


-- 
CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use 
of the intended recipient and may contain material that is proprietary, 
confidential, privileged or otherwise legally protected or restricted under 
applicable government laws. Any review, disclosure, distributing or other 
use without expressed permission of the sender is strictly prohibited. If 
you are not the intended recipient, please contact the sender and delete 
all copies without reading, printing, or saving.
