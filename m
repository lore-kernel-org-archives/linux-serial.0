Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E574270575
	for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055317; cv=none; b=POJCkUROEjCOI8a4hLQ8rdwe8bZUteD2+wKB8vzp7iXgUPDALnJMP1VC0rNDGVLwOcU41lWo9NwjKyfCByotVOtLWzYZIfAKUq09yWDjgCDuB8I6lEytQGn8AuyLvCjgGNGF3/UWSTjYyg7kqNS/E4a2JZmnIPYWC97mx6SY+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055317; c=relaxed/simple;
	bh=QXvZG2q1wYALZ9ywXDBmZP2Lg7TZImln+AWgStp7op4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hciMQx06NDWE2v4ast/Dml6c0qpPvxTBSxOhdvkx68ReK4RaCypU0bmbLJVeWwGACZ1zsnrmFUPg78SRpEJvBL4nvdNPB610KcAMWo8zvTKpZIhjWwxogae8Fb890ni47BMERjybpuOUZy+toJNHZUsiVzUD93tMl1eZVLsXJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=SV2nulce; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="SV2nulce"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e3f449fa6fso57677665ab.3
        for <linux-serial@vger.kernel.org>; Tue, 12 Aug 2025 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755055314; x=1755660114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZh5F0QX3EknECzCmYMfb9xtWVRUzlviyKurejiq7Q4=;
        b=SV2nulcekr4iGfgGD+3qXbM6ug2yWC72pb40cukyk5eOgrIsNQjd0/gGkEhAD4Xv0+
         vumXzHbnlvPcDkYHPcpFfRps7t3ZRz+qCqD1YhT98c+lPyxHt6zEHeB6wuuTiKpiHhJT
         7h3yjcozIIgeX8inKnAyWuEv0m+eriG0aKfQyxw8VV4xYfbkxokSwlkpk+HziurupHA1
         BR11teaqM0BAS3ht8xRgjendAwue6lrW5n+JuQJL+s9fbbcBzX4YTkjQ05ergHAt582m
         NOPsF0g7FY2kfwkhYUqcxupw7M85sf6RUl54aFaP1/j+mZLoW1zkGeDJCdXRZWi00Ve9
         2KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755055314; x=1755660114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZh5F0QX3EknECzCmYMfb9xtWVRUzlviyKurejiq7Q4=;
        b=qUG3X1E7fwGgVzUwnfj8Rbs2tU7pZIqWjKMpl18MesASS/JJ716g5kk5iw74JwN/OE
         y9C9txz5c3d5yJU0+WlFvs0/7J1LTWddWTwpcB062895QKi21DL+0GFoKsgmUBju8gvt
         ARNzYq+SM81N5hILAe+fIOug8tnALqYes1qctviYOAFzQfMVPFA7KzI6U04BIIIAgWCW
         nBpv/lTo0txOjmAtWSS4nwkjqg4m86iKHMzNuBlDSg/GM+DrsTJh2Wm7rkFOTMsxn1d4
         MeZ9JmLDhXMOqHMmNLBViu6/wr8LK6zDg21ymFgeIEAUmTUDBb8WspxvEh8iwoYtch4p
         gr5w==
X-Forwarded-Encrypted: i=1; AJvYcCUlBdQE9qSUXJO8RLnWntQ+F3jCIudwbVhfgC642xusoYg3szc08rOdTlwjjCxC0Ik+enQoavGx4bdjW9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwljKpJbQw29OEOCx4hsu9RuDLn88ltPya0w56/bNRVRTtknLZ0
	SYxOvgUrc6ntxYT99ogHIdiqTG3Pa1aIzMFX/05IeVSMt1uNt865kg8XA7sAVo6wEow=
X-Gm-Gg: ASbGncucGgZPIUhphvuNzSCTNCMTZ4qT3VwxCeK7ktRQ6XPkjWA6LuLAPBk227zxiKj
	mECEGOjjCI2Mu0wt3G7b00lAbJiucI4pV6VAFBP9IabDthDApTLS9qBzzBb5NihFKZDdWe/Hsck
	vNTJP11d9Tk6VxcuMw7MKqAuTe4qxpUDedDW6fjwpBz2f7hNKDIkAs1ODBcsOvK4RWdbM5cRQ+P
	mGkycZGL9/tTMZc/yhVh09ziOFkkvI/XV0oZaqJMZKQLwvZW3tQicU0oWCF5kt7BKUpPb+24bJs
	Yrz5d4GW7SagNFRYI6Qih9nSbo6AY/pkFJLmN5WkyTvUKTD2Eqqp0LS+BBV3HF8D6nF90dQqSXB
	Ay1tGCMBYsSwaA1GHYBrRFDrkhMYCgrG/m06LGF5XKY24wsyctKnW2phyl0v+4LCxqw==
X-Google-Smtp-Source: AGHT+IEGjkB4ovYyLSKxeQ7O4Oh8jWvGVbE2gJKsffKwKHW4yl0n/kstE9uKuxUw+5W4Y4U9OyRJLQ==
X-Received: by 2002:a05:6e02:17ca:b0:3e5:4c7d:b799 with SMTP id e9e14a558f8ab-3e5674713f6mr23473385ab.13.1755055314466;
        Tue, 12 Aug 2025 20:21:54 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9cee258sm3453085173.99.2025.08.12.20.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 20:21:54 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dlan@gentoo.org,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH] dt-bindings: serial: 8250: move a constraint
Date: Tue, 12 Aug 2025 22:21:50 -0500
Message-ID: <20250813032151.2330616-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A block that required a "spacemit,k1-uart" compatible node to
specify two clocks was placed in the wrong spot in the binding.
Conor Dooley pointed out it belongs earlier in the file, as part
of the initial "allOf".

Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
Reported-by: Conor Dooley <conor@kernel.org>
Closes: https://lore.kernel.org/lkml/20250729-reshuffle-contented-e6def76b540b@spud/
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 46 +++++++++----------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf0..f59c0b37e8ebb 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -48,7 +48,6 @@ allOf:
       oneOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
-
   - if:
       properties:
         compatible:
@@ -66,6 +65,28 @@ allOf:
           items:
             - const: core
             - const: bus
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - spacemit,k1-uart
+              - nxp,lpc1850-uart
+    then:
+      required:
+        - clocks
+        - clock-names
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
 
 properties:
   compatible:
@@ -264,29 +285,6 @@ required:
   - reg
   - interrupts
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - spacemit,k1-uart
-          - nxp,lpc1850-uart
-then:
-  required:
-    - clocks
-    - clock-names
-  properties:
-    clocks:
-      minItems: 2
-    clock-names:
-      minItems: 2
-else:
-  properties:
-    clocks:
-      maxItems: 1
-    clock-names:
-      maxItems: 1
-
 unevaluatedProperties: false
 
 examples:

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.48.1

