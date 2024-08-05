Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009450269;
	Mon,  5 Aug 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877335; cv=none; b=Pe8KWAYEJXGm5Jv8YJ5hAMHY5bSyT1EyhwwqstLw7Q+e21Vmz7RFHMlnlzKaMCDrwDX+O8WBIGJLvbrey0/TyQgfUGtw8sTOkG+cCDHVZ9kFTjyQ/jMjs1zcLOPfRUXQzkGnZhqwEvbcqK9xsPpdYJvwaSwlQImVU7xd61QSJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877335; c=relaxed/simple;
	bh=buWMdJiBFjNIl3Zdlss6nsnG6P87jRDiUQ9VCDRogio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSokHc37+OiojDUK3aQsRLXqOYoVOzY9fMqlZiRkAYWF8X3vD9PhXWLx5upUjh+Bi7ySdSnI4FpjXvTmS3pxRJtmAt2VyG22ESJ4O0lVbw8bNZ0cD/GDb45zCDe0oWn/t8jja9eiSSngONBzlonFoqtnA+UiJjsrpwQyaT2i5JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGVipVjK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGVipVjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B400EC32782;
	Mon,  5 Aug 2024 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722877335;
	bh=buWMdJiBFjNIl3Zdlss6nsnG6P87jRDiUQ9VCDRogio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BGVipVjKalid41sRU8+kvk+mKajZEAjey0KD8qmCDhINhPijVCHEu9ER78gBH0QGG
	 pW87cpO0nEo9l5Gyg8RozCUT8c4/5NeeBGO0q//2TqjKk/g/S09pGsLcZo+0OHEusg
	 yVJbpqf+z6gf7UEHLlJY6lgc1RdHjMrdBO4xBgOkXziiXtrBw+ezScoRFG19pHaAMC
	 n8QJzvMh3TfTAFJT+q1cEgI1Zh0DhewVry/NfvYWjBVAYzExvRBezfzr04g89q4eDm
	 SloaBt+dfJ3G1kRlUSZmyAGskrMHARDI7lWrZf5DEd3ilUSw5zqW/EgFOwZApHBW60
	 znWrKbdfgr2hQ==
Message-ID: <e16df619-4309-45af-bd1e-883498be1b67@kernel.org>
Date: Mon, 5 Aug 2024 19:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
To: Yao Zi <ziyao@disroot.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20240803125510.4699-2-ziyao@disroot.org>
 <ZrCwrWjRgvE0RS98@ziyaolaptop.my.domain>
 <82e7e3a78f784b3ad63094c8a0ab1932@manjaro.org> <7941737.iedYuu7f5S@diego>
 <ZrD8N7_tYAiKCg-C@ziyaolaptop.my.domain>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZrD8N7_tYAiKCg-C@ziyaolaptop.my.domain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/08/2024 18:22, Yao Zi wrote:
> On Mon, Aug 05, 2024 at 01:47:45PM +0200, Heiko Stübner wrote:
>> Am Montag, 5. August 2024, 13:37:11 CEST schrieb Dragan Simic:
>>> On 2024-08-05 12:59, Yao Zi wrote:
>>>> On Sun, Aug 04, 2024 at 04:05:24PM +0200, Krzysztof Kozlowski wrote:
>>>>> On 04/08/2024 15:20, Yao Zi wrote:
>>>>>>>
>>>>>>>> +		compatible = "fixed-clock";
>>>>>>>> +		#clock-cells = <0>;
>>>>>>>> +		clock-frequency = <24000000>;
>>>>>>>> +		clock-output-names = "xin24m";
>>>>>>>> +	};
>>>>>>>> +
>>>>>>>> +	gic: interrupt-controller@fed01000 {
>>>>>>>
>>>>>>> Why this all is outside of SoC?
>>>>>>
>>>>>> Just as Heiko says, device tree for all other Rockchip SoCs don't have
>>>>>> a "soc" node. I didn't know why before but just follow the style.
>>>>>>
>>>>>> If you prefer add a soc node, I am willing to.
>>>>>
>>>>> Surprising as usually we expect MMIO nodes being part of SoC to be 
>>>>> under
>>>>> soc@, but if that's Rockchip preference then fine.
>>>>>
>>>>
>>>> Okay, then I would leave it as is.
>>>>
>>>> For the fixed-clock node, I think "xin24m: clock-24m { }" is okay and
>>>> follows the new rule?
>>>
>>> I find "xin24m: clock-xin24m { }" better, because keeping the "xin24m"
>>> part in /sys listing(s), for example, can only be helpful.
>>
>> I would second that :-) . Like on a number of boards we have for example
>> 125MHz gmac clock generators ... with 2 gmacs, there are 2 of them.
>>
>> I'm not sure the preferred name accounts for that?
>>
>> Similarly we also keep the naming in the regulator node,
>> it's regulator-vcc3v3-somename {} instead of just regulator-3v3 {}.
>>
> 
> "clock-xin24m" wouldn't be more descriptive than "clock-24m" and there
> are usually only a few fixed clocks in dt, thus finding corresponding
> definition isn't a problem I think.
> 
> For the gmac case, Krzysztof, do you think something like
> "clock-125m-gmac1" is acceptable, just like what has been done for
> regulators?
>

How both above fit the generic node naming rule? You add now specific
part - purpose of the clock. The purpose is obvious from
clock-output-names or label. Anyway, not important topic to nak these
patches.

Best regards,
Krzysztof

