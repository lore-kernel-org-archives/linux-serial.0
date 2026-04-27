Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903E35B653;
	Mon, 27 Apr 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272013; cv=none; b=cbYPCOwPquCDpxeNOhbWDraWGfs0xo9UWsUrX+8ibTLn2jE+W4BYoNS+vc/CpIW1cjWKTJBhD4fEWOvqg6EV6r2uXEQy8OEMoKJ/J5J5LhWTbW1UX8dWnJ3/FhEOut37TtIO+0bG5PKJf0bz0Rj9BH0e3IB04121RaIycZZDy9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272013; c=relaxed/simple;
	bh=CEL3I6a5aEzGtorTg7xhZZI4CjriD1xxyk4JRpz8rdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1NXUBBLsMLo4VEslJXoMxFgYLEp/BTxUlBPbuShGoeAsyV4tv5s5ofD5xuml5TREnPD7rfvvvR8b9Oj5gc7RCn60T27G4Oy7zmsAQrbfqFtPYx5TbRZb7sPes9m6N9DBTERhPiv9DXZM7MV+yxWLXcx83fqjla5qq26sBMN0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHnUYzCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHnUYzCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D40AC19425;
	Mon, 27 Apr 2026 06:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777272012;
	bh=CEL3I6a5aEzGtorTg7xhZZI4CjriD1xxyk4JRpz8rdk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bHnUYzCFCs19LwnSaJj4DZNsqYcJFDCCJL77wgNPwpZAb/Dl944yU8KUhSyGH/T5K
	 c9qzzZwiTWji8ZiizRlU1ETsdM4XbsWb4gokBDCAruEERpD6HaEhI9Hm4SFcZvwEPL
	 eOwJMOoi6GNx++oMZU0RuLiHy3phlTfAL8NqIwj10L1SDs1iwcXqTtFJy7p+QHbCAR
	 lXfxt6yCGRkwUx5t3Wgpx2fEEgObbgt8QgGvh1dwg8cbz7admr55rst0pKiBXsNPOB
	 jhljaBGfDlJWXehO4djhYhGgTOfBmcTc906ErYdLoLyIhcTg1KcQZoEgJXhirEpdmU
	 ejV8kLd0RKm7A==
Message-ID: <8998d2ae-cb6e-458d-8551-6b44f81b1c60@kernel.org>
Date: Mon, 27 Apr 2026 08:40:08 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: samsung: add dedicated compatible for
 exynosauto SoCs
To: Alim Akhtar <alim.akhtar@samsung.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CGME20260424100201epcas5p371dd69955076938ee41ed0d823433056@epcas5p3.samsung.com>
 <20260424101835.2125970-1-alim.akhtar@samsung.com>
 <6916bf87-4c40-42c5-988f-92a57a6fc658@kernel.org>
 <324e01dcd5a0$a53d3d90$efb7b8b0$@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <324e01dcd5a0$a53d3d90$efb7b8b0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/04/2026 19:18, Alim Akhtar wrote:
> Hi Krzysztof
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Friday, April 24, 2026 9:42 PM
>> To: Alim Akhtar <alim.akhtar@samsung.com>; gregkh@linuxfoundation.org;
>> jirislaby@kernel.org
>> Cc: linux-serial@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] tty: serial: samsung: add dedicated compatible for
>> exynosauto SoCs
>>
>> On 24/04/2026 12:18, Alim Akhtar wrote:
>>> Currently Exynosautov-{9,920} getting probed based on exynos850
>>> fallback. It is recommended to have a dedicated compatible for proper
>>> driver binding.
>>
>> Unfortunately it is not. Dedicated compatible you have. However you are not
>> adding dedicated compatible. You added dedicated driver match entry and
>> we, and especially me, gave reviews many times that it is *not
>> recommended* to have dedicated driver match entry.
>>
> Ok, I might have missed your earlier comments on *not* having a dedicated driver match entry, fair enough.
> 
>> Entire reasoning for doing this patch is wrong. And patch itself is NOOP (at
>> least by quick look).
> Thanks for a quick review, Can you please check the part of the patch which adds OF_EARLYCON_DECLARE
> to add earlycon support?
> 

It also feels unnecessary - existing compatible will be used for
earlycon, no? If matching by existing compatible does not work, commit
msg should explain that.

Best regards,
Krzysztof
