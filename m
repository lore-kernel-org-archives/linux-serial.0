Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793344023;
	b=0u8adTuJWuUxpOxz6WjR0AJgVDmocV0bEoTbbkX+ucMHd6itELtCw42KaeV6rdWLLF5z
	 bkfnEJwaCfLJj2C6+AIYLoNs1LFR1XBR+FFbVDgH4XAhn7+S5hQ9RqfIKJrcUgGgFlSnl
	 M1LOuURlefv0e28emRjKB0fdG0sSVLkS6FkHSQ5YFbzUO1gbgeJVcgciaHCo6fEqldNAi
	 PpMQNJ/pKwKvuF5lVzI44/NN0H+aS3FW9pEKGEBUvlVtvnAxHNVhTgKdg11DPLKqv8KPm
	 pko0O8IlbamKvDIhVju4kR+rfxN6789cxPyd0ehqXj0jioLfENpdKeQReeGFKI0uWVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793344023;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qpXzskV5EfGJ5TngVeJ9Nze/infd4kFnxTnEggJW9hc=;
	b=pRt9rpFY5xVsuHzb1v6z5pdmQBO+V//TVK0qJyGgXGAfGq7WCaF7dO/TVDTdHFSCtLDj
	 58sRXrmDCrO0XBvlvluSon5XZ7PlQKx9P5ZnAsCsGnPhIeuc9i3R/4QeCq6B5q85QvkD6
	 WkHwmIY+uuiBxRBp1WkOMbDXwuwVaRWpmhc/jAQ+LJt6LN9jR6xaHaJMZT1oH9W6DvKpY
	 Gf84mihjHHRwcVsm3bkDVZ+Ik8ekwMYvIsKDkYlOSSGMxWVfAsG92yK+2UwlfsH1Ax+mj
	 ip/txJdmPaM599x6vArA/jImjRIoz25V6rPieMgzKndK7hUebi8gKMJkb/vAsnA6brA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H66/0i6d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08824606A31A;
	Fri, 30 Oct 2026 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H66/0i6d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1361F000C1;
	Fri, 30 Oct 2026 07:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793344022;
	bh=qpXzskV5EfGJ5TngVeJ9Nze/infd4kFnxTnEggJW9hc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H66/0i6dmhGoJh1FbuLeF2Os+fGhx8giTPiPBsHL+Z8kn/hyp2fMrWtnCMDy/Th5q
	 /CImiJeIMBnbDVKq3b4rt6UAOlKRWmsojcx/0gfJ7voBFhdfbZOQDX53LuPyftGxw4
	 qc6lF0uTQb+RxftR+n/cVigjsy8FH3O0D3wxwb9m1gb5V/wMKT9ZGBRp1RzZre0NSC
	 z6Yz5J6+jaeWnXzMflOWzqLShcbU/G5EmMblIEmppppFpSBNQvX0LKfHyW1NgizPb0
	 Ks086XPB3VILn1fY0Hf0xailLOMoW/Z/g4jxvgO/lwB2Eiyg/StIOar87ZUPOeN5ih
	 CeanVR36cmlvw==
Message-ID: <503293d4-3d1e-4852-94c0-0663674fb98b@kernel.org>
Date: Fri, 30 Oct 2026 08:06:52 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] serial: stm32: don't report a wakeup to a closed
 tty
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joshua Rogers <linux@joshua.hu>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Tony Lindgren <tony@atomide.com>,
 Rafael Gago Castano <rgc@hms.se>, Florian Fainelli <f.fainelli@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Robert Baldyga
 <r.baldyga@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>,
 Kukjin Kim <kgene.kim@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Al Cooper <alcooperx@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, stable <stable@kernel.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-24-99b0202ae546@linuxfoundation.org>
 <aef066bc-1b1e-b1e8-97f5-6fa8c8d18940@linux.intel.com>
 <74e02b49-f596-4433-a132-7799029db2a5@kernel.org>
 <84ab00cb-ac35-f1c3-ac9c-fbbdeb210ec2@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <84ab00cb-ac35-f1c3-ac9c-fbbdeb210ec2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29. 10. 26, 12:56, Ilpo Järvinen wrote:
>>>> --- a/drivers/tty/serial/stm32-usart.c
>>>> +++ b/drivers/tty/serial/stm32-usart.c
>>>> @@ -872,8 +872,15 @@ static irqreturn_t stm32_usart_interrupt(int irq,
>>>> void *ptr)
>>>>    		writel_relaxed(USART_ICR_WUCF,
>>>>    			       port->membase + ofs->icr);
>>>>    		stm32_usart_clr_bits(port, ofs->cr3, USART_CR3_WUFIE);
>>>> -		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
>>>> -			pm_wakeup_event(tport->tty->dev, 0);
>>>> +		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq))) {
>>>> +			struct tty_struct *tty = tty_port_tty_get(tport);
>>>> +
>>>> +			/* A console stays set up after the last close */
>>>> +			if (tty) {
>>>> +				pm_wakeup_event(tty->dev, 0);
>>>> +				tty_kref_put(tty);
>>>> +			}
>>>> +		}
>>>
>>> Could we like add a helper into serial core to do this tty wakeup dance?
>>> It is duplicated in quite many of these patches.
>>
>> Likely. Or use scoped_guard(tty_port_tty) at minimum.
> 
> Also the irqd_is_wakeup_set(irq_get_irq_data(xx)) part seemed duplicated
> so it's not just about the reference dance what is duplicated in this
> fragment.

Sure, I was not disputing that.

-- 
js
suse labs
