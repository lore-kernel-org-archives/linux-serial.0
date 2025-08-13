Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A20242930
	for <linux-serial@vger.kernel.org>; Wed, 13 Aug 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054824; cv=none; b=tzYuw4qZWCCCO5Ipv/xrt7YHwaaMFXEuZUETImHuZOftGK/1UL582EALzIrurrj2qCEi5sw9mNhoDY48EYg1Jle+Fr0cst+DpaVlNrCFIu366OT63hl4FDw2eN4UKHGPTba21jg859qa4Zl9rOVEgqFfE9Oo69a6fHKDuocDhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054824; c=relaxed/simple;
	bh=4e3XC4i6uPEnWMRcXdvMk1P32JDvw0n2PeDK+VlwzBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxkfg6u4MQoMMqVq7lDtHjohcgHYgxCQY7XtCO0oWEtrssSiU6pSvmYuhzY1NG8BmXYFR7lf4UIG5hdN4t9XhLR3mzeU1sld6zOrhsyXMtBXIedR5xgkivBrQ6L94Ru1INHVZjJE8svpMxn4UeBkcy7+sUFvQPEt4v6/3vueTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=x12OFLBF; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="x12OFLBF"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e55b170787so2614745ab.1
        for <linux-serial@vger.kernel.org>; Tue, 12 Aug 2025 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755054821; x=1755659621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PhVQGmNNzCiMu9pw3hx+9YH1Eu7sHoNmFIOK1HnGfI=;
        b=x12OFLBFtGzsaCf0B2ke4y0asbbcQ9v81MB4w076TddKKCfZYgUJSA3F0AGZkn8voq
         uqCRgG8OD4vv3bPNJ+buSfUVVtbgRkU5OaIquRuZjcAQI35CAAq0qGUgliQbE5JyeWCb
         XeGCd4wGmoLJnpUXT1ax+tMV8RsqTTTf0NofzkA7h4MBsjrWFn0fmmVmiZorKeqYQRoR
         wQZHcs9Fbm2Bk39+nE+zaMudt9JJ7FBEzFJ5WhSlbgxBbqj0ghhRID6+ocTbcrDkIXVm
         p+y0paVLZImToJT+gFroiR0s2Hyn/rxoJZYecPcJwDnAHoXQGSg6XdxOUyxCs6Yorkl1
         WXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755054821; x=1755659621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PhVQGmNNzCiMu9pw3hx+9YH1Eu7sHoNmFIOK1HnGfI=;
        b=NbiOdIylPWTLIoA35GlsnkHXU6w+V8+N6miqnMI5EdTyRBE08efQ8Rr/qdNU3PE75S
         YVwrvfXzHn9RznLC8yWtGgmaj8GK9lZGLDGLl61q0XeY1SFvEElv/EJcqVma4RdJpP1r
         bQsTX3miILzcauI645rLLkeF/bP4ZuDXBLqYaIkE2R0oE38j0BVzUIAPGmwC1n7dP0MW
         Kdak9X/vfj9Im6yni153vu8v9PEGxhbFeJ4cLmKc4URLo4IJWEllJCHK6k+FPzWPs5us
         QUqhxE8ScDbjoCWo7jOvi68G1rsl9HgYs3slAtg7Loy6Oq9sPA6WjqfsUhym3xWeFdB3
         A/gg==
X-Forwarded-Encrypted: i=1; AJvYcCUmP0tb4iPeWPh9S9bl9qMnDLS3bHnznxzeGypD38bkluu01hXtmMCK4oMhTDpyCqLl5sSwiHp1YWZ08R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLY98FzDo6IoPozhhlfoYJOn6+1rG30sCbct2hPQyGgRu1QhL
	7HpCAzSf9xzOBxWvLGjIVqUfeZj10bKphWnAA0HkqJHX9UUtLk3wzMaRpJuhPqPfr+U=
X-Gm-Gg: ASbGncvTTzJUj1ygx7qcpaehT4Dk68W2c97p5BUZ/0OMBrCk2ANkoSaqYzcmAltb6Db
	n06Z+3mIKiiU/DeDC8n7czBpotdfQvstD+rphJ429fMF9+9NB3CMJivxHbsdKyXDehyAO6MDMFt
	qCAt9YzAcqMHzKx9MtW8cEO73Qmh0Jv4KqMYZNd/r1XC2iJ/XihkEA61A/jpnWCDmdO5kgE1qQs
	dJh9xWnQVKH9AIdLvMyFg6rq18pQ1fxx8caXDTo+CZ1qxnEJ26iLKMH5pDxOQtNy6lwJV0dimwb
	euAT60PSxx9Ix4b23aez07oA0dJU8kF7OlnTH3Kyr1INeeuSic6pAi3pqN5pW4cP/0NE5KjicXA
	lH4a2ma2+t8VitiL/RbMVOTgs+jVwQLPZNj8zaqLmP2lhK/RhBuJdYT+svipIIyPvhQ==
X-Google-Smtp-Source: AGHT+IHJ3cV6K51nVGXbggkk4n0mggTrNvjqK58YjsUKI/uGamOMw1V+7ccv0fj3Is/jMTtEld3VjA==
X-Received: by 2002:a92:ca07:0:b0:3e5:55b7:1eb5 with SMTP id e9e14a558f8ab-3e5685ab4f6mr13673995ab.11.1755054821496;
        Tue, 12 Aug 2025 20:13:41 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bcfecbsm3616330173.62.2025.08.12.20.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 20:13:41 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dlan@gentoo.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] dt-bindings: serial: 8250: allow "main" and "uart" as clock names
Date: Tue, 12 Aug 2025 22:13:35 -0500
Message-ID: <20250813031338.2328392-1-elder@riscstar.com>
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

In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock
'uartclk' and 'reg' for nxp,lpc1850-uart"), Frank Li added the
restriction that two named clocks be used for the NXP platform
mentioned above.

Change that logic, so that an additional condition for (only) the
SpacemiT platform similarly restricts the two clocks to have the
names "core" and "bus".

Finally, add "main" and "uart" as allowed names when a single clock is
specified.

Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf0..0a05a1647b5cc 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -60,7 +60,12 @@ allOf:
           items:
             - const: uartclk
             - const: reg
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k1-uart
+    then:
       properties:
         clock-names:
           items:
@@ -162,6 +167,9 @@ properties:
     minItems: 1
     maxItems: 2
     oneOf:
+      - enum:
+          - main
+          - uart
       - items:
           - const: core
           - const: bus

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.48.1

