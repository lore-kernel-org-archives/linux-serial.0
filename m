Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604522D3750;
	Tue, 17 Feb 2026 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315410; cv=none; b=j57L7T0M1CUMM7AwiAzK89bFd7zsaa3V9HdPXJ4MErAw96eMv1WQwz1hQxJV2/y+Se12SBi60gFjdP9ZRg7GAIZoUEIZLXkP/BA8OEJMfINsA5FxtaAaNz2vSKl9p6SYLJAdmTIjZ+T9iUQjFwyCOhzKl7es+tiugaHIiZRebwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315410; c=relaxed/simple;
	bh=ZZTOKC26qMFPHiVmU10pjYzXdC+lUIS0Ft7L2vrXmso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNvOyaRX/yzUVeV5Pis75mpwCMSoxzedWKvX+vje2C1RON0dVES6dJuHfF6uGrPuoEvy8w+v5jEhiiBtVFDCcs4oySLXyBuT4NTEngGiMpRFGUtQb8BIOmejiT9+G2gT+meG20BaseS2h0QUWvh7por/QKCNm3z05+JjIIyk+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuPgyMOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuPgyMOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0D5C4CEF7;
	Tue, 17 Feb 2026 08:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771315410;
	bh=ZZTOKC26qMFPHiVmU10pjYzXdC+lUIS0Ft7L2vrXmso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UuPgyMOzI+k4tGqfhi7ZcRILMZAFlGMRLXIqL4bTVbiZmSvX+5tZ5wCggnZtRK+/A
	 42q8fGO8QZusVoR4w8MrFEySn+/DD4ZatUX0+m2ur1/W/yewTY/m97Jd9k3zrb3+hx
	 2mU/SUsXHjhjVeJ9Zgs3thi/lg2+AhhRhGFziOWrCO5SYYJvte6N4Iv857fvovj7zX
	 tfveU4CNKqmqka2DVtWVkOm63M5dxGBbcgULqT5LRYHFQw32Y2vbbTCMtOkZpef2MQ
	 V3wRnNx8zQfz3opFbMCxQPobTXJc5AeS+pF5kl1Iq1pEfM5rOviCwYU5z8KjlRZU3B
	 NPqLBRrIDiZGQ==
Message-ID: <a77224d3-04d8-4a62-bb48-06fee922013c@kernel.org>
Date: Tue, 17 Feb 2026 09:03:25 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during
 device removal
To: dsterba@suse.cz, Jiri Kosina <jikos@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, duoming@zju.edu.cn,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 dsterba@suse.com, kuba@kernel.org, alexander.deucher@amd.com,
 akpm@linux-foundation.org, pkshih@realtek.com, tglx@kernel.org,
 mingo@kernel.org
References: <20260208062538.29608-1-duoming@zju.edu.cn>
 <2026020828-unretired-mannish-8465@gregkh>
 <41b47e38.6ddb4.19c3ccb8e4d.Coremail.duoming@zju.edu.cn>
 <2026020859-caretaker-duckbill-0fb3@gregkh>
 <p16239r9-692o-859r-6006-7o611r2rn2qs@xreary.bet>
 <20260209102117.GZ26902@suse.cz>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260209102117.GZ26902@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 09. 02. 26, 11:21, David Sterba wrote:
> On Sun, Feb 08, 2026 at 06:25:38PM +0100, Jiri Kosina wrote:
>> On Sun, 8 Feb 2026, Greg KH wrote:
>>
>>>> I don't have the real hardware. In order to reproduce the bug, I simulate
>>>> the IPWireless PCMCIA card in the qemu by allocating and configuring the
>>>> necessary resources(I/O ports, memory regions, interrupts and so on) to
>>>> correspond with the hardware expected by the driver in the initialization
>>>> code of the virtual device.
>>>
>>> I wonder if this device even is still around, given that pcmcia is all
>>> but dead for a very long time.
>>
>> I doubt that this device is still around anywhere where reasonably new
>> kernels (including LTS) would matter.
>>
>> I don't think I've seen this device (which was back then donated to me by
>> T-Mobile CZ in order to get it supported in Linux, and I am not sure how
>> much global adoption it got afterwards) for, let's say, past 15 years :)
>>
>> I think (let's see what David, ho took the maintainership over for me
>> afterwards, has to say) we'd better deprecate and drop the whole thing,
>> rather than trying to pretend that it's still actively being taken care
>> of.
> 
> https://lore.kernel.org/all/20230223172403.GW10580@suse.cz/ last time
> the question of keeping the driver was asked (2023). Back then I was
> able to find the cards on second hand market but now I can't on a local
> market and there's exactly one hit on global eBay.
> 
> Local linux related or telco support forums seem to mention the driver
> until 2011 (root.cz, abclinuxu.cz, t-mobile.cz). It does not prove
> nobody is using it but I think the chances are quite low to justify
> keeping the driver.  It is simple enough to be built as an external
> module eventually, I can help with that in case somebody really needs
> that.

So, would you want to submit the removal? Or anyone else, if you don't 
want to lose time with this? (I can do that, if noone wants to.)

thanks,
-- 
js
suse labs
