Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31312356DF
	for <linux-serial@vger.kernel.org>; Mon, 17 Mar 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214913; cv=none; b=OZ0pxBPItUKdk9+lfiOXR/SXV3WmvHGqt3aUSk1tK7q3WmpokVVSpVJy0+WAXb4ZUvn8H6GPUWdQXraRgVCSEfGOaMjn3w9D66CpO/ODPzSj0E14acX0HI1C+PqMjFlXsnEjcS/f//jNg6tRtwlW74dlD/Y8iwe6IBPl0OghTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214913; c=relaxed/simple;
	bh=2hhxamJKnEYjgJz9HCPDDBlgMOFyLWxFx7AWrATtYGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zn3QQ5WghQwBHOOGzsmidAMMPI46Yw7TFCp1u/ryKAsw1K3Zc6fej31HkoukVptZ/etfh24vGqVSwGJX5MLs/U/CBJy8Y65gsgDsebiHPWO2wE3kjSV2PG1wZronHlzNv+ZB+QmFNz2f0+C9bWj/9cO5B+oJysLJQzzlLeb9HQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pIZGW+XJ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pIZGW+XJ"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d442a77a03so12563415ab.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Mar 2025 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742214910; x=1742819710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00q0lF62iZBDilWeDRlriXLySeQsOfJjRaqFJoh5fG8=;
        b=pIZGW+XJ4VqSFbjZZGvFywgqNL4kFFLYFcRiVic2bcsVQ9hL9veUgvadJQa8sAJcJ/
         f1JM69T/LRwhYG2IXBjfLB4vZeFPOA0vldvKt7JZZeQ3nyyIokso0B6yoEo5YXULxmyd
         c0K1lLXrNXDg7zRtibLpcJRGfmD7svm2CYHKxvKfNyp6DYsF2a44dbK35MycfMDds2yv
         Iou9GM7zdXOtE9YN04atY1BUoMuu8ukuGPLy1QcIn3zVFlnAPMDOdtp/0dtke8GGOix8
         9R70Qpmr6/RCo1nLOIK0u3NdKhdNWs8fr8aEQnHVLDyOL8uYxkTG9/vZEqnhSspfv9/b
         8azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742214910; x=1742819710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00q0lF62iZBDilWeDRlriXLySeQsOfJjRaqFJoh5fG8=;
        b=EEgkD39A3vDwHVXKMYy0DhwBTcoU+WOo1/QjOVRYvaXbLe1KN6oCaceFemMGNgpUUs
         CHzl+w32vmaCex1slBBw8E3Dp0IS96796Hj4RmQt4ZCuRSQaJk5mnuaecRhI+L/kzwbI
         wP8cHM5mQxTlY8IIlQnVRDHa9DRGVm716jBBvBeGvoCGSPeH1AvHVf9UTtQRpHMI/SCA
         rhKofWkr/vS3gAz+fYz4DRVd7ZM1ua5I1nraMT9YCpxnmcLdga2fUnSirIHPA0HNSHKK
         VzlEaU208FmLon27EmFTJttLDzljc8TARJN6eHtWWCHnPlxLerGiGXzV0k8MvQ28IZ80
         Ed8Q==
X-Gm-Message-State: AOJu0YwAWrN7pgvCpac50fonma5Ru2tAO1yXFsEIi5j3zcEqJ+blPfZ5
	nZJ5FgtUyQdcDnEYlMmYHAJ02giFMNav180ugmAtGNHgNWP/0MEu2bRD8/fIIT4=
X-Gm-Gg: ASbGncv3sY2P8vYHI/4O+bjbUGI9jtuXrb9zFLWJ5f7Nmq6oWc8nMWNZjIB8HJKLmBI
	H0k9EFAmafGvz6iPGIlUMi9DlvhCj5TKFHIp7EXIEtCKgAAXXbAT12c6PwdVVM2uWqEB3xYSLJA
	Ciy5+f6GBHqElQIYOPpy4akRK0IkSusH1s0hAJ1Eg2cG1ww7yVK1q4m3tGmvsOqphv3+MnqAgai
	KYmoBUdVb8lyZuNp2OybpTX2I1i1Fl4R3eW62eXD+Zj64XRXLqqLSQmd2HWlZFNCwC+lfIXuB5o
	M36MW42qtiUBAM2LWvL+nHnd12ePpZy58PpKT7Pmc7P87YUZJC7aV+4KG04RsYnLU17uUvPmZVT
	E+GBWMw+z
X-Google-Smtp-Source: AGHT+IHVpD7/mZoav16FzU6IphNyJrgQsnIiWZ2iM1qY0DQdugl/0lXuxuk7bx2DwfBAOuvC4HPD+Q==
X-Received: by 2002:a05:6e02:1a26:b0:3d3:f64a:38b9 with SMTP id e9e14a558f8ab-3d483a63552mr114188275ab.15.1742214909989;
        Mon, 17 Mar 2025 05:35:09 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a83817dsm26967285ab.61.2025.03.17.05.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:35:09 -0700 (PDT)
Message-ID: <abdaa38e-77e4-435e-94c4-91bc24b49b02@riscstar.com>
Date: Mon, 17 Mar 2025 07:35:08 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/31] tty: staging/greybus: pass tty_driver flags to
 tty_alloc_driver()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, David Lin <dtwlin@gmail.com>,
 Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev
References: <20250317070046.24386-1-jirislaby@kernel.org>
 <20250317070046.24386-23-jirislaby@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250317070046.24386-23-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 2:00 AM, Jiri Slaby (SUSE) wrote:
> tty_alloc_driver() is supposed to receive tty driver flags.

Looks like tty_alloc_driver() doesn't directly depend on the
two flags passed in this case, but this corrects the code.

Looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Acked-by: Johan Hovold <johan@kernel.org>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: linux-staging@lists.linux.dev
> ---
>   drivers/staging/greybus/uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index 8eab94cb06fa..308ed1ca9947 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -948,7 +948,8 @@ static int gb_tty_init(void)
>   {
>   	int retval = 0;
>   
> -	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, 0);
> +	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, TTY_DRIVER_REAL_RAW |
> +					 TTY_DRIVER_DYNAMIC_DEV);
>   	if (IS_ERR(gb_tty_driver)) {
>   		pr_err("Can not allocate tty driver\n");
>   		retval = -ENOMEM;
> @@ -961,7 +962,6 @@ static int gb_tty_init(void)
>   	gb_tty_driver->minor_start = 0;
>   	gb_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
>   	gb_tty_driver->subtype = SERIAL_TYPE_NORMAL;
> -	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>   	gb_tty_driver->init_termios = tty_std_termios;
>   	gb_tty_driver->init_termios.c_cflag = B9600 | CS8 |
>   		CREAD | HUPCL | CLOCAL;

