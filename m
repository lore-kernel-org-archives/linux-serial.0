Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28F2BF3DB;
	Mon, 20 Oct 2025 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944000; cv=none; b=G0paXzJiggaU/L/6uGcNw2wLNHGfv1AsJazEafF3ATGP4VRNkU0DzF6VqlkwkO6axhtN4Ibs4HUEVd2/n1jUGdvuai2A6occHfbVCnqzjxI4guh6za6K4VORUQUiw6CQ4PUEn8do8YD8kqSkRXRX58nXt5SFmf1zn/2s9yttlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944000; c=relaxed/simple;
	bh=yulyTBRll1Rhc1IP4GeW63xjPywR7HDYSb8jX4qUL1A=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=FIvNJeCRgCaltWyctg6eG2UckCWVMxhHaHzCHXYA/f9hMBBA+VZd6XKyOZh7jHl/pMuWdWIKIOKWPxle6g47DLAuWJey6w2BygkLqrygwansl3S1qk3e3CQDXCJOWmUO7djM5jh9Pt5ynYO2/2rAnkmaUEKjGM4JiGD8Nv59Ip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=kldGsZ3k; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="kldGsZ3k"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9402dab0bf=fe@dev.tdt.de>)
	id 1vAjfr-009p04-7I; Mon, 20 Oct 2025 08:47:19 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1vAjfq-008UnS-4V; Mon, 20 Oct 2025 08:47:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1760942837;
	bh=cTJ0KEEGjos3fAl/V3PjF8MxGplnUpGNaRu/eWstcM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kldGsZ3kkkylkIk0sXWnwIVf5/s+ePuKCxHitxyoCnKk9OcZRgkU3ZoVetxLPryh8
	 jBp4jk+HvENp0VypJHKKoPKLtn3AIb2r/wnsJjFWpaSuE2xlUv0aT/zaHUqu+NAPUR
	 Ykq7NaDm5UG78UAOUds8bmuH/fmVZSNMGtHFfpp9vCx71dvLJn/i8MI7CoynhOgSwU
	 jYMAENjxc9mbzad/1IDqcBbY6HqrBEbntt9fIcEok41772GWHZeCiedhl9/MX7dQ5r
	 gnEbOooSiFLYD0B0e87UpQu7tX7ab/XULW08EzA4TJLYXHucuUgcyoZmFKDa0ip80n
	 BQgp2ebxqMHxQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id A3C84240045;
	Mon, 20 Oct 2025 08:47:17 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 922B1240040;
	Mon, 20 Oct 2025 08:47:17 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id F298B229EE;
	Mon, 20 Oct 2025 08:47:16 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Oct 2025 08:47:16 +0200
From: Florian Eckert <fe@dev.tdt.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	kumaravel.thiagarajan@microchip.com, pnewman@connecttech.com,
	angelogioacchino.delregno@collabora.com, peterz@infradead.org,
	yujiaoliang@vivo.com, arnd@kernel.org, cang1@live.co.uk,
	macro@orcam.me.uk, schnelle@linux.ibm.com,
	Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pcilib: Replace deprecated PCI functions
In-Reply-To: <aPPreT00iiTDzJwG@ashevche-desk.local>
References: <aPPreT00iiTDzJwG@ashevche-desk.local>
Message-ID: <84ad1b3070a8374ec20f06588fab9f86@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1760942838-436F738A-F9DB84AD/0/0
X-purgate: clean

On 2025-10-18 21:33, Andy Shevchenko wrote:
> On Tue, Sep 30, 2025 at 09:27:43AM +0200, Florian Eckert wrote:
>> When the '8250_exar' module is loaded into the kernel, a kernel trace
>> with 'WARN_ON(legacy_iomap_table[bar])' is dumped to the console,
>> because the old pci table mapping is still used in '8250_pcilib'.
>> 
>> The old function have been deprecated in commit e354bb84a4c1 ("PCI:
>> Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()").
>> 
>> The remapping already takes or must take place in the driver that 
>> calls
>> the function 'serial8250_pci_setup_port()'. The remapping should only 
>> be
>> called once via 'pcim_iomap()'. Therefore the remapping moved to the
>> caller of 'serial8250_pci_setup_port()'.
>> 
>> To replace the outdated/legacy iomap_table processing in '8250_pcilib' 
>> the
>> function signature of 'serial8250_pci_setup_port()' has been extended 
>> with
>> an already iomapped address value. So this can be used directly 
>> without
>> io mapping again.
> 
> ...
> 
>> +	if (pci_resource_flags(priv->dev, bar) & IORESOURCE_MEM) {
> 
> Dunno if this is included already in Linux Next, but here is room for
> improvement.
> 

I followed the code in the 'serial8250_pci_setup_port()' [1] function.
The same pattern is used there [2].

> 
> The problem with the above code is it (wrongly?) checks for bit and not
> for the resource type. OTOH I don't remember if 64-bit version requires
> the IORESOURCE_MEM to be set along with that.
> 

Do you mean the function 'platform_get_resource()' [3]? This is a 
platform
device function?

[1] 
https://elixir.bootlin.com/linux/v6.18-rc1/source/drivers/tty/serial/8250/8250_pcilib.c#L24
[2] 
https://elixir.bootlin.com/linux/v6.18-rc1/source/drivers/tty/serial/8250/8250_pcilib.c#L30
[3] 
https://elixir.bootlin.com/linux/v6.17.3/source/drivers/base/platform.c#L55

---
Florian
