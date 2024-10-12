Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7263CB
	for <linux-serial@vger.kernel.org>; Sat, 12 Oct 2024 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728692403; cv=none; b=DcqVJ7pE6CYzrbyKjng7i7PJdMcU3ZsJzCDPDuBuaAoYSozOQnymQ/3IL6XQEGF9s7NW0U+LhIwpDNcf/yVLEZssCyR7oeqIY6JvXLa7gMl/gFgXNzuqJnOTfZCfammaFbax0IxZQrF2zhrvoeid5LIi8jb4ZKu+GjE8r62+rbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728692403; c=relaxed/simple;
	bh=L5PU+USaOpUc4MNOsSFRpBsple5k9TASXKc5I9HuBD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hjj/XbG1a+9Cf5h537d1l704xalWJa/rSLNd+Hlg/+sjVofbORdsGOQ5zpOfNMFs2YhLhI2Qzygl2YQLsoG6P+2A+tOe9GgiuA2S2dMv7uDW1q0oJvWobC2b/lo1yMrHJTbuq0nWkwAT+xY7/1I36tzf+YMtyXDlgQZeOi145F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20bb610be6aso26933335ad.1
        for <linux-serial@vger.kernel.org>; Fri, 11 Oct 2024 17:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728692401; x=1729297201;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5PU+USaOpUc4MNOsSFRpBsple5k9TASXKc5I9HuBD4=;
        b=dAbqKJRAbj+s3SW1XM5n2zukGSW6TJgjZQweND499LKqmVSeKy9XqlSdabT20KIVww
         PoSG5KVGfVWBs+lMO14IV4Rw3Dl5eJ8NGMwmyBGvoxYyDNf5qM2K/L23lAcdBQicnNV3
         ONv6IDHpHA72kw5Egqhi3+uXJnQhBXQORQQtrgppPFBhDS9UA0Gzclbo/tH5HQi8aF6l
         YfxNcwS5eF1lOTNzkTINFEIcDwMF4ps4yh3iq9wYqyzBBvcWQVAtjXGG8LJOxv4V7EnQ
         XgQxNCIrnzeWV6+/g4F7ni7Jq1CKy79JKjY+3Ns21ND0xHUVMpZsTNvXNNN1jBHqLp0W
         gmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm4Gy/uXW6WBH9BrPvtqxsJDkVQIusPO5bAIuEK2Y6eggzPBf1cfyDSD+2DjEnQLPQzwoytWOuWhddghE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9yJnJmO1t4iqasSiM4lOxyozWkfSRmXkTQ1pAKYVJrw3KWKqW
	kgYib+3paW6bOb/n4/4tvyKMktaATCvSuls3vu+AcfLZxr9bPGDobJMp8NiIpvE=
X-Google-Smtp-Source: AGHT+IEs1zl3G4UJRzsFyVV8DcKwya9B8nUep2J3tP9kwAe7FHxNrwhmPuHfj2Ge9TUxqZRjXCuS8w==
X-Received: by 2002:a17:902:d2cf:b0:20b:8325:5a1e with SMTP id d9443c01a7336-20ca169062fmr44133455ad.36.1728692400833;
        Fri, 11 Oct 2024 17:20:00 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad99a0sm29023455ad.8.2024.10.11.17.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 17:20:00 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Judith Mendez <jm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bin Liu <b-liu@ti.com>,
 linux-serial@vger.kernel.org, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH RESEND 2/2] serial: 8250: omap: Move pm_runtime_get_sync
In-Reply-To: <20241011173356.870883-3-jm@ti.com>
References: <20241011173356.870883-1-jm@ti.com>
 <20241011173356.870883-3-jm@ti.com>
Date: Fri, 11 Oct 2024 17:19:59 -0700
Message-ID: <7h1q0mw4sw.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Judith Mendez <jm@ti.com> writes:

> Currently in omap_8250_shutdown, the dma->rx_running
> flag is set to zero in omap_8250_rx_dma_flush. Next
> pm_runtime_get_sync is called, which is a runtime
> resume call stack which can re-set the flag. When the
> call omap_8250_shutdown returns, the flag is expected
> to be UN-SET, but this is not the case. This is causing
> issues the next time UART is re-opened and omap_8250_rx_dma
> is called. Fix by moving pm_runtime_get_sync before the
> omap_8250_rx_dma_flush.
>
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Judith Mendez <jm@ti.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Gave this a quick boot test on am335x-boneblack and am57xx-beagle-x15.

I realize that doesn't really test the DMA paths involved here, but at
least it doesn't break basic boot to serial console, and the change
looks coorect.

Thanks for sending a fix for this.

Kevin
