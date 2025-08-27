Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C64301473
	for <linux-serial@vger.kernel.org>; Wed, 27 Aug 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294900; cv=none; b=QaX+kRqMIP8CNyp6QIVCPI0Wa4NOcJAdXbv9MTpZT29Ria/RYcfB7IcMXH6cgbQYaLTAnYUyh6m7dE0T+3ca1fEhSe8aNhF5/zBsHwqtX0PZmzjrZ/OoNHqEKsr+Th3sgo2wcudfESZM/GUbAKXaEIRrE/qmOJRO5CRlXwbEtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294900; c=relaxed/simple;
	bh=o+saMPd6JTK42Lj4xU6VI14af2qrH3H/yY3IsOVZgWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIf3KOJg3wYnUsV6ltOyNAni1/3XhMNVPbuMqsiLuWi5Ht0iDt/sznn8GpVanMCd9MJKANh4SsPV0LsgZYNt+94j81ZIC2T0wcXS1UnQH/H6PMT/EGtUOFfu0hNgaR6hqxAt7rFznxSzTVEr1mi8FZgy/oZn27CDWb/PrJDPeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RLWox7CS; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLWox7CS"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74542b1b2bcso302034a34.3
        for <linux-serial@vger.kernel.org>; Wed, 27 Aug 2025 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756294898; x=1756899698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3FLL1am8JkhfJR2LRNu+sWDRKJqjQgg5H9U00XtTUI=;
        b=RLWox7CSw4yzbwvSO5IYtSIfZQSWJW3l4AUEghSI/5ALA8loknsI3fkr2sfSsNhT35
         cBMlj49W8CHnjFgjrmeg6dF4sH7jmfeBuRswCfxpCfOkXi8fsS/Kb48v7ZawLvJRo/lL
         Dy/7c2P6pJ8oblh3mX8zc6/cVxXtdQ/F+cvXvKgX+JDI0qkEI8eYP7JY2WMx8boiGbLj
         GrCBzSbv2+Z9PvYyPcT6dkN1kuKQqkPTsEQ7ebOstGAtEBajmnz+0sxAFLdxFVDjnr+U
         oHhqAolWyxgq+8JApLHnHLwFlZDikZ3MHZpJPRFMezuIp1/lkYFTVzRQQZ0364iUwMvs
         UG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294898; x=1756899698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3FLL1am8JkhfJR2LRNu+sWDRKJqjQgg5H9U00XtTUI=;
        b=AFK4x+pg307f7ErDASlIYrC30fdDrtV2oNJZgyTWn20XxW/tDm4qB5j6BCi2OzD88v
         4Bu3t0Eli8D7zb4UqTDWgA8SGtAt7akgnU2fQlkHO4mnhjYDDw3xg+VVqDYdwmVAKAjq
         hdeJqJTk4BaGNbXsRFYefFlCXk5T5FyiQ80uOi5aeghYU+5mOvCkwrfEsFusIQgOPRPV
         DW4xGQBSQuixzSRMkPsf1ctFM9eidIrP7spKRYPbWLFTSgVFyYM3wSMeP8wG1teqeEHd
         I6+3LvCbbpK7GZJXnS7bSF/KzXwkEKg06lmouV8RMjh9GWGT1PallDaZqh4d83KFbXzi
         A4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ga7naEfgjN6uYumVqO3CftlVd09g9PllazojupdLPF3gFV+LKwQo3HLgCr8yxFAh2IQ2mjcYPLWSdTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztzFd1rmW2nHdC+ccD8rcWyfjRpdjsCQDzFB0/ovXS4lrQJWxA
	59vMNEK0y1lc6nSYpYsm7P8XJNmygM/tvMNMtaG1Cg5b5gvm6eP5cAtdvofT0drahhtYuYKERPa
	L0uuO1t70JBU56z689LHZD2JzlUyV3JTOrKirVQooKKpbEwSoea/F
X-Gm-Gg: ASbGncuYTnEVwoQbXq85l2nwoyw0LOG23WUKcsC4GkIWsERAgO6cQIW8a5zUlbpq9Uo
	syfI9UYlFFAR9cTm9jaReMGwG0/kG6q6m/s+cztAzzg4VIiwSP4DeDxf1250CwY7Xs7W6PgwUgl
	lSryHsbN3+3ju3BMwt8zPQf0i1ZgMDLtc32Zh8CZsX4vLOaYMSDCgdYbtnjcmJ/pijwTtr6jh3Y
	hZmEz4=
X-Google-Smtp-Source: AGHT+IGJo6FTi6F/n3ItkZ0Xdl8Z3sFRiLTQaDB0ezZp0GYMOSDBOqgG7Yse1giNuoEl4NICfwf7Vh67Mj6+WaPkSyA=
X-Received: by 2002:a05:690c:6704:b0:721:391d:8ede with SMTP id
 00721157ae682-721391d9f27mr53538057b3.23.1756294590842; Wed, 27 Aug 2025
 04:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827101747.928265-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827101747.928265-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Aug 2025 13:35:54 +0200
X-Gm-Features: Ac12FXyTbgjjBJeT1fnr3vCpCnEUgStrxaU2c_luIHFHEO39_lUM5OYykCs5WaM
Message-ID: <CAPDyKFpTb9H5i9J0zSrGu5-7evDf4Eay-NJqTmVBy6SyCoWnPg@mail.gmail.com>
Subject: Re: [PATCH] serdev: Drop dev_pm_domain_detach() call
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: robh@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	rafael@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 12:17, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Starting with commit f99508074e78 ("PM: domains: Detach on
> device_unbind_cleanup()"), there is no longer a need to call
> dev_pm_domain_detach() in the bus remove function. The
> device_unbind_cleanup() function now handles this to avoid
> invoking devres cleanup handlers while the PM domain is
> powered off, which could otherwise lead to failures as
> described in the above-mentioned commit.
>
> Drop the explicit dev_pm_domain_detach() call and rely instead
> on the flags passed to dev_pm_domain_attach() to power off the
> domain.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/tty/serdev/core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index d16c207a1a9b..b33e708cb245 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -399,15 +399,12 @@ static int serdev_drv_probe(struct device *dev)
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
>         int ret;
>
> -       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
> +       ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
> +                                       PD_FLAG_DETACH_POWER_OFF);
>         if (ret)
>                 return ret;
>
> -       ret = sdrv->probe(to_serdev_device(dev));
> -       if (ret)
> -               dev_pm_domain_detach(dev, true);
> -
> -       return ret;
> +       return sdrv->probe(to_serdev_device(dev));
>  }
>
>  static void serdev_drv_remove(struct device *dev)
> @@ -415,8 +412,6 @@ static void serdev_drv_remove(struct device *dev)
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
>         if (sdrv->remove)
>                 sdrv->remove(to_serdev_device(dev));
> -
> -       dev_pm_domain_detach(dev, true);
>  }
>
>  static const struct bus_type serdev_bus_type = {
> --
> 2.43.0
>
