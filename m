Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475FB14D421
	for <linux-serial@vger.kernel.org>; Thu,  1 Feb 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772111; cv=none; b=eu+9H9MrpiHzYq2r+8trwn7T85YgUWtd0Zr/Q0Yu+bylxvieI9y+4oSfCHtGNWb62lPBhJu+RGXlDeEomWyb8dJRn/xrtCtL8kgoE7ZJEHB5xsCmi5DXMQk2VSWLdOrbG7f/FeM6txwk/rB7lwFM4s9ODwT64TcSXQxvoW9rhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772111; c=relaxed/simple;
	bh=CrtTy660NpaBXlsv5vTQvnUbPNgBxTieZHC7VmqsoEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ox/KMwhS98AnleoPc6oi6NTU3glN4St7O33uBdZdiPnrEwudVeCso6I5cKWZGpGqpYw1Mejk3B0XBR5GQPmm5u2hhxScxYLVhhUnmK+j6ulNlSFlxpqrZ24Ol6p+/ieor18BKONtVyp9pKypiqI3aPwTgpLHZjYNsrr4gZSxqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso732528a12.0
        for <linux-serial@vger.kernel.org>; Wed, 31 Jan 2024 23:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706772107; x=1707376907;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsDZKbApnlA2dj+p9U4qkntJDZZ8OgdKFtyDfxWQtQc=;
        b=WUGSaf/y7TFo6SCwQ8ZebM7A0SnyIUREddYPUKT8sBv8qX95mL/kghyi5tTQ27L7J9
         PMCYCvRduFai0P6mCw/Atcsuul9aQALMFvOjmtjt5pwo76pUTDreEvEC9zr+Xdww7LfP
         beAp+pI2iheDwmyBHFovCEKQWGlYK4BH6idfz2sx4PiWtTUwYB6BGEAKG8cl7lK7DV9n
         X8FFvD/Hc+wuKLnOQRJqyUCkxEZGL0lnejD80/9ykJoYZyLT5fp5/ULEvlByiATGT8AS
         WK04sEpq7wR9sUY9uxsvSG640A5ofrXxYeIT91vAtWDaQVsvl3bHa2lZHxKGY1g0UuEQ
         pBGA==
X-Gm-Message-State: AOJu0YxcgtPzI9AppSpWQKPxa7SsyaUm3CKFMiMONWoYb94zuGjdAHTE
	a8LX6t67QstfXzkf36kkINU1/b679yVPv7fYE7Ig79Rzq9XzmtD61iz8LBTpo/0=
X-Google-Smtp-Source: AGHT+IFZjbxr2cJofMVlTOUkCIF0D0dvueGS96gzxjkAiqKk589qNwSLO6i2lSpZaO6635a2uLvAmQ==
X-Received: by 2002:a17:906:eb51:b0:a36:3c47:1a2e with SMTP id mc17-20020a170906eb5100b00a363c471a2emr2831331ejb.19.1706772107235;
        Wed, 31 Jan 2024 23:21:47 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id lz13-20020a170906fb0d00b00a317ca8b422sm5639448ejb.92.2024.01.31.23.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 23:21:46 -0800 (PST)
Message-ID: <2f1b1262-8c32-4dd5-8052-d47682c0b1f6@kernel.org>
Date: Thu, 1 Feb 2024 08:21:44 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: manage irq with spin_lock_irqsave in SiFive
 console
Content-Language: en-US
To: Andy Chiu <andy.chiu@sifive.com>, linux-serial@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 gregkh@linuxfoundation.org
Cc: paul.walmsley@sifive.com
References: <20240201065932.19899-1-andy.chiu@sifive.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240201065932.19899-1-andy.chiu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01. 02. 24, 7:59, Andy Chiu wrote:
> It is not safe to call spin_lock() with irq disabled on RT-linux.
> Instead, transfer the code segment to spin_lock_irqsave to make it work
> on both RT and non-RT linux.

Hi,

have you investigated what is protected by the local_irq_save() in 
there? The lock is not always taken, OTOH the interrupts are always 
disabled.

I believe the fix is not as easy as is presented below.

> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   drivers/tty/serial/sifive.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
> index fa4c9336924f..3f0ddf8bfa7b 100644
> --- a/drivers/tty/serial/sifive.c
> +++ b/drivers/tty/serial/sifive.c
> @@ -788,13 +788,12 @@ static void sifive_serial_console_write(struct console *co, const char *s,
>   	if (!ssp)
>   		return;
>   
> -	local_irq_save(flags);
>   	if (ssp->port.sysrq)
>   		locked = 0;
>   	else if (oops_in_progress)
> -		locked = spin_trylock(&ssp->port.lock);
> +		locked = spin_trylock_irqsave(&ssp->port.lock, flags);
>   	else
> -		spin_lock(&ssp->port.lock);
> +		spin_lock_irqsave(&ssp->port.lock, flags);
>   
>   	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
>   	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
> @@ -804,8 +803,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
>   	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
>   
>   	if (locked)
> -		spin_unlock(&ssp->port.lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&ssp->port.lock, flags);
>   }
>   
>   static int __init sifive_serial_console_setup(struct console *co, char *options)

-- 
js
suse labs

