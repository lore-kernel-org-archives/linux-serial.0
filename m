Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9D3596E3
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020906; cv=pass; b=UUxhfP6AGpE91V7lW3AayZr1MNX7SqsTuvTD1D7mIkjxD9eX3X6LsWOIbekHCSHLrZDLxibSVcrigIJ/lCohR0P6FyqH8PvwNVGefDll9LWTgtZUwsOSA/gC6MTUaj5VKAy4MIfWp3LzuvWI8segZSezmMhryc8eJyEGGVZfg10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020906; c=relaxed/simple;
	bh=pVCOBmIN966fkKXuRySF7MUVwdvgja9tpANGCHqrwWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UTLqbwavqHnMNAO0Dgk2jDlq7R80wQA5ebCb8AeLWsXdmRoKPZYOAouZaRnwCcOOnE0FcmCKgyNfYNJWRjfsYbCTr2oPPPTdQ3IgMqhR9ZjzrhRO90/M61dZ4eJb3O711woCdeuOb7cHPr29q88NCKzjLsz34aB1X1jcDen/9oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaTB1sDK; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaTB1sDK"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6501418152cso7206919d50.0
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 01:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020904; cv=none;
        d=google.com; s=arc-20240605;
        b=GInnMH26lMtIwTAevWH88LiYumyf/cQ4hoH73besoEi6vGxGnL/xs1JyunqqcUIWVS
         2X+IsZlwuxo0AGuYGVfxNue4zwdNDXLspHV0OEJguk1UCUgU3BZTTVgGAa7Qfklbzi40
         S65Pch3JqKIjHXZRg9g/nQxp9h6JYVcj9olGed8n65Fdr8njJFM8M11WMelUeZ4qiG/h
         cl4WWwwzO0B2p6SXNjeKpc/3zvVSPG5kSgGiSFQ2AD4aNRkUxU71bwHXZKg3kQi2+bV1
         RrW0qlHOATU0xShCAcsH4YawF4cC79vFU/1+9dxe1LeshFVzXIxNgBvuM1QsJIntfNF0
         D1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=+W1/1r1GNJYFsiDgvIkORV3f2u50OQE8Jk0hUDGcOjQ=;
        fh=k7TwZ5yzv2hqZLgeyexDMhzvV2/HPETtkwbZT1mMRFw=;
        b=d4zq5GVyS3itfENmJu6NpDLZ89mY9V7w4dqco+OYqrmREWiuaBfBSU7Tr6h3Tq0sJU
         2EatQc3W/34frx/WfMPMgMW/yChjeSzETuBIKuKGluSRBYCVb+N4JpU2jmH1SmtJeRIy
         boMNqI2NpMuhfb8k/UDTuKyssJD9I1FRyLOEhl4PoJbg+okG4/KgABDBfOcSZ8hC4uIt
         Pry26zYtATin9Us9AbUw7VzPvMrkRo1uXO7A7uQ4moll/YwdwbpAyHG3kQ0oh2OqiBIV
         nmPgzhd0lhkw+CO5SUywrGU4XmbfDiFGp+2RWlp4Jjtr0AUBJ7Z9j16xfcw963Oid2pu
         d9zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020904; x=1777625704; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+W1/1r1GNJYFsiDgvIkORV3f2u50OQE8Jk0hUDGcOjQ=;
        b=UaTB1sDKWDgkC/y9LUFl41Ji7hNTHgvdYZ9BxskpYAANsse5HoNnv1soZ0t6AqPBtx
         NB+Ns2GF0hRmR13wvJ9x87QJi0syj/0Ul7y1Tnvx/2t7YAc+iPnh/IMzlPiEMd1/qxCe
         ixc+K4M+ZqzeE0rnODiCjqGO7rZpdkrKvRW7YUbpoCZn5f3Fne0A0x06LBHUAO4+SSaJ
         IcRdrOfQisaJroE/5A+LuzDCWqEY2xG2MipW5bs6rNjNHtwHNmKVeCvd4XDGS4IeerFg
         4exhpSKEI+XSqMXGGcQAyRZgCj3gj5/PIp3jXZDccectUWuLXvvddRMTfRRj0w91lTrz
         zWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020904; x=1777625704;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+W1/1r1GNJYFsiDgvIkORV3f2u50OQE8Jk0hUDGcOjQ=;
        b=XFltW4wIgCYZadHhVElVWl2XZC45r9NBwFuzcnJMR6Dl1uNfMBSqFicgyYj3XG0Sng
         dzJdCI1jYVDyzdHq5aXWbtC/1R7TB6Esd8hZRZWOf3XBp5RTh7iiC02TwMWLYEbGkL91
         L5srW6i4Kv5Tt1VFbUTPVORm39gvtraWHu8Jjhp8CtKc3uSQh0G3z9OgdG2/U50gmfZc
         ciC9qOIXL4RkshMzSayIsJqCrCjId2j+Y9t+WV7i0naWdE4XkYKQesOTd+WV/tIuHC1r
         GnMJxbIOsu5O+/3d4IyNE2rjR1kLzRtIoMTXO5rSzCmigjmQ0pMSs3e/rzUIZQfXNFzP
         Uc+A==
X-Forwarded-Encrypted: i=1; AFNElJ8+q/L/uDlYWjnl4bmrFN/UXAaoysPBAFpQwEljbRzxIijc5rAE2cWDSAd/YFOsYsQbCcZnkqsQdDL93wI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DRAKT1QNlLGuRcI8AhLU4VfbcHs4rBLjJarSaJ3BJd/EqVaq
	i8lgn7eW4xgoZAP/8zbLqgafJCTolrZQuqR0YNSAyoxAmXA+2RACZcEMypiq6yXs+dDJuM9Qdsl
	uoXSNlAnmTcpla8/cvPkLDO5jxCeT78Q=
X-Gm-Gg: AeBDiet/9tsIZUPY3BeUvr+JpoREH4zvOG7xaQudpcfhwmAewF8vpBtZ8eU79L2VMqF
	aG3h1D+HYJcX4GlqIh5H8h7yNmcjkOVNWLXDrqIWHnGPHob+AQ4cbxSSly1+QDje0WCAqq4+39h
	z7Cmt4LzPVD0C2sCQRFZUA86+diJbBSgHuwrWcfmifAZIULIDY90OxUF/p7y2XwEYdP/U9Ov6jj
	7X3iocVFrlWqA87xVNpjWa0JDhBLqxhBrtOJDJgy0s1mX/uX4aCUV6ledBzXr4x2cx/KLC8DOpV
	jdyyukcDKeTXolTHiMkz
X-Received: by 2002:a05:690e:144d:b0:654:2820:f657 with SMTP id
 956f58d0204a3-6542820fb41mr19074394d50.47.1777020904088; Fri, 24 Apr 2026
 01:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415185339.3804023-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415185339.3804023-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:54:49 +0800
X-Gm-Features: AQROBzAFHw522KkToySF-v_dWW0A2zzodzikBessm1lfGeBsvoGSShxmy7me7Uk
Message-ID: <CANUHTR_BDd9G4Lj96v9hsW89wiVeg0F+n3TQQrkhnudBGjte1g@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_hub6: fix reference leak on failed device registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Guangshuo Li <lgs201920130244@gmail.com>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 02:53, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in hub6_init(), the embedded
> struct device in hub6_device has already been initialized by
> device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
>
>   hub6_init()
>     -> platform_device_register(&hub6_device)
>        -> device_initialize(&hub6_device.dev)
>        -> setup_pdev_dma_masks(&hub6_device)
>        -> platform_device_add(&hub6_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before returning the error.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_hub6.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
> index 273f59b9bca5..005dd6bec3da 100644
> --- a/drivers/tty/serial/8250/8250_hub6.c
> +++ b/drivers/tty/serial/8250/8250_hub6.c
> @@ -43,9 +43,14 @@ static struct platform_device hub6_device = {
>
>  static int __init hub6_init(void)
>  {
> -       return platform_device_register(&hub6_device);
> -}
> +       int ret;
> +
> +       ret = platform_device_register(&hub6_device);
> +       if (ret)
> +               platform_device_put(&hub6_device);
>
> +       return ret;
> +}
>  module_init(hub6_init);
>
>  MODULE_AUTHOR("Russell King");
> --
> 2.43.0
>

After re-checking it, hub6_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
