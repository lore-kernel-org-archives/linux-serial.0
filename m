Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D13D6498
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375608; cv=none; b=AO+aMvZW3s6dGBCuEKAX/bvfMwI1KWRSL0DSvbHNmeiWusrf+dN7BliV7fsdtnzIVbb3b502L37rqv6ke79KLbnVJZMhm+ydkyZ+SXhclkHCMrd2ffDv0gAg4x1EuayD0g8tUF4SJe9WLOP7z94fx82fT8YHPWCFZ802E1aZZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375608; c=relaxed/simple;
	bh=qojpEXZM1zqUcd4Hb1bZu7Wvi6ygJ+VZs++N+cOMmOY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/tP8jYLR3rmkz+8k+rK0nD+oUz6uk88iB4ye449539uJUt2HIh8P8fOS9oBgXF44xDew9+q9L6gciaDa0Z5wIsid4GpS0wvkkiqJsETNwfRA4MnQA7kp1iZPid2KtSwShejzWxjAmixTYUAhv/cCXEmYEyi5h67Pu28wqVuel8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCUH2meg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCUH2meg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1127163f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786375605; x=1786980405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8CIp/0d4M5gEc+Mi2m/WthSFXtXGevzphjUBHHQhGts=;
        b=QCUH2meg+Bw/U/bZQFOOBvv0YifsKLY2F4ZvbUsUBCV4QNzCUGbc0dJL/Yx8rXOB2u
         RLGqLqxFCVvlWw9++tWka6USfxAJvSYxac3A12W6BedVgia3qZDLWAXmCHQMWURmTxpK
         asAAYFCj4fQH50OJ5+87jOwCL92h2J231hYSs2l8v+EW3kjK8iy/OHOqcB0oUICbM9b0
         Tq9xGlsISPMRZjCrcbRC9IXmo2V7lfCOlQo+uS9y+iJRrp/Xj9/F3ea9tJj2vY61RDRh
         7mAxjum818tKJuhl43PhiQGOMdqQUsjnS68gaPlDd/3X9YMkIKaPeg8FJnOAqTtUFxJj
         pWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375605; x=1786980405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8CIp/0d4M5gEc+Mi2m/WthSFXtXGevzphjUBHHQhGts=;
        b=rZfJbSR1u85JIu6tI+0dn/Wj2lRtqrHvnuBL96fJ+f3UARNhQQZR1aMhWcljhHlLJJ
         nzFEhnZ7m7Sj745Jtd4WmYN1u+iFl3+LiimUUQ6io8lGF3YMQqJo+pQDFau8D+Wg9vSO
         fzIAHVATTIy6z4kn3WL/I0JnKsfbWPIFtR6FKn+o5+uckNfadtLJezLpmsNPEP4l5nji
         BSi0PONRHA7kXIqlYFJjU/25g9AfAt/w6h3b/QplOlMmtUqbIE29DimwbjDUBOYHsad2
         +kuW8sSKWct5NdgK4fGz43TWRINx+hjwUThdeL0CEjJc4XaFrENgqR2YIi6UwZgoKPrC
         FM9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrPNueEfRPxsH4ng1i8TjSWm2WN6zJ0BKAO+qiwsvJXpmPvYIGQ0jY5hsitlSLInUfIM6kxNAtOGemh7Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhR0MMEwFF03v/CPGELZP+TFI6F+Xg/uSx+lxtr0sckXdx2W+j
	WMzQ/55G5w1FjjHeJo52laoSW/AfC9s5+royvUK5Wdsx7Q2z3gkOkFsa
X-Gm-Gg: AR+sD11rjgOA2d0b5i+B81cuSyfMnC3C8AAdoe9evqF0yvhEGlBoLtFSyG705r3mYse
	We5eFFItbfjVCazz/gRymVsFuEoDnwoyjLX2k1wJIMZBEbopL4+Lc6mn7KdJeHM6DwzDK34Tdew
	1a787vNee4jkZ7qLA6zaNKEvJ40ei+Zkx8aFpLXGf5mXOHld61kmp+9gvLaEY3khxPmwKrViJ//
	A/T+SoCMQnlhm65+hb5wretnDvpGOTt/xPuSotT0mLCZ18Obw5FVzNJy4n/3aubRVttb8yWXUj1
	0ALIyMr0AH4yjEv709n+sgl/HQvkImh3+MZIOtbz3qAod4t34NSLhW5pR51ToR9DZmCpCp5PbUE
	1MeiQjpn3wxzq+PvNJIfbw9mRKlB2qX4UeTGThtwCyMZ4yBnwRlk/YLEQl7uLuF/B+fZhBqCf/a
	0r5lAO2YJWiq4tcXSJYqN4P9vXk7NXn8IciJT8CLxz/ye8uO3uMmgF0dbNZNIa+0mHF1HE1WRi6
	WMqu1m0sHmBhdnHWPbXFy63d47HiqDf4hc/MrjrOjAmMDOb
X-Received: by 2002:a05:6000:29c3:b0:47f:fe45:e597 with SMTP id ffacd0b85a97d-481455c8dc6mr3299302f8f.3.1786375605322;
        Mon, 10 Aug 2026 08:26:45 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-480021e8cd0sm34952469f8f.17.2026.08.10.08.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:26:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Jacques Nilo <jnilo@free.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: serial: 8250: Reorganize compatible to single enum
Date: Mon, 10 Aug 2026 17:26:33 +0200
Message-ID: <20260810152636.658955-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810152636.658955-1-ansuelsmth@gmail.com>
References: <20260810152636.658955-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of declaring each single compatible string with a const, move them
to a single enum and reorder them.

First put the generic ns one and then follow alphabetical order.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..039bd392f876 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -99,19 +99,20 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - const: ns8250
-      - const: ns16450
-      - const: ns16550
-      - const: ns16550a
-      - const: ns16850
-      - const: aspeed,ast2400-vuart
-      - const: aspeed,ast2500-vuart
-      - const: intel,xscale-uart
-      - const: mrvl,pxa-uart
-      - const: nuvoton,wpcm450-uart
-      - const: nuvoton,npcm750-uart
-      - const: nvidia,tegra20-uart
-      - const: nxp,lpc3220-uart
+      - enum:
+          - ns8250
+          - ns16450
+          - ns16550
+          - ns16550a
+          - ns16850
+          - aspeed,ast2400-vuart
+          - aspeed,ast2500-vuart
+          - intel,xscale-uart
+          - mrvl,pxa-uart
+          - nuvoton,npcm750-uart
+          - nuvoton,wpcm450-uart
+          - nvidia,tegra20-uart
+          - nxp,lpc3220-uart
       - items:
           - enum:
               - exar,xr16l2552
-- 
2.53.0

