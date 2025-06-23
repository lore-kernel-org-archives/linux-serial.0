Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88C18E1F;
	Mon, 23 Jun 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750662350; cv=none; b=FCsu5oghR66XIiLolbPsk+Www4K+y4TSeivp6RNZrzWYr6d6jnYfjCozbNbz/iWCVBN1yABd8qgJp749h1ZLx0fZl+7ZqObBtEhJv12svSOuL/B9YVRtLdzKge0UWt2PSwMSM0PfU2iw4Jx3Ypo73ZPq9Pu/XRs7q9VokM6CXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750662350; c=relaxed/simple;
	bh=V/miEDlrI7DnkLCwZUnBD6L179yvwhTDHX1gDrQ+s0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FW6F5n+qma7hkbrapo6NWPhiuWvow4pPIAPtGTyKPN25v+bjclv/m13hkJyz5HAhNMTGrQRHxf7oEnHWI1r0g8dXkYiqe95qPiYa2HhubvaSPWC44GwL7+DXDZHsjcygZuLaQgRDwgNlhLPArKsIitO2ttfbWKYgLrilLnbX2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEyyc0Ti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEyyc0Ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E15C4CEED;
	Mon, 23 Jun 2025 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750662350;
	bh=V/miEDlrI7DnkLCwZUnBD6L179yvwhTDHX1gDrQ+s0I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NEyyc0TiIKhInOksYoEKuy40v0qs9bdisXB2WLEYdL5p57wtsIjZm/6OLfiMn8wvI
	 36p6CE5c4rbUY6cBVWCPE1FMGBN/YIVsfTipmvgLVrnXAkfmfBqq1hKdSKMcVMbQPU
	 Y1Y8N1e8BJU4F6plCc4PKyiRmwUkUNzOu3RWPxzBUCr06KXEC3crbWKDz6XJPIHsD0
	 lZzAlP2SQIQqr4LmMHWRB77FW/qHXF/wkgME5PaV5kZyaw9vJnzADWPH6n1vkDjZ56
	 FzLpqWn2l7tZ4jR+iibRcGMojRf+jKriBfzKwxUIw32S7E4pdGaL2oFVI9RkR2qtEK
	 ArtKXSdtG+1/Q==
Message-ID: <9c3d387c-0ee1-4f53-b4fe-2c2783e5650c@kernel.org>
Date: Mon, 23 Jun 2025 09:05:46 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/33] serial: 8250: invert
 serial8250_register_8250_port() CIR condition
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-31-jirislaby@kernel.org>
 <aFJTQqVvmLBvrVRA@black.fi.intel.com>
 <dfb7552f-9163-4334-b137-1bf69fbdef5b@maciej.szmigiero.name>
 <aFcDOx1bdB34I5hS@surfacebook.localdomain>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <aFcDOx1bdB34I5hS@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21. 06. 25, 21:08, Andy Shevchenko wrote:
> Fri, Jun 20, 2025 at 11:48:09PM +0200, Maciej S. Szmigiero kirjoitti:
>> On 18.06.2025 07:48, Andy Shevchenko wrote:
>>> On Wed, Jun 11, 2025 at 12:03:16PM +0200, Jiri Slaby (SUSE) wrote:
> 
> ...
> 
>>>> +	if (uart->port.type == PORT_8250_CIR) {
>>>> +		ret = -ENODEV;
>>>> +		goto unlock;
>>>> +	}
>>>
>>>> +	if (up->port.flags & UPF_FIXED_TYPE)
>>>> +		uart->port.type = up->port.type;
>>>
>>>> +	if (uart->port.type != PORT_8250_CIR) {
>>>
>>> I admit that there tons of mysterious ways of UART initialisation, but can you
>>> elaborate how this is not a always-true conditional?
>>
>> Careful here, someone had an idea in the past that this is indeed
>> a dead code/branch and ended causing a regression [1].

Right, I was confused too, but then I noticed there is:
   uart->port.type = up->port.type;
in between the tests.

>> It would definitely make sense to add a comment describing the code
>> flow there though as it proven to bewilder people.
> 
> Yes, this is my point between the lines. I left the code that may affect the
> type change and the second check needs a comment explaining these cases, if any.
> "If any" defines "always-true" or not conditional. W//o a comment this code
> tends to be updated again and lead to a regression.

ACK, I will.

-- 
js
suse labs
