Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB226A0A7
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424538; cv=none; b=RuQAEpBOJ01ULqr/KNfTmyESS9eRPQNjdL33EvFS1EXTMV0NrYV3vIyojg+FjH0bYeWkf18nMrRrqdNboj+e3XagylG/xp/IIsmXMpSc2NcRE3979Ib4vu6EjoGgqeiXPtIYNWDzRHFP/R1IyjjTd6P2+gKQ/eSL8aQ2HJJ6tk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424538; c=relaxed/simple;
	bh=3q2n7TAt1ox+1FmWf+k4JtpEhaozJaxCWWCAzBwkT7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLNjfwOoNSC1+AXQMYfWuAeyULjDQgScsSW49d8mFwS3/eHzDIzjxhcymNsDCOZTF2CdyuVRvFL+EAYAGMN65Ad1JaxovOdxopRUu6BlzCdouxw5/qIc+mHXIeb9bGozcvSTwKVgg0A/c38Yal2LS3yISBufzDdLb8Yv8Otn0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=St5gbApH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St5gbApH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769424535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyqvQf74Md75SARayBNgkdcIbqMGeKrSDZTRHF08VG8=;
	b=St5gbApHCqeQ2KrHZftFS2FnqxUqd6WG4XhFHrW7rY96kZAlwniE9+ycBSX2FcDFHyUfDw
	doO1g1pv+xwT7/FV/A+62JeWIvYuFlngtuzCk1vW3GH/Eae1Zr4PHoNkoGkY3C5sxM9ynk
	F/hZGamyUrIsI1L78bs5WgcjtNr978c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-QSsNRmcfN4GxUxDPQE4YXg-1; Mon, 26 Jan 2026 05:48:53 -0500
X-MC-Unique: QSsNRmcfN4GxUxDPQE4YXg-1
X-Mimecast-MFC-AGG-ID: QSsNRmcfN4GxUxDPQE4YXg_1769424533
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so41905845e9.2
        for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 02:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424532; x=1770029332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyqvQf74Md75SARayBNgkdcIbqMGeKrSDZTRHF08VG8=;
        b=ffmC8yT99ORC9TgV3PEsQFIf/qjV8+ZvIIxfmdaK1mWs2BDz8uaDTX79J+UW9KLb3b
         pZMMcQi5WvVBtaGog9GvqkUq8i9MU2mFa3AnwYZRhMdqNsQS+JUjNGiDBV/bfl7Acgti
         FgPnSN2wcR+ahVCS8h24NsGubuvErJmdeRgJu2p1vHBEDp+g/J1hWQ4xkhXuun2ZzSRv
         KCwUeecY+gOYxQ5JdT+5TDhtNbTfdxyQq2vT+66Y/SHpmrf7OE2/5onTx32OktpqTtME
         gSw5aN1/uQz46l+UVDT6SHy3jzZY/y5ODf6hf/N4N3p0z7HEfKb6N2+/3BW1B3c63AV+
         3y4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/zIYU6h3GsfOV51JJuiflASNA1NB/ZK+swqhHQlgxWGmlbyZhpk88gbDH95FHC15HbgrzqfRoOxy+CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2oeT4BBu9nsPsHz6FaSSYTSeIwnRYeF/P1SVJyB4yMjg99SD
	Wl+3HLLLWrqtSrTRcqlrdcr1BTniEYGEk3/7uUNqS8TO0TV1vLQhgw/DjJjHRFUrVv5SR+CwgDc
	ZYmJM5s0aYErSJRHpOsPJOeHKoitsnsFHNe+9G8hD+2791+MY+texOGlUyFxuaIiGKw==
X-Gm-Gg: AZuq6aLDsgkj6N8JPaWtPFAda94ulOD0ibkrfImijZTWbi5HjjpT91B5eREAnzlRShn
	k/u79QIPBq/Kj0yHkkm5q0sMuG2MDGAgL/zn+c5jpBmBsPNhFWrJncUMH++jqTqxLtHEWNZGjt3
	EjM04fihYHatriIZ7PGtZzg36ABGedOB2QC53jgh9HKCR5MvbcnPgAnK2bPTnNJ4XeoO4N25EQ1
	/XQTBOtuaCQpmxBCCKyXilBaTkDAvs6xeI4IC1dNrdEH5c9C/fhk3uc3IiDpuJfXawiPTx422qX
	wR2k8v4qHCygaFUbP8yGLWFTWL1IuPkXLK3b//n5jkqGlKfX+Th8bNmRxn4ZZNfsZ4+cDyi/uRe
	WJw9wafKmN8scuLwel+527XYpvNvHUzGHE0E+qQS0RaXBuovJlw==
X-Received: by 2002:a05:600c:46d5:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-4805d06c412mr63792365e9.33.1769424532458;
        Mon, 26 Jan 2026 02:48:52 -0800 (PST)
X-Received: by 2002:a05:600c:46d5:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-4805d06c412mr63792015e9.33.1769424531970;
        Mon, 26 Jan 2026 02:48:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8a5b67sm275961735e9.10.2026.01.26.02.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 02:48:51 -0800 (PST)
Message-ID: <45526d98-57b6-456e-babc-61b7331318c0@redhat.com>
Date: Mon, 26 Jan 2026 11:48:50 +0100
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
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <2026012648-vantage-mummified-2a43@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CreKmECZcmTKOrEphyKEhWiTXc8TPxJOHC6UV1jTSg0_1769424533
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 11:20, Greg Kroah-Hartman wrote:
> On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
>> On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
>>> On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
>>>> This allows to build the kernel with CONFIG_VT enabled, and choose
>>>> on the kernel command line to enable it or not.
>>>
>>> This says what is happening, but not why?
>>>
>>>> Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
>>>
>>> Why are we using a 1990's technology for a new feature?  What is this
>>> going to allow to have happen?  Who needs/wants this?  Who will use it?
>>> For what?
>>
>> The goal is to ease the transition to disable CONFIG_VT.
>>
>> So if this is merged, you can boot without VT on any Linux distribution,
>> without rebuilding the kernel.
> 
> But that's a distro-specific thing, the distro should be enabling or
> disabling the option as it needs, it should not be a user-configurable
> boot-time selection option as userspace depends entirely on this either
> being there or not.  Why would you have a kernel with both options but
> userspace without that?

Actually the userspace side works with or without VT, at least with 
Fedora, I've my Gnome session in both cases.

> 
>> This option will also allow a distribution to disable VT by default, but
>> users that really wants this can enable it on the kernel command line,
>> without rebuilding the kernel.
> 
> Why would a user want that?  If a user really wants it enabled, why
> would userspace even still work and why would they want to not rebuild
> the kernel?

Rebuilding kernel is not user-friendly, changing a kernel cmdline 
parameter is much easier.

> 
>> It will also avoid hacky solution in userspace like this:
>> https://overhead.neocities.org/blog/systemd-logind-seat/#very-hacky-solutions
> 
> Surely that can't be the only way, why can't userspace just handle this
> "properly" if it wants to?

There is no way for userspace to disable the tty that are running in the 
kernel. It can at best ignore them, but for me it's not a proper solution.
> 
>>>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>>>> ---
>>>>    drivers/tty/Kconfig | 13 +++++++++++++
>>>>    drivers/tty/vt/vt.c |  5 +++++
>>>>    2 files changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
>>>> index 149f3d53b7608..2b94c2710687a 100644
>>>> --- a/drivers/tty/Kconfig
>>>> +++ b/drivers/tty/Kconfig
>>>> @@ -41,6 +41,19 @@ config VT
>>>>    	  If unsure, say Y, or else you won't be able to do much with your new
>>>>    	  shiny Linux system :-)
>>>> +config VT_ENABLE
>>>> +	depends on VT
>>>> +	default y
>>>> +	bool "enable VT terminal" if EXPERT
>>>
>>> So no one will ever really use this config option?
>>>
>>> And you are doing 2 things in this patch, not just one, unlike what the
>>> changelog said :(
>>
>> I can split that in two if you prefer.
> 
> I'm objecting to the patch doing something other than what the changelog
> describes, which as you know is not a good thing.
> 

ok, I can fix that in a v2.

>> Adding a module parameter, and adding a Kconfig option, to choose the
>> default for this module parameter.
> 
> I really don't like adding new module parameters that we are going to
> have to now support for forever.  Why not just rely on the config option
> being there or not as-is?  That's why we allowed it to be turned off at
> all, because userspace was going to be moved to not need it anymore.
> Why would we want to support "both" at the same time in the kernel?
> 

This parameter is there to ease the transition to VT-less system. So by 
maintaining this few lines of code, it will be possible to deprecate the 
whole VT in the future.

If a module parameter is not a good solution, I'm open to any solution 
that can disable vt from the kernel command line (userspace init runs to 
late to disable vt).

> thanks,
> 
> greg k-h
> 

