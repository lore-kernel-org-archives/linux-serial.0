Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443441D433C
	for <linux-serial@vger.kernel.org>; Thu,  5 Dec 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387992; cv=none; b=FENbpSti2GsZDp4lugquGvQ6ttvANYxOJufwWMUW+XFjiz44sqWbPMBUjDh3o3EFSlCcDFExZebahB4dcScMucodrXpXFGDzW59Eyq4cxF9bj23wbnCgrVy06kBDeJfFAWUR/HsTQnvK+bEoYGGzypJA3WzDqD5tSNzjNdIfFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387992; c=relaxed/simple;
	bh=zIX9HOzLoLL86nvi6qHvpdCdGJ7n5hslz6z/r6JsUWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nYSO0tTfUdJwjyW6sceNjVmflq26KnJwy1OOJOf588D8NSiWcT8uB3FHoado+xspmP1VQEmRNkOJVBH4KkUvW/wx+12OUAKw2Zr7fLgp0RC0tWj4Gq64R2QeqdaHbteHKfyFqmRoTAnkmb3GNQ+nuNDt+oSr1nrstGi2x6IJODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ktIPXkFK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ktIPXkFK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382610c7116so349985f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 05 Dec 2024 00:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733387988; x=1733992788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0FprQ4ddVvDh8O4I/zcWPdzZ7UNHiopsB4Wgd5Dy+A=;
        b=ktIPXkFKJejstHpsGxWK6jwiAfgQ2DEGwpE4f6aRaMde6IUB0Vm5mpgCQIvv4D/fz7
         5zzVZnPUKMF/uQa1A59PO8mBN46xX1dSk2Ytb8VP20dTifNqEDtxGB6SFF4reD74sZUJ
         P9HxiaezQi01ZFdP/i78821/ycdejLKNIyDrioDM046/j4Cx1eQY5OiumNHTV68IDtBs
         khO+nBJ7PdWFHLyPn/ndI3ZEOUb+6hmyKPFL9XzbkJNatHTvrtKdEE0bgSQ2g9G4wOp1
         aTArfTrKANgSlCEUTJrl34QTl0VFd4X4i27kPFknJsnbf1SdTyIUSXQIY3+Ms3BXNHzu
         Wp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387988; x=1733992788;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0FprQ4ddVvDh8O4I/zcWPdzZ7UNHiopsB4Wgd5Dy+A=;
        b=Pg9G/uIH1+TAUCsa8O3GvZPyaFkF1aHImMYxoJgBx1jx2gTzj8vgKNL5nFmptKkcIp
         o/9UmUjwwUDxJYYxwO7I0KljRf5/4RGfkWnUcEg1TWhy2kCjN4g8Zq4A5dETsQwBVJLC
         gt/PiG7APMIV5I3zYKXxrYwcpK6wElod34FavuEWjQeqHsb7XcspNaYAD78zXJCwIYKR
         j79YJ7NZN7zmA0WjZ2sJhjnR3M3QUh8c6NxAJKHH38SzTbyO4squRx7DIW6UUGD1icJg
         3H+A17Gipnh2/zDuxinL52LkNtVkuPvSpMwAsz5jIPVGwSa5zqcBieBKT61/XkGgXMBi
         2wnw==
X-Forwarded-Encrypted: i=1; AJvYcCXM6Q576LcfliUTHQo71/RUHGCJgj6jVzsErJC572ccwHz9WYETb3F2QnC7s1k0hG1VTvTVb3R0+6oAra0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHVIfPAnGk43K9UdEz29DEvBVULxHVEXA938owmYW2YRYu/1P
	btf4i75SwclExa26W/6XuoHhDM1UfeIBUATYis87A3e9iBv6f4qjU7Zh6GE9mmw=
X-Gm-Gg: ASbGncu4cd2bzYGv1P+wfDz4IrzxynuQA/Njg7Fos3nuzcH2gy3kH5qAYDqgBELDCpH
	ouZOwLNU8MK6KYmsds5vsVw0fZ211//XBt5j7SgeoCtarMjAzrcRfRam/G3kOi+unVh+qeon5mM
	6GysnpB5mSkMsnfoKZYnzuZN+HLuXfdLep6PF7z/7+Au5wbWjgOdf2jvaTh8Hvk4cFc4v+gICwX
	WhUaVB3bsZJmNG4ewIzHGufk+p1gDPESPoqCPGwtS3qZKt81YHnjmNDymo=
X-Google-Smtp-Source: AGHT+IGnZ7w6xd/QD+wR9VSNkMT3nkF3hb0p5H4CwWD//yDe7dAOOR+2eVQ3kcyOhsrMoo8tkX43PQ==
X-Received: by 2002:a05:6000:1acd:b0:385:de67:2297 with SMTP id ffacd0b85a97d-385fd532bdcmr6260267f8f.54.1733387988319;
        Thu, 05 Dec 2024 00:39:48 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386221a4ae9sm1288223f8f.98.2024.12.05.00.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 00:39:47 -0800 (PST)
Message-ID: <b6c7b4d3-021c-4a4b-9e91-316603b348c1@tuxon.dev>
Date: Thu, 5 Dec 2024 10:39:45 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/6] serial: sh-sci: Fixes for earlycon and
 keep_bootcon
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, geert+renesas@glider.be,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lethal@linux-sh.org,
 g.liakhovetski@gmx.de, groeck@chromium.org, mka@chromium.org,
 ulrich.hecht+renesas@gmail.com, ysato@users.sourceforge.jp,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <Z1DLyQdzUzJzRUJJ@shikoro>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <Z1DLyQdzUzJzRUJJ@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 04.12.2024 23:38, Wolfram Sang wrote:
> Hi Claudiu,
> 
>> in the following scenarios:
>>
>> 1/ "earlycon keep_bootcon" were present in bootargs
>> 2/ only "earlycon" was present in bootargs
>> 3/ none of the "earlycon" or "earlycon keep_bootcon" were present in
>>    bootargs
> ...
>> Please give it a try on your devices as well.
> 
> Will happily do so. Is there something to look for? Except for "it
> works"?

As this code touches the earlycon functionality, of interest are the 3
cases highlighted above:

1/ "earlycon keep_bootcon" are both present in bootargs
2/ only "earlycon" is present in bootargs
3/ none of the "earlycon" or "earlycon keep_bootcon" are present in
   bootargs

One other thing, that I was currently able to test only on RZ/G3S, is to
see how it behaves when the debug serial is described in DT with an alias
other than zero. E.g., on [1] the debug serial alias on RZ/G3S was changed
from 0 to 3. With the new alias (3) there were issues that I've tried to
fix with this series.

Thank you for checking it,
Claudiu

[1]
https://lore.kernel.org/all/20241115134401.3893008-6-claudiu.beznea.uj@bp.renesas.com/

> 
> Happy hacking,
> 
>    Wolfram
> 
