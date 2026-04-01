Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE228690;
	Wed,  1 Apr 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033911; cv=none; b=p04O2Xr7JxYMrMhu0YnAAiViJ4rKZ1zAEH2I2gYOgCdQ9LU64zKa/GuAunVMqysAGRmbfyj3ugRUzd9J1kVo5ohylvimzYnjvKy3FZWiB3LOdcFN8dst4QlnECx5kuPVIhz1N+LKUSuXoVzLG5+yfqEG9zlR6EwwV/6HEqXINt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033911; c=relaxed/simple;
	bh=Y8xpT6LVN6ZCuT/Jk5Me2F53eCiljn6T0UHuzsLdjX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTSoOB3y6nKDC3aXEigFao8IJCUCb058l1ITWg143vShtpfbZY2oXCbfeFwFEmOEA3Pxu6fGImZ2fC7RC+fGpu1H/FHrfOUSBezV4kBsPJnkMSvb7GChJiacdkGQCLAziaOREOGXOsm8QszeAcjeYoBYR2jxj3AErjOEHPodQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnxIphgd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnxIphgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB1CC4CEF7;
	Wed,  1 Apr 2026 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775033911;
	bh=Y8xpT6LVN6ZCuT/Jk5Me2F53eCiljn6T0UHuzsLdjX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NnxIphgdTq+dehfltVzb8J31L5N2kUTo+jv6salTOu9EDNLISbTS6zYd/tU2av5Fx
	 cHpvMKtqjFBmYZEYG281eaCtVQk/+1skh1P4orNb3cPT9gU38gOJ06zs5/wSa5KgbI
	 j9GI4zIs2Afi4rIaaMNXpsCVeqVRi9GGS4ggoN3Ww73yglUahsPpgG/+UKTeyQDzVv
	 NP6oesbX0QxIxxZXr7QiK+y6vMSzp5qWboiBm6StMPOt2ghAkDVI1wHVX2UhgTPuKq
	 lH0J3rQS/msHfsn9y2K9FgTh7x0nkrC5JUsjVJyVZf4Fm0fPF4+TMp0GLVZvZrNHIM
	 m9rHVIQVp6QWA==
Message-ID: <7eaf55fd-1ec9-4c30-877f-12961e8f9532@kernel.org>
Date: Wed, 1 Apr 2026 10:58:27 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] lib/fonts: Clean up Makefile
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: deller@gmx.de, gregkh@linuxfoundation.org, simona@ffwll.ch,
 sam@ravnborg.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20260327130431.59481-1-tzimmermann@suse.de>
 <20260327130431.59481-5-tzimmermann@suse.de>
 <CAMuHMdX1vUuKq-Q1-zA5tC5+LWap4osFJMqQ5pRJ373z++KQLQ@mail.gmail.com>
 <a2b5aa02-2566-409f-960d-4ecb1419cbd5@suse.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <a2b5aa02-2566-409f-960d-4ecb1419cbd5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01. 04. 26, 9:58, Thomas Zimmermann wrote:
>>> -font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
>>> -font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
>>> -font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
>>> -font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
>>> -font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
>>> -font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
>>> -font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
>>> -font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
>>> -font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
>>> -font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
>>> -font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
>>> -font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
>>> -font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
>>> -font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
>>> +# Built-in fonts
>>> +font-$(CONFIG_FONT_10x18)     += font_10x18.o
>>> +font-$(CONFIG_FONT_6x10)      += font_6x10.o
>>> +font-$(CONFIG_FONT_6x11)      += font_6x11.o
>>> +font-$(CONFIG_FONT_6x8)       += font_6x8.o
>>> +font-$(CONFIG_FONT_7x14)      += font_7x14.o
>>> +font-$(CONFIG_FONT_8x16)      += font_8x16.o
>>> +font-$(CONFIG_FONT_8x8)       += font_8x8.o
>> Please sort the anonymous entries by increasing font size.
> 
> Makes sense. I'll also leave a comment on the sorting order.

>>> +font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
>>> +font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o

I'd sort even the non-anonymous ^^.

thanks,
-- 
js
suse labs
