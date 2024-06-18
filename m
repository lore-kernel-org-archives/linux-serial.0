Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C81AC777;
	Tue, 18 Jun 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704317; cv=none; b=pye+sFya5oq8b1mDK/tGev2fuOlY0Dpq8CzgpDjSqfZvQpMN7yUDZ2x22pJ40xfkJOjYXhSC5vDI2tntmf8ByHqqaOPhRshbNQ9TXmERNpl6t7cjkTnqXcCkrNBiPp9fs4NepfA/au0O7acldf75hvwutIIAv7ijUeBxeTo61TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704317; c=relaxed/simple;
	bh=V6G3Uf8lnLdFzV8ghfJZzvu9KzAk7z/NlQT/g7Qtx3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtGOqbBYc95B/16UR/5qHIDX78FnHfAf0TT0abX0cR9dkmFdJ4NuLW4jr8/KH7o3RzHfS2LEOMWF5VjC/o1ROCJCC0mL5hZ/FpztHqp3ts+MheV9OrPjCqUIcIcfNYtJ/aCaUSnDS+iXb+eo7Fw4FVpwv7eoQqbn1tr0PAg6qsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GcAPOWTJ; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GcAPOWTJ"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7A2833F2E0;
	Tue, 18 Jun 2024 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718704306;
	bh=AT6Ux4OQr73lnVvzHIXm8cuYJgw6XPZgJKDkisYJHK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=GcAPOWTJUdcRDhT+V0fM2H1kYLrgApG1C9HlUAYYTBquFKfe6vKsvx7IU7txCILAQ
	 0EtA2rwig39Nob8slFZEH12nHeLETF5wGwvfydh4nssf6M05U1UVv2pHnI/5DdvlG1
	 JXNLNGRiEWS5/uvBf4Ry2iBFDFBPTazDCtHaXLNkKhW/LFWTV0pcZOHpmtVckgQ527
	 d22vEVMOvCKduBg8whE7rUGNa0mbH4LhMnTQ3CA4chMVVuw7tVEqUqCG/eaG/vrP/7
	 kY2EU4z5oa5hL1ebtiWeQ2jL/YjTMc7zZ5pJpLsC1B/KfqR3k+A4gkRq8Avg3hwGQe
	 awSJb1OrqqAjw==
Message-ID: <82a39cb6-7fff-4948-928a-04eccad0e635@canonical.com>
Date: Tue, 18 Jun 2024 17:51:38 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
References: <20240614102952.679806-1-hui.wang@canonical.com>
 <20240614102952.679806-2-hui.wang@canonical.com>
 <20240617120347.907e8e1e8eae5824930dcc48@hugovil.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240617120347.907e8e1e8eae5824930dcc48@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/18/24 00:03, Hugo Villeneuve wrote:
> On Fri, 14 Jun 2024 18:29:52 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
>
> Hi Hui,
>
>> Some boards connect a GPIO to the reset pin, and the reset pin needs
...
>> +	struct gpio_desc *reset_gpio;
>> +
>> +	/*
>> +	 * The reset input is active low, and flag GPIOD_OUT_HIGH ensures the
>> +	 * GPIO is low once devm_gpiod_get_optional returns a valid gpio_desc.
>> +	 */
> I would replace all the above comments with:
>
>    /* Assert reset GPIO if defined and valid. */
>
> The correct polarity is already defined by the device
> tree reset-gpios entry, and can be high or low depending on the design
> (ex: there can be an inverter between the CPU and the chip reset input,
> etc).
>
Agree with that, I will change it in the v6.
>> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(reset_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(reset_gpio), "Failed to get reset GPIO\n");
>> +
...
>> +out_kthread:
>>   	kthread_stop(s->kworker_task);
>>   
>>   out_clk:
>> -- 
>> 2.34.1
>>
> I could not test the validity of the 3us delay since I do not have an
> oscilloscope, but testing with a 10s delay instead and a
> multimeter showed that it works ok. You can add my Tested-by tag:
>
> Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> And if you modify the comment as I suggested above, then you can add my
> R-b tag:
>
> Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
OK. thanks.
>
