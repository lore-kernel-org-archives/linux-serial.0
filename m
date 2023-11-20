Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D414C5AD4C
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjKTPLK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 10:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjKTPLI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 10:11:08 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD2C8
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 07:11:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507cd62472dso5853153e87.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 07:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1700493061; x=1701097861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGaqt17Gnv+JzAAAylZ0QVte6wEO0Ns2QmRGqJ3NeHY=;
        b=WFjR3VcQeOuEjE4XZ4jdKWymEZjI4ELRQxKV8yZ8FlQVpajtLz1F+cvo3pDutWDXPv
         EMvcwGg9e5k0qDuaMSg15OHGmLoZ/jtoDilzIQLCf19EBZxqOjg9mtYZdllmCjlpsoU3
         gZbkFKQwavejwM9eOlkqHE/kbIBgJWmQ6H5No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700493061; x=1701097861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGaqt17Gnv+JzAAAylZ0QVte6wEO0Ns2QmRGqJ3NeHY=;
        b=WY0d/yVzhL+IJdameCgcnjYLnFFsvzDeYqeGyenRbRCLC7v/kI/SAM6xaN8PAr+v5C
         IDZ07HVPL2fTUJrAntF0bhhnoSBAskJbVDLrvZAHxHu1PKa+lTco6kFzs/7PiVIlzoX2
         DdP9HeG1FTGA7LipxB7GcNuVS96beZaBQ/NZzmt1kXB3SCjriFv8eF3+6YYkd0tlvzQ1
         qZ0QGnJ6YtcuiQky2FFNcvJ1h47sT90qsFmAKOzO37Q9D/GImvQZAFC0LRr078W0PRQC
         1F2pq36zU+g9oaqy6Cvu9vJ8sXSfndCcnd94xmkuo1aiKr7opmCf4j3fh4jesT5MB6O2
         M4hQ==
X-Gm-Message-State: AOJu0YyxZOmqyZOfI5PxeiWVwQrRurHEP3bbk83/MQC8nQr7iHI94Cyx
        o8nIkv+rIC1I/cerOMf9POfHqg==
X-Google-Smtp-Source: AGHT+IEEXshhA8STNvN4Eu/EGpdVxChmNz76LrdzefD9n03HKHJTFUi3hysWY3m/wS+1UdsfsGWhPw==
X-Received: by 2002:a05:6512:3d06:b0:509:4730:9103 with SMTP id d6-20020a0565123d0600b0050947309103mr3354120lfv.6.1700493061064;
        Mon, 20 Nov 2023 07:11:01 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g29-20020a0565123b9d00b00502e2ab7118sm1207444lfv.50.2023.11.20.07.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:11:00 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios binding
Date:   Mon, 20 Nov 2023 16:10:54 +0100
Message-Id: <20231120151056.148450-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some boards are capable of both rs232 and rs485, and control which
external terminals are active via a gpio-controlled mux. Allow
describing that gpio in DT so that the kernel can transparently handle
the proper setting when the uart is switched between rs232 and rs485
modes.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 9418fd66a8e9..e8136c7d22ed 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -61,6 +61,11 @@ properties:
       the active state enables RX during TX.
     maxItems: 1
 
+  rs485-mux-gpios:
+    description: GPIO pin to control muxing of the SOC signals to the RS485
+      transceiver.
+    maxItems: 1
+
 additionalProperties: true
 
 ...
-- 
2.40.1.1.g1c60b9335d

