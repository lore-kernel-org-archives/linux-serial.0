Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE92F2359;
	Wed, 16 Jul 2025 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662625; cv=none; b=UPBDyNpQckMD1RIErsg9pJV5+H8J3DeriPLArwMQ+8G6pYZcgCCyh1/JKuXeBDm96KrFIJnfRxvM54MQkR7p7311s3OYEhgvThQFt6eySjr7N+0fWwFF+47XWShb6j4Xt6+2iTtEPXhgWdDjPtUmvXEvBjxmY2xf4u3eRl9Eh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662625; c=relaxed/simple;
	bh=lns19lMaHOFEbWeEH55cyfClRhk4xEhPq1Nuz5Fkc/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFLIgsb+DunSYFhi9NeAgrU6uxnyrhojTRREA04E1QEfLoEGq8t/mSpQGUq+YhgSNDxb76btQElW/VTyXuU0002gPLszi31dP6ZWXn3xaAQhJCxt4IY8f4ae5+FidwMU8egssMvDVdMceUOrYz95bM7aauhvnHJf8Hh+QO+yupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJNWPHSB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJNWPHSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22725C4CEF0;
	Wed, 16 Jul 2025 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752662625;
	bh=lns19lMaHOFEbWeEH55cyfClRhk4xEhPq1Nuz5Fkc/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FJNWPHSBrjeVHPtFj7JDnZEY6WRzOvnuL/7XBDGhD/DnFunayqYF6jkJzXnHlhQTS
	 9FcKEze1bmA7LG//Bdqou70dsfFsp6oqi62WvjX8zk6WWcVTEwwpg5w5WkHx472/pm
	 Pq6cAfebUtom5xY1jnEX4oUGYmoUwp4Lc/M1oIPR7myZJtl5+qDrNzrEMH8boaSHhG
	 xEgFja9RSsjRwDD4QdYL0NgH2lGghOL1mrrjcMBMI0ATonuRZNdrE+v/rR4PVIIL4u
	 /Rs3gRrgM6vFIRy36x9bDjicku6w/Qgb/MtUlUBGIJ/1ro074f420sVyUYgl8w2Tgl
	 cJxyW3mFOcNzg==
Message-ID: <7d3afa64-2bd4-4710-8c16-2a2815d5b644@kernel.org>
Date: Wed, 16 Jul 2025 12:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] serial: 8250_ce4100: Fix CONFIG_SERIAL_8250=n
 build
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
References: <20250716094433.1611477-1-andriy.shevchenko@linux.intel.com>
 <a3240539-04b1-4141-95b8-fde193afa25d@kernel.org>
 <aHd-urMzXlOJPDAm@smile.fi.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <aHd-urMzXlOJPDAm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16. 07. 25, 12:28, Andy Shevchenko wrote:
> On Wed, Jul 16, 2025 at 12:14:23PM +0200, Jiri Slaby wrote:
>> On 16. 07. 25, 11:44, Andy Shevchenko wrote:
>>> On i386, when
>>>
>>>     CONFIG_X86_INTEL_CE=y
>>>     # CONFIG_SERIAL_8250 is not set
>>>
>>> will try to compile the driver and use the stub simultaneously.
>>> This breaks the build. Fix it by making sure that the driver
>>> compiles only when CONFIG_SERIAL_8250 is also enabled.
> 
> ...
> 
>>> +ifneq ($(CONFIG_SERIAL_8250),)
>>
>> Why not ifdef CONFIG_SERIAL_8250 then?
> 
> $ git grep -n '^ifn\?eq .*CONFIG_' | wc -l
> 427
> $ git grep -n '^ifdef CONFIG_' | wc -l
> 431
> 
> Is there a preference in serial drivers?

The simpler to read/understand -- the latter.

>> Also, what happens if 8250=m and X86_INTEL_CE=y?
> 
> So, in such a case if somebody wants to use UART, it will go crazy due to
> missed workaround applied. BUT, this is preexisted issue and not related
> (directly) to this fix. Perhaps we can combine both with
> 
> ifeq ($(CONFIG_SERIAL_8250),y)
> 
> and add two Fixes tags.

+1 makes sense to me. Or introduce a Kconfig entry to handle the deps...

thanks,
-- 
js
suse labs
