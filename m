Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650577;
	b=PaiBhoBEo598H+3mOVCuOhSykpWwp2okSkTwsNoD4x2vLSZFEXuisyWwJ9ptpB6UBMpP
	 qxYqRjbASVgt5Rs2gxbzslbM/JwKBaQ69X3jXTn3DkTeeqE8eSejmL8HylcYBFy0o5Lfq
	 yV8CoGtrBu8/4pYdpi1DRup9rBnmiaSBHNoVPxVKBoU8UrIAYwum/VlZWKTZFpl4+srbE
	 dzfYIvauGU3RiCtiSOJKhqy07PY4skR3Adt+Y8UQflLJduTedCvdRhjAJDs+xI5FldABl
	 3xyiEUn0oblhQ9mm4fHQEH0/soBwgZso2MexMsDIzuG4FSlApqR5/rR1TiLEb02X/XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dkGbvUDyeeZ1ewkhAMtnGT8VJqpJVXFal/OdRewYEcs=;
	b=jI+9s2xDELJkgVSZBPft/Qhe2jJiJT88iUa+qQK0HyimJ3JV8eXYp3fNEmUJno3l/eIS
	 r58FCGTw6V7zDTQUJ62DevxGXPP/r12VaFs7/PtMh9n2Yh8P9rgg8qgeVzCNEZMQPRM1s
	 +RCDg/0bVcXyJ40Kcwg3ezNvyPePqUmh0vJfvaMMHOdazB6sZoN+6Znc11hOvXWnDdoZo
	 5z1a7QB2L64RrGyXuOQtiSx3G6IVdyiEHnQ63mdSlzmNaKGP2FL9DG7H8MEzuET2H1OT6
	 BwTZjwNPGGq2rdXu5KAEspc9tDfc006zTjUaKOZL98K09eFy1dxN0srI2sX0HwFrkhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ph8O0va6;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75932606A337
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75932606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ph8O0va6
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a215e64962so30690145e9.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793650576; x=1794255376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dkGbvUDyeeZ1ewkhAMtnGT8VJqpJVXFal/OdRewYEcs=;
        b=Ph8O0va69qi5KtzeMAZfOR+XDswm9owVaSD7cGWwAQOJ96+cj8DyDmSW9R9AqpSRi4
         qSmxp5fV32iyNS0bzLuXiMm6IDaPiIah9HKWcvPAspPHdsBu+4ga08lN5JkARu5OneY+
         WtcH1ltRJI1RFnuHq4mqfFog7/KanXx6yxLLcYS+/YiINNRA99O5eekCF1o1hw8+KROh
         fyQYMFqDXUnzrsODZWc+ntNXOGuWG7+3u/aocO/UAbmc62K1R464txfBlM31BxpZ5BfL
         j3gkGR6vZ1v65LHnizKzbdOttle62TxIbDRLXj4tPqG8eWMB0++KkAsyZeaRiBaMyjD/
         cC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650576; x=1794255376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dkGbvUDyeeZ1ewkhAMtnGT8VJqpJVXFal/OdRewYEcs=;
        b=M8WFGXKLZI6HSgGVx22Zh4l77D9a+/8saot3aTBHvy2kGyzQmlJlViIaqRs73EisVA
         ed1EW84RdvSwRrep678+91UsjBObwJNsG7hcId5OnvChDDPJAjkIcq/+mXNDPfllk2qu
         6ziNGUv8T9Qv6frA01ZV09EZtNe0F/LbWItXZgkLX2/hD0PHQRogJbIYfLzunjQkdXYM
         8DxEl6oH9U+Uy2l5M5TDxdRBMOzmmYingBftYH5HykseUnVUWaE9J/zlmCBZWpUXEkFk
         tKEoBWVWjhHLjZppJjrlEzOk9bfV03sGdbis59MN33N+yfrGFfjD5QDHo3xGoDYx6fsp
         YaOA==
X-Forwarded-Encrypted: i=1; AKwUvBz2bNC2X/FcZDDEmlzx8Co2n2EWH/yLOLNDevUWiNTLx5y0KrSh9f/TjsVLXFZhHgXEC/akrTEuL8PUAKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKFxgrH0S5auFiETRZxSwzwM6Dm8WXwgYZIZ33mj7WT0M8UgSt
	flQQT0hPmvrFq9S7UGT3PEfSx3L2aBUCF5PkkgnkLLuJeh4I0Nz1FNshZUqH8XlWylc=
X-Gm-Gg: AYBFou0j0C+UyWJFDsiqFPRrUqJ6YRMFaud1FIQef7TCZCT1KHT4BPNkK36w/IOcfUJ
	F3Wyq3CLyYzbwKJ7lc5qFgEnjdIFe8YABZGxl4j20kLwEnZQt7f0yy3kEzla4ByF0tYcP/60N7B
	jlrSc1dvPWXDdWO/ViD22ykGhcLbI6I9qw4u1hbM3fP3UL6pZjG4PlpsYYMHimJL2J+OYVWRh/T
	3Uy7uE9kQPQZajhESMs22PEHXeWtVLtsN8LdEG/iFQPlGzcjRnUKa2pyDBbVBK5ywJ3dsgUOyOg
	8EtgbdErtE/Lm6ksHqqa/mTZHVZkPbCzF4sMUjKsSX/CpOYFuufAAN5yJ2NPdzPrgzHd700cjb6
	oe20VxIcZfVyLXcp0WRBSE8UR+0Lxon9ZPbeeIkcetuyf1Lq5bRgjtqyUFmqWe7hr5Z+EVy5sRw
	jfNcu7pHb/bNfDE1FhDGg3azORAvR6lzIi8hmWCXRyeEdWIj7OYtO8pytA1HyqhMz2cNDv5sZUt
	fGOkgoEG5Gs0kJ2az38C9gJce20ZX9RyoesrwyLlYYEHeguONwd++sRdpFk3qS1PvEpoWS0+wvC
	k+YVUtDn6457jsj8e2y1YTyTQX1XNTbITgp3lQKS51/jmcExE1Lm2kj/t7Rq
X-Received: by 2002:a05:600c:4752:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4ac18e5d4d0mr269807015e9.29.1793650575803;
        Mon, 02 Nov 2026 12:16:15 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6412:7406:ded:3229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09bcc967sm220013905e9.3.2026.11.02.12.16.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 12:16:15 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3] dt-bindings: serial: ingenic: Add the X1600
Date: Mon,  2 Nov 2026 21:14:59 +0100
Message-ID: <20261102201459.49284-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X1600's UARTs have the X1000's registers and 64-byte FIFOs. Add
ingenic,x1600-uart, with the X1000's as fallback.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes since v2:
- Drop the driver patch that set UMR and UACR at probe. After a reset
  the X1600's UMR already reads 16: the 0 the manual gives is what a
  clock-gated UART reads, which is also what Nikolaus saw from U-Boot.
  What needs fixing is a value a boot loader leaves (the HiBy R1's sets
  8 on UART2, its console), which is the boot loader's business, as
  Nikolaus said, not the X1600's.
- Move the new entry last, sorted by fallback (Krzysztof).
- Add Krzysztof's Acked-by.

v2: https://lore.kernel.org/all/20261024220712.23250-1-olivier@mgcrea.io/
v1: https://lore.kernel.org/all/20261024051515.55639-1-olivier@mgcrea.io/

 Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index d5f153bdeb0d..0c452f20e103 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -35,6 +35,9 @@ properties:
       - items:
           - const: ingenic,jz4755-uart
           - const: ingenic,jz4750-uart
+      - items:
+          - const: ingenic,x1600-uart
+          - const: ingenic,x1000-uart
 
   reg:
     maxItems: 1

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.54.0

