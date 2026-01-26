Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282F3382C1
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432743; cv=none; b=Pswqoa6IDIy7AN2BpI/kwjm4U31jqB0cRhrEkYNjl/UjnhWENfIXyuIahXlYonJhWPTSKnPoYY9xvMI9XUJwzcHXBD99c1bFffT7YPyfC4Za4/M9tt/yWEio/IncldfYuluLa1vgKswcdz/oBHoTIguJbAboxj4IdEJrX3y6LPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432743; c=relaxed/simple;
	bh=1Z9XYrhaHB2NNMLx9zFkQ1GYVv2k6DeBO3f12CTbexU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E90Kk+VLAhj5eP9JhhjAbHr5N8tkqPni9SqOEo+1wqPUkWwt3pahBy47Pabql2aTSNrYOr3zNkqaGVunP3Ixpv5tP02v4nkUKLUZvfEbQQGDxacpwztxEA5maIfqe9UmJuq9+LNNFDoYdOpmSs1nGZ5vc8ncCaBzUaJyUJJ0hMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgCLnamL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgCLnamL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769432741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9xTs37SnhRmQ+LbBOx5D6YZCUQcOf/AW/wUxMXnN5s=;
	b=dgCLnamL39DTwueLlfkp+Xp90+v9RDeyKU5lMguy/vJMTm3DFW1ti/hfe0jwDkFLkzU5MK
	U2WLKKnCJv4pyPIqy0sLqCh/QYaJ8lq4Onh98sJ5NHGxS2egBubTsdLonbWaw1vmKGUUl8
	PXEjsOk51hF78SDdTpJvmaEdjXzO4yQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-uMh0D9g4Pq2Zg830R_w1Ng-1; Mon, 26 Jan 2026 08:05:39 -0500
X-MC-Unique: uMh0D9g4Pq2Zg830R_w1Ng-1
X-Mimecast-MFC-AGG-ID: uMh0D9g4Pq2Zg830R_w1Ng_1769432738
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-431026b6252so4028433f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 05:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432738; x=1770037538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9xTs37SnhRmQ+LbBOx5D6YZCUQcOf/AW/wUxMXnN5s=;
        b=UlJPg/3sq0qPUQ4cQIiOHPVYIWeb+af5Miu8zuqPdDA6njtiLqvp14ewshM8077lLu
         s4vdByhaf50/thISXp86TNe12pPWbH9pBHWUKwrOuLAfcBaWNAA4TU7FCQrfWO9RP49n
         VbubTXMRqZfn5Cy6NzEvmQNqMXOrVvBQXrKC1RWxR+ZSuf22X3WgGT2G7Fusv4OdZgOG
         U2uCRxmJyHbKvvHHKuaXGiUU6EnBWb1NPZ2rax6qREtsnxdI4plcMwTErt5Xzef7+Su7
         6ZgkjqR0sEkVl0DX4NlzC8FMIWfh5fAq6exq8OfYaYMcQInoypSiE8NHHtjmhcE/+2TF
         gJxg==
X-Forwarded-Encrypted: i=1; AJvYcCX1h7d5XR6A4CKPoDxESYMaQmdvRMO8yyPxKuFzv1vCN+SxeLBe+sGnYPSxTC5rwPgVAX7kyTDE86mSSdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyA4MloRB4X8D6pIVfgcFBRYuGHzMO36meGFT8lR7Uh57LWYN
	gyJW20FmRqtnBLQphw68afCofrTqU0ApccQ7z7AHwwyWol+RSKNUj8WgwIdtW938qxKoAgdSKmt
	d7jt8vUa+GTCGzHX6653+Edd+z0N7nWa2GSIHt2uY9si9KnJQpsSbrVeqvSeUZgs5VQ==
X-Gm-Gg: AZuq6aIlKtfCi6H3e73yD5EHOx7S5P2u+0AEH7ZWQrFBXPxtHSDRcMbgRfXhMMZR63P
	zOYb7vnIiHtUVVSfHat99tsCP/G2xXcek7nGCYUBkzCfQpJyiaAdrRIDghpE3TDK2rZzvOhCbW6
	tGsRHBZGJlDe8fWV5iz7xgwo280NAn18bLTjOxLmnLNzx6m/mB+4jog9A/DRS1yzddjSSEWvBoT
	yLvYkNpQiv2ourrIQFEEIOfetuLTszktZ0yZx38HFB8LnmLuJWQ7tqEc8kes1LPyPIY3g/DD929
	ykuBE2d55NQx6Vn/YZny+rOTWrEiDfZdoYjwRsI3fyEWpiskIMPZzAQdUJp2UdfXVVHjcd1JIu1
	i26dMAOf1NvIpAnlE9uCUQMUwYmaWMRmvKtRyFYHupQROmaJB4Q==
X-Received: by 2002:a05:600c:5248:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-4805ce4e6aamr68484725e9.11.1769432738063;
        Mon, 26 Jan 2026 05:05:38 -0800 (PST)
X-Received: by 2002:a05:600c:5248:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-4805ce4e6aamr68484345e9.11.1769432737470;
        Mon, 26 Jan 2026 05:05:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d84ef51sm249933025e9.5.2026.01.26.05.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 05:05:37 -0800 (PST)
Message-ID: <286bfe2e-796e-4c71-a75c-4967450edaab@redhat.com>
Date: Mon, 26 Jan 2026 14:05:36 +0100
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
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <2026012653-designer-capably-d575@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: imDNWHPRWMSQqsMwKyr6-FLdAa16tP7beYnShwL7Q8Y_1769432738
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 13:46, Greg Kroah-Hartman wrote:
> On Mon, Jan 26, 2026 at 01:26:34PM +0100, Jocelyn Falempe wrote:
>> On 26/01/2026 11:59, Greg Kroah-Hartman wrote:
>>> On Mon, Jan 26, 2026 at 11:48:50AM +0100, Jocelyn Falempe wrote:
>>>> On 26/01/2026 11:20, Greg Kroah-Hartman wrote:
>>>>> On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
>>>>>> On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
>>>>>>> On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
>>>>>>>> This allows to build the kernel with CONFIG_VT enabled, and choose
>>>>>>>> on the kernel command line to enable it or not.
>>>>>>>
>>>>>>> This says what is happening, but not why?
>>>>>>>
>>>>>>>> Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
>>>>>>>
>>>>>>> Why are we using a 1990's technology for a new feature?  What is this
>>>>>>> going to allow to have happen?  Who needs/wants this?  Who will use it?
>>>>>>> For what?
>>>>>>
>>>>>> The goal is to ease the transition to disable CONFIG_VT.
>>>>>>
>>>>>> So if this is merged, you can boot without VT on any Linux distribution,
>>>>>> without rebuilding the kernel.
>>>>>
>>>>> But that's a distro-specific thing, the distro should be enabling or
>>>>> disabling the option as it needs, it should not be a user-configurable
>>>>> boot-time selection option as userspace depends entirely on this either
>>>>> being there or not.  Why would you have a kernel with both options but
>>>>> userspace without that?
>>>>
>>>> Actually the userspace side works with or without VT, at least with Fedora,
>>>> I've my Gnome session in both cases.
>>>
>>> Great!  Then why is this even needed?  Who wants such a "let's not make
>>> up our mind until we boot" type of system?
>>>
>>> Given that traditionally the command line is a "secure" thing, that is
>>> locked down by distros and orginizations, who would ever be able to be
>>> changing this type of thing?  Who would want to support userspace that
>>> handles both at the same time?
>>>
>>> I don't see the issue here, if a distro doesn't want to support VT, then
>>> disable it in the kernel and all is good.  If they do want to support
>>> it, than enable it.  Don't do both :)
>>
>> Maybe the real issue is that VT cannot be built as a module.
>> That way the userspace would be able to load it only if it needs it.
>>
>> That's probably more complex than my 3 lines patch, but I can try.
>> Would you prefer it that way?
> 
> If that would make it simpler for a distro to handle this, perhaps.  Try
> it and see, I think the last time this came up, unwinding this into a
> module just wasn't possible, but that might have been a long time ago, I
> can't recall.
> 
> But again, why wouldn't a distro pick a "this is what we are going to
> support" line and stick with it?  Why would they want to support both?
> 

It's all about the transition. Talks about VT-less system started in 
2012, but since then no major desktop Linux distribution have done it.
I think that one of the reason, is that if you switch off VT, of course 
some users will complain, as it has a lot of implications.
Telling them to go rebuild their kernel is not good. Telling them to run 
grubby to change the kernel command line until they find alternative for 
their use case is better. They can experiment and do the switch when 
they are ready.
Really it's nothing more than that.
I don't think a distribution will want to maintain VT and noVT for a 
long time.

Thanks,

-- 

Jocelyn


> thanks,
> 
> greg k-h
> 

