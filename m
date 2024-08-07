Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC03339B1
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039973; cv=none; b=CV6nrOkdYTa/XYC/SSrktASq7a0FbHzD6FU63ZlmxAqSNniGAQxbuufGTY6g5sRWnFHf3sgFWBgR8RSOKdBK8na0zaCVlhdoUDHxye9JaYDyHLr66EEJkoAowpJRNNNnWj5kNuc0XswAlS/WUL0I3A8wbRH1SaA/Y6eRU7xzMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039973; c=relaxed/simple;
	bh=qaLIhY5a76Z3Df5j4EUrP5Uqp81Mo30nXZU+/Xwg6EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVPsSuZYQA+g0lM9MSsPdebTz2qz9sfGoXXVCMdgUhvdIaJ2PVyat5bsOzDJTcRUJboSQRRzGswOHWj4W54VJJisR0SAxhmigPrabVaHvjeFxHNx/kNYLTHY+I4JAAbR8+zm34KH4UpZGL8WjYw6ubP+27RKZD8vKWHR0/ljgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y47iMReT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y47iMReT"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so1109010a12.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039970; x=1723644770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPc8uL/JW9kq7vTw/l6UlNZzhd8kMKMZECX7hWsn11g=;
        b=y47iMReTM8VnQbFb+ijO1pi5Hm9vkUEp+WNV/IJ6bfloBBVqjsDsycwi/JxUkG1sLc
         oRlQHqnEx1KHXqYjTswg6pEJVCK8UW89A3I7TqHxLrLPmiWJROlQ4HwGYwpEUA7vFFhV
         qTpOHHPSZjmXqLshdqh1N3jXwL9FCR3miDldo+H8MqdS05E1Z3Dk6j9dChueN7Pqu3MA
         VOBg1kGJ4ofiX2aPXJZ2qkBauR8uEKGl6pXgSJco5tPcMbOykJ8UJvIK15Rp89Bb7sYB
         LkktYGnoxGepnGYVMVnPrw6wFWNy8h5DPCWCYEIAA5fs/BCapUOtdtyyc/qJ3nkz3Hbx
         Ht0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039970; x=1723644770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPc8uL/JW9kq7vTw/l6UlNZzhd8kMKMZECX7hWsn11g=;
        b=nzwyl+6KO4x7Jq9UpQpBiiVvDHXyKX7BFddOOVlkAAEynEV+QU+YXMIGgp3f8Khzeh
         gIq3Vtj3nG3i27RxIaFRHVo+tMvJdA/VFYF/4eWGf2ROSgOfZmZm5OhIpTPkIUvY1LLf
         +pGAg6wyRGc2lsNDwdTgWaCu0YE4ZUliFMM4fBJOCRCjnxDBwpMmBPtyKM4BgvAhmfqx
         98wZjNnTzz5zA/MUwPpzB3ju0VbElNQ04/VuIDS6JTfjhBeEzh4flbPDJnNS3HeqReis
         tujdDWJKJ+sP7mYGey3yNxgzAUx2MdNJyoOhbhj1syW8QmT90MRmr3cKyXUCfz0wJP2E
         ZNbA==
X-Forwarded-Encrypted: i=1; AJvYcCUPX4PLuwzkTt85GYXCKCNSaP8r5G3Ay6ATGB/r0qnBATZinFQ8vXp22S82L1Ptbt2QlizoaY07JhOQXnlHWJbWG3wZgGjgrnu0N1jR
X-Gm-Message-State: AOJu0YwyTSEk8OZYweRkqBW/41QZgcw2fkehQ8lqgQNfftWqij5wwtLp
	dmAYhSCcUDIqogRfYRktla33bP73KNl5mWSZhGSigh/Gi2jhj4JCUBEuaKVFT7TaCqRiLswVuyj
	2
X-Google-Smtp-Source: AGHT+IEsUdOugcFq+1Zh+LgBNPD+cI5u68iHgjax1xg5KbxJ57PrjeQWrdQKQ2V4fRjbRDhrQZGJug==
X-Received: by 2002:aa7:ccd6:0:b0:59e:a1a6:11b9 with SMTP id 4fb4d7f45d1cf-5bba36774c0mr2032366a12.2.1723039969391;
        Wed, 07 Aug 2024 07:12:49 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:48 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Udit Kumar <u-kumar1@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: serial: 8250_omap: Add wakeup-source property
Date: Wed,  7 Aug 2024 16:12:23 +0200
Message-ID: <20240807141227.1093006-2-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807141227.1093006-1-msp@baylibre.com>
References: <20240807141227.1093006-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the wakeup-source to enable this device as a wakeup source if
defined in DT.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 Documentation/devicetree/bindings/serial/8250_omap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 6a7be42da523..4b78de6b46a2 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -76,6 +76,7 @@ properties:
   clock-frequency: true
   current-speed: true
   overrun-throttle-ms: true
+  wakeup-source: true
 
 required:
   - compatible
-- 
2.45.2

