Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05418C914
	for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374572; cv=none; b=HeVEHoE192n8rc4aFG/PAik10BbzzDcJuzwXuZuhWVaWlJkVFcqzNLrH4uWSFEF6eSu29bHfneQzxB0YWPnYuOmShdeov6cbWz7NSSElc110TXTBplGw/w7E5Pe/ag7r+etVMAoxyIu3qWxCBpvNqBQLbh2/fTB+KHg717ANVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374572; c=relaxed/simple;
	bh=RCyXB4V21ndreCSUROM/QFnhUzJbb9FhaSwMhxqy5CA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KZWprCcGPCyn2moY7ivT70FgKQ88TZSwvxS2Qsouc8eqxK+XYD+V2srzfJ8MrLi64ns+VqxqIgHir1wcVBj8pD4XOD9BK3bzouLv0pFj5MmxyAcfqAo47pbgfIdTVZ8Tlol+UCoZ7iGUbivtURrayDO4ScPjqJ/W6v3zJVlNkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fiJfG0rQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fiJfG0rQ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3044954a12.2
        for <linux-serial@vger.kernel.org>; Tue, 30 Jul 2024 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722374570; x=1722979370; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSAZ/0e3vxufk97FChYubRiOc48MpM651wYXnibrJl4=;
        b=fiJfG0rQK5ZJjPeCqIIYiYsz5zUuBvo5BewcbowDxdKpy5PK8ye/vLh3T9eMY7pZ1J
         3F4QjwEyLelRB5BIpwroaAEec/p8S8lg5nuN9aM0EkHD0mLkND0DsQwL1J66/LVOgwOX
         DLpKcirBac3f5y6/iqu4FoO81wTZg0TGdNsE64MvsLsEjpT2VybXV6jDzfVUGsQanAWo
         0jSS5g4ES+EJ7qXZc075vS44StZZhpoc/wq0SGooaIzyT0GHAaUOes/ox5BGD5IfTroo
         G8/plgx2tdegUWNHW2ArI0r9N9XEnfLTed56RDeI60vsT+lB9FEobZ6mDiGLxL/xBIFQ
         D5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374570; x=1722979370;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSAZ/0e3vxufk97FChYubRiOc48MpM651wYXnibrJl4=;
        b=cf+slXkDvoqSOhUSK9hCdrBbdJyTwrQbv91sAc9eoEBSWXuv/OiVSPvEs1XiYxr70W
         5Bs4ZdFYzOpPv7DeA2Kftfmp1kvLOFg9DL6MYyusOPYV1WONqhFjAP39PvIOlOkB8pUO
         GQAnvBPAqol0BasJGE3/FbJY88FSBBUoidRr7H9e7X8ZQvSct74uyqCiprdRVGhkC6/a
         tB4M98GevqCP4p6oOsosMkkKAo6Db7kSf2tZj6JFJRJyQdPvSHSUfx9oSyfZM43BiN3v
         7nMOYRQexf0kmGUJ6X4r9zT7iSgm3PetssijFpIQ/+bD5yFp1N+yp+Q7HhWbNi6vvdVH
         XDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIuCof6Fga+2OAPzKxo/iMA/sufTu/XmRUvoNfpjHpJ2cDPxhAr8ZjpJYBI37LYpLhy7pcoxqhozWMFs3oDgsI0XDInBIPe/EAcggc
X-Gm-Message-State: AOJu0Yy02vF1W4VZEvgLOgcj41Ausu3s0WwsPhB8tvHBjyaXn/wx+mtG
	0IpxXKti8P4NMg4dsbtCd2McolWdZG6uNhtAcUq0byn+EUKe4dK3xdogf8CJPpw=
X-Google-Smtp-Source: AGHT+IH9bMw0hcFAvLIjZgRgjAbIFYieWwlgocGF3033Pqj4XUKk5VtAkzU1YoxPo9v4luCXtq6pAw==
X-Received: by 2002:a17:90a:468d:b0:2c9:7e80:6bc8 with SMTP id 98e67ed59e1d1-2cf7e71b37emr10000581a91.37.1722374570266;
        Tue, 30 Jul 2024 14:22:50 -0700 (PDT)
Received: from localhost (75-172-120-197.tukw.qwest.net. [75.172.120.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c9c764sm11119757a91.26.2024.07.30.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:22:49 -0700 (PDT)
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
Subject: Re: [PATCH 5/5] serial: 8250: omap: Set wakeup pinctrl on suspend
In-Reply-To: <20240523075819.1285554-6-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-6-msp@baylibre.com>
Date: Tue, 30 Jul 2024 14:22:49 -0700
Message-ID: <7hh6c660d2.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> To enable the serial driver and it's pin to be a wakeup source in
> suspend to ram states, select the wakeup pinctrl state on suspend and
> restore the default pinctrl state on resume.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

but with a minor nit below...

> ---
>  drivers/tty/serial/8250/8250_omap.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 617a421a1396..61f056c4e78e 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1663,6 +1663,13 @@ static int omap8250_suspend(struct device *dev)
>  	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>  	int err = 0;
>  
> +	err = omap8250_select_wakeup_pinctrl(dev, priv);
> +	if (err) {
> +		dev_err(dev, "Failed to select wakeup pinctrl, aborting suspend %pe\n",
> +			ERR_PTR(err));
> +		return err;
> +	}
> +
>  	serial8250_suspend_port(priv->line);
>  
>  	err = pm_runtime_resume_and_get(dev);
> @@ -1696,6 +1703,13 @@ static int omap8250_resume(struct device *dev)
>  	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>  	int err;
>  
> +	err = pinctrl_select_default_state(dev);
> +	if (err) {
> +		dev_err(dev, "Failed to select default pinctrl state on resume: %pe\n",
> +			ERR_PTR(err));
> +		return err;
> +	}

Shouldn't this bit should be at the end of this resume function?
Otherwise, if this fails, the UART could be left unusable, and if it's
the console UART, you wouldn't get any logs to know why.

>  	if (uart_console(&up->port) && console_suspend_enabled) {
>  		if (console_suspend_enabled) {
>  			err = pm_runtime_force_resume(dev);
> -- 
> 2.43.0

Kevin
