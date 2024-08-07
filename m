Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B155811A
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039976; cv=none; b=GKK4tlEL6T9Ml1Cqb5c3XK/iKTvfSQninKXwHXh7K/nT8DdKHyXJFK32uhBNTgIF8Ge8G6qh0lZXOlJZ5nnZ/JjOz38f1nUDrAp60PRpfe9HZPAGfLyNrG/8D/Bj6tZjM4QPTL6J1+0ln65Vg3JpK/361tCpJp3UFpnKG7zDq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039976; c=relaxed/simple;
	bh=e9Jc2sCWqNGEQJxc1zAjMLSN7zhY899ZX891bxlRIFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8cJZsMw/QWLrTCHz2tfOiaj33xhqPxMpwXzOkAsT23poQRUPK7SPn91t6eIFK/VW7BdvKTjoLLlCdVlp0BTbcMei+dVXnmnNs2wIgHTJuwg+9/pVRHW8tsWhvDqzL1UUp58DTeUghhbswg360WqX9E6FqRPNMV5verh5JPJhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w1LATSfC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w1LATSfC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so2161804a12.3
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039972; x=1723644772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKla0TikiRVuhRSfUT0bnjb0mFUM6MzVyHzb7uGiohw=;
        b=w1LATSfC1cDKgdDqOGwe3eDw9Mp9RG252mLySZfJImFljP1OOFTgA0wxCA6NSTeuET
         bLyYU2r6iJiEcYLCAaJJK1ISp6OGpqMNFoffi/MsabY6tnOJDdm7N9/2LpEUCvzgkrFJ
         4efDk6BCnRM2OpgSVkNlqXgJq8zNMNgzG+/PLOvyEwz7dCU8T95PeAaxfElW1f11bDr7
         IvjkamYeEOZXN3xJnvpu26gxBQ71rjfOOe96MCoDVWFqqkqh0/m5/1MwqIzjKW/CJmpy
         Ee4RNKc9pCPeinesdVg04djl5zH45vZHYzGvmJufOJuC9FLkE3vizvnLlF+ziFSfpDbn
         Buig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039972; x=1723644772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKla0TikiRVuhRSfUT0bnjb0mFUM6MzVyHzb7uGiohw=;
        b=s3IXQzB3wKbo9LRQnohCzmF9kMD56gBhogu/f90bh86gYOh7+JEKrK14qu5fXJ+nKI
         5beTv1E8WPFNVuEyy76tNxvD31wrwtwaNvHLt4k7eotGBGmDcR+mx6Q95ikkVl+w0Q3j
         GR4V1wez3xwqAmzqLGUxPRacLQPhgFPLXMaI8Dhivgl6zpr4oob3HdU9QiUedBZvQdL5
         KLvn0Z6xaJlWTn7Z4/1H5le3cgB4vTs3m8oEHpdETG1wxWV6hulPbfOx7kjpMdOcmMMo
         4iXAi/7ZycipnP5eErRYOq/vipwCm5lE9cce/pQNc7NbfgWi/6ohWmJ4+Zp7NC/jzub5
         gzaA==
X-Forwarded-Encrypted: i=1; AJvYcCXuW2LsrJucAYCiub6dR5xKXeQ3TZAAtQJqHM6Ea6A8nTQlNlNlvvJx7ky3xODkCV1tx/nWGi2Gs1YKQiWLmo6n0823tMuabs5u8xeo
X-Gm-Message-State: AOJu0Yx1pVJV3UwDCxbI/XI/rtvtB+zkL1A5FqclnPkLjcGeO2yaQ3pD
	bAz/Z2V1rz8YZqMrUW2mcmo+/LR2XVx8LrEUm0C7p/0Cz4R487QJ7Ko3YuY2vdo=
X-Google-Smtp-Source: AGHT+IFTtDrHzcEyJfrxQSsx9wYYXZfPjxj1fP6zwRtDfyoo6YHEvanfv08xhTEKIkVOKBpqh5fwkA==
X-Received: by 2002:a05:6402:542:b0:5a2:37e0:1e88 with SMTP id 4fb4d7f45d1cf-5b7f39e0ac1mr12617987a12.9.1723039971875;
        Wed, 07 Aug 2024 07:12:51 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:51 -0700 (PDT)
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
Subject: [PATCH v2 3/5] serial: 8250: omap: Cleanup on error in request_irq
Date: Wed,  7 Aug 2024 16:12:25 +0200
Message-ID: <20240807141227.1093006-4-msp@baylibre.com>
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

If devm_request_irq fails, the code does not cleanup many things that
were setup before. Instead of directly returning ret we should jump to
err.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 02d4f3073696..01d430de9c64 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1587,7 +1587,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, up.port.irq, omap8250_irq, 0,
 			       dev_name(&pdev->dev), priv);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	priv->wakeirq = irq_of_parse_and_map(np, 1);
 
-- 
2.45.2

