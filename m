Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B51B0113
	for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638351; cv=none; b=pridkieR6PYH8xDprH7tZU0djU0ViS1rL6dzkjcJBDzQYyEum0v7uMWbFUKEmh+dQWn/zj2GmVVZ6y845CzT96AqA3ZGr+xDNQZRxsCv9FXmbU6d5T4YtC+rNIErk32jklJuka3VCf3oMD+D9qmodJOfpR4UvUR8ax61H1G1TVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638351; c=relaxed/simple;
	bh=8tzPFbEsdwK4HI7ixI1tqw/hZg62rldk5tfi9WSp0ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLIFhdiVi0KZIs/ovJgPGu5V1diQD28oL5uQEi3GCXF/0f7Q1V9GwgP3cqJdhWixHctyPMod3ax76tt31XODimuNrj/lAU8PqluTwcbKKqJaau/1BtG1CLb/yRn4r66PqCapR67z5Pdn9i/9g0n5mBgw1o3swRbUZNJ+NSQOdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwJ68REh; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwJ68REh"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0878971aa9so696560276.0
        for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2024 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723638348; x=1724243148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9W+rcl3/x6n/YcRtLISn/hkiAh/kVAHqezbuzoZlzs=;
        b=mwJ68REhiGmJUmhReu+GK5KCZ+i+ixC64Tkb/llGgPP7S9owiV3/duxQD4/MhKx47/
         ccy53nUelVaw50ScPa/qnwshPVqZkxo1C841vHFDZSIW40pNjDa3CqisVuUgsIlsKDp0
         764bxJAnkPsNB/dq9cp92n/U8rQBdJjNtML+GXqzBpeprlDLnr64woCj/wyxydOjKxdg
         A+xYGYebmWHGdQlGRRZdSxoCOTuG1Jk7fI2WpB2ANlW7/vHU0OFyGBCo7GjjUsrA5OhP
         orjyX3Bv/UlQRfke241P76w6xj5Fw7wMgUEwVqTLj+VedkG+QinG5iJWE3J44/vPdWeJ
         HWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638348; x=1724243148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9W+rcl3/x6n/YcRtLISn/hkiAh/kVAHqezbuzoZlzs=;
        b=GF3C5F0DdLj4KBhv1jCowQ9mLXw52NfZIxQdFvSEx+RiiYkgik/kbM2AVJW9f6SeLP
         IMPKvbhYA2wSyNDfaifp92fxT4g8KZ83qXwuGB4ZIKwJTo2BA5DjWGk6vDjFQZXDNZsm
         nZgQbpMsv+fDjPjn8zkvR+V69gt/WdSIafFCYLsHT7kaZcGmh9/6euADMKXL12E3/gTN
         V3tXXrWTDmzPUKAhZIEzbyh6XdhhQ5L4G7j7YYjECRdDx4gHtZcvvjam+iP4YTUYrBAB
         YvpFsd0gQ/cmXsTR0jiUqz0nh5oOCOXa6sBbBc/cIk1YiQMjemXV7bxF8JvoN+Spjv8z
         xtNw==
X-Forwarded-Encrypted: i=1; AJvYcCXp2FFbkpobaabmsI89Tc0/Z7xz9Fd/FqXOyyAtxloT5eSA1gDZuUIeuwCeUscSLSde/4F7ICojIHF1+UxVPlEHx0+QCmtBTw7U7bfj
X-Gm-Message-State: AOJu0YymVreTuwbF0R5sXluOc7qlL1cW9jeN6aWLl6lBGcwZuQBcu7G/
	+J8zz/i0UNm/NfTxQEPojDFASe/pB37zWRD8Rr1gcHEcAIimbUBjtEawz8hy0Qzo+zzp1xJV9Gc
	C/g/7hHTUb57GGRo3C2qiJhQTU0aQ0sFg6pc+eA==
X-Google-Smtp-Source: AGHT+IG9s5zKEuElzdmu8nYTv+TuYXsEEzkAtXGAXraUgcr2mrfhNdPpz8+DdeopqaF18UtxfyTI7E1EKXrMGt7AwqI=
X-Received: by 2002:a25:d685:0:b0:e0b:f963:263e with SMTP id
 3f1490d57ef6-e1140cd0625mr5768707276.9.1723638348494; Wed, 14 Aug 2024
 05:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728114200.75559-6-wahrenst@gmx.net>
In-Reply-To: <20240728114200.75559-6-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 14:25:12 +0200
Message-ID: <CAPDyKFpNbrgLOrtofdR3s0hHvao3gt4+6C0Oj5_phrRYi=enCQ@mail.gmail.com>
Subject: Re: [PATCH V2 05/16] pmdomain: raspberrypi-power: set flag GENPD_FLAG_ACTIVE_WAKEUP
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Minas Harutyunyan <hminas@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, Peter Robinson <pbrobinson@gmail.com>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 13:47, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Set flag GENPD_FLAG_ACTIVE_WAKEUP to rpi_power genpd, then when a device
> is set as wakeup source using device_set_wakeup_enable, the power
> domain could be kept on to make sure the device could wakeup the system.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Patch 3 -> 5, applied for next to my pmdomain tree, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/raspberrypi-power.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/bcm/raspberrypi-power.c
> index fadedfc9c645..b87ea7adb7be 100644
> --- a/drivers/pmdomain/bcm/raspberrypi-power.c
> +++ b/drivers/pmdomain/bcm/raspberrypi-power.c
> @@ -91,6 +91,7 @@ static void rpi_common_init_power_domain(struct rpi_power_domains *rpi_domains,
>         dom->fw = rpi_domains->fw;
>
>         dom->base.name = name;
> +       dom->base.flags = GENPD_FLAG_ACTIVE_WAKEUP;
>         dom->base.power_on = rpi_domain_on;
>         dom->base.power_off = rpi_domain_off;
>
> --
> 2.34.1
>
>
