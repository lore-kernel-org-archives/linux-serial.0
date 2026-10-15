Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F3525A86;
	Thu, 15 Oct 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068290; cv=none; b=Fs6djb0kHSKbKMkmpYyg7CzjvmjTRiozDdvP+6kVcJEwKPr226ZO9V76uYW+kkQWEQeFjHPfaXBPCRIDACr22l6kMTKhooK4kojdadcdN8XGxmpj1FGzAJUdJf6Dq7BeoGTaUHgfkmVzOrQEBp7t2VLGJJbXKeSzocl/2V/h+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068290; c=relaxed/simple;
	bh=7KBLTTLQ7itI1AaQ11FEEwhAACt/sfe4Yun3y+XczE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Juc77GTVnhRkBkREcys8P9p/wTJtm5IkBnpP4Y4hIirIj2kG71EIzRKPahHypzfDIZFuLgchklAAM01w1eLiwMfzYETELhUy/DHTwZAMAH7vVskWHOefOGkf86GTv6uSTCzJG1IN5j3Gvf2KU8+hCQcTFaIJPIA9YXdQCb09exM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE701F000C4;
	Thu, 15 Oct 2026 12:44:48 +0000 (UTC)
Message-ID: <4e9b365b-7c5a-44f4-bfaf-d24e9162fd94@linux-m68k.org>
Date: Thu, 15 Oct 2026 22:44:43 +1000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-5-gerg@linux-m68k.org>
 <20261014-expensive-shrewd-nautilus-abcab6@quoll>
 <d256f39c-6ed5-409a-a7ed-224165d00521@linux-m68k.org>
 <20261015-adamant-realistic-bettong-a24c4f@quoll>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20261015-adamant-realistic-bettong-a24c4f@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 15/10/26 18:56, Krzysztof Kozlowski wrote:
> On Wed, Oct 14, 2026 at 10:48:41PM +1000, Greg Ungerer wrote:
>>
>> On 14/10/26 21:24, Krzysztof Kozlowski wrote:
>>> On Tue, Oct 13, 2026 at 10:07:02PM +1000, Greg Ungerer wrote:
>>>> Create documentation for a new binding to support the Freescale ColdFire
>>>> UART hardware block. This is found on pretty much all variants of the
>>>> M68K derived Freescale ColdFire family of System-on-Chip devices.
>>>>
>>>> It is not compatible with any other known UARTs.
>>>
>>> You never tested this, so limited review.
>>
>> It is tested. It is working and running on multiple ColdFire platforms.
> 
> You cannot run a binding. It's impossible, otherwise show me how do you
> execute that code.

Of course you cannot run a binding. I took your statement to mean that
this series as a whole was not tested. Which is wrong.


> But as proven already on the lists, no it WAS NOT tested. You have clear
> a warning.
> 
> Otherwise you claim that tests shown errors and then you decided to
> still send it with errors, so then th enext question: why do you send
> code which your tests tell it is wrong?

Sorry, I have no idea what you are talking about.

This series of 5 patches was tested before sending, on multiple targets
that use this code (obviously all m68k/ColdFire platforms).

Just in case I missed something I re-ran testing with a fresh 7.3-rc7
code base. All 5 patches applied cleanly, with a clean compile. My testing
showed no new problems in normal operation. Granted sashkio did find a 
couple of error case checking issues that you just do not normally encounter
in practice (but I will of course fix those for v2).

So, no, I didn't just send it knowing that it was failing any tests.

Regards
Greg


