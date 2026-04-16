Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01D92FF672;
	Thu, 16 Apr 2026 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320043; cv=none; b=e6S/xgNvs/px6QNyPABoShXo9AvHV1w6j99ZUZYF7mkIGyqaec0RxxuqtMT+sI7gpT2yvRERINcUDGlCxnLJZgnG493oKcMZRndLd90KVb9L1191YmbC2BQr51Hmb6xkuAskP5lR0zeAFQlDUL+/jaqKLjPBvLCljrWWjt6zJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320043; c=relaxed/simple;
	bh=O0qZsKmrGfbZpaWF12Ph+8auZdfeqxCWG+kcnD4cptg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcmp7HN9YZA4UT9X89sCkhH0mCHw/uo0A/gw6oeI2gVGsPbwXr6lgyyR1V0fnKfVnNPm8wr2dPso8Ya2wRlAgZD1tJz/smS0SAe3YWOKYTDGuOcs353Q1YQb9CF2EK+ppQ+8v2CorLlHuZGmBK0yhWaAy0Y370Tm0LCQiNd8kdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Kjqurt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Kjqurt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DF2C2BCAF;
	Thu, 16 Apr 2026 06:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776320043;
	bh=O0qZsKmrGfbZpaWF12Ph+8auZdfeqxCWG+kcnD4cptg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O4KjqurtHN+CmLcZgKvgbzwlRAzP/eup4XdcQlk+wi3kl+XMwYu72ptnYedXfnP/t
	 xoBrDj1A+qEv0Zzpoeq2L6QBjTV6CSolRyVVa+UhOLDxN0LIkCx5PTERMB7cxj4GTL
	 5ulSMnq5i15A4E5urGlSqy4vJzvJ1bTZ2CmIdijjzAEN9BOXrVQHyu8/d/imMquNZ1
	 ORvYtfsUbGtQila4kVoKRySN5ZCzAU874dhhhqUpt76LlJ+ikmzoc8QxTkuCvrLS76
	 k0gNtfnMXbZs2Lp+YowcM0EgP+1VJ851Pj3FMD0pzqw4zAV9tUjDv3a7sqSHDtr/xY
	 z/965mQod5n+A==
Message-ID: <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
Date: Thu, 16 Apr 2026 08:13:59 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_accent: fix reference leak on failed device
 registration
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Russell King <rmk@dyn-67.arm.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260415183436.3763871-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260415183436.3763871-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 15. 04. 26, 20:34, Guangshuo Li wrote:
> When platform_device_register() fails in accent_init(), the embedded
> struct device in accent_device has already been initialized by
> device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
> 
>    accent_init()
>      -> platform_device_register(&accent_device)
>         -> device_initialize(&accent_device.dev)
>         -> setup_pdev_dma_masks(&accent_device)
>         -> platform_device_add(&accent_device)
> 
> This leads to a reference leak when platform_device_register() fails.

What reference exactly?

> Fix this by calling platform_device_put() before returning the error.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.

How did you verify you did the right change?

> Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_accent.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_accent.c b/drivers/tty/serial/8250/8250_accent.c
> index 1691f1a57f89..e9cf40268c0e 100644
> --- a/drivers/tty/serial/8250/8250_accent.c
> +++ b/drivers/tty/serial/8250/8250_accent.c
> @@ -25,7 +25,13 @@ static struct platform_device accent_device = {
>   
>   static int __init accent_init(void)
>   {
> -	return platform_device_register(&accent_device);
> +	int ret;
> +
> +	ret = platform_device_register(&accent_device);
> +	if (ret)
> +		platform_device_put(&accent_device);

In particular, what does put_device() do on a static device, even 
initialized, ie. with no device::release? Try it...

IMO, all the patches are bogus.

thanks,
-- 
js
suse labs
