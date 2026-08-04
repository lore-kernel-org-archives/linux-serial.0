Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9714830C174;
	Tue,  4 Aug 2026 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838727; cv=none; b=izgeQv5TdksLoAPOgG6uPL2BrnOlRmLziBRZT6ptPwqDswhyVTPly49iEDJHOwGz9BGp8fZysZz452Y2L6klyQBNdR/GFyxe7EBtG/bgyIXdYVu/zwX2TVBAKkCVlWifIjNdaEXXwEy9vj4NN2II/zJBuYNvL1OkDWuL9itJLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838727; c=relaxed/simple;
	bh=aZdmmLQ/MNK6xmqBKSlrxSEI7sLpWjj7PxVXrKI939c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfxBd1Y/oGEjoGhVhCzbweVsYGgKlrg2FeWygnU8ljBmEvgp+lgORz/Nxz7VXEMH0xI+m/LWDVEK2snwtfP2sNT5rx7STfqAy6lCHEmeG6TLmp+YRkONRXkMRgV7M6ukhGdvFW08BRVna5jOJTRwcCnSkygyCHDXHirYL2KM55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqCw4oGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqCw4oGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C991F000E9;
	Tue,  4 Aug 2026 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785838726;
	bh=jkjJiFBUO+c2FmPb7tRkkaqBfisR4+tpSDqOOOAV8LQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RqCw4oGMD+CAnmMKEVKshmYDL/4rFvWBMBvlVzjYwnRRuVhMmGeRjE91msXjuHhL7
	 +pVYolUbLai5Zy1zbc755jbtUhUT1OvN8Q3i0GlBsCk82aDT2EGLPhVgZJr/0rThfy
	 RslExKiEHVMG/GaykCcLz8d862E1fUyPBizExNjVawkvn109uvQYr4dy/H55OpXPzG
	 w/ex1hJGg95emIr/A8hPfI5f0hkbKw8+aVxD27Ip73qD09F4OLWubun2x2tOtQWsn1
	 XXhVKNIQHFHEz1CJeC6hxI+Kd80wSXd7DMyaZM0dXVdEBkgr4U91KBPJu6BbXckyBs
	 s7HT7eUtWRN9A==
Message-ID: <0bcdcb38-78b1-47e9-9a4c-4df0bb8380c6@kernel.org>
Date: Tue, 4 Aug 2026 12:18:43 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: moxa: remove driver.
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>
References: <2026080345-unmapped-sliced-49f2@gregkh>
 <7a3538e1-444d-42f5-b48a-0a8eb9f2625f@kernel.org>
 <2026080429-deforest-snowiness-90ad@gregkh>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2026080429-deforest-snowiness-90ad@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 08. 26, 11:57, Greg Kroah-Hartman wrote:
> On Tue, Aug 04, 2026 at 07:12:01AM +0200, Jiri Slaby wrote:
>> On 03. 08. 26, 14:52, Greg Kroah-Hartman wrote:
>>> This is a very old driver, and no known hardware is still around for it,
>>> and the company says they do not need it anymore, so let's remove it as
>>> the LLMs are starting to poke at it and find "interesting" things which
>>> will just waste everyone's time given it's not actually used.
>>>
>>> So let's drop it.  If someone really needs it, it can come back in the
>>> future, in a more "modern" way, as the style here is very old...
>>>
>>> Reported-by: Jiri Slaby <jirislaby@kernel.org>
>>> Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
>>> Link: https://lore.kernel.org/all/afqyY8FQ8ZfpH48_@moxa-ThinkCentre-M90t/
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> LGTM, there are leftovers though:
>> MAINTAINERS
>> 18341:MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
> 
> As you said, that one documents the mxser.c file, not moxa.c, so should
> I just remove both and this entry too?
> 
> And the .rst file needs to go, right?

SMARTIO/INDUSTIO = mxser is supposed to stay.
INTELLIO = moxa is being removed.

>> Documentation/admin-guide/devices.txt
>> 2391: 172 char  Moxa Intellio serial card
>> 2398: 173 char  Moxa Intellio serial card - alternate devices
> 
> Oops, missed that.
> 
>> =========
>>
>> Funilly, the MAINTAINERS entry was supposed to be for both mxser
>> (SMARTIO/INDUSTIO) and moxa (INTELLIO), but the F: pattern for moxa was
>> never added (cf. 679655daffdd). INTELLIO should dismiss from there,
>> nonetheless.
> 
> As above, should we also just drop mxser?  Same age of the hardware from
> what I can tell.

No, mxser is still alive hardware-wise. I have a couple of mxser PCI 
cards around :).

There is also a patchset to convert mxser to serial_core (even 
8250_core), yet not ready:
https://lore.kernel.org/all/20251130104222.63077-1-crescentcy.hsieh@moxa.com/

thanks,
-- 
js
suse labs
