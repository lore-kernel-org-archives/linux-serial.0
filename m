Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D413D261
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451114; cv=none; b=hqCh62O3cd9YchseMFxKV9sA04iQuzqvfXPa1uTh0g2dZ8tiAhY9KR7jdUAwU50iwqmdonOKIURDLS2fZrQNg2NkaoADIRLPOaX23UF+puOeUIsy4xsMUuHhTJQSjLJsAQ1SaFeWvNUOir3Vnc8nOQe9hrVbVplKXYJrhjhA/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451114; c=relaxed/simple;
	bh=JXfSwwnz3aoD1YttqGWpLZwDZffWB1gKvJPkA/WlJVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6WCSJqa+oj1k9IFDXG1rlK6+4UP7rjq7Fz/F6pJ2UFyvLZLuP2Bc6NiCWtXQWEMmySwnnNObyL6VVn6LMWxHVPWcQPDjh3XDvpRr5FZEsH5xW/++EUtTFfjfvQ0jV+ldFRRlw+wkM5Lq60IRvTCucstp7hjcbcUitohEzhtiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ih7cW4tj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ih7cW4tj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420180b5922so20508035e9.2
        for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451111; x=1717055911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI60UQPxpWufyIYTmlWT9jYm0QX18O1OLfjH3sNxehE=;
        b=Ih7cW4tjbhpzpJjTY6jbi2qqMrrmkRC97Pso2mnpsH8zpgZqxOaeSNAXZW2OjhCYpp
         HKZKmCsQPXx98VrUTIpA71F0L12zZ36AsSCVVBQFllLEydbJDrwLHWArxSORMeuQSF2Q
         WIOSvE1mn0zwEb8OyEaxEnhpaKdNZgcrGPoYaDuomy8ceL4h0XvxkpyrxOhexYcij8zw
         C403lNhkuCiBiDjcy7UuhXniYLCsDCl9JV1Z0DH8s+Q5OSmZJlwEq9bgROjFNOrIzMw6
         tf8rh54VFmKypHyXkPun+NQmeqfkFMtTMkGO5COcJGxjL8PG7Puq2RVykwkaV7tOopnn
         tQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451111; x=1717055911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI60UQPxpWufyIYTmlWT9jYm0QX18O1OLfjH3sNxehE=;
        b=D1hrL6Wbc/wY3u/PlvWt731mtj9vPs+UQZNo/0w1inkjeUMz3ppZZYNUyjvueVE/af
         3ovZNSP1GTxWC6Bv3mPH86td166bqA0WbTzOddrXpKb0OzqAv2VzgFqjo8lADncsN7BI
         2Spuodd1yWInQeZpdp6QEPqjaiAUgFeR7ZIJLonVF2bzu/Fxt2NoBqyxIegtNlfzUp0U
         thvt9CnIciHDBefu+aYWPjMK/GEmEBF8xLQTARy0L7uydUvzxrsgTGAxGLAgJL8YN4je
         xpqMnsL2eQv+MDqIGb9ksZrRCzumHVZK05I8Uc7KQbLeYB5E8usUWmNS/tyPegZW0jJE
         FQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXcp4myRfYgeCKfrxhBcEO1sVionHF/on37kz06wOKC6Sz5B3EgFuoYhNCiUWRt3B5BEfirLDtTSib8RCh097OBI3HZZJfiTRo6QWpy
X-Gm-Message-State: AOJu0YzKUTY82hr+XKm/3yfb+be3q3kkh1DYrwLpjG5KZKJ2yLiAEVKq
	ntJFJefzVg0B906+d6DJlklnUq4tOIoVfH9yrzqNHFQYD3vOUjxFFEOkfY5yuY8=
X-Google-Smtp-Source: AGHT+IEmmwzL+k40uTlhKRwS2l9e+3ryu1+UT4VHTi5jnr4CZXZGZT2LSEj1dDGLqO0KbZJstq52qw==
X-Received: by 2002:a05:600c:314d:b0:41b:e244:164a with SMTP id 5b1f17b1804b1-420fd2f1533mr40593155e9.6.1716451110834;
        Thu, 23 May 2024 00:58:30 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f01d7fsm17359125e9.1.2024.05.23.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:58:30 -0700 (PDT)
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
Subject: [PATCH 3/5] serial: 8250: omap: Set wakeup capable, do not enable
Date: Thu, 23 May 2024 09:58:17 +0200
Message-ID: <20240523075819.1285554-4-msp@baylibre.com>
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

The driver sets wakeup enable by default. But not all uarts are meant to
be wakeup enabled. Change the default to be wakeup capable but not
enabled. The user can enable wakeup when needed.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ca456ea23317..5b7508dfb5d8 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1496,7 +1496,7 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	device_init_wakeup(&pdev->dev, true);
+	device_set_wakeup_capable(&pdev->dev, true);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-- 
2.43.0

