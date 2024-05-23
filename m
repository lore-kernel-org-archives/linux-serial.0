Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48A13CF95
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451111; cv=none; b=U56ZVsggYGlmIh8RyoHrDqZSyZv3/Tp4wwEHFOv8NdWQod4Al0OzVXFdoLM1GNkSJKQmVxHZRf1j9K600uW9CmPHe/6trQjRgD1xTlY1sitvt7Yc6jYJn89Ishxf22e1j2pURCB5Kw37zYJX1dYJktNIUCzfGUOHExKcBE147O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451111; c=relaxed/simple;
	bh=Iws/eTrVyDn5dkbNRe+ngWkLPY2GChSsQJLxObwKLVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=em3hVelrTBfvWYPZnCiqNnNRoIqbdIU9jo0rEaxx5AUExHj0VgCJ1KEzx65xi/CQmHdRCYXFWSvIEQEb6VQAA97xZ31Wm8IX/oeg6qbbA23/gwG4bElGLWhVTF0mVnGa8VZ7O9XN1jtwKsDY8RitNiQ6a1Uvnlp+KI2xkCHkZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DSEsaT0C; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DSEsaT0C"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so74075931fa.3
        for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451108; x=1717055908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dcME9c6ixaYcF3shVm7kMCcCObSATYl0aCrY0gY47w=;
        b=DSEsaT0CewPiZdtsjAYPQ+DHuM43Mz4jxdj3cbYt9veo/YzDvYQFLgk87LxMwdBDP+
         Ug4Xpdz1/YMM7SrlS8Se4oVPC1rwwaNFarsFBMtrONnornNLYUJBOA8nRlU/rW/9yYv7
         ktSQUWIG+CVu+PmkrM5IRIDT+ob1Dj9nKfvJd5lZbtEGNi3W1HdEWrhyfR93ZO/CW4sK
         lTAHCRNAzPwwBDDDI0yCWNumNYIPC3F7j9wChVpktj82aad6goomyUwlWtseg6bJk3Fq
         Dg1nyQs1xH0Kil4q6yMN6HmkjCd0KpuzoF/Pn11WMUhcJ5R0uFABbPtGi61qlio6sqc8
         /iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451108; x=1717055908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dcME9c6ixaYcF3shVm7kMCcCObSATYl0aCrY0gY47w=;
        b=Q1w66WX/RnJv7iazoxIl0UQMGlmbDw80T/pkMu58C3tchAnMSmOVIkuXUUwnDKbm95
         W4QqezJOx+FvXENljYAnUGoHyePwHUdHFkcA9mR+ZtdFmJRE5uZgrrDCJ3j1K8zFc8gn
         Q/khDuwn7y6VPLHS7ZkwHcCG1VBCul6olqYHaQEiFf+BggQsdcSz5ZUxmXR0uxJL7iQl
         /ULNDb2DszEY7xooH4sYCPU5k8hq90wMSljaPQRH+CoEAdnoGoP4/DnmvE8B0Jii3XkU
         m6hL9xoKROCNgLhE2jGJ+vpPCaQ7Q6L2JSBZzpDdtJfN3Y/hFpl8Pzl7/UcZiaSvsJBK
         WbCw==
X-Forwarded-Encrypted: i=1; AJvYcCUdOGkWzPckm6iAjxtD0SyHuInv0HVF2knQ9BeZQk6LiQ7k9/fwkRfAQtPY0yS/gcKnHwNU61KJKAUq7L0RFrRFm0aMwm1ZXsJw6wnq
X-Gm-Message-State: AOJu0YwK4AIcBlXgCdUIgJpT0uN50WhiGkiVUcbiPPsaoE+BVVCi6Sn6
	fx7OlOR2D16KqXfA8DPw5jsqtnrrB9ABtexLvdjTjstgSvLcln+8PFuGgvopRxw=
X-Google-Smtp-Source: AGHT+IFpTa7+bTT/sd4yF+zlR91kFCGJP5zdGd3C9ipXu2fgsrBztORz8qI+fV4vZQJhbBvN91EpGg==
X-Received: by 2002:a2e:3807:0:b0:2e6:dd18:ac29 with SMTP id 38308e7fff4ca-2e9494c4841mr26332501fa.20.1716451107667;
        Thu, 23 May 2024 00:58:27 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f01d7fsm17359125e9.1.2024.05.23.00.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:58:26 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: serial: 8250_omap: Add wakeup pinctrl state
Date: Thu, 23 May 2024 09:58:15 +0200
Message-ID: <20240523075819.1285554-2-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075819.1285554-1-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pins associated with the 8250 omap unit can be the source of a wakeup in
deep sleep states. To be able to wakeup, these pins have to be
configured in a special way. To support this configuration add the
default and wakeup pinctrl states.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/serial/8250_omap.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 6a7be42da523..402e2ca81017 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -77,6 +77,22 @@ properties:
   current-speed: true
   overrun-throttle-ms: true
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
 required:
   - compatible
   - reg
-- 
2.43.0

