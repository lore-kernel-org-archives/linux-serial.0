Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8D3D0930
	for <linux-serial@vger.kernel.org>; Sun,  9 Aug 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786277712; cv=none; b=HKCKgLiZg62EL7yc8ai5JupwjVWOR0XrkbHzvZSNgw55+rVtTricD7/PQtYVPvOa/ktLqD5gsB1R2CH3FxHL1pCLPeaG9SWiDrLzj8qKtkb6mgO9qPxXl/c/mo6X+lcRaCHSD4IDmwf6ZY9LwQ+GDwPO840KwDHiS3L0nEc5W4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786277712; c=relaxed/simple;
	bh=VT2WkLbrVHZk/VBbTj+r4ElGw6wpo4atU2roVry+mzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOevMLEODq/f49wi5t0uFSb1XHhpNLVjeDHy2Wib6NkIp6hJbuOB73l4CMIrV1QXGgLo6L7Z1WS5Htch+Hb+5NK95/kLtN9z4/F7r3IYwdoEhvAjyZ5A7iaRyFECnp2Emck5AQm7ap7D3weMhXfOelWinGTYaHXQjtpaW9ZRy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV5gi6dY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV5gi6dY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956869750eso6059585e9.2
        for <linux-serial@vger.kernel.org>; Sun, 09 Aug 2026 05:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786277705; x=1786882505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHSgNIqpIGMGCDb/vwfax9xQeZ/i97RAydBRvL1DXus=;
        b=YV5gi6dYipeW2cJLZRhHhOiqjTw80r5E03ZeONgFeSMNb5cjUpvKAdjGfWZkuF6JbA
         HGfG8yb5CMSztLGLx/wKv8i7M8KslM2Vc+B+C+MClZZMActHDvgFDCPvdHSGsy1DyqhI
         DYWw/oWkPT53Rj1StwODOcsOnEi65v23AisRNk67hRLk3GbIhinLqCS7sIIO94fcKSl6
         edOeATs/LaY/Y0V4MPdWoXCupowCebo3D/HZEuCiU35SFNLylmwE6+4lrLfioH9hDzaT
         dtcswbIlrgUhVStw8t99l04kPQ9auDJw8mmdL1kMzC/FM7lKzKFmXPIdhJai31Mg5J77
         92Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786277705; x=1786882505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XHSgNIqpIGMGCDb/vwfax9xQeZ/i97RAydBRvL1DXus=;
        b=KwxPCjSVhJHS2NHH5UqGvVABBsVmyW5cq/lkZaHt2gQsOwfDdXRtDP/ORv9pF9SlCc
         R0vHNjmMk3eWyBv4XdnT4gfMfQfVM7UBf7G4Hn+DE6mdzCH4CIUisEB9a1JjD5vDqna/
         rrSYnyatHKQy6LkAllMJbEZ92MTkMCeE3myuZk4WLeuyxaH4SdxJDLFoGJVNHCZcKhNm
         7dnTR6N7Aaw+Glu/RVs+7kcc7f0YxW2CtLMC93zy92ST9GtwJrGTcj2ZXp8xC0JGsFay
         EcAytdnR3Me3oxze06bsjTQiPr0RQcImFEgiIiAvDduPbESrxPkU6OGZ62ulgv1zcauo
         GQBg==
X-Forwarded-Encrypted: i=1; AHgh+RpAg49BzLymugfHY3Gv1ocjTxDT8P3BJML1oZk+ZLP97gR3byTp2xeVLuwe+AZnwfx27DfpFjSORkXQ3ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXPrxMJRdFHRcZwceo5s79JkDIDPYshaPbPHO/LrUko7OVG/Z
	CqWA+PqYCQDQ8kQlOgnEypAPUZy6tEF8702arszJ6A1hTQhqy0XjRuiZ
X-Gm-Gg: AR+sD10KEC/w0SpWAOIoj8BzvMTWYdKFZ9yW+TOYhYlaGb7IDz3ZC4fV+AId6f6o9Hw
	i68Ekl0t/QDB/2PI9jkNdqfoZf3nDxteuIrwp4A3R9EAyoc+E+e/kALqDwbsZWp5s0wLdKZyb+w
	I24BKEBfPooCyciNX3+435jDmCNJHXWH2mBOBmb4tdQoOSX8wxy0Oj+YNCo+4v1Slkuedh1f+4a
	Y9imAwvC2qJYebmIUZ9iCFJKdflkSQ6AnDygBGVbuox4Cg3vFhV6kUaIh5wuMb7rhgO31R+PVdE
	tjoE6APYMK5Q1hdtDG8RmVpxUkVdOit7KraLS3k197rsU9Tof/2K+YJOJ3atdFawmdYY8NLiH0t
	NGMGinu3zTONqdSsFZ6Hv8afwB9lr4oqvqF4ngW8289uhv+uYNe/znHfcQW5Vgb1N3Aht5NeHAr
	deQXMadbM8LXUEUDXEEhz8Q49I/XYPHZCKxFOH3lvHNXX9XFCCqIY2JbSviHDtkNtMlOu3gyPO7
	3VI/l4tTrsez+l/KgPU4sSVOAzvsLvamI3m9+YEch7nqNaCGw3Hyzs+L7F0
X-Received: by 2002:a05:600c:a20b:b0:495:737a:7afe with SMTP id 5b1f17b1804b1-4994e7d5b82mr349705485e9.15.1786277705032;
        Sun, 09 Aug 2026 05:15:05 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995ea3361esm194506475e9.15.2026.08.09.05.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:15:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Sun,  9 Aug 2026 14:14:46 +0200
Message-ID: <20260809121449.574277-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809121449.574277-1-ansuelsmth@gmail.com>
References: <20260809121449.574277-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

The Airoha SoC family have a mostly 16550-compatible UART
and High-Speed UART hardware with the exception of custom
baud rate settings register.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..b6f7e093d8d7 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -110,6 +110,11 @@ properties:
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
+      - const: airoha,en7523-uart
+      - items:
+          - const: airoha,an7581-uart
+          - const: airoha,en7523-uart
+      - const: airoha,an7581-hsuart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
       - items:
-- 
2.53.0

