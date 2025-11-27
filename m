Received: from mx11lb.world4you.com (mx11lb.world4you.com [81.19.149.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC030CD8F
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273992; cv=none; b=X7p9iYAcYdArrKkM8N9poFWuAWaIaZHc9kVTD5pwkyI8GDS4Ww+RTNqol46VAD7QZgbulxYyGpjgb/0uOYGqmRvEVjCG9+P2sfqQdTA2GU6QdxEvXqLNvFtyBLLSIwZuPe02JxXckB9KgCeTLaAidYNCKdnjT1yXf1LTaLe+m9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273992; c=relaxed/simple;
	bh=Hf9YUIUogEX1gyN/sPMtLdIcrdGwM5LVovO2EstAwtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/+kJa+mz8oWu/Uz2YSbUvL/EyHqadjm6WFq/GN+UezRSAKJccpUzI1yFXHl4MAPdn1kCOX4sHy1bzvEt6raoGFepw8ghveeswSH72UOIKqTJaXkLABAX5630nBXn4okk6gipjcTr8Xonx7bZ1m/KCAl0cp0RLTOvM31fdB5rnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=JrQQqfcE; arc=none smtp.client-ip=81.19.149.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="JrQQqfcE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tl0NJ2YPQ2AOumRFLIntC59+hyS7nmIhHe642WD3Kdo=; b=JrQQqfcETYtiZ2rUAwuCMd5tKR
	9HyQnPlCF9DwVBv3hCqkTQNdNPqDTiVH3/fLtv2T5HcugXgL4vv0+Ev3Zn+Zhvf6Sz67fhEhvbjNW
	ByFvUdQCUgYCI7wjChMdF9nep/kMlUaDQxSBTae8LCVLvBKFI2oa28mqod4X9uf3y5d8=;
Received: from [188.23.34.236] (helo=[10.0.0.160])
	by mx11lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vOhr8-000000000Ku-2pYi;
	Thu, 27 Nov 2025 20:40:43 +0100
Message-ID: <3f3092a0-8e9c-4d5c-9f98-3b574f970361@engleder-embedded.com>
Date: Thu, 27 Nov 2025 20:40:41 +0100
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
 <1692bf5e-a0de-4f75-8ec0-b228e94b6b4b@engleder-embedded.com>
 <aSdyMXhtpDX_Eo82@smile.fi.intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aSdyMXhtpDX_Eo82@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes


On 26.11.25 22:33, Andy Shevchenko wrote:
> On Wed, Nov 26, 2025 at 10:06:17PM +0100, Gerhard Engleder wrote:
>> On 26.11.25 14:17, Andy Shevchenko wrote:
>>> On Thu, Oct 23, 2025 at 05:12:29PM +0200, Gerhard Engleder wrote:
> 
> ...
> 
>>>> +#include <linux/auxiliary_bus.h>
>>>
>>> + bits.h
>>> + container_of.h
>>>
>>>> +#include <linux/device.h>
>>>
>>> I don't see how it's being used.
>>> What I see are
>>>
>>> + dev_printk.h
>>> + device/devres.h
>>>
>>> + err.h
>>>
>>>> +#include <linux/io.h>
>>>> +#include <linux/misc/keba.h>
>>>
>>> + mod_devicetable.h
>>>
>>>> +#include <linux/module.h>
>>>
>>> + spinlock.h
>>> + types.h
>>
>> Is there any extra tool to check for missing headers? Or do I have to
>> check the header for every used function?
> 
> There is iwyu, which is heavily tweaked by Jonathan Cameron for use in Linux
> kernel and even though it gives some false positives.
> 
> I did this manually by reading the code of the driver and remembering which
> header provides which API.
> 
> ...
> 
>>> Can't you call uart_read_port_properties()?
>>>
>>> If ever you gain some properties either via FW description or via software
>>> nodes, they will be automatically used without need to update the driver!
>>
>> Yes that would be some nice behavior. But __uart_read_properties()
>> sets some defaults even if no firmware node exist (UPF_SHARE_IRQ,
> 
> Is it a problem? Even a single IRQ may be marked shared.
> 
>> 0 as irq number
> 
> It doesn't do that, it just skips setting it in that case.
> 
>> or it fails if not irq number is found).
> 
> Yeah, this is most "problematic" part in case of this driver. Why is it
> auxiliary and not platform? With that the __uart_read_properties() needs
> to be updated to also query IRQ from respective aux device, and aux dev
> needs implementation of dev_is_auxiliary(). Not that big deal, though.

It is auxiliary and not platform, because gregkh suggested to switch
from platform to auxiliary. IMO he is right and that is a better fit,
because auxiliary devices were introduced to split big devices into
sub devices, which results in smaller drivers with one job for the
sub device. That's actually what I tried to do with platform devices
first.

>> So __uart_read_properties() would need to be changed. IMO it makes no sense
>> to change __uart_read_properties() as this functionality is currently
>> not required.
> 
> Yes, but as I said it will give you for free the possibility to use those
> properties without future modifications of the driver. OTOH, driver is in
> tree and modifications will be needed one way or another :-)

Yes, if the KEBA UART changes, then modifications would be needed. We
kept this UART stable now for over 10 years. As it is FPGA based, we
can keep it stable as long as FPGAs are on the market. In industrial
automation the products are in the field for 10 years, 20 years or even
more. We can only support the devices for that long time by keeping
them compatible. So I don't expect changes now and therefore I would
not prepare for them.

Gerhard

