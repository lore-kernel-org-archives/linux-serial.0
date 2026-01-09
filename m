Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4A35B153
	for <linux-serial@vger.kernel.org>; Fri,  9 Jan 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962318; cv=none; b=bd7LFTSBHaIeSA1PIcTbtCR7UqC4xLRTpuMfyY0a9qZc6u/i7kqozsATFGVlYlwVTbYNG7GSEo2KCCfMUgDf+xY3Rbo/HPfob9B6BKNzqbJtC+kUjBy/N9vsUhbOJH6W/UlNL627NUIMLRhA63BcAxXhPvhxC0w+WshB8bEOKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962318; c=relaxed/simple;
	bh=JYApr68wtO1IgeeQX97XtB8VFiH0AGBcAiljSulIrUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exAoTPii6o39ABJA3U051qjEs0mNEVn53EHLefKCAWgP1H4y89+3oh195sosZnNaymM4r4qD1qejWKtL91Oy/WSiJ9sP3y5Xl416dd3s16PW2rI1QkP0x/oltTKRNEmZkTA8SXE/vgZgUi1XhGmiek+Nq/L930Im7IU5o2wiZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuCfUVU/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuCfUVU/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47796a837c7so30898595e9.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 04:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767962315; x=1768567115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1Ry5v+SWBJqmYXgepJPkse9qv8WRlai5KDVImpPed4=;
        b=ZuCfUVU/S6Txus+PfoLZ1PNd0zAA4l3ekzEERt3V2UIZdVvrUNbJxKZsuVBWzL4WFU
         CtWsLgoYSx3QcmDPXY/uD/ltk/zACiNtIoNsigjIot2+oNfaR8Y4ln+9FMXoJPkXq598
         NPobL4zIkCJr0hrllK4Bzp8EeK0erNg1M8l53cqzdOZMInJ5x0QHAS8znMyG8sgylkdJ
         Dx96DzLN38TZaC++6QD/h76qNH/wOjnQy6h9ZmmEGR5bH4Euqjzw92g8y/w1wcTJVvx5
         CiLx9Uyt7lPW+YFT8kRpzoJrhul1sd9UWXgbN2EJnc1ikg6WrBImJojd00qGhREBKv7V
         n7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767962315; x=1768567115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1Ry5v+SWBJqmYXgepJPkse9qv8WRlai5KDVImpPed4=;
        b=n2n5zVx6eTchh0kj4y8crsSFwq2TCZTgzxCaom+prANxVu3FXx/Kfx7iftLU9XOm/2
         UUFmaZCsSF32w0WsUADALRwvdsQ4uarfHBED4/pmKsseijn8kpY45xQysT0jy2hWQU18
         VwmRSW3ev4+YygQqvEbLykGB+m0RZQxELn3fEWVwdJTUeIuMmZcpSdi9AO64ICSVDcmV
         TpKi0Sn3ABasnanzWgqskJzXOCY4jjsIKC3BA79rjGADvOxwoPpPrZDnmJV8zHtq1Ynu
         WzX8ft1dZH86gY0ZXZKI1lY1SYbfdR4DWj09bRJi4lG2twN4iUtu8nZORkpXNql6HTl1
         5Jkg==
X-Forwarded-Encrypted: i=1; AJvYcCWy4ThpC875aU+dAAGlXq4T4QbvsR3kMsU/cSDb9icgh4QGA4J8Rrg7l+LDArcXLjHL8BjAIMFjDDGs/ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YySDi7ChmbFFvurSd7ZfET39Wi+iz7P/dRxz3fy+3h4Ioj67/kk
	1755pzC97F/ZWnelpkmZDk4AjEq1b+oAtA8JEtu4xGQu5dsWZgbytfAP
X-Gm-Gg: AY/fxX6kfRPamxg7V9xI9niLYvoGKezffSXBb23+znuGbvQsIr86MGiOfZOqAonMSfb
	OzxnyIKS7W1NQDksnB645q0XrdzQK1+6G1qgwSheF5rSR9nOzLvwnARkcGtOoBuVhwoDb5ck0xU
	1Oh0Izx3REfgly9giUw4x7vAMyu/YdT63bNXkxKttWFhc7IoUz2/N2RftJLRZ6TEbhnddCXXpJ9
	Tkv4pu4HgB2Vad9xNkeP7kkHZcBs8OFWIojmMB0MKlajJtk+KuS2fkjSTDarhBqqhs2S0AaWJIF
	Un7mTM7I6co+BLtMT9NoQ/zVf7UWt5VBZAIBzM3MmdErlY0V7DYopvE34fJXG95E0NQCwRjlFh+
	vm+2hh4FEsASr4I4v3tNIKqbcjTl/tHExEwYRH98dmFZ7rUi1yb2wh1xcmp/mfQ1RAM15R2hgA0
	lZAzEocWf7aN0HiBKWdQ6BB6u8wEJs+hKxekjvk6Hcdd9rMO1NrVa1kuOBAeL0DLQvUBn2jmvhm
	20lEVlzF0IXfGy8ZUx2Hlg=
X-Google-Smtp-Source: AGHT+IEWZrzNl5AJ9ePzJLbVDi2fmNB6EfpTUXDyBQ4Q2PKHHDld6QqEWKcGJu91UaKZ0q2M5WpLng==
X-Received: by 2002:a05:600c:3b1f:b0:477:63dc:be00 with SMTP id 5b1f17b1804b1-47d84b5b3e6mr99580875e9.25.1767962315169;
        Fri, 09 Jan 2026 04:38:35 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3d06:ce2:401e:8cb8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8384646fsm174060935e9.15.2026.01.09.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:38:34 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: serial: sh-sci: Fold single-entry compatibles into enum
Date: Fri,  9 Jan 2026 12:38:28 +0000
Message-ID: <20260109123828.2470826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Group single compatibles into enum.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/serial/renesas,scif.yaml          | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 72483bc3274d..d4cdbbf4c1f1 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -20,6 +20,8 @@ properties:
       - items:
           - enum:
               - renesas,scif-r7s9210      # RZ/A2
+              - renesas,scif-r9a07g044    # RZ/G2{L,LC}
+              - renesas,scif-r9a09g057    # RZ/V2H(P)
 
       - items:
           - enum:
@@ -76,10 +78,6 @@ properties:
           - const: renesas,rcar-gen5-scif # R-Car Gen5
           - const: renesas,scif           # generic SCIF compatible UART
 
-      - items:
-          - enum:
-              - renesas,scif-r9a07g044      # RZ/G2{L,LC}
-
       - items:
           - enum:
               - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
@@ -87,8 +85,6 @@ properties:
               - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
-      - const: renesas,scif-r9a09g057       # RZ/V2H(P)
-
       - items:
           - enum:
               - renesas,scif-r9a09g047      # RZ/G3E
-- 
2.52.0

