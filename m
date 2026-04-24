Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C38357735
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020663; cv=pass; b=uUGYvVYYsK7wDzdfLSrNThm0Aaa7IJqSttbV8U6ISg4f+pegICAjXjKBtuziYGKzLNsZ9FusYM6yMQxHKmtrPob+JFl2eIDdy7a6MNKd8TzVJ61UbfwSqxjBVOpyCffSOYoMHzEJBGUHAxy/ShKuXSQaAkBdIvARyxKTUAjZ0k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020663; c=relaxed/simple;
	bh=fULNxiEb8ewDozWZ7wVgbDvqFQOPB1csfMaW1LC51/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ibWQzzVK5L80KmfDXAHGeIGqQso9AuE9kR2meRId/XEGAE9P4ACAMrhdFsdvL2ZpUl9WPxfoxrHJehkkyvzteas43kdgxJzLWlLl5LECT0j2D0gisv8awdDqm0dCaMXb3gdMuxgUlG5bbJ3RCnGLXfBlNMj+jdCoCojWv/JkZSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGAqK+2q; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGAqK+2q"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651b4d09141so10241286d50.1
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 01:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020661; cv=none;
        d=google.com; s=arc-20240605;
        b=i3JhL9xwaJUPgd9UDvkAxw/Lz/6uxTufJDxC8G9FcKoc93qxo0em3MvKkANMX2Pkmp
         JQ0zDDyyHOjZNfILKSi0LDY1Pg5K8cyw9FlzLj6AEOtKluabLbWLTFRgOuwN8HGacoxh
         kdNlNYyAoNOjC0BeXnglT7k33Q8cgFp/qQWtJ1aAR/7ptKvwzuMTmlmDIks7A+QaNln+
         /RxCYdwUAlPA7Ulwbdl3oY5eFJU2KJDoziD6dan/2XE7QytdrLEovb9lVvCKUXm5/mQ9
         LQnp0+ISJbvbqb8/XUm42IPPMv9BvE3JG0KMRuGuCEqUXGNPVlpt42SHSQCjDp3ENkB3
         yKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=HHGF3Q0AdvdA8fXH/S6yTywGaS6Rg3AgRr8vO+Wt8CQ=;
        fh=1UnE3vDGQnffQaFdP1FwIlmAnrVw4vzq7GAUeyDOCsg=;
        b=Kbp7cSrP9VFzUoZcJHeP/3V9Tc+WjUpc6rq67TNduBD3/qtOw56D4DhCgz3uHVd+vg
         bjXMbzr1JjCS4gEClzCc5LjmKbcbuex3cyr0Fwlj9VgT8O/6KyecaRp/ZCeJb5MhoKze
         cTHxehSJeKmgT4ClbSHLqQfJFESbcQA0305ZN7+6q4MA6uMbEyr7ZOiC7H1Mz++m1vih
         RvEFRKJWo9ylyqyWIvEgyVLnnRUylXNIFLc4G9DAiXOZpUS03DbTQIlE/si6SPlT3UHo
         1lK/gghzGkZSXoY6PLvWKp4rE5KlZAUJD5ebbvx78tmsipS3SHdMHJLLr70EqPIZs3+q
         XEew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020661; x=1777625461; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHGF3Q0AdvdA8fXH/S6yTywGaS6Rg3AgRr8vO+Wt8CQ=;
        b=hGAqK+2qavNJ0HRl0NVKUQ29YY9qYZRmFXCbtwrY+q68+vBKND+2Lk4cRFi/3Yfa5Z
         ybfT6zbKHqbncTKz2utSLoxhCVQhhklsqOihQ/6gPHX7nyaKyARscDNJeGXuwo49lZ3m
         ONbORLYYBehJ+NsQBVv069voU0wzCmB/FxFpLgxIadHgac/EcHCMdwFmKCBD4cTo8YCg
         sn5A2vCVc0hr6R/8pgHuVBt3NJtV3w79JkKEYv8GZyFFG7k7vJR9sNcGvqaMllve2c8A
         4cYm6ihb2CIsfO59BidfAUyx9K2dVpFnXQkfKYrs3QDpuRP16St6Om7M7LHwDCfNyi3M
         6ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020661; x=1777625461;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHGF3Q0AdvdA8fXH/S6yTywGaS6Rg3AgRr8vO+Wt8CQ=;
        b=NWxsBvNqY0Xi3Eru2upthMiikXMJv7OodQ0Dc4nbZS0fbOA+dKnskk5Twvuyupe/3l
         JZETlvnpG3RePMngBaPcha5bSybj5yabN1DVRGbbo6Y2rQ44sEh0TOPhN3LJ9mLOHKp/
         2mNmBNqhPXiSeGrAsYG+zO/pJRY1WoHeX0QkoSl7+ItvLLFDDLPUaXnQCSP7ACdSZkfx
         qlwlOFY73lA4HLakON0ah56hVOWdB8cyEAeIoO707+49f8hlkghZb4yHzzF9kvLQNu4T
         nDTy1hBIWYNKhTYPJUNTvb0ByVENSjzcAZM2/b0ACbueBn/cEbghqAWCds+bfG9nPy75
         jf7A==
X-Forwarded-Encrypted: i=1; AFNElJ/xehOrEx3Y84ycw36bxMRQqp8xmbaZfv3ldzmPqLpUIypTj50fVXMu/VCuPAFxTPP/J2euB/hqpNtPlA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhUm+VmvsJf5timN1rXuCubSEKNTYYUsqo616zT6sTIR7Sbqy
	JCjwfY0FJv2YQcAbwj+dqMCt6FgQD05cJCkkoVp7NimNQqU4jBSko79Fs9I05FWaM3VdDMeHmMc
	fO1E8/zNYfoLJ7sTz8GA3sD/7r7eUBPE=
X-Gm-Gg: AeBDievSTsA13uLTbTT1ldhr6GtCY8TFCeeHtVUa3kDlFIGxxsczG0d+U5GAQzTV15i
	MGY5MHlKtEwryakTG5YlERGmiTOiyslnmNoxiQyfQ3kwRZGD5wxid4jFWXS2IsBkB/xzmryHPvw
	Mw4455ETEBsW5Jh6ddsS4woX2HYL9Pp5iV9DAyyyEOk8vpzQ+P1hTbu+0DXcD7Eth8Dbsd5c7A8
	8478V4CkhwP2/Tr+6aut/bC6fyNb9cNlUaBWDnUMzBBjG8FESGBbEcrDzrhlta7NQV8lIPBwZHr
	nFcA0OBX2G/yzHsknMZz
X-Received: by 2002:a05:690e:1285:b0:653:3ecd:cc3b with SMTP id
 956f58d0204a3-6533ece04f5mr19178886d50.41.1777020661476; Fri, 24 Apr 2026
 01:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183756.3770073-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415183756.3770073-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:50:47 +0800
X-Gm-Features: AQROBzDtgAhZNJfwlnMiF1vQYDwYvJqJRfQ_cyqhdKjrZlvtK5jt5L-IBoJpUbk
Message-ID: <CANUHTR-QWCMb4=9ErGF5cdvz0TPPtUXLXTNCSijL5KsPpY4XkA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_boca: fix reference leak on failed device registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Guangshuo Li <lgs201920130244@gmail.com>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 02:38, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in boca_init(), the embedded
> struct device in boca_device has already been initialized by
> device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
>
>   boca_init()
>     -> platform_device_register(&boca_device)
>        -> device_initialize(&boca_device.dev)
>        -> setup_pdev_dma_masks(&boca_device)
>        -> platform_device_add(&boca_device)
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
>  drivers/tty/serial/8250/8250_boca.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_boca.c b/drivers/tty/serial/8250/8250_boca.c
> index a9b97c034653..70ea8e30ae80 100644
> --- a/drivers/tty/serial/8250/8250_boca.c
> +++ b/drivers/tty/serial/8250/8250_boca.c
> @@ -39,7 +39,13 @@ static struct platform_device boca_device = {
>
>  static int __init boca_init(void)
>  {
> -       return platform_device_register(&boca_device);
> +       int ret;
> +
> +       ret = platform_device_register(&boca_device);
> +       if (ret)
> +               platform_device_put(&boca_device);
> +
> +       return ret;
>  }
>
>  module_init(boca_init);
> --
> 2.43.0
>

After re-checking it, boca_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
