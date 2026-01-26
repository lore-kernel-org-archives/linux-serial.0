Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4030BF60
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468390; cv=none; b=s9z9dkOK2bX46iAhGGXJZd+hKt4yOyM1hYJtYpsN3YHqG/VaqAydwcZZ2W3pVoSqkAHgqxKIuXCQ5WPBnc8EacWnPD8cIuAKX798JjZPdTnwXagHG339LHJzHGcMKWIk07HdhQegu9j2r+KBK+ZH1NMtt7iLC7t5aTiY6Qam9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468390; c=relaxed/simple;
	bh=LZygu8bZmlRR2avZDSz9+Gytd59GFQBczWPSLAsb/N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qfxa5T9Nj+pCtU9+qj/TPfvhpAQj6yWqLejNH0t0Re80/R1lJqenhccaL9ui9pucKnMJyrJ29rVRCZ/EpE0yijXhxICAzkOTnZgwyMlwG4DLpwYPTrL8SKq3C7F+n93DpKXXckDIIhT48CmkM/l4nmImUQRBLdfJ39AKpbWmgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoLUNzmY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoLUNzmY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769468388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Q8p5FirVxhQtEfjtH5PH9EqUasLHpWsZO9RvAKId/o=;
	b=WoLUNzmYYQOZjzuuHA25/9jI+P5fJJrQ91iplKebq/mDaktcASenikyANoovRngKEY7gGf
	8bDkhlHGPybsF4wkRob40ehxDaM3XRhuJSbw2rqE+uGAl5r9Psj1Wzelhtry0z5dEXyKvi
	k8BQiLclUmmQsVdc4n1GXGt/hNG8eF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-p1jjLERoMfGXGcXE3EicNw-1; Mon, 26 Jan 2026 17:59:46 -0500
X-MC-Unique: p1jjLERoMfGXGcXE3EicNw-1
X-Mimecast-MFC-AGG-ID: p1jjLERoMfGXGcXE3EicNw_1769468385
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801ad6e51cso43605355e9.2
        for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 14:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769468385; x=1770073185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Q8p5FirVxhQtEfjtH5PH9EqUasLHpWsZO9RvAKId/o=;
        b=cQ2HUBpSiT+byIBYhWwkZ2EohPpU8QxFseATjOm8UE26HmumqKKA4y6ZLNcd1qoDqr
         aa0MHrkCU23RQk1T9dKfP6oRNQV5Fyc9s6Z289v6upE1HfZHwT22UzwKuRiOBd5EwIX3
         bVqAozTCuHQ6BWf2n5PwS/3zdHTfXU/bciKA2W2eJU9aIlZqY3daTo4xmpSXbPfRBJln
         1BgalhQsHZNQqdPt74iWdV8W0xyg/KtE0rI6OQ6qMnYgkX0+89oJc7KEknUn535H310Z
         GhyKdtFfLJ9yoK2SDttcrQ1sWrOzSDzELBNOL59geK0nobR+FpaQl314z/I+EgITzSBw
         4/2A==
X-Forwarded-Encrypted: i=1; AJvYcCXXoq2bPjKDNbwNXOHRbAskAogz7JNLIoAt19tbTKABWia4mfRBe+pZ6tB9mHhnOZGQ/15HObG9jAWL7m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09tDbeofS+s0A9sLjIrFtBHvKtV+NiVvxWQv9NQI69agSJln7
	pp+R2ldREgxUUOzFvX9eDFrh4eN51Vz2S9s/dmKFsqqxKxg3LEjAm81KGvkgecGuXPerzLpRYi+
	y/17eE0MHiWXefAu645b48pU+C6Fa9FVkCt9yJrd4IQT+W4n1YsRhYBc8ff4UhniKrg==
X-Gm-Gg: AZuq6aIRERAzhU+3qN47B/ywUVA9MorRFISdULajsV8cpI6wcTK5Yhqlmc+wEEiElQO
	9Bmdqxffi+pCnEh0kIzqSa/UxOk5NcbXVSin408d1ER8VJdWKGg6bXozTbJ94higuMA8g9eF8GN
	W+Nwu7Qjr7AFyePnI0r8nP7sXCS2flDs95JBycscOug6ckI4Io0LZKCHBQfo9waT69fhLkoG97x
	xml9trcg2PLrre0TtXAqduiy20Xb3ZNvSXVgH/D5Zl10FZgswZfaKRLj8ZbUw2KVLFrHD0dJQ7I
	6Z9SjOZeEf27PZYKiKIKaHZA/Bf+M4+cXRDmtd16Df3i2xiInxBXaxs5aBbC8DUa7dJUVenP830
	kxJu12ImP+6LSsHf/MhAOBfvBaLbD/BZlz7hc0hws+EaXbi0oRg==
X-Received: by 2002:a05:600c:4693:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-4805d066303mr119945205e9.35.1769468385185;
        Mon, 26 Jan 2026 14:59:45 -0800 (PST)
X-Received: by 2002:a05:600c:4693:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-4805d066303mr119945045e9.35.1769468384740;
        Mon, 26 Jan 2026 14:59:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066aaf30esm19583515e9.0.2026.01.26.14.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 14:59:44 -0800 (PST)
Message-ID: <5707632d-3fd8-4a5e-9273-dd7d48d5b438@redhat.com>
Date: Mon, 26 Jan 2026 23:59:41 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vt: Add enable module parameter
To: Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
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
 <28snspp2-3912-rs5o-04s0-1648504sq90r@syhkavp.arg>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <28snspp2-3912-rs5o-04s0-1648504sq90r@syhkavp.arg>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0NLvOF8cmgWRVdDVYf6sf1NpiVGA0m6zYm49LmtBqss_1769468385
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 18:24, Nicolas Pitre wrote:
> On Mon, 26 Jan 2026, Greg Kroah-Hartman wrote:
> 
>> On Mon, Jan 26, 2026 at 02:05:36PM +0100, Jocelyn Falempe wrote:
>>> I think that one of the reason, is that if you switch off VT, of course some
>>> users will complain, as it has a lot of implications.
>>
>> Again, that's a distro's policy decision to make, don't force the kernel
>> to support a wishy-washy distro's decision :)
> 
> As a daily VT user for my primary Linux interface due to accessibility
> needs, I'm baffled by the idea of distributions removing this support.
> 
> Of course this has lots of implications. For many users with
> disabilities, VT is not optional - it's the only _fully_ usable
> interface.
> 
> Consider this my official objection. Just don't do that.

That patch is clearly for people like you, that will need more time to 
adapt their tools and workflow to a VT-less system.
It's also less practical to develop alternative, if you need to rebuild 
your kernel to disable VT.
Regarding accessibility, I don't see any technical reason why a VT-less 
system would be less efficient that what is currently available with VT.

-- 

Jocelyn

> 
> 
> Nicolas
> 

