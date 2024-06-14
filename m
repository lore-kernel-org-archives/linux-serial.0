Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776F8479;
	Fri, 14 Jun 2024 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333322; cv=none; b=JwZDdbqcp24TrkjPui+AB6jgA/VuVtcTMAHSA8p1hfFN3ew6hyVsjGzDPSAm/vfD/q/LGJ+O6VZHYjaX8NJc9ZP8h7QX+0WfoYx9VaZdNwfI+Ezdb6ZYsUOIF7TDf4cBJ4dasBzAu3I2zR2rTesmG3qJ4vUv8VW2hAHfqUWOPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333322; c=relaxed/simple;
	bh=nJRJKGj8sglZBrfOY3WDwe7MIgU1n4E9xkGE5RJEtAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYVepTtOCdA/nX8pgAUtH73x+m+/LmRzFuIfZbeHD2d2KcyXMEVyqFKzlrPzca1tr0JPSwJLDIjeklX9R2PwKz7hXL0J+kJ0SAyhALiW1zbJWrpiP8AdkD2kxdg3E7Wq9rIOSsDME6ZW2ZAd754T1nO0R7KctOFhLy6rJU0CwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=s5g1m7OS; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s5g1m7OS"
Received: from [192.168.0.106] (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C0A2F3F372;
	Fri, 14 Jun 2024 02:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718333311;
	bh=bJmc0GU+aqdQAqb6VqCMe+1Dm0FPkfRALI+Y1NzLVAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=s5g1m7OSlXsoPjRPXIOk2wEBPkMVvw2y54K2rGiyg1dbed7zPQ57lKddmydYmMVHT
	 Hg/v3zb4xv/sZnh8kEebINU1DyIJZVQskQeZ2c7JFwzSZgHdxZ3+iOyy32NaNLhxyQ
	 UjzIVUQQg/86wNe+7yGdjXnyYXu4RxyYQphphu8Pc5vC+YSws6Rs/ArYxf2NdXw2te
	 iASRLi2FLuXiUvTWbEf1nActaJHNOh31+7H1vKBu6qTGqXM4i1gBFV65kIsn//oh8j
	 IoYNyQa+u//Suc5xpAa06DJ0VLdU0z1w+qeYpSKc9/JjGvzzwi1CzWTjjvKXtfOFEb
	 zOMW1/9QpWF4w==
Message-ID: <51900a3f-9702-4b65-bfe7-cb8671f1668d@canonical.com>
Date: Fri, 14 Jun 2024 10:48:22 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 lech.perczak@camlingroup.com, Maarten.Brock@sttls.nl
References: <20240613082528.22591-1-hui.wang@canonical.com>
 <20240613082528.22591-2-hui.wang@canonical.com>
 <CAHp75VcuobPDHX8eAskc-=SL5_527PqRiNCSfq09=RpP9EH0cA@mail.gmail.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <CAHp75VcuobPDHX8eAskc-=SL5_527PqRiNCSfq09=RpP9EH0cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/14/24 04:47, Andy Shevchenko wrote:
> On Thu, Jun 13, 2024 at 10:26 AM Hui Wang <hui.wang@canonical.com> wrote:
>
>> Some boards connect a GPIO to the reset pin, and the reset pin needs
>> to be setup correctly before accessing the chip.
> set up
Got it.
>> Add a function to handle the chip reset. If the reset-gpios is defined
>> in the DT, do hardware reset through this GPIO, othwerwise do software
> otherwise
Got it.
>> reset as before.
> ...
>
>> +               /* The minimum reset pulse width is 3 us. */
>> +               usleep_range(5, 10);
> Simply use fsleep() and it will take care of the sane API to be called.
OK, Thanks.
>
>> +               gpiod_set_value_cansleep(reset_gpio, 0); /* Deassert GPIO */
