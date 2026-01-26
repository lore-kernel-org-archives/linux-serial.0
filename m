Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112422E3F0
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430405; cv=none; b=BDgi0cWkfcg7awSbz/7TU2NRI9hCIhbf+EqcpCPsbQRCiOa/2eMi4UmGm4uTS1sf5Ay4L+fF0iZd0MEbaPKXEy+mKjNYQEVPZ5jzk2J9MVt/0RJpGSbxJD+jfelUiOOIQL8S4DdF66iJYyDGPToSuoQaxoojBxIh9p48vumw0Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430405; c=relaxed/simple;
	bh=UQBNreu95MI4Q8V9RC58x2ayLPxj24KYhxgW8Vs2nGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAlE2x8xyKTpct4v53XFneV6pPc6vtpnmcnMvzgXKjZPjGO6Jgb48y51GUrlSwNVkdHZuQ9xgf627et7R9vN057CT8HGMjCn0c6eECv9YhPevropmjSyItikh/fK+f9EOtDg9vvlNB5cbLzdrBG3XZW4GDnOoZLNGx2XPJX/O2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsNDP/cv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsNDP/cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769430403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8Faa0L+qn+PMM8GCfMwSNgO72PmHHclarZT7GZadoQ=;
	b=LsNDP/cvCLY34r1LeFIIuF/BYjhn2eH+WNLrXVVKkJ2GNgBrA2leb4135isll78pfmFEgt
	BMOx55sX50tI254MRJPGZbe6qeWdQ/Y7fdrVyRHH+/7ELl0r/iqAwlSwZu1TYHxfKdHnYY
	fyqm9tUke6UvhLGcWs3Ef3MdXf4b0j0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-J69BQkXDPBWfrOHzrKfuqw-1; Mon, 26 Jan 2026 07:26:39 -0500
X-MC-Unique: J69BQkXDPBWfrOHzrKfuqw-1
X-Mimecast-MFC-AGG-ID: J69BQkXDPBWfrOHzrKfuqw_1769430399
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so38632935e9.3
        for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 04:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430398; x=1770035198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8Faa0L+qn+PMM8GCfMwSNgO72PmHHclarZT7GZadoQ=;
        b=rO99BLQ+2TrxKFdVjLyhKJXc/CpJAPB7EKYd44YxCiki8U53HjG/BEQ5AU/XX3LCKU
         0VC14VJnPtoP7YaxGdIgBOTAuYyLtZdPbGss77PlUPmj5GezylNkfxP3ofbAN/8Wvwve
         TOMQK38NE2TTvtiBrmkSTBKw/OJoyd7i65z+ZpF2Bym/b2LG4PIcISJb61pjM3Boz7S2
         ZdCzmDsTrRBsJqFeLC51PzbFMtwDlR6SAcJi9TiLFJK1K+qqEKwxChK+UgTKqoxn5AXd
         Nr/mt0PoB+Fq9Bi1d4UABUGQ8v9Q2k9jPbs9rb+ruxB3/j4xDeEJQ4stqWkC783B4JA+
         VVOw==
X-Forwarded-Encrypted: i=1; AJvYcCXcTmdTIrhnWoWWzyhOz0pI+5A8iouTJYT8w6dlufE7KnI3kq5iaYFtIh8mv3DHqSp2uUmdFga7tPxRO0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4SmTE2GLGjtnpWDrXzH/SJBV88JeznfJeec1kJrz0nNCH4EG
	r6YgC3RSMg2xpvUAUyZ6pLDfvV9SdhqBupf1p0cBsl6n7sOPMqVlsbeqIag2wUz6wIElyXLQLXc
	DVpjzsan+D/ddSwDP6o1h53Gho66RGQ7mKvCfHYgd9yWsM3JTTLSm5K/ovQMwKd3a4g==
X-Gm-Gg: AZuq6aLEVOOdxbcyGqJLgh+QJ2E4ajKbk/GbeIlyVFkhecDSi3/PIdlCHkLPiOiLOnA
	2f6oQG3ue/yppga8DpnLEHsV0gup+G26osBkwTq/UH36D6AQ53Y4YZ2d98qdwsgj8Cs8NACOsQN
	55D3j9Dejngb60WRHkK0QO0rAoZZ12+oSO4wCD1Pr6oHmHNtOHh0mVHK6bF6Av7k/i+BvTOsbFl
	vNAlSrlnYUJEQaMYwJVWxWFzOmjygb7gpxTDAkjQEyv0rRmKIZzRBvUXTq99OD0aTbsRVYv9GO5
	pXp6SZMLN7Df5LT4592Grz+ekV+gGBV4w0jd5D47wla2U4NRstCdsHTYQjyuSHnUYk/QBoFfqic
	rOD2mMbsc8jckJWkVI2NcEpIA/r+TulF/1B1BZYX41YlqKbDSQQ==
X-Received: by 2002:a05:600c:6812:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-4805ce4d0damr73864785e9.9.1769430398536;
        Mon, 26 Jan 2026 04:26:38 -0800 (PST)
X-Received: by 2002:a05:600c:6812:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-4805ce4d0damr73864555e9.9.1769430398086;
        Mon, 26 Jan 2026 04:26:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d84589bsm273181895e9.3.2026.01.26.04.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 04:26:37 -0800 (PST)
Message-ID: <99371939-e9b2-4114-8e27-e605ebf941de@redhat.com>
Date: Mon, 26 Jan 2026 13:26:34 +0100
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
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <2026012642-threefold-atypical-a3ad@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pCgaR1w8ODpHd89qFBIUhTUwm1QN7UXzl2envY0puJs_1769430399
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 11:59, Greg Kroah-Hartman wrote:
> On Mon, Jan 26, 2026 at 11:48:50AM +0100, Jocelyn Falempe wrote:
>> On 26/01/2026 11:20, Greg Kroah-Hartman wrote:
>>> On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
>>>> On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
>>>>> On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
>>>>>> This allows to build the kernel with CONFIG_VT enabled, and choose
>>>>>> on the kernel command line to enable it or not.
>>>>>
>>>>> This says what is happening, but not why?
>>>>>
>>>>>> Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
>>>>>
>>>>> Why are we using a 1990's technology for a new feature?  What is this
>>>>> going to allow to have happen?  Who needs/wants this?  Who will use it?
>>>>> For what?
>>>>
>>>> The goal is to ease the transition to disable CONFIG_VT.
>>>>
>>>> So if this is merged, you can boot without VT on any Linux distribution,
>>>> without rebuilding the kernel.
>>>
>>> But that's a distro-specific thing, the distro should be enabling or
>>> disabling the option as it needs, it should not be a user-configurable
>>> boot-time selection option as userspace depends entirely on this either
>>> being there or not.  Why would you have a kernel with both options but
>>> userspace without that?
>>
>> Actually the userspace side works with or without VT, at least with Fedora,
>> I've my Gnome session in both cases.
> 
> Great!  Then why is this even needed?  Who wants such a "let's not make
> up our mind until we boot" type of system?
> 
> Given that traditionally the command line is a "secure" thing, that is
> locked down by distros and orginizations, who would ever be able to be
> changing this type of thing?  Who would want to support userspace that
> handles both at the same time?
> 
> I don't see the issue here, if a distro doesn't want to support VT, then
> disable it in the kernel and all is good.  If they do want to support
> it, than enable it.  Don't do both :)

Maybe the real issue is that VT cannot be built as a module.
That way the userspace would be able to load it only if it needs it.

That's probably more complex than my 3 lines patch, but I can try.
Would you prefer it that way?


> 
> thanks,
> 
> greg k-h
> 

