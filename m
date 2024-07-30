Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CF18CBEB
	for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2024 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374356; cv=none; b=H/p3av0CWDsmexK6llNEmKy6XWI0ZaJCBSlO7Ljf/IBJHIdCbNnirQl5Ht/RsjVR5ktXSV7HaN2swrepxUI9oueRiL4s7IRu3iRgLChxuYgZu7q3WWAmBc0G5BByFI1gN0nWq2qgtMbTLx75SZOZEnZ5sd1u2cK72W2L+lKY/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374356; c=relaxed/simple;
	bh=DIxMarJsBAsZLWNoPUxc2mcliNrW3Qg+0wlavW/inmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iVEleGuqihxohkjCPRSZ5/JJ4gEvbSZSycU7ZxscOpBd49/Tx4T2fxWboOnqHUMLB8S+mIxrkFkk3ZPxfHKUnUf7rXDeQeRCnDChDw3mFVcS9hyxJJ0RnhwGAbo99rb7WvoQuGULFgyzm7GRwKgQbSMuN7usFSKyB8SkZW4CdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RBeqcwWR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RBeqcwWR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb5789297eso3142008a91.3
        for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2024 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722374354; x=1722979154; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdIkd2pe0a3xGWOfFhFwChwsMO18vyV+cxJRBo1n2IQ=;
        b=RBeqcwWRNnMl5wsUmcDKe4ArFdAKg0IZEwUvRuK4L8TyDd9DGYYcxFcPOj9YEE++Pw
         6OIFqJOHUcVuzobmgQzP0LwbxmOpCdCFnQ2Pq4f9UzZLU5MbZ3/1mTDyHk9Kpoz9q2EU
         +rShoAaBcsAxe4Wxgxu6XptBn+JYXc2G5+BLxmm2fT1bHqQsj+ZkzgJYTw+A82QLAx+t
         VW1Rzyr8E0MsfdhUMsy2e200GOfqv3Z+V5iXdJVDvvf502M1n92+rEC/EEKt9Qal2NrF
         YSsOn7q+R4qkTlt5w7R6PrwlII4fcQ0qT66pOIFilqVyhr0giDP7G+RkurqU3tWQ4bj5
         oNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374354; x=1722979154;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdIkd2pe0a3xGWOfFhFwChwsMO18vyV+cxJRBo1n2IQ=;
        b=DzZ+22jknV42iswNVzopNQyX9DJsZt6taGh2LFakIU4Sc5qwFGLaCyDXKs0jyJ0xdY
         TFDr2+cO1pgNqagmriete+R0ml3UYqe4qIuVntglRDIkcZA6t67We3wMjQjn7PFCaHWv
         pTkY/2kuvDg6gqXIigmwT8cZJpkeLRGKd4PB3z8J9hYZjGxtyqf0ufK/80ZdlX37BFQq
         RyKFEShTQOHtRDGqkee9njFcc3ViMvzAoYIyimdvVPkemFM0pnESjo3f2wDcfETkJW5O
         vUdG7MmpHF8KqhrIKmAQSRI3DkPfoUXXblhZyUWUO4Qq3rnlM8r3/TqL/toJ28Y3bVZ7
         /nxA==
X-Forwarded-Encrypted: i=1; AJvYcCV4b65VxRt1+/wGUDxeXF0AejzrJBQcnpay0l79qy3eMEN14/lppUCPwzTPitrChKkTvhz4uN24cOZxcQftlGDyFAjrJLsMZt/B4yDz
X-Gm-Message-State: AOJu0YzPJ+nNneeyqrH7sS5JziEBdGyTS646fEvwbgEjqlU2mPf79A4F
	w76wVVtqK+AOXLreQF13TEXwvrgF7xjnR6uFLs4bYx+tpLCALsuQQt9FNIMu7wA=
X-Google-Smtp-Source: AGHT+IH0pxifqw1gkvDTkAWMSwQ+9XO630EomiwDVY0jejimMBKfIGwo7NNOWI0vlmyhGje1eiqcgw==
X-Received: by 2002:a17:90b:388a:b0:2c9:679d:78a7 with SMTP id 98e67ed59e1d1-2cf7e2073b5mr10869519a91.25.1722374354603;
        Tue, 30 Jul 2024 14:19:14 -0700 (PDT)
Received: from localhost (75-172-120-197.tukw.qwest.net. [75.172.120.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb738bb33sm13295415a91.4.2024.07.30.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:19:14 -0700 (PDT)
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
Date: Tue, 30 Jul 2024 14:19:13 -0700
Message-ID: <7hjzh260j2.fsf@baylibre.com>
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

In addition to the user enabling via sysfs, this driver should also look
for the `wakeup-source` DT property, and enable when that property is set. 

> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

