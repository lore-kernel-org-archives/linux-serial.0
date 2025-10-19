Received: from mx12lb.world4you.com (mx12lb.world4you.com [81.19.149.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A42E03E0
	for <linux-serial@vger.kernel.org>; Sun, 19 Oct 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885854; cv=none; b=j0CzpedloBnqEIHJhCKvneAmMtBzQ3N+kp11trXUE1mW/Hd2cbyEgV4FwUhujVxD9cVdcpZIpvfNRLHhZtMOX/9DzSwy02pBR0EtnyQv8GdMJec9hVk4dln7m76gnjKuCm7EbKSJA7dolD94arpnJO9w3XqMJEsuYx1HKLwcO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885854; c=relaxed/simple;
	bh=ThR3ToeaTaHJXTXxcYzdZAUMkp+JXh6Tu1JSCLvZum8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVPZHLeMVMpyTtfToNBw1imedoCcLXFfDO/iYbv5wDfD0D4VxbPJm6qAqOlSZ8NkVMGmepwawWLkwBBy2pYIqHaWraHTyLsSHdkaHiqnjSaxtti461GaFNC8d+s24BjBStcg93TuteeoWT1X44MsIjfaTARb+RE9OZAJqsXvovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=JL/8hj8F; arc=none smtp.client-ip=81.19.149.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="JL/8hj8F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ERDtGQsapMzzCWZZswqGfqL1hV2oy0wqWNvcGOGZPF4=; b=JL/8hj8F5lkGzggjqMbfajbTCf
	raaa8cNiSRcGG+Qvaa5Q+ckqUbqK+gXq/WqtKO4GFwFXnG+C3FWP3esfn+PFSGK8RcM9eEcpfoZur
	ImPr6Obek+tlYUYxuB5GjsuL26y/9DqcHRKx+Dtt8X460n45sPaDQf5Zkw8tFhASYo7E=;
Received: from [178.191.104.35] (helo=[10.0.0.160])
	by mx12lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAU79-000000008U1-3FAE;
	Sun, 19 Oct 2025 16:10:28 +0200
Message-ID: <81b924dc-4e95-40af-a52a-48a75e01d7f5@engleder-embedded.com>
Date: Sun, 19 Oct 2025 16:10:26 +0200
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
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aPSmOcbprjf0EoAq@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 19.10.25 10:50, Lukas Wunner wrote:
> On Fri, Oct 17, 2025 at 04:42:08PM +0200, Gerhard Engleder wrote:
>> Commit fe7f0fa43cef ("serial: 8250: Support rs485 devicetree properties")
>> retrieves rs485 properties for 8250 drivers. These properties are read
>> from the firmware node of the device. If the firmware node does not
>> exist, then the rs485 flags are still reset. Thus, 8250 driver cannot
>> set rs485 flags to enable a defined rs485 mode during driver loading.
>> This is no problem so far, as no 8250 driver sets the rs485 flags.
>>
>> If no firmware node exist, then it should be possible for the driver to
>> set a reasonable default rs485 mode. Therefore, reset rs485 flags only
>> if a firmware node exists.
> [...]
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3533,7 +3533,13 @@ int uart_get_rs485_mode(struct uart_port *port)
>>   	u32 rs485_delay[2];
>>   	int ret;
>>   
>> -	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
>> +	/*
>> +	 * Retrieve properties only if rs485 is supported and if a firmware node
>> +	 * exist. If no firmware node exist, then don't touch rs485 config and
>> +	 * keep initial rs485 properties set by driver.
>> +	 */
>> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED) ||
>> +	    !dev_fwnode(dev))
>>   		return 0;
>>   
>>   	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
> 
> Hm, this will also skip the call to uart_sanitize_serial_rs485_delays().
> 
> I'm wondering if a better approach might be to move the check for
> !dev_fwnode(dev) further down, after the invocation of
> uart_sanitize_serial_rs485_delays()?

Calling uart_sanitize_serial_rs485_delays() would make sense as it helps
to prevent driver bugs. But on the other hand this check is done within
a function, which implements a device tree binding. So it is confusing
that device tree binding code issue warnings for none device tree
configurations.

> It may be necessary then to change the else-branch for the delays to
> "else if (ret != -EINVAL)" because -EINVAL is returned from
> device_property_read_u32_array() if there's no fw_node.

Yes, that could be done. But is relying on return values future proof?
EINVAL for a missing fw_node is not a good fit in my opinion. So this
may break in the future silently?

> If you decide to keep the check at the top of the function, then
> style-wise it would seem cleaner to not insert it into the existing
> if-condition, but add a separate if-condition.  It doesn't matter
> IMO that they both return 0.  The way the patch is now, it creates
> a little confusion to which of the two if-conditions the code
> comment pertains.

I will add a separate if-condition for better readability.

Thank you for your review!

Gerhard
