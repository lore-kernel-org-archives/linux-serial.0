Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5797CE79AC
	for <linux-serial@archiver.kernel.org>; Wed, 20 Sep 2023 02:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjITC1N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Sep 2023 22:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjITC1K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Sep 2023 22:27:10 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291EFC5;
        Tue, 19 Sep 2023 19:27:03 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3aca5c85a34so4381539b6e.3;
        Tue, 19 Sep 2023 19:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695176822; x=1695781622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFp5dcr86642Gm0jWlFS8dlTBzQtD+VYPc/5vpg94e8=;
        b=brbDSTHasaJIlDMaJyyUCsWcO0DJ6a68I6RebxUc2rcMZQSnVJ0CkDqm8sIQVx5nes
         i0l4NR2b6SG2SciBAk2tCJxIXSYBKYGTsuMESCOjKXmzBGvIs3/W2mznRcA0ctuRbRfc
         2iMT/lV7CGYaSA1o+5lGhDPkCGAKfC8PtaA+e6JTlUNoSgeyjvks/NARYnOS6IISKZnf
         B/pq2b/XMvfRmzNnq4NmHo189nUnkA8jySHA9vnIx7jCiAL3LToCV5FGaSumq3q7nCPB
         LuD39/WiSKChJRH8Fs85hXP6RJR+xmTROndT4Z3R0eshpBI9K7qj9ckiJugNC3SZfn/t
         dlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176822; x=1695781622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFp5dcr86642Gm0jWlFS8dlTBzQtD+VYPc/5vpg94e8=;
        b=boRUqUewtr2GKAoP1gGbHZpp7kRtg4GT3ZnYXaNPyZP/Fbv/LZtdnTYXM8m4KeewGa
         sf0DAG804jTj5a17Bq7/Y8mwrrAFrSG25QIbhO5MeVlcDsfPdcOpMyZ5iZlInhh8ZZ0i
         xM+5gbJf3KSctOe8gFdlw4OQ82hSyZHKdecxPTVFL6EZnZGjjoT/s4kDy5RIBl6yDrZe
         w2AX8s5SRLxkgNBVU1Nrr85CEY2Sr1BN9sOm70r2eZkuHrv1c7MxvSj8PTzCqGKN0lJv
         Nn3WAaz0287cUdxcIOpYd89SARswwDviwhWuIp8nE+WuKj7vMjF3xdT7qgBda0qoX05f
         3o1w==
X-Gm-Message-State: AOJu0YzZY32ViIF/g/fnUerizXTdVVuN7CDsC5acemC5nS8h6eXSr+RG
        EOoVYIguCBDmLs4fs7xnL++zQi5mLUo=
X-Google-Smtp-Source: AGHT+IEb3kx6scx+qBGioyQ9JNEYrxApeHbBklPcWL4W0AB5nV0SxX81IfXLHlxNyB460gdPUKTeUQ==
X-Received: by 2002:a05:6808:1484:b0:3ab:84f0:b49d with SMTP id e4-20020a056808148400b003ab84f0b49dmr1361354oiw.3.1695176822033;
        Tue, 19 Sep 2023 19:27:02 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:9ca3:318f:421e:68cb])
        by smtp.gmail.com with ESMTPSA id p15-20020a62ab0f000000b0067aea93af40sm9224757pff.2.2023.09.19.19.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:27:01 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 2/5] dt-bindings: serial: document esp32-uart
Date:   Tue, 19 Sep 2023 19:26:41 -0700
Message-Id: <20230920022644.2712651-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add documentation for the ESP32xx UART controllers.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

---
Changes v1->v2:
- drop '|' from description
- change 'compatible' property type to enum
- drop label from the example node
- fix example indentation

 .../bindings/serial/esp,esp32-uart.yaml       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
new file mode 100644
index 000000000000..707c10eb093c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/esp,esp32-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESP32xx UART controllers
+
+maintainers:
+  - Max Filippov <jcmvbkbc@gmail.com>
+
+description:
+  ESP32 UART controller is a part of the ESP32 SoC.
+  ESP32S3 UART controller is a part of the ESP32S3 SoC.
+  Both SoCs are produced by Espressif Systems Co. Ltd.
+
+properties:
+  compatible:
+    enum:
+      - esp,esp32-uart
+      - esp,esp32s3-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    serial@60000000 {
+      compatible = "esp,esp32s3-uart";
+      reg = <0x60000000 0x80>;
+      interrupts = <27 1 0>;
+      clocks = <&serial_clk>;
+    };
-- 
2.30.2

