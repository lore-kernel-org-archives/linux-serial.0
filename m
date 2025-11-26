Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCBD33C194
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176565; cv=none; b=JTpbs9tT3qpuLieKaY7U0FAm05CdbL/R3RgSj4eWqh+mFR5L+d84yVBAkIQn+DwauUih3oZW0nQ7tpURSnVgSmhRGB5CWuEPCr8Rd7BpmGe50cZLljCgkIoe7MstPJQUB0XPtgB2pf0v7ijIfyyldc7BjfPVVMu9iM1LeF7mQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176565; c=relaxed/simple;
	bh=pojbRHa/fXbLAisXZsdgXtXvmCWXBtB85ke7LMbIbfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0eiFQUxwfOAoL7ZJa4GmmOLxONavar14kIUle/mR/nDIJeSlbQ+5RrC4SxxBzdAehDX9xHptPikn1imztisGHE3Zrg8mMgc37VtRhIT18+f/Io0XlW7mLjmF5trQmiDmUYUWPOhTl1awMgp9I4TFLavOprmMKSSHArRfqqpVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHIoQCKe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHIoQCKe"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so7787142a91.3
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764176563; x=1764781363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DBtF9PuNDom/r/Q/1nI+GCLUM9qtySen8pmJzpCyHPw=;
        b=FHIoQCKeUOdr+jso0ekICIDDosS4C3aF2XRUM1Dc/k4if1nDrxplgiH2+q/XAssLQX
         +vD7aTTOwwQ+lVpIVgU7i8aQqnpDRaaGqe5lrLMynKtdCUeYiLjVk6V/wxd61ZmXcilQ
         /aNjatlTLkqA/CuQ45hwvE+FVoUCjLf1VLfpx4e9c6vWO6ukSgbMacp2og7f807p1/Ny
         BESprssbuQd6za8q27Gtq/U18wBk8m232jqlzduf2Tt1NSfsq7FS8a3b93UsftLkQQeK
         pTGlh81qQ0AKOBGvZaUmUBCrviBHISDNGeEmjFk6hgELk2uEV0XCka0LDdrWgElaqZF0
         MU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764176563; x=1764781363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBtF9PuNDom/r/Q/1nI+GCLUM9qtySen8pmJzpCyHPw=;
        b=Kk/qg8+pCNfWkjb/FfVyMDw8JRTJyjy2or9yl+xETWVSsbgfN6fv40LB6xkQHoIZGH
         iaEWdS4CKwYd7BWutdFkz3jmcQTYpPem3MefMfMDo+qche7+GB6CzojO7i2eCvRIItWw
         yZNTZYGvV/39G/4duae+vmHMcsyT/ffUBhUzJN+X/MdIQK2qrNk4KAJeCBNyocMDKyII
         OY1TP+cmZAzhwUdimYQdYCG8Sos0F0I8gsK6amgHrJuvI/jtKAesXYG1y0uOSAxfwcyA
         aRmzSkjAo4jZWWDV0M/CsuEfzW3bz9FK7Ih7eU83+wGxAL9jgIdlPNC0jup97svNQXdF
         amGw==
X-Forwarded-Encrypted: i=1; AJvYcCXmjIl3dtnhEyyKvruUCaM5X4OW41lAkAVvBsJSupjF+1t2syMEN9JF/B55hi0BivjkkI4YZ29dzNULhzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsOSSu8BrFfQKTTQNQKn/6XsYB2pWiF5XxbR1K/DYAs9Pr1Oj
	zcS4BDlOElsEzPMgXK8CvH9bdDqgZu4/6Vn13+PYCpGpD7a+/I06yK18
X-Gm-Gg: ASbGncuoywYvkTRzDEQDi01Fzxqor3EzeaBccp5zWIu/bKiOx6ANGvamI3Z7Ajtd+Z9
	UK5T/KR+ak/q+rfEDVf/8YkNNu9pDSxewHvE+APj3yv0n1BEXttF2whQRxlsly/R7eLF/Nmm9oi
	1kJEsY5sY2vlozxbNGBh3olX31maH/sacVR1kLypxD+z8eLG7Su5va0yxtqt7B4hCZPlim/kI3f
	Hg/P1V40FNQx8dPdL2BmvjChPjvOjtwWFu5pYwh2D/hdm2js3Tft49UU0zy+Ir7sKR4g6X5pVhh
	CbD6xubSMjuHj+F9mYsznYDs1xHrNOQemjBfOjt7n+QlTGXKh8lOfW+euLkOuUU1lenGeyZhyMW
	oCuAvZOx8dcLxXBrMY23rblLksruJAIktJB6QfRxkWptlYqxjXpTN3jowINpY2jLkNG7waWQPPi
	DHNNBPtnF67uefXNeZ1MhGly37K66EbiFYF+OldAvWMg060igR+61vYkL1OTE=
X-Google-Smtp-Source: AGHT+IF3GTfVqg6kKMkKgXEI4HnRfSh6BiE8celFp+VgEbUnCfCvPp5AMsw9f6heOTAGU/dj205yGA==
X-Received: by 2002:a17:90b:1a88:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-34733f4f8a7mr19172992a91.34.1764176562527;
        Wed, 26 Nov 2025 09:02:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a549070sm3122597a91.2.2025.11.26.09.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 09:02:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3f5370b7-c67c-409d-8422-83b5096d1233@roeck-us.net>
Date: Wed, 26 Nov 2025 09:02:40 -0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: Replace deprecated PCI API
To: Philipp Stanner <phasta@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20251126091032.130787-2-phasta@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251126091032.130787-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/25 01:10, Philipp Stanner wrote:
> pcim_iomap_table() is deprecated. Moreover, its special usage in 8250,
> causes a WARN_ON to fire (in pcim_add_mapping_to_legacy_table()).
> 
> 8250's function serial8250_pci_setup_port() effectively maps the same
> BAR multiple times and adds an offset to the start address. While
> mapping and adding offsets is not a bug, it can be achieved in a far
> more straightforward way by using the specialized function
> pcim_iomap_range().
> 
> pcim_iomap_range() does not add the mapping addresses to the deprecated
> iomap table - that's not a problem, however, because non of the users of
> serial8250_pci_setup_port() uses pcim_iomap_table().
> 
> Replace the deprecated PCI functions with pcim_iomap_range().
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/dri-devel/16cd212f-6ea0-471d-bf32-34f55d7292fe@roeck-us.net/
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> @Guenther: Can you please test this? I hope it fixes your issue.

Yes, it does. Thanks a lot for fixing this!

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/tty/serial/8250/8250_pcilib.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
> index d8d0ae0d7238..f98eb2ab1005 100644
> --- a/drivers/tty/serial/8250/8250_pcilib.c
> +++ b/drivers/tty/serial/8250/8250_pcilib.c
> @@ -28,13 +28,14 @@ int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
>   		return -EINVAL;
>   
>   	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
> -		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> -			return -ENOMEM;
> -
>   		port->port.iotype = UPIO_MEM;
>   		port->port.iobase = 0;
>   		port->port.mapbase = pci_resource_start(dev, bar) + offset;
> -		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
> +
> +		port->port.membase = pcim_iomap_range(dev, bar, offset, 0);
> +		if (IS_ERR(port->port.membase))
> +			return PTR_ERR(port->port.membase);
> +
>   		port->port.regshift = regshift;
>   	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
>   		port->port.iotype = UPIO_PORT;

