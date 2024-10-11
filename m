Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB551E0B76
	for <linux-serial@vger.kernel.org>; Fri, 11 Oct 2024 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687177; cv=none; b=oeOoYG14J5LC+tcJSB3DErcGR+pNvrARzv5K+4aap5so5Bi1oB/sXvLsm7FOPctbXi9FlG3fC4AL4a9CrwajHBKMVpqulqZOwo9Zn+NUfcSng+tnvKXA8c0Kp+l/FRRdzBz9COt6fOBPoRUOJny1RGY45socjhAtCBROPcbBBrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687177; c=relaxed/simple;
	bh=QHnSVJgKPC4Nvh2tA4kTrfCxlBBghkUgALPOqLtV+38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uH5jWpNPP6FNf59eV89mKYMkr0jj/q+ddgiN2POIDj9B8TzJuYsdlpZQkRiJkgb4ufA9WGaaDJadJF22sVnvNWIzNCtFv0eshypCCs+cQVDqZfRQHS9nF2/2tzz11BXqiPxrQpt+nVbhVDILwG0Dy1nwbylEc7dtoFFAnxbSrws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e3d45bbb5so738062b3a.0
        for <linux-serial@vger.kernel.org>; Fri, 11 Oct 2024 15:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728687175; x=1729291975;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHnSVJgKPC4Nvh2tA4kTrfCxlBBghkUgALPOqLtV+38=;
        b=Yc6jmvG0mDfTug2uEHqxcv5HqMlQ+o6s4cz90pY9aFB9CisoprDVeZnFUbnuH9bz6T
         sg7oPFfUL1uAkM2u512/YBttxG/OPsvw4Z6ApgaoUR5N5iZlfIAtFinPr5JWm9JAfDWo
         1BKnRWByOVeAMEtD3qa7dc9H7pn8TSUN6A3INqWWdhD2c/Wx/B6o5jl8ZusYlehAcPkj
         VTW0T2B2/CqghpRqWXY1qg/zYD0rkEiAofKtRjVKfzf6zChNuIXondVHe3MopgEMix7o
         1fkR5Rmz7/Vz74JoogtR344Up60j1PvEfqIC6xYEP58K08/lKF/7i9zG9a1C+yepJtt4
         gZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCWCeCAR5HyR/IdxqyuP7ANaJ3nUzhk+7+R1OetU6fC7gS62c8Z50aCVGY1JpKA8tymzzTxbUgoTRQ3p28Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmpxS0608X+8iPploFCm/WetJf3cMk1l5pbrV2+uY3Y6y3QWnx
	txKrG3B46OYW9PbDt7K2zrGE0+TntQqZDTE08W3opzd7EpnUCfnWhXe7e0c+rco=
X-Google-Smtp-Source: AGHT+IHaDDeBN7leSygl7Dodvs7/8OMvmcN+zyvTXC30J47HSWRnFCUDXl22hQJ4K5zbR934STm+cQ==
X-Received: by 2002:a05:6a00:9a1:b0:71e:1498:9ed8 with SMTP id d2e1a72fcca58-71e37ec22e2mr7297495b3a.7.1728687174894;
        Fri, 11 Oct 2024 15:52:54 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4d0760c7sm254472b3a.174.2024.10.11.15.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 15:52:53 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Judith Mendez <jm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bin Liu <b-liu@ti.com>,
 linux-serial@vger.kernel.org, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH RESEND 0/2] Misc OMAP GPIO/UART fixes
In-Reply-To: <20241011173356.870883-1-jm@ti.com>
References: <20241011173356.870883-1-jm@ti.com>
Date: Fri, 11 Oct 2024 15:52:52 -0700
Message-ID: <7hr08mw8u3.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Judith Mendez <jm@ti.com> writes:

> This patch series carries some miscellaneous
> OMAP driver fixes for GPIO and UART drivers.
>
> For GPIO, add gpio_enable and gpio_disable calls
> to gpio-omap which fixes an issue where if there
> is an irq storm, serial console is unresponsive.
>
> For UART, move pm_runtime_get_sync since the
> current order of omap_8250_rx_dma_flush and
> pm_runtime_get_sync calls are set in a way that
> when omap_8250_shutdown returns, dma->rx_running
> is set and this causes issues next time the UART
> is re-opened.

Could you summarize which OMAP platforms this was tested on?

Thanks,

Kevin
