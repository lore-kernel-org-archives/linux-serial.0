Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659D3596E3
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020835; cv=pass; b=D9yw4mNMGHE28+8hphzeeq5wlHXtrxOZmlgdJOruQ4DxFeYGze/khZFvgr6gOGP8B+Z2ETSBHXhMyJeA1vZp75K6LWO+ifC1WaxSyYqVex//agoX1Mvs1i2bifkEz2O3maIqYbrWFgBqg1ZJgU4Fr8rvq/wdnig4kXbWDMFr2Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020835; c=relaxed/simple;
	bh=03xMsqqyaWqJ0+5XzJF77FyfslQyAIC6yi8Rq8AsH1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pFzIWv56o0FgxiBhOkwg4KpIRVABXt7+RGY1gWnzYA0Gn3+EMCf3iqO0Jrq7sSVW7XZRQUmJ28wfmP8sOa/T5Lxmr5lLpolepUqIprHJbPXy8h3635w1In+/A91PbHPUtzivq1xMT6JuanBaMkzLTdCT6omm1rpKyYOWoiG3kng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxWR0Xd5; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxWR0Xd5"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ea87af213so121842447b3.0
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 01:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020833; cv=none;
        d=google.com; s=arc-20240605;
        b=Vmw8noJRF5UlzsHeSR5nDeZWwOfCe7n582lY/cVVu6U1rMVu9VKPKSyVvhmuisUwLc
         GK+XS4+0EH25WyeJOa4yxWtHMN81lMp/wCe7AUM8dXn1yIeGY/fQP0vC2SwY5KR0KIWN
         eQtD/WtSTu9psxDIYtgdHYq/Or3xLW9X3WJ0rNplrg9BUfT942N9sdEhP2CjMT1Yjm73
         /t4Ft/atvYGeEWLp8FIN08VcfheTbpBIrfkzk7cJPrIJAI8XSzQBUV1Y5SO0zkJaNVNV
         3W8X2vhFcelyESdniPRqEPlh+hqAjBfxwPDZZ/417XM+PqKaBxfbB/jbSPhXelgcpY2k
         Fisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=PbGOhMSZqO7dOzVDV97vevpCJxbqyhSKXtY9DHU4Dz4=;
        fh=WC37Fn3A0Tt8HHq4XtByaFchWmpThVXVUAdTBMZLPqM=;
        b=eQNTI/pryZMRVzIlIzZjF/Yyky8XKnNeAeCawcfDTxTUYkF6i0C//GAr5LUTqpLLjP
         rY+ZnTvZ0eVz6CBFyRRRyM3p2dWPRWhfBQYgUo70DNKGh9LSTLA12fTJu58SmCcPzz7p
         JeduuKlntHK3bVAkPiHFg9qfCEcTbz3j8c5HNgVzgl+bn2X2b7lyOECsmPnzjZBlrjaC
         yois3URhwyhxzWaXQkHUjwqo1+ZRj+Ef2QPRPPGm0QzshQFVAd8VSZsb4P0teClKYWiv
         APNPR04agHTUs5GSDn/G53qsCbDojG2TvWTSO/NFq/d/sHAvWniPII6FEJnB5cfyuAAu
         97KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020833; x=1777625633; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbGOhMSZqO7dOzVDV97vevpCJxbqyhSKXtY9DHU4Dz4=;
        b=XxWR0Xd5se2XBrS/cmjubIw7RQdVNv5EDMWZniPrtx17WPouViLpQYxWa7g/sMKVYb
         z5sk9itWgAtx6aCWTD8g47rfNiOdg4r7AowcW3liKUEzYFUkhr18gCILieMsiK5Eh1m9
         XjDrrd+61tgfNlJEqpHZZd/+xDeqpbfDm0b8cE7cm64KaVrR3r7SNUBZp18JsKe2XEcx
         BbByhEj90wGWax30xEp8UwtfXjWXpx4MDctF5CEppCqe5nxWhFITRBYWe/EhJL3EaxRZ
         RlXi+5EAvbNbO1UaW9QKmeVRfwcT+Y0lVyr/94EcxfZ1+XYSV+vp4L3B3aWMoM3zzLkH
         OxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020833; x=1777625633;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbGOhMSZqO7dOzVDV97vevpCJxbqyhSKXtY9DHU4Dz4=;
        b=h9lPxo9qvMo0zh/cfjqPiN+nYLe/9QSpsi/DVkiGgvs4A+RB/FootyAnkeVl9yidtE
         BzHLruvNkuzd3oiEhUqrU5FbsI3gzJLVBrPbGF1qsPCxv1SAEXotx6oyu2gkO8cGU3Rt
         uw6p6iVvq2Ro1Db/yLih9fidKqSRzRkbI0p1+RRlIbrdYBHvt6VA7fIssCcQVpJ6xXZ+
         APCOVuBWbvAaUZBrqTHciiLjE4UKJXoqg0/tTM9E/eoe1uc6uJ4gEnr33zwcEc03tzSr
         axQ5KiRbvrsfEXVgTbrV3BRxPwdCS0l/i6ShKNxM8ZdEwAGOJY2v+QSHWQA37HV7l6F4
         /yjw==
X-Forwarded-Encrypted: i=1; AFNElJ/SJLa5dKunMuH0AoBYTx6EHWdBmOAQUsxu2OMo3aT3oykCwNZcxPm4iK+KwWBdtjxirRauriWP/UFA7RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKhL9JzBRluRQ6E1EC4udxTFrFxkyQqcolWEgYmar5G2D6dN7M
	I+N8YjA0PmtJafFNylGjOJMTTA2gzT+MYw1JWU1cKjR6y3vWLQFWibseBHnuqujl6iqs6kZPVMh
	XONhGVWUMFrSq1Uqe0TN18RV2vFu+tSo=
X-Gm-Gg: AeBDievYeH5zWnYY1ZK6n3gZBW2VvaQEs0ovsCyTDLM79cv+pNuhLCPiNbwCoF6RkIb
	d8iv6xFT5rfNk1PP3LuZ5gpQ83Ea8rELC0/sUUqjrNEQAM6KASXIej8QJQ654cXZoTZafOqRhDT
	Sd0tOs+hzrGumFDl8cdnFOe6fZqQ5ROEaAkYXu9l7aBjMiIgNWh5kHR/6F6MOQvENkdDo42kW0M
	0/NLGSbOv4p/3+dDdaUskp7R5uz+bdMn6SA7A4AEX3I3FvuLVEl2sViupJweM/3oeWt5fx7mgFX
	MA/ihpxOXc7qZ1DjFMKQ
X-Received: by 2002:a05:690e:b4f:b0:651:878b:d819 with SMTP id
 956f58d0204a3-65311aa2284mr21735444d50.17.1777020833458; Fri, 24 Apr 2026
 01:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415184839.3796326-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415184839.3796326-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:53:39 +0800
X-Gm-Features: AQROBzAdNSnJ2dpURFLzjX9uN2r_bB4Ew24iin-mkrxk7EKCbEPArNhqVZKwoNM
Message-ID: <CANUHTR_MEMfzCq0XuVt4wBtL7ND+q5Wx5OE7eYa9xnvipLLrqw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_fourport: fix reference leak on failed
 device registration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Guangshuo Li <lgs201920130244@gmail.com>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 02:48, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in fourport_init(), the embedded
> struct device in fourport_device has already been initialized by
> device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
>
>   fourport_init()
>     -> platform_device_register(&fourport_device)
>        -> device_initialize(&fourport_device.dev)
>        -> setup_pdev_dma_masks(&fourport_device)
>        -> platform_device_add(&fourport_device)
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
>  drivers/tty/serial/8250/8250_fourport.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_fourport.c b/drivers/tty/serial/8250/8250_fourport.c
> index 3215b9b7afde..a65bc7316655 100644
> --- a/drivers/tty/serial/8250/8250_fourport.c
> +++ b/drivers/tty/serial/8250/8250_fourport.c
> @@ -34,7 +34,13 @@ static struct platform_device fourport_device = {
>
>  static int __init fourport_init(void)
>  {
> -       return platform_device_register(&fourport_device);
> +       int ret;
> +
> +       ret = platform_device_register(&fourport_device);
> +       if (ret)
> +               platform_device_put(&fourport_device);
> +
> +       return ret;
>  }
>
>  module_init(fourport_init);
> --
> 2.43.0
>

After re-checking it, fourport_device is a static platform_device and it
does not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
