Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743949;
	b=o4mNWQP4TRHdtCKbBtrIavSr/+vq2LrFL6X3C9IQTwAPje5g5GJUPLgYqo68dUYGw5h+
	 +IFB3a2MqRdK00Dxg9pYgziS1nu40g1ouBw9ZJGpG4gjyvmJMuWVKyoVxks3aM49yZuev
	 +lWaB7vdLGknB+4pj/U38JW8mvqYZLL/gyc5T5kRuB9uRD80Je+3nhCMxP84hjE+u9J7B
	 5HPmhUG6kQUt5p91euFxdTgbiCqspPjuFb4IFVfLJhvRpaXnMbus3ArIyPxYxXFNHFpjs
	 1gBD+SA2cHIB6Uvkv+ekXcSPcuooavvpazGdqzUju/Zm18gxPrJFc9QM41v4+SEm1Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743949;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:X-Google-Original-From:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=vtZnMJF2vZlZg027D24VbqVYv+QbjJx2DNalcemb7hE=;
	b=M3OJzqSj/Xb7vbqLqCR/b1Ce6Hn853wB/cYPk/vfnMjf3/qT50YYIXLduJxpFD67bIvb
	 KpdsUP6tbDVDBgaML2YoRRFsXPNdZucSFvmFonjPl8BuMaTUYY1uroW7O0wVHj5eaQHvX
	 cHy5N/M+FSAYKA67tYTua9FOVe+hTqg0ydw9hC0wkBo/QfGls+Coyb3/pl3uOQFeuLMyi
	 gUx1ryIfVs89AkfNH+ZyzIELGZF6CjHuY2iRbMcLM2muF5cElwdRwPszVUjpyXKtfHkzL
	 o5qz1HaRkofxUxKGaqFiYmDBfbpmadYcumDAilWZK1PK/jL//vUrG1MWVryeD8jmIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=K57+C3L2;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB9606A326
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8CB9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=K57+C3L2
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b0960fdde9so63450a91.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743948; x=1794348748;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:dkim-signature:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtZnMJF2vZlZg027D24VbqVYv+QbjJx2DNalcemb7hE=;
        b=MOYUabnG+EXthsUvYIY8oOPIG6TO7kITFoRCmxNSe6moi2GQAPS1wgNnmemt6G3kqF
         4Mv4OD54ypveiNRaEU4iPxnCWDlfFyszK0j55UD4nypregMFyps1gkFeOhCFD1uFVN/w
         HkSh1LFEzAHIEQSTGyctSuy6tFxpXbrGCMkapjJAWONuS/H6zfy3DEOzoWzGGqnqkFWv
         cVVzSIxXy9am0hGW6YlOY6z/pk9V4cWTMF16O7AE+8zKVarompYMWvRwZKMEV8ElCz3w
         6xD0aKvAM0mNOSKqwlw9PJ0dmSSaGjiR+Cw3RuWV22M7Niq7YJL3wsFZywRoRZt16QDg
         y55Q==
X-Forwarded-Encrypted: i=1; AKwUvBxQAEnkxkgKtpPvkTrFgWlsBUCFYKOyZ0xGGAeTvfor96PD0BgBplwXjDM8t2UrclVKLnE5JyjiB3/FFEk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UkUd4xnMHtQNWIyAGGTxSzRN60BNEdOWxym6HGkX4YN3pjBf6
	7gnaWDmptWFI5B4R7Mach1rBRbbszHWLzuzefFH7odkyeclUQuk7g7rHQ1os7JCTLNO1EWgXAtV
	OwsDPd3+Jdq3PL53lK1Vo1g2CA+H6MKeXWLKaAjBalIp6ijHidzhTgsD9ATBGijdZSnczmmurdb
	h4759MBoSFcr5y9E89dKXuxgxhuhwO5i40/FMK9k/Ey8KoXxSVqeRZyFUfeJ0iRVGeZABuP/kP4
	JTzlgkYmGEk31nd8C+NrlwJg/c=
X-Gm-Gg: AYBFou2SZzZwq6LWKTCIMmIeMv3TNuvdH1osIfhXWJ/ZTzOVBSwx1wwDpvUUSi8LYPH
	DdXjmIpdgLl7cYqL7SrJpylSiEv+mmXRtWzpsKfcGvCmPsFnEol9ZaTbRWKFZusqeRVYVVulOSC
	zC3PlMzN2v4rX1R8fl4gm5kDIjDqRlUTA8BoGfugXboT0HQM/PHpDVieutmEpvZkteZaTvTSGKL
	kzsbDeBpzz5ihWBcCsOOaDeT4uLmax+QQkxx3VCL2yVuo0ZqvwYPA6LrQ9EVLx8uSpD/6MkMVo8
	kM++DLM7YhuVXMSOrb8GYmtuVjJKapzReubGXpD9agb+B240megBSj/uuKdOleHLMoBCDhbu1mb
	fAJHuVhrmOjkYCVUu00nn5ZNfXQPPzJ9J9exdOS09fziJ2/eu36oPk2o2ksYY6UmFDyMqgxl/rq
	8x8c+VPOMQkOB+XgZnWoOhw5IMv4rkMOZ2rKoBQhg5
X-Received: by 2002:a17:90b:4b89:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3ae897e2a73mr11692022a91.41.1793743948200;
        Tue, 03 Nov 2026 14:12:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b094ced6a3sm125011a91.0.2026.11.03.14.12.27
        for <linux-serial@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:12:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91bebff9fcaso3401286d6.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793743947; x=1794348747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtZnMJF2vZlZg027D24VbqVYv+QbjJx2DNalcemb7hE=;
        b=K57+C3L22hgw4U+Q4/70yUZil/8/Ps+3bw3smGfhKxKi81uoeP0wbtmQBhLIrt+hLT
         f5gvsabfFkyou9OvrQZiaPm1M77d5NhYNP0dbABz7Jokt+Js8kwZkoHLQkTRbVOwb+RU
         MlildZELpoBkjLqUwNURvdgV6NXJYcFSxFq+s=
X-Forwarded-Encrypted: i=1; AKwUvBw519SOkcE2KnDTkDkXs3I0gQ3y/BkztzVTj8BSo6oZVcTwU4f8B/EtkpexdeTilZU+1hxVEOICgoIxp9I=@vger.kernel.org
X-Received: by 2002:a05:622a:412:b0:535:7b01:1ac7 with SMTP id d75a77b69052e-542b3979c2dmr236984701cf.6.1793743946770;
        Tue, 03 Nov 2026 14:12:26 -0800 (PST)
X-Received: by 2002:a05:622a:412:b0:535:7b01:1ac7 with SMTP id d75a77b69052e-542b3979c2dmr236984191cf.6.1793743946136;
        Tue, 03 Nov 2026 14:12:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e012f9dsm1985446d6.25.2026.11.03.14.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:12:25 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
X-Google-Original-From: Florian Fainelli <fainelli@broadcom.com>
Message-ID: <3c034e89-7e17-42c5-9471-159962897a7c@broadcom.com>
Date: Tue, 3 Nov 2026 14:12:22 -0800
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] Revert "drivers: convert sbd_duart.map_guard from
 atomic_t to refcount_t"
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>,
 David Windsor <dwindsor@gmail.com>, Kees Cook <kees@kernel.org>,
 Hans Liljestrand <ishkamiel@gmail.com>, linux-mips@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2605241602220.1450@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605241628110.1450@angie.orcam.me.uk>
Content-Language: en-US, fr-FR
Autocrypt: addr=fainelli@broadcom.com; keydata=
 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
In-Reply-To: <alpine.DEB.2.21.2605241628110.1450@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/24/26 16:12, Maciej W. Rozycki wrote:
> Revert commit 22a33651a56f ("drivers: convert sbd_duart.map_guard from
> atomic_t to refcount_t"), which broke perfectly valid code:
> 
>    ------------[ cut here ]------------
>    WARNING: CPU: 1 PID: 1 at lib/refcount.c:114 sbd_request_port+0x54/0x140
>    refcount_t: increment on 0; use-after-free.
>    CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc2+ #34
>    Stack : 0000000014001fe0 0000000000000000 ffffffff80830000 0000000000000000
>            ffffffff8127bc7a ffffffff8016fe08 ffffffff808d0000 ffffffff808d0000
>            ffffffff807aa828 ffffffff80822337 ffffffff808ce188 a8000001860b0000
>            0000000000000001 0000000000000001 00000000000001c8 ffffffff808a3090
>            00000000000000bb ffffffff801b09d4 a80000018609bb68 ffffffff801231cc
>            ffffffff812a0000 ffffffff80171388 0000000000001000 ffffffff807aa828
>            0000000000000001 0000000000000001 0000000000000000 0000000000000000
>            0000000000000000 a80000018609bab0 0000000000000000 ffffffff803c47cc
>            0000000000000000 0000000000000000 0000000000000000 0000000000000000
>            ffffffff807cb648 ffffffff8010bff8 0000000014001fe1 ffffffff803c47cc
>            ...
>    Call Trace:
>    [<ffffffff8010bff8>] show_stack+0x28/0x88
>    [<ffffffff803c47cc>] dump_stack+0x8c/0xc0
>    [<ffffffff801aff5c>] __warn+0xe0/0x114
>    [<ffffffff801233f0>] warn_slowpath_fmt+0x40/0x50
>    [<ffffffff80455bcc>] sbd_request_port+0x54/0x140
>    [<ffffffff804563a4>] sbd_config_port+0x2c/0x68
>    ---[ end trace f666d696412caa3e ]---
> 
> (report at the offending commit) -- sbd_request_port() is called twice
> per DUART instance, to reserve a resource holding the control register
> block shared between the two channels, so there's no slightest chance
> for an overflow.  Also this doesn't stop the driver from working and
> it's just the reservation that is missing as a result, i.e.:
> 
> 10060100-100601ff : sb1250-duart
> 10060200-100602ff : sb1250-duart
> 
> as from the offending change, vs:
> 
> 10060100-100601ff : sb1250-duart
> 10060200-100602ff : sb1250-duart
> 10060300-100603ff : sb1250-duart
> 
> beforehand, which is surely why the breakage has gone so long unnoticed.
> 
> "If it ain't broke, don't fix it," so just revert the broken commit.
> 
> Fixes: 22a33651a56f ("drivers: convert sbd_duart.map_guard from atomic_t to refcount_t")
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
