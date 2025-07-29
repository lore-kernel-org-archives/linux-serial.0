Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3C22539D
	for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753824963; cv=none; b=PIlNIdA0TFsh9Cw60Vuws7ZAgLu8VsBElid3+8TizDfTQrYR5u9aEjnOIo6rGStGxv0iQa4GRP7WNqdz/QL44xzILkDztFFQeZgz/7ZRWCq0acw2XyKsnOlxiKyLDUwEvPVBHuhY/YlehvrKPaSAn8pKjBAg1aATk8y642oUgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753824963; c=relaxed/simple;
	bh=TrgIz2OT4qDkw7/yxDSJfKcyMf8vlrlfJceE81V2yjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gu0NHjkz0rXuY9s97zD3tDyKZxeOhk04JHM3cT/mwEru984WdjqEguzNrkYdpgiEsnQZkvCFQCZxfH8JqYAxY5chBAVi2SteB4y7w4foYdSz7dpmssn+wK3+hzs1fo6lcWBqbdpDqCrwyJCIBEOBHLE/BVFPaDdkp7h46tSGV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=LolU6kF2; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="LolU6kF2"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e28be470f1so1312935ab.0
        for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2025 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753824959; x=1754429759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6TTijnB+mf1Tx70AUpgzd27gcsp61CTxKy/bu5Mf0k=;
        b=LolU6kF2PVWI0kgEhS5mW5462kJx3eljcqMhAbCGLyX1BpiwDeEG+I1Q9KytT0iJJ3
         jduKHPyfeqArddaLQiis1m7CkEBR3LfkaB8a8EVhCN04792Rtkmyn5MJ76A+bG3rcp7E
         +vKWSK8VWEdos6YZIIbrvU+AHL0girNTzqwTLYseRvG70FlULzMpibFRvcP73IXG7mKl
         6kLriF/4PIO+2cCzA4IzU6c1tf9hT522KhKqmMrTnI5SZE+g6q51W86L8r5SZZZ2aXmb
         Q0zwqj+nMiGc7aj80SjHVuJ7IZ0QMQBCocf1ePZUkuiBOh9ZjxGs31qzDCx2Tm2JC+/h
         35qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753824959; x=1754429759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6TTijnB+mf1Tx70AUpgzd27gcsp61CTxKy/bu5Mf0k=;
        b=Za43PmCsOChqa/4pfqS2lyiAC0JK4yD4gmASAfctVWRWfEbBLymQUpTpUNNhElc/Mf
         cNn53EIVbmsVHjHnTqo71RdjOj98BEaZYUrdUtFUtI8SlDLhtj2/C5d3EX6rey5xUTot
         OqYYI11UptpTs9DJEeB63mA4hbQYQLhJ8wsL4AtdtrCrqMo1maZgfCuozFwjIyrBO/QF
         o6VjSOLaSMsj8WNNB1UTh6hK7Lu6tSerb82rkUmca92lF4K0N+rTPw0ZbBby1W1Tayhv
         UL7pSDWtrjSDc+dtViiJszJUH6fksWBwgTwsvV0vtklePITpO5bbgugr+w51DIeHFzjJ
         WFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7p1IIktD50jom9d98gKHhFvsisuC93q3x5gVNcgyYlriCE2iA35Y6rEHJI+7zINqsYqB3TLfdff4Kjxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmuYNd2tV2CjVVWrtXiTXdM08mtjYYYgvMO0IW6MpvQpPUO9X
	VXSdxoJjbfnaSkE3l+g3VYoE5RbIjFafZEydu2IC2aY+OaOhbv/8htjLCYM6vt43/us=
X-Gm-Gg: ASbGnct9KyENI8ezn5l9nx8/tcx02on76S5bpNKD4QWdwAWxgdL8hVIfHz9AzCRmpPD
	KIPbDEosIwvITkoYepZzYZsput+FubRUQAC3vwSzdJ0nmVIsTK+7ZkXRr6pzqu5vDFWE+WdCIbw
	X2LX8muU6/ly0G/WVSYtNzHFXg+ok0CmluUKcfkudgDJctHM6fcFECACXfLOfBg6Gbm++Lf/PeJ
	9YWnwuTIHDqhfhBtV+1K4mV5wCM5vENc0c0ocQ6LpRfzmrjFnfQ89TARJw7toCZmRcFVN40wkpr
	Uss6cVTyv5jLEo2IYlpxCJPJFuOLgUFMZYdsUxFAfL6U9TpBGLLhI7tmB3ccSzfdIoA2MYa2m0B
	ISoA3meKHIw0ubEQPntpJnE/JYy5jOsyC/9MryJG84c3Do7MhJkO+9oVmREOfFw==
X-Google-Smtp-Source: AGHT+IH9yMoT3SyI/T66ZtxcPnZNldk6FIOoyhUi5kHT3q4ZE7dn1hQwAMIQq+oM/1pZl9ARWn7tQA==
X-Received: by 2002:a92:db50:0:b0:3e3:b3d0:26cf with SMTP id e9e14a558f8ab-3e3e97254b5mr53179065ab.10.1753824959544;
        Tue, 29 Jul 2025 14:35:59 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c9343739sm2781465173.69.2025.07.29.14.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:35:59 -0700 (PDT)
Message-ID: <79fde2dc-2370-4ec8-94eb-57715cfc2806@riscstar.com>
Date: Tue, 29 Jul 2025 16:35:57 -0500
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: 8250: allow "main" and "uart" as
 clock names
To: Conor Dooley <conor@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lkundrak@v3.sk,
 devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
 spacemit@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250728220002.599554-1-elder@riscstar.com>
 <20250728225319-GYA900803@gentoo>
 <20250729-reshuffle-contented-e6def76b540b@spud>
 <5c3f9f10-6a9d-45b4-80c0-09402b35bf47@riscstar.com>
 <20250729-clench-hastily-b80f11f73336@spud>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250729-clench-hastily-b80f11f73336@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 4:08 PM, Conor Dooley wrote:
> On Tue, Jul 29, 2025 at 04:04:05PM -0500, Alex Elder wrote:
>> On 7/29/25 12:54 PM, Conor Dooley wrote:
>>> On Tue, Jul 29, 2025 at 06:53:19AM +0800, Yixun Lan wrote:
>>>> Hi Alex,
>>>>
>>>> On 17:00 Mon 28 Jul     , Alex Elder wrote:
>>>>> There are two compatible strings defined in "8250.yaml" that require
>>>>> two clocks to be specified, along with their names:
>>>>>     - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
>>>>>     - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"
>>>>>
>>>>> When only one clock is used, the name is not required.  However there
>>>>> are two places that do specify a name:
>>>>>     - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
>>>>>       compatible serial device is named "main"
>>>>>     - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
>>>>>       serial device is named "uart"
>>>>>
>>>>> In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock 'uartclk'
>>>>> and 'reg' for nxp,lpc1850-uart"), Frank Li added the restriction that two
>>>>> named clocks be used for the NXP platform mentioned above.  Extend that
>>>>> so that the two named clocks used by the SpacemiT platform are similarly
>>>>> restricted.
>>>>>
>>>>> Add "main" and "uart" as allowed names when a single clock is specified.
>>>>>
>>>>> Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
>>>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>>>> ---
>>>>>    .../devicetree/bindings/serial/8250.yaml      | 19 ++++++++++++++-----
>>>>>    1 file changed, 14 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
>>>>> index e46bee8d25bf0..cef52ebd8f7da 100644
>>>>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>>>>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>>>>> @@ -61,11 +61,17 @@ allOf:
>>>>>                - const: uartclk
>>>>>                - const: reg
>>>> ..
>>>>>        else:
>>>> would it be better to drop this 'else', and moving following 'if' block
>>>> to the same level with "nxp,lpc1850-uart"?
>>>>
>>>> the reason here would avoid too many indentions if add more constraint in
>>>> the future if other SoC uart need different clock-names..
>>>
>>> I agree, it's more typical to do it that way I think to boot.
>>>
>>> Also, why is there a k1/lpc conditional bit that is not part of the
>>> allOf in addition to the bits in the allOf? Can that get merged with the
>>> allOf please?
>>
>> Are you talking about the blank line here?
> 
> No, I'm talking about what's down around line 270 in the binding.

Oh wow that's in a weird spot, and it might be redundant?

Anyway I'll work on getting that fixed too before I send
my next version.

					-Alex

>>
>>      then:
>>        oneOf:
>>          - required: [ clock-frequency ]
>>          - required: [ clocks ]
>>                             <------ this blank line
>>    - if:
>>        properties:
>>          compatible:
>>            contains:
>>              const: nxp,lpc1850-uart
>>      then:
>>
>> I didn't notice that before.  It got inserted with commit
>> d2db0d7815444 ("dt-bindings: serial: 8250: allow clock
>> 'uartclk' and 'reg' for nxp,lpc1850-uart").
>>
>> If so, yes I'll remove that as well when I update the patch to
>> get rid of the else as Yixun suggests.
>>
>> Greg won't take this for a couple weeks so I'll hold off sending
>> v2 for a while.
>>
>> 					-Alex
>>

