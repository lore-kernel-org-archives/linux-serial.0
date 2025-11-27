Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE6311C10
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277623; cv=none; b=nFqDiFFkcJxa+02noureGT7W7/grszAZS432kfW2x/vKZ6hIGbhYcFKf9YBObg0T+br6WU9bcV4IpQ8WgkD/q8f/NCtrx+dehUV4MN3SFejTXwZFQFftE8D5nwBaZKp7uxsX1p3pqj4yDnMBtWh2wiZLuF9NVhpaAxEoMJzgNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277623; c=relaxed/simple;
	bh=hC9j/DxBuu4iM7FgZy4ZRRnRhxk70Vbm1G0vYJfjfRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiKiIEMz4qugEew4s7Vemz/Rb3xeEJdkVODhva+iT3totEFH2PT81at7XqkC6qRy1Y4IlyycGmuyQhed5z1VJf+FpLBzNiSohWrW9EWDUBfJB0RCvk9Kl3rQlcdlIouq/4zxl8kGoNwtRkn9n1XNChfsDefZq93bBXkHzE9i3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=kBY1z8kx; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="kBY1z8kx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q82GbWKHpgCB+Wu0b2Nqn+Do8CYrVMi2BZQyvj10aSs=; b=kBY1z8kxsCYLeI5Nv0l32UjI1W
	jLsiRNcLJwPzijVblbMKBlc4C65DTSnn6KXauLkil3fW0LcZO2xL+7Eqw8W9DtGHbbS9ZSIgpbm8k
	YLtDQOuZpeThYNNhJJQCynSLckR3g2iV+ZEq+sukstzZniyYuOUgYHIUd5P2jnPjNK14=;
Received: from [188.23.34.236] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vOiGl-000000005LP-391F;
	Thu, 27 Nov 2025 21:07:11 +0100
Message-ID: <0269cc4a-9631-4129-b52c-59ee396f71c9@engleder-embedded.com>
Date: Thu, 27 Nov 2025 21:07:10 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] serial: add KEBA UART driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
 <aSh21GDLStR3uhnX@black.igk.intel.com>
 <d7f1fbbb-0ec0-47b7-beee-8e9487098c99@engleder-embedded.com>
 <aSis8tuBCfHqJvGY@smile.fi.intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aSis8tuBCfHqJvGY@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes


On 27.11.25 20:56, Andy Shevchenko wrote:
> On Thu, Nov 27, 2025 at 08:26:13PM +0100, Gerhard Engleder wrote:
>> On 27.11.25 17:05, Andy Shevchenko wrote:
>>> On Fri, Oct 17, 2025 at 04:42:07PM +0200, Gerhard Engleder wrote:
>>>> First the serial subsystem is prepared to keep rs485 settings from the
>>>> driver if no firmware node exists. This enables drivers to configure a
>>>> default rs485 mode, which is set by the serial subsystem.
>>>>
>>>> Second the driver for the KEBA UART is added. This driver supports
>>>> multiple rs485 modes and selects RS485 as default mode. This UART is
>>>> found in KEBA PLC devices. The auxiliary devices for this driver are
>>>> created by the cp500 driver.
>>>
>>> I just realised (thanks, Lukas!) that this is for some kind of FPGA which makes
>>> even bigger question here.
>>>
>>> First of all, we have the FPGA framework, which handles (re-)configurations of
>>> FPGAs. Second, why do you need a new driver when we have already one, i.e.
>>> 8250_dfl that follows some kind of standards?
>>
>> Yes, there is FPGA framework, which handles FPGA re-configuration.
>> There is no FPGA re-configuration in the driver and neither in the
>> system. The FPGA does not even support re-configuration. The FPGA is
>> just a variant to implement a PCIe target. The FPGA loads its
>> configuration on power up once from flash before the BIOS starts. So
>> the operating system does not need to know that it is an FPGA. It is
>> just a PCIe target.
>>
>> Why not 8250_dfl? Because this is a driver for a different IP core.
>> The UART is no Altera/Intel or AMD/Xilinx IP core. It is a KEBA
>> IP core and the 8250_keba driver only implements feature added by
>> KEBA. The rest is 8250 and uses the 8250 infrastructure.
>>
>>> Third, the expect approach is to see DT overlay provided along with the FPGA
>>> configuration. So, basically your cp500.c should not have been existed to begin
>>> with.
>>
>> Like first, it is just a PCIe target and this PCIe target is divided
>> into auxiliary devices, which was suggested by gregkh. Initially I
>> divided it into platform devices, but the suggestion of gregkh is a
>> better fit. It is a single PCIe target, which consists of multiple
>> logical devices with its own registers and interrupts. This logical
>> devices are then separated by auxiliary devices.
> 
> This is implementation detail in Linux, but in HW why are those not a proper
> PCI endpoints / functions? With that done, the drivers can be just normal
> PCI device drivers.

Yes, PCI subfunctions would have been much nicer, with direct drivers
and no auxiliary/platform stuff in between. But these were not
supported by the FPGA vendor.

>> 3 years ago Intel was not able to deliver enough FPGAs. With just being
>> a PCIe target, it was possible to switch the FPGA vendor without
>> touching the software in the field. With Linux re-configuring the FPGA
>> that would not have been possible. So re-configuring FPGAs during
>> runtime is something that should be only used if needed.
>>
>>> Can you elaborate on these considerations?
>>
>> I hope you get a better impression what this is about. For the drivers
>> it is not relevant that the device is FPGA based.
> 
> Yes, so it's rather something with a custom FW that is not supposed to be
> changed (at least from the device hierarchy / functionality perspective),
> or very little from version to version. Is this a correct summary?

Yes, the only changes are bugfixes. The register interface must be kept
compatible. Like a microcontroller with a firmware which implements an
USB device.

Gerhard

