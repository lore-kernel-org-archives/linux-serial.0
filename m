Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048071F09BF
	for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2025 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753740008; cv=none; b=GJso5ya4963L7g4sSIPF84nkPZaGMdXWygXoUrjxRyLVEKiQMojxYlHNMopha5buRKoCCEs2Yk7T2C17ZjObuLw8DmTqNhei74nXAQStcCfzkn9c7hKevz/hPrVWUfJJOG4q1loHlRtDiumzODPZ3NhZrRJS15xjH9/Wbe1Ya+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753740008; c=relaxed/simple;
	bh=/qAK7aYKKFRgAJnNBp3OG1T2f+7X1+5mXUXNzKDQxr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swatAfKqWx/ZsWRB6ECrGUE2gPDkVqt5oMdMI7pPLOWcYX5qVRIPHzzzIC5clqc9+qPOpjjYvBWO3Ju0dEY0oeYSG7svmG1g3zyRMoIK82vltSM9K6FuTTpE5bEYxNjghKhaQ1TwNrH+BfQ6rGKg6OFf+iGNeJDjwMhInTalvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=v+W2wslr; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="v+W2wslr"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e3d31a9ac7so10401285ab.0
        for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2025 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753740006; x=1754344806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SW20ypPIfCwWzDyApEVu137flF7JF7gBm3arCQYvIbI=;
        b=v+W2wslr5hItGs6yCQ5c+558JTBleRDLv4njzriMThgLURHsc9qoj9mpVU7gnEtzmW
         Sm11lp2eGHrf4IYNSYxzUKBDiYNCMxcdpUhEA+CeuOKxdSfiT9rJjk/A6VGJUKTM6CIO
         ifJxFV9woud5CAqsOhuFOAlchAQxMQrvAPLtgrXV77v/tH6yqmTkqS0vKBbK5brBiOWq
         WprGIa6EC9YGSicNK2Xqo58q7taHmhOxEu6NXNoHcMOTSmvxk1xP5did2BJfZaxLxba5
         6CVy9frO1nUUIUje7kRFCaVkJynocM7OhbjGt29ygcMynmoueuSalidbiPxsSIVvnjrk
         pKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753740006; x=1754344806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SW20ypPIfCwWzDyApEVu137flF7JF7gBm3arCQYvIbI=;
        b=bVvHqO/6iFfKvxfR04G716B9PAsYPEgcCah8v4CmP4Qma9DR7sCScYuMMSloOnJuVH
         H2rl6nU2SHdcGjvTzkZJFzz+GUpOx16vOZ0iOFyqTLXvCbTqs/pNaCKpACDQUB1U3Vmt
         X1bQqdeQFi1WQAg8v6qRYNQQrWCOU3fGcEa0dJ70tLHjb5IRqA6w2jTnOVeIT+Jma1e3
         PeR1Y+sThWdcZF95x5apUx7ea7dUDDmScFbm/aQVj/jhUZA6BR9e7/ZIBgJ06+ZCJv+w
         XWQpL7Cb/MK4ot+TwFbq6Q9mL6k53g37RcM9sDZUD2VIu/7mQhNXqSZXZKGtZADUtoeT
         t0dg==
X-Forwarded-Encrypted: i=1; AJvYcCWJjf8TIBwY2E7dLvuyEVI6MxN0U8/HOfvqr5kHClvsmu6WjeM1ugqL5CE56ARTaQuil6JSQ0wUu/vTmho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8MX/g/YUEaLklgHoiXOwfB9QYlqUVDg5s/Uxh2zSL4f4oG4Q
	ir6GyRhMf26Q5beGmuukGRQU/sCTWEVjyDN0+w+ldBTEC5yCqqjJtd5PlPmvbTWOx1w=
X-Gm-Gg: ASbGncvJW71EERsyoXR1M/880bcI0Gws2gGX46LZb9H5CUMT/vWDs0KbJy7qqfcCyxX
	99hn0a/YPtWFj/O63Zpwbt/1BcW7lVdRKQNogNkjXWjijqZQ4vMkoyBhc2Tv1iMPYnOp+RaDaFy
	vPjauDzNAHbtcRFHl6x2rYW4tftw0+eFp23WUsri01zz6ud3aXrpKvVT2CydnZKJq9RFWr1oUMc
	tknFnhOddMLwopU0BwB2KTD41GA1MkIMFVgjkqPn0/htDB2KHSXmXEW5YBnAtq2hNHEn6uZjBY6
	2H3IYAW7TegTMze9lrm4S1piI7QNMd+4YvIerXXRHHenS7k+S03g5+aoUjTNOmtRGAQ1oLUc52H
	roGvQEb7gx4m39tCa0np6nE+HyJxi1qnZ9sPNrJVxb1pKtS+TrWwIWcRUdNpkWcGQAw==
X-Google-Smtp-Source: AGHT+IEInGF/Uihao86Df5Hh8l2S/n6kOMKGVWM1LdBNeEbSuGAD9Xt1OLU4ny9gFPGHVpMlKG5tfQ==
X-Received: by 2002:a05:6e02:1d98:b0:3e3:d185:9163 with SMTP id e9e14a558f8ab-3e3d185932fmr133375445ab.20.1753740005684;
        Mon, 28 Jul 2025 15:00:05 -0700 (PDT)
Received: from zippy.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91c9fdfsm2167331173.4.2025.07.28.15.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 15:00:05 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lkundrak@v3.sk
Cc: devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dt-bindings: serial: 8250: allow "main" and "uart" as clock names
Date: Mon, 28 Jul 2025 17:00:01 -0500
Message-ID: <20250728220002.599554-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two compatible strings defined in "8250.yaml" that require
two clocks to be specified, along with their names:
  - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
  - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"

When only one clock is used, the name is not required.  However there
are two places that do specify a name:
  - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
    compatible serial device is named "main"
  - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
    serial device is named "uart"

In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock 'uartclk'
and 'reg' for nxp,lpc1850-uart"), Frank Li added the restriction that two
named clocks be used for the NXP platform mentioned above.  Extend that
so that the two named clocks used by the SpacemiT platform are similarly
restricted.

Add "main" and "uart" as allowed names when a single clock is specified.

Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf0..cef52ebd8f7da 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -61,11 +61,17 @@ allOf:
             - const: uartclk
             - const: reg
     else:
-      properties:
-        clock-names:
-          items:
-            - const: core
-            - const: bus
+      if:
+        properties:
+          compatible:
+            contains:
+              const: spacemit,k1-uart
+      then:
+        properties:
+          clock-names:
+            items:
+              - const: core
+              - const: bus
 
 properties:
   compatible:
@@ -162,6 +168,9 @@ properties:
     minItems: 1
     maxItems: 2
     oneOf:
+      - enum:
+          - main
+          - uart
       - items:
           - const: core
           - const: bus

base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
-- 
2.48.1

