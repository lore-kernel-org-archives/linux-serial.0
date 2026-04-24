Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F702874FA
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020749; cv=pass; b=UMiXJUVbFekOGFjfoFYHHpX32GB1CeVNoazotmhq897YHHSChcVInOyA2x6eAvMUw50GkbYh+RxlA7aGQMi4FhPn1PX8Y8foPNolscWeY0OyDUCtceu29GX9P/9hWJWtL17UEUYd8vDjv8/y6ux+RZNCdiCBmjRXdXc1MuP77CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020749; c=relaxed/simple;
	bh=adhxGrFmQ7Gmbb/LyyV1MtkjnZG5hgDXkgv+V8iZuvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ItyBoUZb9rW/QtElhitBeHBQAN70vdhSm2nvxjqoW47QmHuJqgR3u3n1QDzfVlHiW9Cgl9dAvKsorYQIoGSbgr+U/U8PUElzHXp0nHPWsr6OIzta09dseSHniu5o1IDXdiCXY8xsvk/HgteLmFpzmQfYlPwCCmnQ7CP5hpzIctU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvs8sF6P; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvs8sF6P"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501547d7edso6982632d50.0
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 01:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020747; cv=none;
        d=google.com; s=arc-20240605;
        b=bCze+NI+JDYU0T1fcxcrRKUqxtJH7xLW3GPf8w8tZduLMmxw1j517vQO+LC0xsKl8V
         SXilhRFgjRBgUlURYRgDshBeYC1dYlgXqLJu3Qk8TBBpz1bhmRQXnLtmpwxGWmkS3ZbB
         PuihkhyFzAdLkXpvpjwOJUsRcQReIdT90JkiK8z2VJpTFSvfGR80/wQwpjsDVThLmmHi
         arMebTvjwW5+zxlYt6wpRpixE0wcR0b/HoRb0RkK83T8zS2GTsNe8/LTbZNQFW9gGC+E
         lRcZuZYUjeq6jrJ7hKaZ9sR6O2JabR+6DLO+zGtsCWg2tMaxQ4kYNU/8j9zltcRqa/KM
         ynQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=FE1KkqqVj8aQlCojRJ0XxXhQr9/V1vEASpdjR9JcsnM=;
        fh=wm0FED3PlWEh8t5iLC5mRqJjWK6rA+CaAFcMiv0VKH4=;
        b=f1KN3dUBswaqoGVWQvMVTIYY5Kq19bXsC+jVdBN8TYRj9iMnaaLVYflqtWB+cIr7aU
         qKIRCgW01FqBm3CBBAq5soiasmOxDE+5aen1rJ1RfN2OMd4+jimMVrf3LXBioMjkNdQI
         F1UU9U+3ZBCTh64dNHO+dg5kID2HIN6gSZra4qlKbqCucau+UqOjhq2OuWwOQMM4ci8a
         3o1m6QhxAbYFbNIaX/hssBBlxOcKU78g/Q52lZLp4WQRL7GzLTddwySxaGzzK1x6UfuU
         T96tpOXuDQOaGvX+UaKpKnSvuNa7GiQuiUGoSGwMujc/Y1AXOe4ex8063U6cBfi06Lbv
         zpmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020747; x=1777625547; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FE1KkqqVj8aQlCojRJ0XxXhQr9/V1vEASpdjR9JcsnM=;
        b=Gvs8sF6P2aM5zzFjBlYc4awA3MpLip+ZRTJ+cmG20MAMSGF/0j+fzioIPAMVuREwRF
         Nky6G/1kRMHnfR3hfTZUlpePb5uLfrC4oY4sARP246hiSlYdfHdkKB3bbyfg4LQij1Ji
         43lYf9plZDAXi3zxFwPCqHFy09tG9kfJ2cAsWCntl/jqMdFFzlQCFFQUaIgH15zIMg9Z
         lmIOH4DIDgcoRAajCxgTE/i8wKqkVrgo+gQuao2XGXYBoac9Tn+7W2I3q3QLH9dabFr2
         CJtcs5DUm6vvyz73q1304Bg9tCa+UDpo0eO87rbB3yWGXeqqyEHb5hTJw9f43yuqssRe
         zlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020747; x=1777625547;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE1KkqqVj8aQlCojRJ0XxXhQr9/V1vEASpdjR9JcsnM=;
        b=qogcJFDwrbupR+HmmijWEAvz/OzzxpwXgZOdJ/x2x7pWebyBZHCEAqS7VhaIbDbYck
         5rqyj6isWDZ3mxpKQMZsxbtgd9ds0DaDL56/N/JBTc3RYFe2UON8cvGImQBlFaTqilKa
         4s/CX+oe2/ULIlEasjhmzJhnjgluRLntMVTkjWuZDJbI2N/5h9ciYXHbILKhc/KHqCdL
         tVbLujI5himy2x6/I/Fk/XlVzOHF5um3NkADLOXXWdzT403vmcnv97XmHnp1B6KdsbKq
         J2nH8fPyYgTTmIgGeOsUMCNg0ADC+aqerCV0uGanZ954RuBmReST/u3XcTT5XX/T4ooN
         iS0g==
X-Forwarded-Encrypted: i=1; AFNElJ+tyAtoMf9W6k+MyUs7vv2MG0e3YYlB6ZEAHNjWWqdIMUWNiRtQUN2sx39mT83J5/gLbixYbPVlNy8t2Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0VfgERyBiF6SlxKK0QKa4yVP8zBUQiFKejZDHCAKwK508TFZ
	1EMtJYVmXxPjVdUqE4D+MAiOK0Kv4jRhuOeYoOTiStr4Y2tYU88gj7vcqXggNLkr2bNsEXYuOJw
	rPK0R3D5lIO2BZ8aD1vYdJn6yDasf4aQ=
X-Gm-Gg: AeBDietvkpUhuTV4vqtYx8gzNO9pi4Y37mebRgUv5CGcOKNDNphZ31PUkLLpOS5s9Rb
	U+aXB/B+ZuH0eRa0ShEpSs/1ddzrvwv3Dpfec4ULduzn4coc3x/JP8szS3kGalhGvuJ2GIgNrB/
	FFq815CBhFIHfujLEcipBr6mmkyqXrTj/KQOCZ14tq4kL4fZeiWW3z2xEHy664xJDLfrllDCejH
	emn1CROsJxAFavpgj+b1+zbX0lVN5gzmFsJR3GRbVvfFdXl5yv/wTKHEYBXPjKo4N9NrmaR65x0
	3XD1KzzmRTkRsWmfZhMM
X-Received: by 2002:a53:acd1:0:20b0:651:ba8b:a950 with SMTP id
 956f58d0204a3-65310b57b32mr23200290d50.60.1777020747070; Fri, 24 Apr 2026
 01:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415184032.3776292-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415184032.3776292-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:52:13 +0800
X-Gm-Features: AQROBzBkj4pl0bdCozMgtQV0phCtnPUCTED2bbuNK4MaKFWbfyEUKorSk1UBYFY
Message-ID: <CANUHTR_9NGoL0rQa5swdqaheauoU5s7TBCeaGDYgiZ6PW_ociw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_exar_st16c554: fix reference leak on failed
 device registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Guangshuo Li <lgs201920130244@gmail.com>, Paul B Schroeder <pschroeder@uplogix.com>, 
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 02:40, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in exar_init(), the embedded
> struct device in exar_device has already been initialized by
> device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
>
>   exar_init()
>     -> platform_device_register(&exar_device)
>        -> device_initialize(&exar_device.dev)
>        -> setup_pdev_dma_masks(&exar_device)
>        -> platform_device_add(&exar_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before returning the error.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: e0980dafa329d ("[PATCH] Exar quad port serial")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_exar_st16c554.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_exar_st16c554.c b/drivers/tty/serial/8250/8250_exar_st16c554.c
> index 933811ebfaac..b2c37f0c52aa 100644
> --- a/drivers/tty/serial/8250/8250_exar_st16c554.c
> +++ b/drivers/tty/serial/8250/8250_exar_st16c554.c
> @@ -30,7 +30,13 @@ static struct platform_device exar_device = {
>
>  static int __init exar_init(void)
>  {
> -       return platform_device_register(&exar_device);
> +       int ret;
> +
> +       ret = platform_device_register(&exar_device);
> +       if (ret)
> +               platform_device_put(&exar_device);
> +
> +       return ret;
>  }
>
>  module_init(exar_init);
> --
> 2.43.0
>

After re-checking it, exar_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
