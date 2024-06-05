Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AF14D435;
	Wed,  5 Jun 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717592532; cv=none; b=PZNybo+iqQzMSbEK9Hrf+myPa4sNTMI5Z3UMoyXCbm32rX5jTWJa1/mmhCZBD0GBfR5C4jViaNsLh7AT5kG79Xv7hwro/os79+RDPyl4uUOUDGhPmiUc2aN6VWHJ3apiAi2x84P0EZQzrXHbxMiMVZzNEdRje/M6umySfrD0Gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717592532; c=relaxed/simple;
	bh=Hi8bBS84ks95pjw7iOOuGpCf6sztKJkWcQyHl46a098=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWpJZfmaXue0Mjxo6O3zvAkD10E50DZyrcZOQWDTDS+9gWmdbj+kUJK+b2jOZAxXY2VAvMe7IYQo20F3z2gLvpc8+72ZH4nUOtOkjUqv+WnTM4tSTyC2bZHl2ppSvP7zOCpzARmd1a0duDb1r4DfdfryuhqdDFDZjy57VIVvbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sPCILkok; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sPCILkok"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6DD5040FB7;
	Wed,  5 Jun 2024 13:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717592529;
	bh=Hi8bBS84ks95pjw7iOOuGpCf6sztKJkWcQyHl46a098=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=sPCILkokWdWrYGNBa7RX1yr7hdffKnPcKcWZCrbZfmGV7no+adN/+IjgQYFCLV9sU
	 kv0GrCYEKDP6hoiA8fzARUl4isX8fJortyf7p8e0KGzE2RmYqqyzp9iqQEyTP805fW
	 8iWO74dqgcI2puqp8iQ49VUtfPDP94QYCYtdKiby3K6MheNPs0RT0u1BjaLuQfvhwI
	 RtZCGQW3YSSWarDywX+uYJs51SB3zBu3gxEJkP4Kq8Hhei5oAU7ocSwaSCixgWyP83
	 SldVgyw9VEc1zV3wfzJaSScRjpzbjZRwt3+C22HXmED4dWOEKUgHzMMsO5U6jdXhcv
	 5klC84omAAR9w==
Message-ID: <4189bea0-8f7c-446c-bddd-7b4a213ba59b@canonical.com>
Date: Wed, 5 Jun 2024 21:01:59 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Maarten Brock <Maarten.Brock@sttls.nl>, Hugo Villeneuve <hugo@hugovil.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jirislaby@kernel.org" <jirislaby@kernel.org>,
 "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "andy@kernel.org" <andy@kernel.org>,
 "lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com>
 <20240604102323.b2a305fa03161df3c2eec16c@hugovil.com>
 <AS8PR05MB9810940582493046F2FBFDB983F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
 <f56a2c59-9ae4-4d5c-8321-fff9639c5405@canonical.com>
 <AS8PR05MB98104348D77097F60396B82883F92@AS8PR05MB9810.eurprd05.prod.outlook.com>
 <e3f81288-3000-4965-80a5-b68ffccb47fe@kernel.org>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <e3f81288-3000-4965-80a5-b68ffccb47fe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/5/24 19:24, Krzysztof Kozlowski wrote:
> On 05/06/2024 13:19, Maarten Brock wrote:
>>>> To make this a proper reset pulse for the device you must first assert the reset,
>>>> then wait >3us, and finally deassert the reset.
>>>>
>>>> Maarten Brock
>>> Hi Maarten,
>>>
>>> My understanding is when calling devm_gpiod_get_optional(dev, "reset",
>>> GPIOD_OUT_LOW) and returning a valid (gpio_desc *), the flag
>>> GPIOD_OUT_LOW guarantees the GPIO is set to output and low (assert the
>>> reset pin).
>> Ah, right. Sorry, I missed that.
>> So GPIOD_OUT_LOW disregards the inversion from GPIO_ACTIVE_LOW.
> It doesn't.
>
>> And gpiod_set_value_cansleep(reset_gpiod, 0) uses the inversion to make the pin high.
>> Looks fine to me now.
> They both respect pin polarity.

Will correct it.

Thanks.

>
> Best regards,
> Krzysztof
>
