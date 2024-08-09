Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713F2F41
	for <linux-serial@vger.kernel.org>; Fri,  9 Aug 2024 05:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723179645; cv=none; b=YoesBzs/8UgiGbJpQCtzgvz/PNdNNsmSJP6/SzafzMw4zono0F3zbLy/2hMNjAqzazz3ap4DjWfRYS34FOW4Im2zPQyQgCSPynpiE4n68DoWwN5hQvjUikHHCwLOj7uBh6HoyFKlzByNJCNixPlcmLtuvAzo8moRJn38vfvG2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723179645; c=relaxed/simple;
	bh=RS2Wisndf1M9xYYGRxVIJ/AZevEHZFxXqEiIIDtcods=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEY9N5efPjDc3/jAS1t3+TGGzCDZJhnVQVPtua5lN57B5qDmgAIftZugz5yW13NL6w4Wv/XstxwDeupNyX0SQsp7t8tnnlUc+uHwvZsEhuvBcVdlVQwrwGtH1w/4yMg+KKLZCas+VCmCZKn07WVlPIGxIvkYQ++7/TiIsbcqKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso2496041a12.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Aug 2024 22:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723179642; x=1723784442;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0LFJnbpMLPKGrI45RCTD6mALAQ0UmygCqa7l8GzeYs=;
        b=Z0yAZJgICIqcnNJODvRdwEj7tZbvimfTCZ+xuqhWpl+S0FwkuLSlIaMpCinJa/Ncqm
         7Yp2UlCPIT7LS01ciDU4wjJwMF0GWx1+OlpnuhKmkr8i0twTz4NrYy0QcEAbrLTm2IpV
         bKQjXZdX6HbtxS7Dk7Ylr5JXto8l68mnyYh+UVKdfXu0csqaqCMwjh6Z939dvTqvll0z
         Uovd6PnGJjDqI3GxzjqPoLs1Ff6LErvjm5m2TMVDWAzNAWHVkrQ5++KUijfRJXhvgWSW
         IBB5hVx3eOnOaq/vp1zg2LZY26rUSQIUvmMr8am7hortzxpGitNYzmYmo1IhdZyhDYim
         QIjw==
X-Forwarded-Encrypted: i=1; AJvYcCVQRtToutB9Q1+RIU53nt4FgNuqClyUIyCq5QhmAeuCwPqEXBMINu14kBo7VfQ1xLxf7LtvlLTs2i9ScAw6KJxp+meTYnFU0LoITapI
X-Gm-Message-State: AOJu0YyIxCbwSiLszdklbCrjDAS+GoAha3A942lk3say01JKgV6XQlx+
	zOJipOaBNpR5cR/fYAh99MlnXGvXekUoWBcdwzU2dl6sid60W3Ii
X-Google-Smtp-Source: AGHT+IFB79hExN6xEFeF4e77P4+CmywiUbT3mGLf4O190JkRjUp0cBj0TUREH63zCB65y91MDQYWSA==
X-Received: by 2002:a05:6402:90e:b0:5a2:5854:5a2f with SMTP id 4fb4d7f45d1cf-5bd0ab55a6fmr297780a12.10.1723179641607;
        Thu, 08 Aug 2024 22:00:41 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d34895sm1199266a12.62.2024.08.08.22.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 22:00:41 -0700 (PDT)
Message-ID: <5c10be62-3114-461f-88f2-c3042d6ba15f@kernel.org>
Date: Fri, 9 Aug 2024 07:00:40 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: sc16is7xx: fix copy-paste errors in
 EFR_SWFLOWx_BIT macros
To: Lech Perczak <lech.perczak@camlingroup.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>
References: <6bfb7abc-0264-440d-b0d6-6dd6a8b64b5e@camlingroup.com>
 <b792ee31-6e47-418a-9619-3937a38d3054@camlingroup.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <b792ee31-6e47-418a-9619-3937a38d3054@camlingroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 08. 24, 18:00, Lech Perczak wrote:
> Comments attached to bits 0 and 1 incorrectly referenced bits 2 and 3,
> which doesn't match the datasheet. Fix them
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> 
> Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>   drivers/tty/serial/sc16is7xx.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 8a2020f9930e..c9695a3fd193 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -280,10 +280,10 @@
>   						  *       XON1, XON2, XOFF1 and
>   						  *       XOFF2
>   						  */
> -#define SC16IS7XX_EFR_SWFLOW1_BIT	(1 << 1) /* SWFLOW bit 2 */
> -#define SC16IS7XX_EFR_SWFLOW0_BIT	(1 << 0) /* SWFLOW bit 3
> +#define SC16IS7XX_EFR_SWFLOW1_BIT	(1 << 1) /* SWFLOW bit 1 */
> +#define SC16IS7XX_EFR_SWFLOW0_BIT	(1 << 0) /* SWFLOW bit 0

Are the comments of any benefit here at all? It's clear what the macros 
are, right?

I'd only switch the macros to BIT() to make them more obvious.

>   						  *
> -						  * SWFLOW bits 3 & 2 table:
> +						  * SWFLOW bits 1 & 0 table:

This one is good, though.

thanks,
-- 
js
suse labs

