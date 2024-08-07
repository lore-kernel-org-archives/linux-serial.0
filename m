Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3577F08
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039978; cv=none; b=sn9I4oDvr/v7Uqq7jqb1izwd8ImBe0ifk/b+UHa9phK6Oq48CGHFc9Qsqo6r++EmvUT9hes58ZYXP1LQ0/Ccod/2hhjEW81MzU3pyy0v++Ps+SFJY3Nat0FoH9xFrRed2HW7YuXc1OnwmOgU5LKpTdohp3Ns47BphCuY8Staz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039978; c=relaxed/simple;
	bh=jJ/dqspqaWeDfyxYIMbjnG33egLfKjvpbKPXZLYU2Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNkpXnlU60aWrAVqRRosjVByMJKBrT5soJ3sblpDewn4Pn42FF60RnmEPjsyqAp9xj7ezlCYNmwOZzFFEvPEBEaiujzBxfg5t/su7zw53QomHaLAU0/ZqCRzC8x/6JgpKgvl2lXZCYO/iNAKnEz65nH3wtA6KvoCc6I5ke8SGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3J9tLpxp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3J9tLpxp"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a611adso2563337a12.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039975; x=1723644775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWzbHrkvy9hRtxlDmALumwCtMR3F4NOzbURL/XveH2s=;
        b=3J9tLpxpAQktP/CNTTI9R2YOuNOZ9seuckzPxBGLeAWc3ObioLIZSPGwwitFJdIq75
         Rvdk8vMG4l3ysDhInNv0TsiunZFNkjPa6oIkwD+dqWAuVU0U2KJ5h06vL+CAFeoPBQaL
         ASbmu1hDxqC/gsdzEgLienLvA1eWUZbGXRxfQQWuNBsU2Aj+vBITfE7mSaN2q2mM0v/W
         l4zVUQYUYYPNzDzLZfzPWAWtJ5PlzkYQbU5rQ51CKWYFcJEifIaAn6lPS+WRx/Uat4EO
         +S6F1jRk4ijw5lu82yXg6tJ0yFDe6syDb9z8O/pdzwt1fuzZSOLxrSEi0yo1R63qYXgI
         NQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039975; x=1723644775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWzbHrkvy9hRtxlDmALumwCtMR3F4NOzbURL/XveH2s=;
        b=NAKmoC6PCXw1My1aZ/cx8LM/rMu5K60xvkyn1dCxYqBVOVuw8j3IMtyY2ytQCUmm7A
         AZ1LJgCfruYh5iPijTEqQpRF6mPU6KBtyz1hVQixanVVg0Y3uQDT8Z70A838teWZuR+9
         0twEtzlN4zfW1yhP9iAwPp3D8nbIoXmD1nT9TzrPWr78azA2sldOAKv6wuG8WkYUVnKt
         AfLl3SyA9UCoWUH1pTmgGsY8XkpdGUcPTlBOsZtfXWpSRxFJlLnx2n0uJSoHH0/1qFMc
         7BHDQF/85p8XZT/xZ++c+AIZ0ohecgvGy9RoIpSmyglvsb5+h6rLrwHGNPbM3vRtLQRK
         /52g==
X-Forwarded-Encrypted: i=1; AJvYcCUhSugiMov9dWFH0Nl/duhCypRCQ0s0MueKLRbN1UNm0IalDGSVfHRtLJBSW3DILaxRmlSkyoqy+MYM+SorICkgd80dN541FX01k4P+
X-Gm-Message-State: AOJu0YzziuF3a5SxeCtruazzZ96C/8uou/4ez0I12xPdZfkFnJafIz9u
	Xd/2IxgJ7shLpRj34rkouuPPL5ddRWHW1oWvEKkT8OpqEdUHGU7zFXa7PJ9v33o=
X-Google-Smtp-Source: AGHT+IGq4cislIJyd0Fi3SNfVx3j+NKux5WeCaTZh0bSfOP0nKaFhK2IzDBaxUc7p5dC22ZqWvPYOg==
X-Received: by 2002:a05:6402:60f:b0:5a3:a9f8:cf20 with SMTP id 4fb4d7f45d1cf-5b7f58eb70dmr12738369a12.34.1723039974659;
        Wed, 07 Aug 2024 07:12:54 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:54 -0700 (PDT)
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
Subject: [PATCH v2 5/5] serial: 8250: omap: Parse DT wakeup-source proerty
Date: Wed,  7 Aug 2024 16:12:27 +0200
Message-ID: <20240807141227.1093006-6-msp@baylibre.com>
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

If the wakeup-source property is present, enable wakeup from this
device.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 7a6dfd40af9e..ccb83c05be20 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1530,6 +1530,9 @@ static int omap8250_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	device_set_wakeup_capable(&pdev->dev, true);
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_set_wakeup_enable(&pdev->dev, true);
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-- 
2.45.2

