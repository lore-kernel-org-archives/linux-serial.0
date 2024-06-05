Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F30190463;
	Wed,  5 Jun 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569785; cv=none; b=IaKpqdfnICYsC4nMz+dyw8qfawgtvfIWIg3dnIEKeI5dnpoj9ffvY90G3DuD4FBlFE6x+8lJfhjUGbu00flOmBVkJtO8aOZFqxPciPzXLFsdn7LXwUn8yLQ5/iiGQ/bo13fbFDjBLlmq/vDLt76zygZ5zRq1zOihb5/WdG5Zhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569785; c=relaxed/simple;
	bh=yJKv7AecPwKyIXSNdkr0KT5zq5C6ItLlyPG9V8UGefs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvRrR2iixtbbcr76fS5t7BclhvbVCo+aaX6TGCCsj2SqYit2wxvz+m8KZLg2rV+vYwY01ur/+TeN136D4zElrvjFILRTN25mcR4HoJexcE56NFjFz8V2jFU4CWTSbLLrh1HNMBm8AwSLPuxXWcMRbJvOuNzFnMqIAq/Cspv+BXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=c/SgttII; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="c/SgttII"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 420D940F6E;
	Wed,  5 Jun 2024 06:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717569780;
	bh=da2PMN2NaLuPFjAiwZ7RWbO+G5Iadto7S5KAihRqBag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=c/SgttIIkqc5btVIzqXwT9XPZH7rwAq0pmNkPxBa7QgfT+Dv+Bieyg6v/zRu3jCRa
	 17Azza3HRh/RG/2tPqi9ookC8F7HJwTXraf6ayfQ3C9lX75kAlaFLXiTUV4N8PCVeW
	 YsQvRN0h4XYjORHAqVRUQetygvVi0sqqZtd/plcRYDFtyg5uaz5HkKDTTxL+kJKOvF
	 A54BS5nSjoDjiCUiozQJYqTPkPuH2x1/BZg1ZgcM8xdQugChnl8IZyT4DzIR2SsygI
	 dqy9G9MSqPs/iwIrp8unUbViG+/MryKJGZwUtkwwz1KDXyYEq37ZmBsCDHaOR4ZQTP
	 MbPAsO2xAJHCA==
Message-ID: <eab136d3-ca2c-416d-b4e3-43ff922c105d@canonical.com>
Date: Wed, 5 Jun 2024 14:42:49 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: sc16is7xx: hard reset the chip if
 reset-gpios is defined in dt
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com
References: <20240604132726.1272475-1-hui.wang@canonical.com>
 <20240604132726.1272475-2-hui.wang@canonical.com>
 <20240604103427.8986166ad4cf34e1e9357c5c@hugovil.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240604103427.8986166ad4cf34e1e9357c5c@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/24 22:34, Hugo Villeneuve wrote:
> On Tue,  4 Jun 2024 21:27:26 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
>
> Hi Hui,
>
>> Certain designs connect a gpio to the reset pin, and the reset pin
> "Some boards..."
>
>> needs to be setup correctly before accessing the chip.
>>
>> Here adding a function to handle the chip reset. If the reset-gpios is
> "Add a function..."
>
>
Got them, will fix them in the v3.

Thanks.


