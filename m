Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F110F2
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468434; cv=none; b=Avgs3g5u2las3UVCiIaVkmYGjEcpfr3dHLBYdya7NNspvZ5/v47y3asD7UsKU2EKBFnSKGhRitlNuzN8QRtWUUSwYYnyu6aaBJYS6m4SMmZCuCXTUYnOiDk8DoEPHASsF7Gdhi75ds6ua6AMmnzzdXfKffUCwy5QSdUKJXOps1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468434; c=relaxed/simple;
	bh=QdYsYZ/XZ/BhrWZiC3LmVOgd0ZnKqPTEavFlSQj7vKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1Pw/r0wMTYAMP1w+qmPk5/lJNB59oUvEFcPp7h/c9Vcvpj2NlXD6Ik4CW/Jfb34jgTSrk6A9uj/uJxpCtiRVCU3U5dAnjFtYWYBmVaxHzdut0V7dsj0R//6p1ccUUSkvMiXgQluofWE+qGeW31q0qK0UL/rFwPx7qLhFQzR4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sbc+tSEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sbc+tSEn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769468432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yy9iHITJImOaWp+w2IDttpcClHHB6iVERPgCL4cF2OU=;
	b=Sbc+tSEnTK3E3ALcDuX710QzE6JTEu6/rFTvxD5KWfeO275FqSHn5nhNOOFmQmdsNiGBqv
	o7vUYhIZQiDkaEISDEhGw7IyyjV8/UXYs1rCt3y1hCZSNzvzpCwxjXJwQIgU3RL5351u+u
	Nf2H9hDjeeR2XwlfaDfxZOqdUCXM1OM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-UeO0ERaxPmScxn4PZUasjQ-1; Mon, 26 Jan 2026 18:00:29 -0500
X-MC-Unique: UeO0ERaxPmScxn4PZUasjQ-1
X-Mimecast-MFC-AGG-ID: UeO0ERaxPmScxn4PZUasjQ_1769468428
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-480600391e2so14550355e9.0
        for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 15:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769468428; x=1770073228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yy9iHITJImOaWp+w2IDttpcClHHB6iVERPgCL4cF2OU=;
        b=xGwMDgsvbWXc8+eCOkW6QCcFGEzZMLBO2GUttTltKKSRD5LblFOy85KDetVctYsrlA
         owcuyTqbe7FcJ184J2dhk/RkVx/WS4IAZbjgcn5yKdZFV3pRdileabF23OHHJxK0RHOm
         7+p4du+9fImdBvwuH+WhPxCQI7lGjEWKclAQ509HzyFKyKUDY2sv7QguUB0dFpFyeKCP
         dnUANWYv3bj/Ke1MkFDqAjuLCzP/KbXh8iaz2fITaAv9jcamKxCAeCcHTEj9/1y+eeVt
         BT+JWOwPX9vTFvsUnTkR+HcVILS7vDTFopKj8eWv4sW1GmEHsjl9dFY9oFhD8ERVbjZI
         rZyg==
X-Forwarded-Encrypted: i=1; AJvYcCVa3/pCFv2h/Zm/O53NdCM1vSEOhbY7Z0Whv+UDPw2hKQdlHcnfIxudrsWEzN9kJY3XiZUFVzb3gqkS83M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwj/dlLdhl9JDD55Q0wNMVt2amJkc7U67X9Et7d51BYWfpMY6
	ns1/E9fK3Ehy1+hSb1BixbHrgNiXacmaMpz+lJUzGOUBEvHOna8cy5HnWV3hV41mcrKXhbcJVSf
	TZ35sEYgYwf35ziioER5Ah5X9+V1S8k2rg5u0jLB428TvquyCCw2Zzx0RvFZgCYQNMzs+CkHEmw
	==
X-Gm-Gg: AZuq6aJjF3DlICmrij8HqPONKaooalilUDfDb5jWvu7UDGMW8eBFagsYeHJjt2U2s5/
	v3iVNoAfcdMxpE9EVoVqD8aPQGNEVwmsZnsCdhNbSzmoSp8eRrLZ4ZNtlnLWopuqRVAtIKVjxlM
	x8RBAJfyllUIVhKPdWfVMk+bgZc4qOniunXN1ALnCtwM/JLHy4b7cpL9T7KewE68kr58SWOeG/B
	ftfHM8LS9tkaLC3lOCmGebtO12IpdL5eXkyQGMj0wfl9CV6Q1QkHD65bBvCrx2DlVmeS2yyXw7u
	SgNJ1eBUGammHXsqOvI8IB1oA0AO7pJCaGK0zHv/QEx483JG+l97g6PmbmA3VbOimjPruzNfQA6
	HJI82AbM89m4oGu4qd3HFqXv9rgfTg0Xm32QZD140MxP2Jddp+g==
X-Received: by 2002:a05:600c:314f:b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4805cf669b2mr80349925e9.18.1769468427922;
        Mon, 26 Jan 2026 15:00:27 -0800 (PST)
X-Received: by 2002:a05:600c:314f:b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4805cf669b2mr80349755e9.18.1769468427499;
        Mon, 26 Jan 2026 15:00:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c0f3f7sm26880285e9.13.2026.01.26.15.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 15:00:26 -0800 (PST)
Message-ID: <ec476a78-c721-420e-8c79-219d1c35a041@redhat.com>
Date: Tue, 27 Jan 2026 00:00:23 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vt: Add enable module parameter
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <npitre@baylibre.com>,
 Calixte Pernot <calixte.pernot@grenoble-inp.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260126092234.713465-1-jfalempe@redhat.com>
 <2026012613-cotton-jellied-b67a@gregkh>
 <48be84fb-bee4-4a22-bde4-0d0c78282f80@redhat.com>
 <2026012648-vantage-mummified-2a43@gregkh>
 <45526d98-57b6-456e-babc-61b7331318c0@redhat.com>
 <2026012642-threefold-atypical-a3ad@gregkh>
 <99371939-e9b2-4114-8e27-e605ebf941de@redhat.com>
 <2026012653-designer-capably-d575@gregkh>
 <286bfe2e-796e-4c71-a75c-4967450edaab@redhat.com>
 <2026012620-retool-gloater-6cd3@gregkh>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <2026012620-retool-gloater-6cd3@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hQ0QS8LWPGIAQIEDh83tvRUEzJ3moRSabuMqqBZY5M4_1769468428
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 15:36, Greg Kroah-Hartman wrote:
> On Mon, Jan 26, 2026 at 02:05:36PM +0100, Jocelyn Falempe wrote:
>> On 26/01/2026 13:46, Greg Kroah-Hartman wrote:
>>> On Mon, Jan 26, 2026 at 01:26:34PM +0100, Jocelyn Falempe wrote:
>>>> On 26/01/2026 11:59, Greg Kroah-Hartman wrote:
>>>>> On Mon, Jan 26, 2026 at 11:48:50AM +0100, Jocelyn Falempe wrote:
>>>>>> On 26/01/2026 11:20, Greg Kroah-Hartman wrote:
>>>>>>> On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
>>>>>>>> On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
>>>>>>>>> On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
>>>>>>>>>> This allows to build the kernel with CONFIG_VT enabled, and choose
>>>>>>>>>> on the kernel command line to enable it or not.
>>>>>>>>>
>>>>>>>>> This says what is happening, but not why?
>>>>>>>>>
>>>>>>>>>> Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
>>>>>>>>>
>>>>>>>>> Why are we using a 1990's technology for a new feature?  What is this
>>>>>>>>> going to allow to have happen?  Who needs/wants this?  Who will use it?
>>>>>>>>> For what?
>>>>>>>>
>>>>>>>> The goal is to ease the transition to disable CONFIG_VT.
>>>>>>>>
>>>>>>>> So if this is merged, you can boot without VT on any Linux distribution,
>>>>>>>> without rebuilding the kernel.
>>>>>>>
>>>>>>> But that's a distro-specific thing, the distro should be enabling or
>>>>>>> disabling the option as it needs, it should not be a user-configurable
>>>>>>> boot-time selection option as userspace depends entirely on this either
>>>>>>> being there or not.  Why would you have a kernel with both options but
>>>>>>> userspace without that?
>>>>>>
>>>>>> Actually the userspace side works with or without VT, at least with Fedora,
>>>>>> I've my Gnome session in both cases.
>>>>>
>>>>> Great!  Then why is this even needed?  Who wants such a "let's not make
>>>>> up our mind until we boot" type of system?
>>>>>
>>>>> Given that traditionally the command line is a "secure" thing, that is
>>>>> locked down by distros and orginizations, who would ever be able to be
>>>>> changing this type of thing?  Who would want to support userspace that
>>>>> handles both at the same time?
>>>>>
>>>>> I don't see the issue here, if a distro doesn't want to support VT, then
>>>>> disable it in the kernel and all is good.  If they do want to support
>>>>> it, than enable it.  Don't do both :)
>>>>
>>>> Maybe the real issue is that VT cannot be built as a module.
>>>> That way the userspace would be able to load it only if it needs it.
>>>>
>>>> That's probably more complex than my 3 lines patch, but I can try.
>>>> Would you prefer it that way?
>>>
>>> If that would make it simpler for a distro to handle this, perhaps.  Try
>>> it and see, I think the last time this came up, unwinding this into a
>>> module just wasn't possible, but that might have been a long time ago, I
>>> can't recall.
>>>
>>> But again, why wouldn't a distro pick a "this is what we are going to
>>> support" line and stick with it?  Why would they want to support both?
>>>
>>
>> It's all about the transition. Talks about VT-less system started in 2012,
>> but since then no major desktop Linux distribution have done it.
> 
> Then perhaps it's not really ever going to happen if no one actually
> does the work and wants their distro to change to not have it.

To give some contexts, I proposed to switch to kmscon for Fedora 44, so 
once we are there, it will be feasible to switch off VT, in 1 or 2 
years. But the requirement to rebuild the kernel, makes it painful to 
test, and much harder to get accepted.

>> I think that one of the reason, is that if you switch off VT, of course some
>> users will complain, as it has a lot of implications.
> 
> Again, that's a distro's policy decision to make, don't force the kernel
> to support a wishy-washy distro's decision :)

Agreed, I can also keep this patch as downstream, if you think it's 
better that way. But I though it may interest other distributions as well.

> 
>> Telling them to go rebuild their kernel is not good.
> 
> Agreed, this is a policy decision a distro needs to make.
> 
>> Telling them to run
>> grubby to change the kernel command line until they find alternative for
>> their use case is better. They can experiment and do the switch when they
>> are ready.
>> Really it's nothing more than that.
> 
> Again, policy decision that a distro needs to make.
> 
>> I don't think a distribution will want to maintain VT and noVT for a long
>> time.
> 
> Please define "long time" given that no distro has even done this yet?

I hope it won't get longer than 1 or 2 year.

> 
> thanks,
> 
> greg k-h
> 

