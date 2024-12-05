Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA71D0DEC
	for <linux-serial@vger.kernel.org>; Thu,  5 Dec 2024 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388707; cv=none; b=UfgEBYAPHl0SaKS/awNAqNSTm+59XKCub3fzGlUYeB6BwWY2p1q45zbGNb9vg46l9ZvBT0bP/fQiok8vv/vL+O2RqNVzD0m7DZFYUPPBK4A07OcmEUSd35XBx/cLS+gC1knbX27SVhVgAgMGeMT+7nEcFGrW5VkVi3XBNqvrfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388707; c=relaxed/simple;
	bh=fiqkj+GRvZeuFOzolqiFGreSPgcdv0TDsi5dd2Towps=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cpWAKA+x4Bxvehv7yn6UNeo6qQ1+hJRsOzMyO4HFIqCHSph/szL7r3cRiBFNBOLfykozbvQd9Q/pHTy/yaz8CLik1JvU1Xxt+RFg73CT09He/hYTgxCjkZiFY4qbh96WDzkCB3zHPXvfnHdf5rpqLtziQH7ARd42X10MBbe+jHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZigRGVxg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZigRGVxg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385df53e559so532269f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Dec 2024 00:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733388704; x=1733993504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bu+BjISWLkOjToTmmpDVh9uIKwI+akwDpSA5Z73Jrm4=;
        b=ZigRGVxggyVTIVSZqINO1vdP34ggLGFkV9u7KMUIeTdeXZoW2BZlnIgsFhbl/kSAAf
         USWscXPqzXmunwlKidYk4SWuDx1FjSHdRgLU8YYngUNJOgBnUWXnP+35b1vkr8BrAj7C
         IdZqXctQzTyFwPpa1FC2RkArIqWsnF1Oky/SbFsl4fmL8e60a89jPjQoM4cC6mltHBrG
         YIeE0kzr4k3q72KMzOvIM6Xdl8gWOV3fVSsMQU963ygBOvGR3WzJVMhd71T0Gps6Uaij
         Sz8o/B0acJSJC3ad7kOIsTDsr9Q3/JJpWb9sGsjHE3mQQNUCNy1FV+NXeDdwR+J4MRXT
         oBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388704; x=1733993504;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu+BjISWLkOjToTmmpDVh9uIKwI+akwDpSA5Z73Jrm4=;
        b=KMlszxfzNR3j1AJrKO0q5IBWw8mNiFEu6mGi6XEpQrPRI8CFHqIHbSXU7tpUej2kT3
         8xCba1jMmydm3bco01E/TdVdLrZLBFvWWlrbaXw+tzichJgW/HsTbzJsau/CyEdrTupV
         TaGmZ+ipzyICgJJbFPLvWB3x1D+vanU1fJyR+4S3mXBvJCYxsVvJaeetyTUqyNBHlec0
         dgg/BfRdhyezugl5r6+lJOphTE99SXaWZRD+DID5pXrlLizY45Sq0411f5ONvZdr8rBV
         ooy7NYtdSGk+Rl9NQzsIQYWiHT1eCf9TobOQzisWlRspISAZbNLyhksoN9AHAAcFipMe
         ZzfA==
X-Forwarded-Encrypted: i=1; AJvYcCUyj04Ygzqgb9Vgp77sPEEKghpI9J9MgLqzttYcG8jVEJ3Fz5eb6r29sFRKhSQHl2WazR5ZP5GVDYUUMic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg13dfsBPoft83g2u5upblruxs+w8u9kq2ahMIEho2lh9evAul
	skyyZwglk3jf6VL+zPWbR+6FpsAoG98x/RY581/Ma9lhyllK3gqf7TQi93R/bls=
X-Gm-Gg: ASbGncu3YxDqTuBNyFqE/tMKGDOrA6Td5BT3toHIrAfzyCQj9FnpKi0LXWmOpPEnuom
	wQdl5vzEpQTlRIZrgRJGP50n+6M6Xr/YyHbXuWEKgXO8Z2g4p5Ia9mi2H6REusjTFWgNMqLml2f
	9s88TMiqGhaC8awX3rKtHqlJb1u4VJtV9gCtuR0NxvsWWSTJaOV+gvXH8ar0LVOfkha6iK02RQC
	tKeRimJI35PH/D8B0wh3f8lM2ODZLAC9NzVoCWrFnD+Z5Vs9aE0NSpuEbc=
X-Google-Smtp-Source: AGHT+IEOpwQyKT2ZzfkreqlTf5liiEt9p2jfLaHmcGM387ZkeDSElvomTcEaXCXFcRKTLDZIbgydFg==
X-Received: by 2002:a05:6000:1446:b0:385:ee3f:5cc6 with SMTP id ffacd0b85a97d-385fd4395c7mr6706652f8f.58.1733388703231;
        Thu, 05 Dec 2024 00:51:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbe50sm1326046f8f.99.2024.12.05.00.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 00:51:42 -0800 (PST)
Message-ID: <1d8ea5f9-deb1-4236-ad64-d29a69a44aa2@tuxon.dev>
Date: Thu, 5 Dec 2024 10:51:41 +0200
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
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, geert+renesas@glider.be,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lethal@linux-sh.org,
 g.liakhovetski@gmx.de, groeck@chromium.org, mka@chromium.org,
 ulrich.hecht+renesas@gmail.com, ysato@users.sourceforge.jp,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
 <Z1DLyQdzUzJzRUJJ@shikoro> <b6c7b4d3-021c-4a4b-9e91-316603b348c1@tuxon.dev>
In-Reply-To: <b6c7b4d3-021c-4a4b-9e91-316603b348c1@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 05.12.2024 10:39, Claudiu Beznea wrote:
> Hi, Wolfram,
> 
> On 04.12.2024 23:38, Wolfram Sang wrote:
>> Hi Claudiu,
>>
>>> in the following scenarios:
>>>
>>> 1/ "earlycon keep_bootcon" were present in bootargs
>>> 2/ only "earlycon" was present in bootargs
>>> 3/ none of the "earlycon" or "earlycon keep_bootcon" were present in
>>>    bootargs
>> ...
>>> Please give it a try on your devices as well.
>>
>> Will happily do so. Is there something to look for? Except for "it
>> works"?

Sorry, I noticed I missed to provide a clear answer your question: if boot
works for this scenarios we should be OK.

> 
> As this code touches the earlycon functionality, of interest are the 3
> cases highlighted above:
> 
> 1/ "earlycon keep_bootcon" are both present in bootargs
> 2/ only "earlycon" is present in bootargs
> 3/ none of the "earlycon" or "earlycon keep_bootcon" are present in
>    bootargs
> 
> One other thing, that I was currently able to test only on RZ/G3S, is to
> see how it behaves when the debug serial is described in DT with an alias
> other than zero. E.g., on [1] the debug serial alias on RZ/G3S was changed
> from 0 to 3. With the new alias (3) there were issues that I've tried to
> fix with this series.

If you can also check:
- it boots in this case and
- the serial device with alias zero and the debug serial are both working
  (tx, rx are working) after boot

then we can declare it OK as well.

Thank you,
Claudiu

> 
> Thank you for checking it,
> Claudiu
> 
> [1]
> https://lore.kernel.org/all/20241115134401.3893008-6-claudiu.beznea.uj@bp.renesas.com/
> 
>>
>> Happy hacking,
>>
>>    Wolfram
>>
