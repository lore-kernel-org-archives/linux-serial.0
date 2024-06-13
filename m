Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601061411CC;
	Thu, 13 Jun 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274178; cv=none; b=Hk6yFiTRU6xASsWa6S00ZpiNeEV7F0eWQqWuxzXlajtDOTaZ7cE9i4J1OxfdfK5R0iZMnq5uFYZWKFw3yQzRw00V/grXhf9kklNbLBd72nFXN+1N2Oyq6WQs0IgX4s9Gf5AB2G6n0gsAzV/FTNc0H/JkS7cj47LzvsdDW2oTIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274178; c=relaxed/simple;
	bh=BdbfbVNUJ/Po26LzTgeT+3JT3SDujEdh7tm1Kp1n4aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvkk/YnknteD39Pn8lZg/z+vAIoe4THyecHFLzpZM5Sa0cdkTEC2hmQPE/leirII2gvQRn5T6F0NZ3ZKfWHYkUgymSOAN0Kf1xNMC5n4MovjBQBlmuWrbmJQzq+PljuX4P/Sp0LMxjn5tOFdmdO/A/UhBChscvxMkYhhYKP2sdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=shr24tVK; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="shr24tVK"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 03FA93F527;
	Thu, 13 Jun 2024 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718274172;
	bh=M/shd22WFiumKudU8kq/ozikBnOMR6LjGo5PWIyhknM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=shr24tVKu2/q6Irg1yhS7NC6oSLICEkS0U9+cP+SVmMP9VBiqyNil2IYrwUkPDj9j
	 E/2gH/EHWZjynbaX6I3zeYhPo++TWjaFFiRpKINv5Z9yjglojrTTsqgAnYHiuCzuVY
	 YMY+y7y1j/e6sH+mIFQtrzGF2BXUkARR9d9CLmIBQ8crpvAQG6mcIfvcMbKOpwYV1N
	 zkWczk/sL1tma/i0tU6K6bXkA7i8mB2wkq3ujCE0exQ3H++Kox6TGc4+9jCjVm+ChC
	 kryYwxhzgT0VIVtU91V5JoRRTYcHeBb39xNSE/znqLiVrL7NpFlRugwxblSb/PGebx
	 3NuuNcGKIm0nQ==
Message-ID: <95b28282-c067-4f34-8ddc-1b2b2f0be2a9@canonical.com>
Date: Thu, 13 Jun 2024 18:22:44 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
References: <20240613082528.22591-1-hui.wang@canonical.com>
 <609a4713-2bd0-4ebd-aa75-c4ee1a2fabde@kernel.org>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <609a4713-2bd0-4ebd-aa75-c4ee1a2fabde@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/13/24 17:08, Krzysztof Kozlowski wrote:
> On 13/06/2024 10:25, Hui Wang wrote:
>> In some designs, the chip reset pin is connected to a GPIO, and this
>> GPIO needs to be set correctly before probing the driver, so add a
>> reset-gpios in the device tree.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
> </form letter>

Got it. Will add that tag if I need to change sth in the v4 and need to 
send the v5. :-) I thought the Ack is for Hugo's explanation rather than 
for my 1st patch, I mis-understood it. And I plan to study b4 in the 
near future.

Thanks,

Hui.

> Best regards,
> Krzysztof
>
