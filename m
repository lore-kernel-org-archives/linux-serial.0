Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34291A9F96
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760887702; cv=none; b=kiF2JBOLlyfEz2gzKxSDjjue/QuGeIEVc7jJ7yDHbvgx3dFYMFfqsBSX1tSvg4I4JCk/Rq8zDI5AAsVPFwzwfg4sfGPEBjfHQOCenoCmYCbRe9M5+V5dUaxUzuP8ctTKT79vR4EZ2DU4Ie576BuVBeqBT6Jbw10OjAxw93b1DvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760887702; c=relaxed/simple;
	bh=pkpHBxMCgjWW80/WXamyeQNbPGZF1vp60FDEVBMJLx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuErlnniGNi7dUxzS11+5QjNp19ebUoskSBqnvYaFNZDV9d/kdSZ3inXALkAT580g+AhCgz6lLn0XTiJH9kCWrGlb+XztACUjnc5O3swYr0AmEkUYv8h8/oTXKOngFzVyljjU+imoM66uPupcTum0dlAYK97WWxRvEf5LVb/CbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=GChfnKZ8; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="GChfnKZ8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uC9NhUQf2QJ5EKsERk8zVj0de67zHOTntp7VyjUgMqE=; b=GChfnKZ8w9whJGf92uKF5n7dfH
	weCHOPcu1i3eLP5BhtCKvFRfEAXM68laHfoFJztmCRSAPGfeZuJ9JQ9vQMGtCh3pekpx6AE3mPWq0
	5pprXQEzzW9ovEqMZFDdYS2ivfnzU8reqSpAATzwrOliwByMU3QiB0Fmr5o0bQNc50K0=;
Received: from [178.191.104.35] (helo=[10.0.0.160])
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAVDv-000000001np-3pMo;
	Sun, 19 Oct 2025 17:21:32 +0200
Message-ID: <4e3da3b9-693e-4d21-901e-14ac4663d340@engleder-embedded.com>
Date: Sun, 19 Oct 2025 17:21:30 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] serial: Keep rs485 settings for devices without
 firmware node
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, Gerhard Engleder <eg@keba.com>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <20251017144209.2662-2-gerhard@engleder-embedded.com>
 <aPSmOcbprjf0EoAq@wunner.de>
 <81b924dc-4e95-40af-a52a-48a75e01d7f5@engleder-embedded.com>
 <aPT42ykVKxouqUHK@wunner.de>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aPT42ykVKxouqUHK@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 19.10.25 16:42, Lukas Wunner wrote:
> On Sun, Oct 19, 2025 at 04:10:26PM +0200, Gerhard Engleder wrote:
>> On 19.10.25 10:50, Lukas Wunner wrote:
>>> On Fri, Oct 17, 2025 at 04:42:08PM +0200, Gerhard Engleder wrote:
>>>> +++ b/drivers/tty/serial/serial_core.c
>>>> @@ -3533,7 +3533,13 @@ int uart_get_rs485_mode(struct uart_port *port)
>>>>    	u32 rs485_delay[2];
>>>>    	int ret;
>>>> -	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
>>>> +	/*
>>>> +	 * Retrieve properties only if rs485 is supported and if a firmware node
>>>> +	 * exist. If no firmware node exist, then don't touch rs485 config and
>>>> +	 * keep initial rs485 properties set by driver.
>>>> +	 */
>>>> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED) ||
>>>> +	    !dev_fwnode(dev))
>>>>    		return 0;
>>>>    	ret = device_property_read_u32_array(dev, "rs485-rts-delay",

...

> 
> BTW is there a good reason that you don't have a fwnode for your UART?
> It seems odd to have a UART but not describe it in the devicetree.
> Maybe that's the real problem and fixing it obviates the need for this
> patch?

This auxiliary device is part of a FPGA based PCIe device. It is mostly
used on x86 but arm64 is also possible in the future. There is no device
tree or ACPI information available for this device. Think about an x86
CPU module where you cannot influence the BIOS implementation and device
tree is not available. IMO having a self describing PCIe device which
works out of the box is best in this case.

Thanks for your comments!

Gerhard

