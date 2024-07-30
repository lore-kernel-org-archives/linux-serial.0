Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E535E573
	for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368042; cv=none; b=tlVNubgbYYsfZ1S2jyLYdFzymc4irIv6sW1L+nwrckfMc+ikz4qUNVpcvS0ZiOF/KIJa3o/ubPjNvY4OYheSQfu7ZEtZAma2DLiXLVKvwkdxhXU6tUGlFBNYzy7sIQxsoATiKhYSCJFjt1Nf4xesA/hrgdQBe9XG+6LLVIhfZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368042; c=relaxed/simple;
	bh=omf2X1L/LKEL4UHtKhSM2wQmgye4tQs+vDaZiXSvInQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFZ0et3mzl/8x7JKqaGRpr+oIMdVOwPTSJ0gpRI30rVH5Lz4QNRHyxkUUyBz88zfvPszS6FSSy5YCaOETE5r+VjuecM8YeSiKoa9zF2D+t8UwZUOTqLS0u5gQhVyP1OZWHHmQw4J30jvqlgEK//boa6T2lep5/Nif7ptY2zsDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OhghCyWA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OhghCyWA"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd65aaac27so1543085ad.1
        for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2024 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722368039; x=1722972839; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeimEcrtXREu345QOU87DnizcugtBEtpmX3D5QJy8J4=;
        b=OhghCyWATs/ozEG4uDYanTn1mnhf1y82xZ9/fNjaE/cawi3B3HoyR0jGck5QNxzirG
         Obpo8Ft7x++GlfN8AYHpR2GwhqxFNVASfDkylzN8tzUZyZFetZNj0VWIEzS6kAhK+xba
         x1QiajA6cGk481ggv+iaZEMWlRPTTbEG/+wLTs4a3z/L2kq12N9igc1KYp1jnq0Ub3tV
         OZM9PpbLcvy2xqQsMtQAklo80FI1E3lPtOmXdQBJJH2YoVpOHQN6DWLRgWug0Fi9r0ic
         mwK4/MbDf6DM6W58LrvLCfSybrRlJxQYew+JJ0qTbyK/v00s87qnXDCwG8T3Ee1T5Zz0
         R/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368039; x=1722972839;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeimEcrtXREu345QOU87DnizcugtBEtpmX3D5QJy8J4=;
        b=s+hu3KS8M5vGYxkbh0nsq/fDIoA832nm8QyZGGZMbbOvwDjD0jO4W18JFQRnZuhRte
         2gm/ORe7Zkc51wdQJw4M+sdBc3xJ4foUZA7DJe0Q7HbJqWHsCWpmi1ReKnzmXncCYLT5
         yXAyzrbEWLh7iqPx2tAofQTmvKCQPKI4oQofwJZT+RcGSa4DKLszHfz+/qKRmxOWufiM
         hrAc4EjCkBUc9I7QCfzYxqn/z68CV/KRBwWZb6SugsfWAkIEQYVPz/vd5iqfpFXH1zcX
         +vP5kBAK2M8A2DXaTKW6KM/6HDQ1G6pit8ygWbpF+bKigHK+O/Y+ELWN1A173Nu/T8eK
         XzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvneajGGF+JMsL7cPBhcGZbCAye8jibOapapY7i87/VDHkjXzkgH4TxyJF76kB1yInwp3lZfYwoUfUqa5xoomws+rPp+VoRikwbgIC
X-Gm-Message-State: AOJu0Yz1wPejqcZ3hOXpp7nqXybI2SaPUlI0fQfzmrr9+JkmRDaPnLyv
	0thm+xhvw5OFNh+iqkAguJ/j9BLf82r9sQyLXv919WQbNFMgaU3t74y1u31wX5c=
X-Google-Smtp-Source: AGHT+IFkDhc8yviwAlThuG4ZoWAs5VdPkSosPcXR0VUE/A4FR2+6AXlSgN0b2AGf1N+G4hTO/60CJA==
X-Received: by 2002:a17:902:c40f:b0:1fb:5d71:20dd with SMTP id d9443c01a7336-1ff37b2efc8mr57345095ad.0.1722368038924;
        Tue, 30 Jul 2024 12:33:58 -0700 (PDT)
Received: from localhost (75-172-120-197.tukw.qwest.net. [75.172.120.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8461b5asm9312814a12.36.2024.07.30.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:33:58 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Tony Lindgren <tony@atomide.com>, John Ogness <john.ogness@linutronix.de>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ronald Wahl <ronald.wahl@raritan.com>,
 Thomas Richard <thomas.richard@bootlin.com>, Thomas Gleixner
 <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] serial: 8250: omap: Set wakeup capable, do not enable
In-Reply-To: <20240523075819.1285554-4-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-4-msp@baylibre.com>
Date: Tue, 30 Jul 2024 12:33:57 -0700
Message-ID: <7hsevq65ei.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> The driver sets wakeup enable by default. But not all uarts are meant to
> be wakeup enabled. Change the default to be wakeup capable but not
> enabled. The user can enable wakeup when needed.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ca456ea23317..5b7508dfb5d8 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1496,7 +1496,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	device_init_wakeup(&pdev->dev, true);
> +	device_set_wakeup_capable(&pdev->dev, true);
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  
> -- 
> 2.43.0
