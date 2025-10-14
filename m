Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84236296BA7;
	Tue, 14 Oct 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464668; cv=none; b=anrFmagFqCdmtKEux/Sed90GFh0A/qyFeZADSh2+WD/VlHyBJ/Q3Ezqv3z/P++MPJLCx3rkSRAPr34EO5s/i/cqEhTpEFD6/K75iXWoQ9DWhPfM4VLi/R0+pQkQMJFBV+IpSPCzwh38FM3mtwJJ5cTfntjXdXdckz+uJtCYhQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464668; c=relaxed/simple;
	bh=+MCW3pWeUmZPyGxMrX0RxPKRd723eQqL7FGWAFlCJcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMloozitSiGsv+AnOCcGR9UNBmpcMyzN/wzzi1nSKx5kgOdj7bFqIzCnEoz7aaPYRxczVOdlNhYKmOMIDGM4N7qM+MhvTIlhtTrvQFB60iP7bOSJhBTM8I2njex9W28pnug/V4wEoSAm0FjFSptnPDd0+j8Bhu01Y1N0umvljvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xU12w+3h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xU12w+3h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=r2+wIsDTT/YrPhAA/dkQ7vm5iMhdp0goW9on/CiFr/g=; b=xU12w+3hNb9ltRQ40yzAiQ8eEX
	eLwUXtuCe25tCXZsYxXQTs+wkOHgDCKEcULtHzYWGIvnZesaKEsFuXaZrLofohWUYKsGPhrFqV9Z0
	370bdaiGaI2xWJuJRLXFIOO+Nf3bY728T0JZOGqGLelCLpSOUg+YKO9ojPcADR84Ogh5J4QqY8yRh
	otLPq8KSHppiyeMt6/JUFFLz9LvwttJ+1ata50ti6Io3BRevw4GldC8lrbjBwLPBr7ZRY1La3BAwx
	Do0QiyD9dLqIyMbfchLI5eGzjVYYgwn764pH5x6e0iNt+YM905C7sM8dwnHv93J4iuLrzBGdTB9ni
	EYjoIj7A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8jHN-0000000H7sL-3awZ;
	Tue, 14 Oct 2025 17:57:45 +0000
Message-ID: <d6cd375c-dad6-4047-9574-bac7dfc24315@infradead.org>
Date: Tue, 14 Oct 2025 10:57:45 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on
 extra /proc/sysrq-trigger characters
To: Jonathan Corbet <corbet@lwn.net>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Serial <linux-serial@vger.kernel.org>
Cc: Cengiz Can <cengiz@kernel.wtf>, Tomas Mudrunka
 <tomas.mudrunka@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
References: <20251008112409.33622-1-bagasdotme@gmail.com>
 <87wm4xbkim.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87wm4xbkim.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 7:55 AM, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> /proc/sysrq-trigger documentation states that only first character is
>> processed and the rest is ignored, yet it is not recommended to write
>> any extra characters to it. The latter statement is contradictive as
>> these characters are also ignored as implied by preceding sentence.
>>
>> Remove it.
>>
>> Link: https://lore.kernel.org/lkml/7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com/
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>  Documentation/admin-guide/sysrq.rst | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
>> index 9c7aa817adc72d..63ff415ce85d66 100644
>> --- a/Documentation/admin-guide/sysrq.rst
>> +++ b/Documentation/admin-guide/sysrq.rst
>> @@ -77,9 +77,7 @@ On other
>>  On all
>>  	Write a single character to /proc/sysrq-trigger.
>>  	Only the first character is processed, the rest of the string is
>> -	ignored. However, it is not recommended to write any extra characters
>> -	as the behavior is undefined and might change in the future versions.
>> -	E.g.::
>> +	ignored. E.g.::
> 
> I'm not sure this is right - there is a warning here that additional
> characters may acquire a meaning in the future, so one should not
> develop the habit of writing them now.  After all these years, I think
> the chances of fundamental sysrq changes are pretty small, but I still
> don't see why we would take the warning out?

but the following paragraph says:

	Alternatively, write multiple characters prepended by underscore.
	This way, all characters will be processed. E.g.::

		echo _reisub > /proc/sysrq-trigger

so it is confuzing.


-- 
~Randy

