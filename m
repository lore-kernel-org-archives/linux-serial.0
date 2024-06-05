Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A44225D9;
	Wed,  5 Jun 2024 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717567666; cv=none; b=iA1I7f/i7PSWCv7cQnZQCxV88H4juUyhhuWlTBrqv0otiy6T8dqbqlB4Jh3i0LYwd77eFZnPvVLxBJxAH0Ji9z7BHCxQIiHhuY/5bNyjfkFhWRGmbc/9Nd8TBO+76ptMdKrwDGbTjWRl6oRADZS/InkGKrvlJRjo2HhsbhkEGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717567666; c=relaxed/simple;
	bh=/XM0NACg3K9az3N1gkcveTY2vTZKFeEbA3mFqyvgdkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzpIoKZgMncnpXiE0E4RdEk/IBi1m3TH46aJC2eYuZF5sIVU9zGIZhI9/jGEZgtH4OcC0/xWzF8y3m6Robgy5heI3B27Ai3qsuya2+/VhtdU9ZkANonh3SABqON5P+2G//rZWv+qf9gGXAfIJzvpIgHuUm92EJeMCuzcgYTVJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U6RLi2qQ; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U6RLi2qQ"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0242040FA6;
	Wed,  5 Jun 2024 06:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717567663;
	bh=/XM0NACg3K9az3N1gkcveTY2vTZKFeEbA3mFqyvgdkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=U6RLi2qQPZ31IB8YYKkjSjnmZ0e6n3H170NKbgNu4g1LA+Qm3zFD/m0utRXSMFoFR
	 LqiVTviCz+hSjUWQO0ACdLw0Na+ZvGWkfRenaZDTBsRLzkC5xBrlXkS/TtjP458sm1
	 c5GcbrAdgh45uEP/9h5fqScyyjbaaaKF3jY2VY/LtCmxe1deLEhMkOEfIWNcc8AlTs
	 /SQGzrjrOGHr+IOMwp1i/Gc26jIMn4pcFBExJeHKUCim569gGf8AhLrQJf8XJU9z5h
	 lsKErJsBOHWjJRUMtWvfS6VOWboxwf7h5yGU+kMZoiSxZgEhYlTsqriexmdZZmCqjr
	 4maHDynwYmejQ==
Message-ID: <6b1b0635-304c-48d7-a941-fae30962083a@canonical.com>
Date: Wed, 5 Jun 2024 14:07:33 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <1c56b7b3-faea-4d17-88ee-c954e0f69994@kernel.org>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <1c56b7b3-faea-4d17-88ee-c954e0f69994@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/24 21:29, Krzysztof Kozlowski wrote:
> On 04/06/2024 15:27, Hui Wang wrote:
>> In some designs, the chip reset pin is connected to a gpio, this
>> gpio needs to be set correctly before probing the driver, so adding
>> a reset-gpios in the device tree.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Where did these happen?!?!?
>
> NAK
>
> Please talk with your colleagues in Canonical to explain how this works.
> Then read submitting patches document.

Sorry, my bad, I will read submitting-pathces.rst carefully.

Thanks,

Hui.

>
> Best regards,
> Krzysztof
>
