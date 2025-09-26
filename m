Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A7CA4B;
	Fri, 26 Sep 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890956; cv=none; b=jwvNQ71e+ff/DXvotQ/F+EDXqccqEZU/Txsqxvs+h/PLrDZZ0xUJzNug59/J7qPRCHmcwhH5BFs7SJNY62rwfk+7laxHpqrGThWHVaMOie+uNL1AuZQ+Gt5hZRMbtYP6UslGF3xRMVi2bH+T96QMACNtMFsCGU9TYsf6+NBU/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890956; c=relaxed/simple;
	bh=65DFOZeav1wJdixGj6xUR7lGVpIMaKBOEEE22sttMoo=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=CG/K7fdgvOEUVvz9VHd2mJQLqmFmnwSZNcKhdiiT563aJ1XYgkBGwM0vFb0NIJkcLEuzfhz9Yu/IW9e6K03o3aBQ8iErVDVTeSSZDIvrMI6efwJPlLDw6OQsA4jJhibjN4hIGn1rtCm2Djr0q7/a5MVmrp0PcaYGlanf2t0OKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=upISTL8U; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="upISTL8U"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=8378631f71=fe@dev.tdt.de>)
	id 1v27bm-00HYxG-57; Fri, 26 Sep 2025 14:31:30 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1v27bl-00GVGB-8P; Fri, 26 Sep 2025 14:31:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1758889888;
	bh=rpo3USVtuGtBG/KBK642Z8MdMw03cWYlO1txs/w9bVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=upISTL8UnGcqp0YbnyJMyULaojhZooayN8u1rJU45KeQaIFecFm3CdwxJEKKIz9Xm
	 Bd2j7jF07ow5udBFPPQ8ZFf2+Tq2rW+C1agSmnVUS+AjUtheqX2opF/RFjmcXQukpu
	 ce3sVh4aMj25fBpwuDn0yFrgdeBJfN9aXTtIHEYp3M9QBtDIsRIZx2SuxdTqOdB836
	 ifrs4GSisYCex5DhfjvuLlJA41f5gX7TwtgQuaab+lduSAponK3ITr7H9ghmWzbcn4
	 myiKDMJ0fvwdwzQQWt7BJnlGzp6FrX7jIsOitUgaGNt+nqFyw3s419bctVJ2q0fnbT
	 XLPjbV/gisaEw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id C193E240042;
	Fri, 26 Sep 2025 14:31:28 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id AF091240036;
	Fri, 26 Sep 2025 14:31:28 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 696F02645F;
	Fri, 26 Sep 2025 14:31:28 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Sep 2025 14:31:28 +0200
From: Florian Eckert <fe@dev.tdt.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, kumaravel.thiagarajan@microchip.com,
	tharunkumar.pasumarthi@microchip.com,
	andriy.shevchenko@linux.intel.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pcilib: Replace deprecated PCI functions
In-Reply-To: <5fed7e09-b59f-46b0-be49-881c0c1b61c1@kernel.org>
References: <20250924133544.2666514-1-fe@dev.tdt.de>
 <5fed7e09-b59f-46b0-be49-881c0c1b61c1@kernel.org>
Message-ID: <e4d2fa14701092977daa844cf25e7dd7@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1758889889-256FD63A-6B86B2C9/0/0
X-purgate: clean
X-purgate-type: clean

>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ...
>> --- a/drivers/tty/serial/8250/8250_pci.c
>> +++ b/drivers/tty/serial/8250/8250_pci.c
>> @@ -165,7 +165,15 @@ static int
>>   setup_port(struct serial_private *priv, struct uart_8250_port *port,
>>   	   u8 bar, unsigned int offset, int regshift)
>>   {
>> -	return serial8250_pci_setup_port(priv->dev, port, bar, offset, 
>> regshift);
>> +	void __iomem *iomem = NULL;
>> +
>> +	if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {
>> +		iomem = pcim_iomap(priv->dev, bar, 0);
>> +		if (IS_ERR(iomem))
>> +			return -ENOMEM;
> 
> Why not to propagate the error?

Most other calls in the kernel of this function return
-ENOMEM on error. Therefore, I thought that this is the
correct return value. I can fix that in v2 if you like.
Let me know what you prefer.

> 
> Other than that, LGTM.

Thanks for the review :-)

