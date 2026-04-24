Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2F344DA0
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777020588; cv=pass; b=mN2uJY975sCNWValW4Wp1CiqzPBpL1mmSck+Z/shST9ZGxtBUAcVJuwcP4f03WC/v58OX/COUTreL7d7Blib1VgaVPpPPNGZyMplrm4QgrvPaUnffhDr+J9VWIxvXQm5smtpzHs3rfca2nFZkF6y6QUi+pngQ+YsfEOTfRD0Zi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777020588; c=relaxed/simple;
	bh=bp4CHkwtHm/yNe5ftwnGy+F9/hm5CgtWKfBVgAu3/Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDgDMw8D1W0VUUlBb/ETHLvLYuWmG8yhGiEG59daOBXp4U6IkG7tndjT6xbonjY1MXf2S4s2wcAWirkPnfgk1YFQklKZMRRLMB74Mv9G1u4Ln2+IujZVFa+wmRZ+hBbbxNVRn/09ra5Mgo6a8B9m8zfcuzsxBaJ9l7QuwqlXreg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSReVLai; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSReVLai"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6530dd51ccaso6961486d50.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 01:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777020586; cv=none;
        d=google.com; s=arc-20240605;
        b=AixM/NXBWKZ8//HS/+0oFWOE8fJsl9dj17eXp/6+//ckKGUBbRcHLt10+e7Jeqpx2y
         tMCmhmitQlPQw6+vCx1o80ONrT45A4JqSmhJWl8mKqcYxWeOBtPegOn7KiMIQTyE/1Y9
         IhVYoTreYJnCscjZ3Aq+TgX9uB7nXjNXgofgaV4HbAL4/q/QKE4gxI6sz8yIN0DAkhK3
         9v4xDMgjW56X+HrTTm0T9m+ZysQN5vU1RburXscCieWmAtXlwY3teaMGi3QA9KNZbshd
         Fr8+PzG5cJrcXeGwIv7Yv9rynpwGIp22EpeS3SittylHAWK5Aen9ijyyImeBfZsXGxyO
         PBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GQehjiJmR0uqm/keJWoGWadsPstIT7+2ouE9/A7a4oo=;
        fh=0HcXq+ScGOpvakjViOIv2PzKdc8EujeWREM9Cm5kR8Q=;
        b=DvAKGpj5/B1Jsu/r+SXheJ49Em0w5fUirkkR28g7lndppjjTJLqEQj2eMV16WFGw7K
         duamcUBuY7At6HwAivuyDNZ38h4YToWUBRIkXdun0OxmjrI2O3hbKWs7evWEXVRcJM4K
         toG+MgSs+k5Qivjp8yeifa0Ujx1yXBXgAOB5TbAfcWpNWI5vxIU8uTYacNXrAT0ggGKh
         53GTM+bJxLIaWltEWGVdGRL4upUc7WuRSa9YBNZwbxz94n68SE3DRLiZ41kth0TNW36Y
         A//FzDn8HkfLhXcF3QiRX0FiNKqAWeNk6MtIHLaGWurzNEjwMyzL0QKSSniTdDImyhg4
         JsUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777020586; x=1777625386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GQehjiJmR0uqm/keJWoGWadsPstIT7+2ouE9/A7a4oo=;
        b=TSReVLaifvHXCBtS0r8EF1jVDnwKsC+mPkgaJi92LkvXmpxexxTFJkc/Lz6jxkoupZ
         wBF+R/BQwxxqEENUVWXs1PRt4dYTwLxhuy+4G345xvZVkKPTd2Z3kysErrU6+HfFydp8
         MKC38T0KAEHnqebkHyQ/wA0H/lCyoE8J0ti/39EkV10qNftsNa9xtXf1oMreaR6bmsH+
         3SGBNj4rrTVcUU3o0TrSiExl5fkNp7eyZuS/KSD2KTgywJwZDWiO9bdZZkwwNqmXdohN
         AGmEK2XOvAJuYAVjY64o4P+jmp+BtHXdu6IKhzc3rXSisgw82IXCP39Gd4k0f1Wzgjv7
         WEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777020586; x=1777625386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQehjiJmR0uqm/keJWoGWadsPstIT7+2ouE9/A7a4oo=;
        b=GPNDp4GG8ptadGQdI7Qg7YRb9kjBZkNGeLJQIMOAWAVlqPztqMUk7xsvSZRtbK67fx
         fmKpOwCLPx8C2deTJ8g9h1xP3JxaSkB2+rsLBQHAtInV/l4yHRJFzXNprSR29UFH0S/K
         UaQK0+mb1ZRsJOSvZ28wOLL6JaNmpdaUblQ518wpwV1xrv4kMMX9OMhO1svFflRCy4DN
         in5/imGpnZ+2uhwkg5NowlxUFe6sQUZO4Br1/4Sd2EQOiMyGIwCCR19rKa21rOx1awEc
         GThXAwC8mCQqIfMip95NE9nsfHGZAxNy9T/3yZxsNfa0MDnH2SZTeXppl82sYe9bJpDm
         FNXg==
X-Forwarded-Encrypted: i=1; AFNElJ8AfmwTmJTFVTJmAO4BcSSyQshMJTfm30jmaodY5QCkMpiv7X8aHznxrq4Uwob41UnGP19+TZvIfvDLoR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iRIpPiB33Wu8nXivuxOsoD1g+ZS4o5bP2T0Qz/9mG2PiUqER
	SxGclwd6FSlmq88gp7lUTphkEjG+cKaD3FTajM/PvvEKDIqkq15ms3LddSwgfyp8tS21KM+x0ZH
	p5kQzVt01EKfDVHUFE52QAK+v2MIa45Hi45zibz8=
X-Gm-Gg: AeBDieuLBVrO54aBX+DX+f0IJAU/K59Wjl6MggXOxBzNLw36rcVEbJt44eDfIixrS5a
	k08pbqqGjDAJnLkdPi1jwoP/8c6xe6CtlgHbtMXd8uJ6Zl6kKepynp9sFOi86TRVL9ZHA2ARcZY
	wB3yB1klJrRbslaDJucyXXKyTuptAGpnIjK+5BtLgvyyruD6ivnUf0vyVO1bnEOdL9fa8YUK+Ih
	uEeQqCRxUoAwb7C7YOEVXleNE0arU7gZ/CrI3wj6EnxxyOacmSnBQfCHP88kCkTfFzDvyjn1laS
	6ctIM2JeMEXcsqAiXEC+
X-Received: by 2002:a05:690e:b46:b0:654:5d65:9fe1 with SMTP id
 956f58d0204a3-6545d65a50emr8674290d50.8.1777020586306; Fri, 24 Apr 2026
 01:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183436.3763871-1-lgs201920130244@gmail.com> <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
In-Reply-To: <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:49:32 +0800
X-Gm-Features: AQROBzDc9asseH5Q--_xHnSI-mK1kVwpFsYPD_rv0VNAvdsqutw3hyErl1PRuZo
Message-ID: <CANUHTR-Oe3ztfvn-jUEarCKZa-74kmOQiNMQKtoiT58pCneaYg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_accent: fix reference leak on failed device registration
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jiri,

Please disregard this patch.

On Thu, 16 Apr 2026 at 14:14, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
> On 15. 04. 26, 20:34, Guangshuo Li wrote:
> > When platform_device_register() fails in accent_init(), the embedded
> > struct device in accent_device has already been initialized by
> > device_initialize(), but the failure path returns the error without
> > dropping the device reference for the current platform device:
> >
> >    accent_init()
> >      -> platform_device_register(&accent_device)
> >         -> device_initialize(&accent_device.dev)
> >         -> setup_pdev_dma_masks(&accent_device)
> >         -> platform_device_add(&accent_device)
> >
> > This leads to a reference leak when platform_device_register() fails.
>
> What reference exactly?
>
> > Fix this by calling platform_device_put() before returning the error.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
>
> How did you verify you did the right change?
>
> > Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/tty/serial/8250/8250_accent.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_accent.c b/drivers/tty/serial/8250/8250_accent.c
> > index 1691f1a57f89..e9cf40268c0e 100644
> > --- a/drivers/tty/serial/8250/8250_accent.c
> > +++ b/drivers/tty/serial/8250/8250_accent.c
> > @@ -25,7 +25,13 @@ static struct platform_device accent_device = {
> >
> >   static int __init accent_init(void)
> >   {
> > -     return platform_device_register(&accent_device);
> > +     int ret;
> > +
> > +     ret = platform_device_register(&accent_device);
> > +     if (ret)
> > +             platform_device_put(&accent_device);
>
> In particular, what does put_device() do on a static device, even
> initialized, ie. with no device::release? Try it...
>
> IMO, all the patches are bogus.
>
> thanks,
> --
> js
> suse labs

After re-checking it, accent_device is a static platform_device and it
does not provide a dev.release callback, so calling platform_device_put()
on the platform_device_register() failure path is not appropriate and can
trigger the missing release callback warning.

This falls into the same static platform_device pattern as the other
patches, so I will drop it.

Sorry for the noise.

Best regards,
Guangshuo Li
