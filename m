Received: from mx13lb.world4you.com (mx13lb.world4you.com [81.19.149.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49372E88BB
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195162; cv=none; b=u1fwehkwoUFPzKsq/DE+43p2FTn/Bo2+Wz3kjLTpTuHfE4fO4+MxoJDX4q5yHHRVGmI2dbzfHj6++dYfxmf8L0MsAwbXsBZX6dZN5yz+yE7sxOr7mbTbYgWWZpCTAr4bMlWl+2Whwzqk6pF9sqObHzNgNjeS4vJ6uqBsQP9gZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195162; c=relaxed/simple;
	bh=E1BlH3rJSbM2c0McBVzcEn5WYaBf1c9bq1nlKeSqCss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXs8GWwvElYcPGfTaVSKkGANg87E08LJkdj2xDt7oaNE2Sr+Kh5gfTdkqE7eat6ndD6zb5lETDZ2jaz8/cS9uhvL71OMrytmPl8rhtShqc3Pee5hP5nmux2riXUUyOmrKtC4dJbZXtI9gDxHQqXcXBRbm7S/i1SuWwhp6eIiVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=KxhpCCbl; arc=none smtp.client-ip=81.19.149.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="KxhpCCbl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PJbu8aoLRtn/olIjXZbZVUJ6k1jDKjYb4TIAwpGYeYk=; b=KxhpCCblQAD054vB2z+9Er1O/c
	q0+L0RW8SVdGEP5vFStkgpsu72BbRUMbk/Hj5noVTdvi3/rTgv2A4Ow5ZansLPY2i2Q3aYkP0nJ3z
	pavwtdN9AE1+oxhGYnfNIX2vZKqcWHZBXeu7nP/hubfrdRIC/ZHUE8dsTkyhL8r2H7Hs=;
Received: from [188.23.34.236] (helo=[10.0.0.160])
	by mx13lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vOMiP-000000003Rb-1OdB;
	Wed, 26 Nov 2025 22:06:18 +0100
Message-ID: <1692bf5e-a0de-4f75-8ec0-b228e94b6b4b@engleder-embedded.com>
Date: Wed, 26 Nov 2025 22:06:17 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] serial: 8250: add driver for KEBA UART
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, lukas@wunner.de, Gerhard Engleder <eg@keba.com>,
 Daniel Gierlinger <gida@keba.com>
References: <20251023151229.11774-1-gerhard@engleder-embedded.com>
 <20251023151229.11774-3-gerhard@engleder-embedded.com>
 <aSb99zuXhUh3VD4J@black.igk.intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aSb99zuXhUh3VD4J@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 26.11.25 14:17, Andy Shevchenko wrote:
> On Thu, Oct 23, 2025 at 05:12:29PM +0200, Gerhard Engleder wrote:
>>
>> The KEBA UART is found in the system FPGA of KEBA PLC devices. It is
>> mostly 8250 compatible with extension for some UART modes.
>>
>> 3 different variants exist. The simpliest variant supports only RS-232
>> and is used for debug interfaces. The next variant supports only RS-485
>> and is used mostly for communication with KEBA panel devices. The third
>> variant is able to support RS-232, RS-485 and RS-422. For this variant
>> not only the mode of the UART is configured, also the physics and
>> transceivers are switched according to the mode.
> 
> ...
> 
>> +#include <linux/auxiliary_bus.h>
> 
> + bits.h
> + container_of.h
> 
>> +#include <linux/device.h>
> 
> I don't see how it's being used.
> What I see are
> 
> + dev_printk.h
> + device/devres.h
> 
> + err.h
> 
>> +#include <linux/io.h>
>> +#include <linux/misc/keba.h>
> 
> + mod_devicetable.h
> 
>> +#include <linux/module.h>
> 
> + spinlock.h
> + types.h

Is there any extra tool to check for missing headers? Or do I have to
check the header for every used function?

>> +static int kuart_probe(struct auxiliary_device *auxdev,
>> +		       const struct auxiliary_device_id *id)
>> +{

...

>> +	spin_lock_init(&uart.port.lock);
>> +	uart.port.dev = dev;
>> +	uart.port.mapbase = kuart->auxdev->io.start + KUART_BASE;
>> +	uart.port.irq = kuart->auxdev->irq;
>> +	uart.port.uartclk = KUART_CLK;
>> +	uart.port.private_data = kuart;
>> +
>> +	/* 8 bit registers are 32 bit aligned => shift register offset */
>> +	uart.port.iotype = UPIO_MEM32;
>> +	uart.port.regshift = KUART_REGSHIFT;
> 
> Can't you call uart_read_port_properties()?
> 
> If ever you gain some properties either via FW description or via software
> nodes, they will be automatically used without need to update the driver!

Yes that would be some nice behavior. But __uart_read_properties()
sets some defaults even if no firmware node exist (UPF_SHARE_IRQ, 0 as
irq number or it fails if not irq number is found). So
__uart_read_properties() would need to be changed. IMO it makes no sense
to change __uart_read_properties() as this functionality is currently
not required.

> 
>> +	/*
>> +	 * UART mixes 16550, 16750 and 16C950 (for RS485) standard => auto
>> +	 * configuration works best

...

>> +	}
>> +
>> +	retval = serial8250_register_8250_port(&uart);
>> +	if (retval < 0) {
> 
>> +		dev_err(&auxdev->dev, "UART registration failed!\n");
>> +		return retval;
> 
> 		return dev_err_probe(...);

Yes that's simpler.

> 
>> +	}
>> +	kuart->line = retval;
>> +
>> +	return 0;
>> +}
> 
> ...
> 
> Since driver is about to be applied to serial-next, I suggest to send a
> followup(s) to address my comments.

I will do a follow up.

Gerhard
