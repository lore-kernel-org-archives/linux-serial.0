Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0919C566
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424591; cv=none; b=oXCVT8cZKgwpjidWfowffjQD5E6UHymjC31Co/FmiKH/h+NIE3LQ5kl01xm8Jg5mP6RF5rGCq9yvfzm12MNNYkUe8pekISUhtTHUlwC6rMRBRuYw8ZYcuSRKwurO/icQjZTb/tM/twP3ys+qrgEktjNcQQ0gDee3m4OQvuBVBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424591; c=relaxed/simple;
	bh=Oo8JJe93/cM+Q1yaJlfUaR5aDr7iDNesYsFcAbc0O8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2MHLgLTCEDEhY7+Lp1N4hz989l84jg/1jGp8UV/KpZULLq5WTQMIam6iHEaWCVIBFWvUCjgMu/CmONQ0S9AzyxlpMlOw7NCsFlLyJwMjyBCCu6a+MKZzfslqWc2pEy645XC9rnHdcDTkozVAYfjnEh4saoUGOR9eR49Ei1Ofjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8oKQPHI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8oKQPHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769424589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miyVD1VKQI4mtTCbhFiBjFpZ4JFSyDP8wb300TShJsA=;
	b=d8oKQPHIy5ohXezp5MOum4jalIDVB8vOcJR2AFYlQlC20RygZsZGnzc1NE4vipcnvd2TPv
	13HoFLfdyro6qpa05KXw7LnnXZGZz4q6xFvRANmZftn+YNrVuR7rvCmoA8oWQ6yBXbHHt3
	XExS4xwzPgEOCVGsRcPahUzfP2Qz7ak=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-ucOXyS1eM2ut0fksfulXww-1; Mon, 26 Jan 2026 05:49:48 -0500
X-MC-Unique: ucOXyS1eM2ut0fksfulXww-1
X-Mimecast-MFC-AGG-ID: ucOXyS1eM2ut0fksfulXww_1769424587
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43284f60a8aso3010975f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 02:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424587; x=1770029387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miyVD1VKQI4mtTCbhFiBjFpZ4JFSyDP8wb300TShJsA=;
        b=Z1+n42BqYvW8TDaLKZIartZ+RSKuezEh9WHRDQBXYVFQXSKpIsVzpmGIdJGDdTo3tC
         va6g0SwLfQrD5my8ZE5qY0fV43joRk8t8j2XSLZWexWAfE6KZVFBNN05Ml+tTserWJ4I
         hdp4nB26R+1XBFVc3kTbxeHb9lVXmrT48cSwIEwqCA8b4pIHob6e9Du/02rQXCTO2aP7
         qQo0wrtUTfIAjKBjmA94Kk38+6MW0HILdoQsbIvfRed8CiT2tfY/15zXG0VjJYakUVjY
         80j9J0Sej7ynvXwqKo9H0Bt+cWbuhzz8CxNrOnM6kshDLPYZiOEwoVv4+ODTwdw2mvMI
         Mj6A==
X-Forwarded-Encrypted: i=1; AJvYcCWq4sBErP9V9U2PPZjDg/P1c1hJgSnVkgBlX410qxt+y0hDVBu09HVrMAhYmcVrxblgg6uF8YNj+mvpPNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPH1XMc8ZDGGLj1EEfppj0sLvX3+BNPFduELDIN7FYRcEazUOV
	1/MAaaAL/9uwqGzg5n7Kf1G4v7CDNCTJVZymwrlrHMy2GAm9PUdkYnqtyjbZ8ZK7velFhiSAJEn
	tRkIkOcg8WU+yaPvVqCOK+Ltkv3b1f+5xEkcxAJOAM+hoVsvBOduQNcYmorHgWZ7f+Q==
X-Gm-Gg: AZuq6aIeKaxa0q18k3m878eqO4DqoPwfGpUAR+ZeVct7Ynk7YpUZqOgYjJcOpSr/Tk+
	RCZvm/+HpYBi/lpb/+agmWYedlBB+lk7APNez/ann62M8MxK4X099vqwMbLHPSGog91vadaVO/M
	BkAd3wM+SUHeLs7VhWgzXDzcrnBunUPI54/v7WG5adsTv+oZX+2gny1MstOgXl7af8fqi4b70Xx
	PiJhGctHRv7a/Y8Oj3fwwmric5Xp899pwxToXOx/zrQEPVaySoj78AH0kM+x67WDmWxdp35SEh5
	RjO1PF6YxBe9wIysuw1d3rhcvE8jM7cmRpgZv32YPDW2J4bXnG1LesAzetZ3kcuz/sVFaxce7FZ
	kypPf2b5TuRFyNAHCKLDzl5D41V6fxWUG3OzKiErQbuhltUJ8Hw==
X-Received: by 2002:a05:600c:a114:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-4805ce3fac0mr53554565e9.12.1769424586921;
        Mon, 26 Jan 2026 02:49:46 -0800 (PST)
X-Received: by 2002:a05:600c:a114:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-4805ce3fac0mr53554405e9.12.1769424586515;
        Mon, 26 Jan 2026 02:49:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d8c0aebsm265322725e9.15.2026.01.26.02.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 02:49:46 -0800 (PST)
Message-ID: <40fa8cab-af36-4420-9099-511474833fe1@redhat.com>
Date: Mon, 26 Jan 2026 11:49:45 +0100
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
 <2026012659-credit-suing-72ce@gregkh>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <2026012659-credit-suing-72ce@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cSz1KUkQuMYFhANshiMen5ZNGVyrQxk7gmDuvpfyNGo_1769424587
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 11:30, Greg Kroah-Hartman wrote:
> On Mon, Jan 26, 2026 at 11:20:21AM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Jan 26, 2026 at 10:43:35AM +0100, Jocelyn Falempe wrote:
>>> On 26/01/2026 10:33, Greg Kroah-Hartman wrote:
>>>> On Mon, Jan 26, 2026 at 10:21:50AM +0100, Jocelyn Falempe wrote:
>>>>> This allows to build the kernel with CONFIG_VT enabled, and choose
>>>>> on the kernel command line to enable it or not.
>>>>
>>>> This says what is happening, but not why?
>>>>
>>>>> Add vt.enable=1 to force enable, or vt.enable=0 to force disable.
>>>>
>>>> Why are we using a 1990's technology for a new feature?  What is this
>>>> going to allow to have happen?  Who needs/wants this?  Who will use it?
>>>> For what?
>>>
>>> The goal is to ease the transition to disable CONFIG_VT.
>>>
>>> So if this is merged, you can boot without VT on any Linux distribution,
>>> without rebuilding the kernel.
>>
>> But that's a distro-specific thing, the distro should be enabling or
>> disabling the option as it needs, it should not be a user-configurable
>> boot-time selection option as userspace depends entirely on this either
>> being there or not.  Why would you have a kernel with both options but
>> userspace without that?
> 
> And to follow-up on this, if a distro wanted to support this, why not
> just provide 2 different kernel images?  One with this enabled and one
> without?  It's up to the distro to support such a thing, not the kernel
> community, right?

That's clearly not an option, they will prefer to keep VT enabled 
forever than adding yet another kernel package. And for distributions 
that already have kernel and kernel-rt, that means maintaining 4 kernels 
for all combination.

> 
> thanks,
> 
> greg k-h
> 

