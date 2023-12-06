Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGLHGot3"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB21B18D;
	Wed,  6 Dec 2023 08:28:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce6f4d3dafso2746b3a.0;
        Wed, 06 Dec 2023 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701880128; x=1702484928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BO7BVaT8ykrHob1h3+ovpqki8WyMIscCih53fWrcP4Y=;
        b=NGLHGot315zX91adINojOQlQwSHWrGjX6u2QvaOqKTAmscPNWVkMiaR6EBYiVM+Rew
         B56JCZTQnoDoWQJGLjbvcEcWU8DZD42XtEUIIP1/gMIldpusu6VTbiPEVfLfFMGQrtxp
         C4+4t/3AcnFZZ8xvLAJ06+U0pyQYeUQKr5Af0KN2Imu8tySED7jiqe2Oi7xEAVtKk3eA
         QgMZDTabqCWMThcdOOBKXob+WlLj/W0WFtBxpiprG8zmLXtcK0ekTU+d9rpt/r7eR41Z
         zSPp+3JU6lzXgED8EHr+ub2iuiclNkjxqhwRkdyH4VlzeRaIz/SPcC8BxwsadRnzaoMU
         6HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880128; x=1702484928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BO7BVaT8ykrHob1h3+ovpqki8WyMIscCih53fWrcP4Y=;
        b=m6VAvsBhrP/gbw4W4RsyO+n9RDvwhq5ysv90xlpTt9v73rqHOfbNz0L1Rh6Kf+9gI7
         Yib+c+yb9wHRvZN1IBvD/dXxdD2V4clsesgZnVQROpnabyngNteBlj8altQWAez81t3S
         Mij7bJB933cqjuUlyoeFg7NheNXKsA8dC5EfWi8wXOA/ode7OO+x4vVt/JlXDzj7Y1UM
         7KqQ62XeXkVPAjIcAk6bcZaGertCl4DusGEvSORq4OZDLBZ6PotrCot6NhvlckpYANFB
         E3issBctNCmPmdJrWqGRTjthEc7dxYN/Nt3XRXd3xYr5UJ5915JEiDfnOfQYbFWvuPQO
         F/Jg==
X-Gm-Message-State: AOJu0YxsAy8g0/6YxcZBgWApOaycq2MhYRx+EsleEoQ6UQTXjRpfeB3Z
	8jzWNox8KSyOzT+j6aokT34=
X-Google-Smtp-Source: AGHT+IFeb9Ojs+M8QvvuNEXcXoN51gwdzmt721z9VUAc8/LOPH6msSCX/vYftkKR9dIu4gSQOGFSXg==
X-Received: by 2002:a05:6a21:187:b0:18b:2020:8cd1 with SMTP id le7-20020a056a21018700b0018b20208cd1mr2695743pzb.3.1701880128169;
        Wed, 06 Dec 2023 08:28:48 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6764:e124:5ffc:3f5])
        by smtp.gmail.com with ESMTPSA id f10-20020a639c0a000000b005c60ad6c4absm120340pge.4.2023.12.06.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:28:47 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: serial: imx: Properly describe the i.MX1 interrupts
Date: Wed,  6 Dec 2023 13:28:41 -0300
Message-Id: <20231206162841.2326201-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

i.MX1 has three UART interrupts instead of a single one like other
i.MX devices.

Take this into account for properly describing the i.MX1 UART
interrupts.

This fixes the following dt-schema warning:

imx1-ads.dtb: serial@206000: interrupts: [[30], [29], [26]] is too long
	from schema $id: http://devicetree.org/schemas/serial/fsl-imx-uart.yaml#yaml#
        
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../bindings/serial/fsl-imx-uart.yaml         | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 83035553044a..9c6dc16f88a6 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -9,10 +9,6 @@ title: Freescale i.MX Universal Asynchronous Receiver/Transmitter (UART)
 maintainers:
   - Fabio Estevam <festevam@gmail.com>
 
-allOf:
-  - $ref: serial.yaml#
-  - $ref: rs485.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -68,7 +64,11 @@ properties:
       - const: tx
 
   interrupts:
-    maxItems: 1
+    items:
+      - description: UART RX Interrupt
+      - description: UART TX Interrupt
+      - description: UART RTS Interrupt
+    minItems: 1
 
   wakeup-source: true
 
@@ -110,6 +110,25 @@ required:
   - clock-names
   - interrupts
 
+allOf:
+  - $ref: serial.yaml#
+  - $ref: rs485.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx1-uart
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+          maxItems: 3
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

