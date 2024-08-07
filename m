Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDD12C465
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056936; cv=none; b=ExLEV9S8W+yrIna+skkGXY+k4SBrE54+sorOCnMVTwZp73/iyoKy1T+k/ad/nWUkNw56ljqAnb3rzqPqsus8SHPN3N/IiM5w56gN5TwCqjiQYFGA49fdBfxG9RvTEaKBTbtYJy7UKB30PL2EVULEmHKpHj1HmDv8KglgM12A47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056936; c=relaxed/simple;
	bh=QzhlHFhB1FlhGEk8gZPrNnM4az2SdvOjtcQi634hGIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZAadvCTfKMbOhLReDmOU4mSZtGmAi8Wv6qW7kBFbm1C0EiUHw3j8Me1mJ+AFscC/+NoeKhZsLPiMOuyizql6Ff3RVh6g69n59JNkdfZsfBcY681vlsbRitTv1cM0Wetpjw6RJdlCV5Fpb+ZyQjR3f0Lj9L3M3yWMuQg1u8Eu4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K4ybcO5w; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K4ybcO5w"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d18112b60so107719b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723056934; x=1723661734; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFMK304Cg4PQj4mJQ9LEOTK8TkHQhLXzoojwOreQ/Ok=;
        b=K4ybcO5wEPjvJSXg2hs3VvuZiX6MvQowzIXetYqdlb1poo3K6RH9nAsVOajDuQwHgX
         epKi1wdjKD0DG5vpiaxzQ06eqUfJfeSgyC1quEbnSWe6zweSR8z+tdO5KPPe+y9QYbpi
         0adWKjOaNgagHUivC7i+ujbZ7r0A/c0TFzxAbARARwkj9t9G04DVC94+fPrAdI6GPt7J
         8gqramJqlZ6R4scpq+rk9+8WWFptzm3fDDF3vGpQzsQ7VB8CVZgQqiuMu7H1nsQvR7gY
         DJu/1zZwCU+xCN2Rc5eYtyJuUZFAPBWYXb7+kMTWl9LAb+hPVSLBFNpR/wobcZXLYJ3b
         89zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723056934; x=1723661734;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFMK304Cg4PQj4mJQ9LEOTK8TkHQhLXzoojwOreQ/Ok=;
        b=Jh3X3RVqlZUhK1WBaU/fveMFqgz35f35DFx3vb8Kq65GKhevgPQmzjEaQMuLDfikDD
         E34ly7xE2wQgbk3b9XxMAWj1XoC0kLhPReDDWNIyGOwIvcrvrX9YMIVJVbKA79O731mU
         09kdY78NjngkjCdf34kF9gy4eYYOZlBm8M7vZKnFIVsWzzRUIANiBiAV0GOMpU14TRKz
         dcd0PZYnhvMo0565vADk933VNEJ7P54+9g6kRM1iTatsAEDByxnOECTEJ4jg70j+m8v6
         GJU6ftJ6CJhC+wkI2/1ZAwZxCic2LoD97uKxwV0y4EPnCPodK/e2abSaT9MPeouyHsJv
         WH9A==
X-Forwarded-Encrypted: i=1; AJvYcCV7VSr+NdDbJOqOZdiybG7ImmUn8iKtxmNdTME3dpRHX+GPIES7/OjrgIoY4Q8YCDbj3AixcuWL7kX3atg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/oYX3boy3+QwMrgjVqIULTWVOcuNX37e1OaRZ+2Cr0ifBSF/+
	ceUEw1mqxoUgv0Cts6ylADnPtc0L3bu+BrVbQDjFmy83xk/hGS544ovFPUDCkmQA66kNnHddyMy
	jKOw=
X-Google-Smtp-Source: AGHT+IEYK846WIyyA851lwFO0Thrl84W8t0gbyPKmjyyprzOtO6+L8KKdMUAaabzXjldmTOqaK+sQQ==
X-Received: by 2002:a05:6a00:6f5b:b0:704:2516:8d17 with SMTP id d2e1a72fcca58-710bc85f5e3mr5133969b3a.8.1723056934390;
        Wed, 07 Aug 2024 11:55:34 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece4967sm8678435b3a.138.2024.08.07.11.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:55:33 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Markus Schneider-Pargmann
 <msp@baylibre.com>, Tony Lindgren <tony@atomide.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Ronald Wahl <ronald.wahl@raritan.com>, Uwe =?utf-8?Q?K?=
 =?utf-8?Q?leine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Thomas Richard
 <thomas.richard@bootlin.com>, Thomas Gleixner <tglx@linutronix.de>, Udit
 Kumar <u-kumar1@ti.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/5] serial: 8250: omap: Add am62 wakeup support
In-Reply-To: <20240807141227.1093006-1-msp@baylibre.com>
References: <20240807141227.1093006-1-msp@baylibre.com>
Date: Wed, 07 Aug 2024 11:55:33 -0700
Message-ID: <7hed70kvru.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> v2
> --
>
> In Version 2 I removed the Partial-IO specific patches as these can't be
> tested due to power issues in Partial-IO on am62-lp-sk and similar
> boards.
>
> I added a patch to add DT 'wakeup-source' support.
>
> Series
> ------
>
> To support wakeup from several low power modes on am62, don't always
> enable device wakeup. Instead only set it to wakeup capable. A
> devicetree property 'wakeup-source' can be used to enable wakeup. The
> user is also able to control if wakeup is enabled through sysfs.

For my low-power constraints series[1], it's also important to not have
the UART wakeups unconditionally enabled, so I like the defaults
proposed in this series.  Thanks!

I tested on k3-am62a7-sk along with my constraints changes and all is well.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

[1] https://lore.kernel.org/all/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com/
