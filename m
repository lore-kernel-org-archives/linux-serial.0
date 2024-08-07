Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2699474058
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039976; cv=none; b=I/oi61Ro2IfCkR+FWNREizHCmSAtPN5O7sp793V2koxe9PSX19ZrQMCAopqx0vIed4uZ2TC8RP4/+qzPgrdLcCrXwN83qoQM39RTXWYbhH8cW7tUuoc3UDtlNlsQSxVui5E9f71Xj92IUBuWpjZk7G4o5iZ7wmVKpkmkbjUrZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039976; c=relaxed/simple;
	bh=/M7emE/2Qa2RgsvJur8Mg3ojafyx/BbqtMTsB9gWNeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLFUNT49F3rBSYbxdP12F75DYqf3ChnHK8yf2EC6AOCagX7xENxm21i9UFGK2DX/CcYN5sAtM2KHiQAVBEU/NZ5GB29ElAbHKyzQy0EqU5H/gRRmDyNkkwc+jeIfkeIArZhWYQo0hD/6+UkUySogkXHjasVjxfy88Q+Ahtek+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hcHvxlmh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hcHvxlmh"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso2891831a12.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039973; x=1723644773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj85BiW7OH0vjd00Din4ISdKFXtoAd7NnhKsZDjxWzA=;
        b=hcHvxlmhGW0B8hjAS2RGGef1QnhgFqQU1v6V3rU7UmCDt8MlCA9ERKp9GhDhkZ6281
         5hO4L3srugHqaLct9wU62weixLIvxmT9e7QmjqFQOlHlGXYVQ2Pc/vCaWXdpZJcxoT4x
         MFxUfNlFriwwTXJtXCQGk1PDs3S4JO4suOcXF9jPMUwCpTTSjm4aq2Ls4gPajtTfMfxa
         i4EywJclY6Q9mIB8o7/gIDwBe9W3cvqulsrmT8lFq7/wQwetXXYxmynsGRbUxavcqnKs
         THoStBY3qJVJrWhb5xrvgvv7IleUArW7JXoeFgWweYhqBPnxMJPOp2f3PKmIKP4hqqn3
         HBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039973; x=1723644773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj85BiW7OH0vjd00Din4ISdKFXtoAd7NnhKsZDjxWzA=;
        b=d3BC06xyljnz3fleV1S9OQFNFe4w+/98kQPXyt8+5KVDg66dOIj5YsGGIfQ6aKs7J4
         iQzbGwrV++CoF3eRyT7ploi2NxxjTVncYPsQUUseuukGfJhJaAo+1ZNX4MoYX94vXPuJ
         XTemA5K8x2+r+9pJbhml6yf3aj9/6P1uTMvCxqWzSMEEZmjfz6cMfjKLPSzVZ/ySEfy/
         UGLYfQJ8e+64JM+pDvOu0hySAkUd0qLo4TuW0ULFjZ/XdJNr36EmUQTkx2313bwREIhL
         6DTD2DnERnFx6Rci38wtaF4/+1PCW70KWKmRZR8v9AnMz9LhENchvouiwBaxc3Z0CIJF
         OGEA==
X-Forwarded-Encrypted: i=1; AJvYcCWBqRGBnRZRSOKNlHKI4tq96l+U28NmvmueWvSrCVex8QZhDLuuZReBSQesfNRCWYU3oZCcnz+7tXt81C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+geSQ2T6HfR7r6BG5yOLE0ppQzS+2YrGl6YnymQEGwQl09W/L
	IOqbsJC6D3y9rdDd8izbGBJZGRKSneMd5uyJQm2elmjMsBvLdj6au29urK+dNIU=
X-Google-Smtp-Source: AGHT+IFFeWkyTUn3gXwl17NAH20cD1sXn2wOqFO/iSCy6b44/Rpq7Q6khSChCCoOdtQ8kcv5YttJkA==
X-Received: by 2002:a05:6402:40c:b0:5a0:c709:aa0b with SMTP id 4fb4d7f45d1cf-5b7f56fd439mr14154527a12.24.1723039973524;
        Wed, 07 Aug 2024 07:12:53 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:52 -0700 (PDT)
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
Subject: [PATCH v2 4/5] serial: 8250: omap: Set wakeup capable, do not enable
Date: Wed,  7 Aug 2024 16:12:26 +0200
Message-ID: <20240807141227.1093006-5-msp@baylibre.com>
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

The driver sets wakeup enable by default. But not all UARTs are meant to
be wakeup enabled. Change the default to be wakeup capable but not
enabled. The user can enable wakeup when needed.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 01d430de9c64..7a6dfd40af9e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1529,7 +1529,7 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	device_init_wakeup(&pdev->dev, true);
+	device_set_wakeup_capable(&pdev->dev, true);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
@@ -1628,7 +1628,7 @@ static void omap8250_remove(struct platform_device *pdev)
 	flush_work(&priv->qos_work);
 	pm_runtime_disable(&pdev->dev);
 	cpu_latency_qos_remove_request(&priv->pm_qos_request);
-	device_init_wakeup(&pdev->dev, false);
+	device_set_wakeup_capable(&pdev->dev, false);
 }
 
 static int omap8250_prepare(struct device *dev)
-- 
2.45.2

