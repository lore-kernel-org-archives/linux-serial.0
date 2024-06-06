Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254519D8A4;
	Thu,  6 Jun 2024 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639499; cv=none; b=p2YseBtiZViVvowdDJ+aJKZvlQBFrXv/H5Z0wQbUm+Jj1AHUp9iMJKhZinedoUVP8mPpGTwwpAIHlHaZs9zS3CkTRjEyKwvke8kOg31H6Gc866QpoITKlkQxqt5+POwvOwVJGhRK1d74YEajELOHYwPh6SU8CaHzwVZsLc1Gz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639499; c=relaxed/simple;
	bh=YYt2JX2Ubs8hH9hvuNtgUODLWxer/k+nWbOThS2f2MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RN/8/hI91NeQStxIzAOdClcvGxYTXEb+0FV0S6otEVYByZpECo35qDfWR7wBcrKFYXjpZuRJxdyr2hN8IQ+hs/ejfjtLcHE1PQzfQFqbrMVVPNruHUX1avl+U2C/3oMtu8wDnTGkPPHNAq7U1FLGiUbB5iQsVqEN6vCZeM1DKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jwtWPhJD; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jwtWPhJD"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 73BBA40FCB;
	Thu,  6 Jun 2024 02:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717639489;
	bh=aovh8NZG8ODUjuRfUnNWtsE40V0Und7G002YFBbOuqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jwtWPhJDFVOPZW7DdkCKgaAmmM1kZslCTRJBzk95Cygh8Pdkg+S3+2QSTL1+4oi99
	 xqbYu3Jc/3FgVRp70d4YZ+RxlNUOPDdZZ0QJWIMo1geYpWGf2Ozyiq7DRJ26wRcGEO
	 IEe+zc9efnBgGcCjgHZf2gywEoEaSHI9w4kNYQebYcCZ3g6r8jETN/dD152GsAp8QP
	 caiHqwzeZXxP8yzYyWzjivX4ybqP5jnVoC0Xh3KSzGAHX7bPtwLVrnH9yUVKsRd/kw
	 Fomifr7mUbFV18UnPHTnAYIYJyWAtKwhszjGgllKmUN2+DCv9VlThPPYPLw7pc7M2S
	 a24uqtUiFBmjw==
Message-ID: <f2014d01-a4d3-4fc7-a00c-bd17944701f2@canonical.com>
Date: Thu, 6 Jun 2024 10:04:37 +0800
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
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
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
 <CAHp75VfEONqGBx7xbOKtGcn5z3shzSyUt8WABJqq4yOnweAr3w@mail.gmail.com>
 <1d5c49ea-c021-42cf-b878-83c625e17caa@canonical.com>
 <20240605113246.5a0a6a8840636e835f2bbc4c@hugovil.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240605113246.5a0a6a8840636e835f2bbc4c@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/5/24 23:32, Hugo Villeneuve wrote:
> On Wed, 5 Jun 2024 20:55:21 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
>
>> On 6/5/24 19:19, Andy Shevchenko wrote:
>>> On Wed, Jun 5, 2024 at 1:55 PM Hui Wang<hui.wang@canonical.com>  wrote:
>>>> On 6/5/24 18:30, Maarten Brock wrote:
...
>> # cat /sys/kernel/debug/regmap/spi0.0-port0/registers 1: 10 2: ff 3: 00
>> 4: ec 5: ff 6: ff 7: ff 8: ff 9: ff a: ff b: ff c: ff d: ff e: ff f: 06
> Hi Hui,
> the best way to test a reset pin is with a voltmeter, if you can. It is
> way too easy to get confused with reset pins values/polarities, etc.
Yes. got it.
>
> By the way, if the reset pin is asserted, you cannot communicate with
> the device, therefore dumping registers cannot work for debug purpose.

Got it.  I just use it to check the reset pin status. If the returned 
register values look reasonable (not many 0xff), It means the reset GPIO 
is de-asserted.

Thanks.

> Hugo.
>
>
>>
>
