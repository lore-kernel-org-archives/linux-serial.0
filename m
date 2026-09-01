Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547F2DF156;
	Tue,  1 Sep 2026 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240722; cv=none; b=guj0TEtD6/d+oE+PA6FzIKMWcrte3slsVn5VSC9eyIMCkEA0xZQ4L8I3t9J6RsEt2qJZLuuy0gZERHC4rttF1jPRgBxE5YmZfFTUy1fvAYTAUV9wnxDcVR8jb6b0ffH+ehiKpQNCXdi157OJ3aTQsfdprQ3TrSbHVKGXN9eFIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240722; c=relaxed/simple;
	bh=5ynHe+dy7ACCQfSkxjgDClc+6VjcbLLhvvl5BxVeuQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDkN49AeBBqHgZbJctDEsYjDtNA4fWKC2Tq/qqOkYliPqW8ujwvJkGgPGp9taeiLUtA3Sx6/UCEK+ShxklkKCHuBfcpIDMCfdkKsw2c7YQdJSdKCluh2gRq5jKi5lNf95AgBR93sYIMZ+axuVZ2g89qpleqjTLjf6NIo5w2hRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDqhIoHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDqhIoHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDD71F000E9;
	Tue,  1 Sep 2026 05:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788240720;
	bh=xPgLmERa54izknplIHehdL6mAiqjD6RjdmK9hGApl0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VDqhIoHMX8xIYyWArdGs7ZSdGkaB5eScjNbKYJXZ4PbJFFRDk9aTUfK5rcQOk0uYw
	 cQ8Bme3xjiasYDoJ5P1mb7Ymla+aGZVdaLx3NArdNVo+u+JufYBYZhvHkedHbTdlVL
	 Ny1vPRZSE6eYDYpzgRRpl+x/WcJZ25wJZgrWYtmumkWrmh906G304UMTH5+z1EQ6nP
	 RKQ+ZRXiI6yB9OyCQ2vQyN98sC8voMKVlXsY5yxaOpluxrKu3E71da5oDTeUj9sNfV
	 hZ2fUZeIP6YBzCSqhJtsOS/B2k59MDkEIYPjzWEFzBO1IERfcypiqfDyGNTfUbn+37
	 PsCei+oUqi22Q==
Message-ID: <ee4a130d-76ff-4202-ad54-989795bd58f6@kernel.org>
Date: Tue, 1 Sep 2026 07:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] serial: 8250_mxpcie: set the driver data before
 registering ports
To: sashiko-reviews@lists.linux.dev, Linmao Li <lilinmao@kylinos.cn>
Cc: linux-serial@vger.kernel.org, Crescent Hsieh <crescentcy.hsieh@moxa.com>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
 <20260901041519.114737-2-lilinmao@kylinos.cn>
 <20260901043252.85D391F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260901043252.85D391F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cc Crescent

Sashiko appears to be right.

On 01. 09. 26, 6:32, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing initialization of `up.port.port_id` causes all registered serial ports on a multi-port device to share ID 0 and corrupt each other's hardware state.
> - [High] Unprotected read-modify-write on shared hardware register in `mxpcie8250_set_interface` causes a race condition between concurrent operations on adjacent ports.
> --
> 
> commit 0dfacc505133057b054c4b8c8d42d557343c298b
> Author: Linmao Li <lilinmao@kylinos.cn>
> 
> serial: 8250_mxpcie: set the driver data before registering ports
> 
> This commit fixes a NULL pointer dereference in the mxpcie8250_rs485_config
> callback. It moves pci_set_drvdata() before port registration so the board
> data is available when the callback is invoked during initialization.
> 
>> diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
>> index ce873fbd62e93..c0e3517d4e4ec 100644
>> --- a/drivers/tty/serial/8250/8250_mxpcie.c
>> +++ b/drivers/tty/serial/8250/8250_mxpcie.c
>> @@ -542,6 +542,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
>>   
>>   	mxpcie8250_init_board(pdev, priv);
>>   
>> +	pci_set_drvdata(pdev, priv);
>> +
>>   	up.port.dev = dev;
>>   	up.port.irq = pdev->irq;
>>   	up.port.uartclk = MOXA_PUART_BASE_BAUD * 16;
>> @@ -578,7 +580,6 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
>>   		}
>>   		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIG_DEFAULT;
>>   	}
>> -	pci_set_drvdata(pdev, priv);
>>   
>>   	return 0;
>>   }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the port
> registration loop, I noticed that mxpcie8250_setup_port() seems to leave
> up.port.port_id initialized to 0 for all ports. Because the up structure
> is zero-initialized, and up.port.port_id is never assigned the idx value,
> it remains 0.
> 
> When this zeroed structure is passed into serial8250_register_8250_port(),
> does this cause all registered ports on a multi-port device to share ID 0?
> If so, hardware callbacks like mxpcie8250_rs485_config() and
> mxpcie8250_startup() that use port->port_id as an index might inadvertently
> apply configuration changes to port 0 instead of the intended port.
> 
> [Severity: High]
> This is also a pre-existing issue, but looking at mxpcie8250_set_interface(),
> the shared hardware register controlling adjacent ports is updated using an
> unprotected read-modify-write:
> 
> mxpcie8250_set_interface()
>      ...
>      cval = ioread8(uir_addr);
> 
>      if (port_idx % 2)
>          FIELD_MODIFY(MOXA_ODD_RS_MASK, &cval, mode);
>      else
>          FIELD_MODIFY(MOXA_EVEN_RS_MASK, &cval, mode);
> 
>      iowrite8(cval, uir_addr);
> 
> Since this is called by mxpcie8250_rs485_config(), which is only protected
> by the per-port uart_port_lock, could concurrent ioctls on adjacent ports
> (like port 0 and port 1) race and corrupt this shared register byte?
> 


-- 
js
suse labs
