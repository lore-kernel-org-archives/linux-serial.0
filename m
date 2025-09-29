Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0B1F5EA;
	Mon, 29 Sep 2025 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125625; cv=none; b=ezheyznbgK2wJEz9bNm3J6sLGAQfbiHBUytPRTK7OSkBXRZPc580QICrTzNF0Uzh5szbIiBDp6GhUns1Gtk2n2O2UYh4Ogd5To8svM8aW2Oh54wUrv/aDT1Fp+hU5wk7Dhg9Pm5oqyrevfMiTe9/mXX9DKaIHX0+dBVLVrnbry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125625; c=relaxed/simple;
	bh=mBZFk8UZ7lxek2kM3lWSsghrg3BUbJ2YXC59VzRhYB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEwB8l2MAZroj1WBayRUXcc9fBw1U5rDphyxVE6zzdykiJ/Q4WU5KLPIp3RYRRzUQ+v+tbjHMUFRG48HEffTS1lrdEHU6er/uCJ0xtRbWZFtTG+zSlBehs+v+1CZI/+375LyYm/Za6EK5FlV86+axxk69uE8vZwdTFkfhFr0W+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTXgpGmd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTXgpGmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36BCC4CEF4;
	Mon, 29 Sep 2025 06:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759125624;
	bh=mBZFk8UZ7lxek2kM3lWSsghrg3BUbJ2YXC59VzRhYB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KTXgpGmdJMF00Cv9NdwOEAfRbABjmxjaPpNzFPthisGc18Y4hG3mOqXuBcsALMBZJ
	 Rk/DfHXhTwQAK8AUreBcCJW7pFDuoqF7MfXpJ9557bbjH7kcFZyT4ugGJhSQSr724j
	 EGEKrjvVj+ECb8+LVjcDsZ+4zFDmnuca1fBog8Rc2sVF25fgTg3yge7MKYYN4idb9U
	 KrqyPNxYIJmIrM3Gcr1cwy4mA/dp8mPzMYv4zeM3EV6/BclWtmXOPvfFyXpy+dwzI8
	 Ks36aZMOW3oCpnGGfTh9UAZnALPvxkBmHUeePNned7ZktW+3QIn9FQoS6lbQAVBkRm
	 HPSyNAAzTEJeQ==
Message-ID: <da2de297-2c9c-4855-9fb7-553022538cde@kernel.org>
Date: Mon, 29 Sep 2025 08:00:19 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_pcilib: Replace deprecated PCI functions
To: Florian Eckert <fe@dev.tdt.de>
Cc: gregkh@linuxfoundation.org, kumaravel.thiagarajan@microchip.com,
 tharunkumar.pasumarthi@microchip.com, andriy.shevchenko@linux.intel.com,
 pnewman@connecttech.com, angelogioacchino.delregno@collabora.com,
 peterz@infradead.org, yujiaoliang@vivo.com, arnd@kernel.org,
 cang1@live.co.uk, macro@orcam.me.uk, schnelle@linux.ibm.com,
 Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20250924133544.2666514-1-fe@dev.tdt.de>
 <5fed7e09-b59f-46b0-be49-881c0c1b61c1@kernel.org>
 <e4d2fa14701092977daa844cf25e7dd7@dev.tdt.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <e4d2fa14701092977daa844cf25e7dd7@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26. 09. 25, 14:31, Florian Eckert wrote:
>>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ...
>>> --- a/drivers/tty/serial/8250/8250_pci.c
>>> +++ b/drivers/tty/serial/8250/8250_pci.c
>>> @@ -165,7 +165,15 @@ static int
>>>   setup_port(struct serial_private *priv, struct uart_8250_port *port,
>>>          u8 bar, unsigned int offset, int regshift)
>>>   {
>>> -    return serial8250_pci_setup_port(priv->dev, port, bar, offset, 
>>> regshift);
>>> +    void __iomem *iomem = NULL;
>>> +
>>> +    if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {
>>> +        iomem = pcim_iomap(priv->dev, bar, 0);
>>> +        if (IS_ERR(iomem))
>>> +            return -ENOMEM;
>>
>> Why not to propagate the error?
> 
> Most other calls in the kernel of this function return
> -ENOMEM on error. Therefore, I thought that this is the
> correct return value. I can fix that in v2 if you like.
> Let me know what you prefer.

Ugh, pcim_iomap() returns NULL on error, so the IS_ERR() check is all 
wrong. What other places in the kernel use IS_ERR()? They need fixing.

thanks,
-- 
js
suse labs
