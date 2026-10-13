Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4D39EF20;
	Tue, 13 Oct 2026 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878018; cv=none; b=ANMio1EnYrqGGzXxaJY6w/5ViKMy2h5kCgVoEI8w5CQym+/4FD2nZUpY48mhkeJtH44kE7OzRS0iywYy0un0CsEh347tEDPmRjNNkpLnU1LJ7JzN/+oN5P06E3BZVrG6ZiPJwLHeq3q8fEW3jie9c0A9XXw/mcQppoQfHA8LgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878018; c=relaxed/simple;
	bh=C1aIzE86sqm8McUgnImEBS8yIfSKZgcQeoJe81CHiJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6pN93Va5aS8kwrAbUI15Ma3nBfNc2Bn5WbZGkGtF1L/H8/lBmNSflI3wIhO0IsRkXo80/Y0FkwtT+CQMj90PmkmimMRGrQ6qwtlmvWuydErmu/LqOKQNuvDDgQ54NHTnsY0vGKp8mPBFedU1b7cvTRzwm1AoOD5dDa2F/Tatfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O06Cpeeq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O06Cpeeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5BD1F000FF;
	Tue, 13 Oct 2026 07:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791878017;
	bh=tas9U3V3AeZE1w7vH1v6gtzOKhOJa4ZQMqHk8WaF6lo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O06Cpeeq77ilR7tKOCKDu4+a71dz+XYULvQB1IXFjdQDf7ArhGIN935gv8XzSOw2t
	 SX3rBjlHFUY1+4zgxauoImIUtTQU5VVIpO8cu+Kl4rjf0HYE48v0EQV0BVTEYx6cv6
	 IlD0qYXbvbOZyibNz7e+Nq/J4g5przozM1c5UTHKMQOXPjXMWp79w7JjBs9Q+eRWvE
	 prYycl+aFQvlKPGe2l/w/Hf/5oucr4eygLkNj6alXWMtntZSkS8dGxe/aTkP83iujr
	 /WDzseCHefgktv1LxFuRV/e/5ovV5iNMwPjG7znKnaPTAt/zrJ961CTEM8MzRDcMyC
	 jCMnoBmtlzh7w==
Message-ID: <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
Date: Tue, 13 Oct 2026 09:53:26 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
 Scott Branden <scott.branden@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>,
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-hardening@vger.kernel.org
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <as3etnbZatn4sbfx@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13. 10. 26, 9:33, Andy Shevchenko wrote:
> On Tue, Oct 13, 2026 at 08:48:51AM +0200, Jiri Slaby (SUSE) wrote:
>> serial8250_register_8250_port() returns a line number and the other
>> port operations (serial8250_unregister_port(), serial8250_suspend_port(),
>> serial8250_resume_port()) accept it. Many drivers then convert the line
>> back to the port using serial8250_get_port() anyway.
>>
>> Switch the interface to struct uart_8250_port:
>> * serial8250_register_8250_port() now returns the registered port, or
>> an ERR_PTR() on failure.
>> * serial8250_unregister_port(), serial8250_suspend_port() and
>> serial8250_resume_port() accept the port.
>>
>> Convert all users accordingly. Drivers store the port pointer instead
>> of the line number. Several drivers kept a private struct only to hold
>> the line (airoha, dfl, em, fsl, ioc3); these are dropped and the port
>> is stored as drvdata directly.
>>
>> This also fixes two latent issues:
>> * For a CIR port, serial8250_register_8250_port() used to return 0.
>> Callers stored this as the line, so a later unregister/suspend/resume
>> operated on ttyS0. Now the CIR port itself is returned.
>> * 8250_acorn checked ports[i] > 0 on removal, so a port registered as
>> line 0 was never unregistered.
>>
>> There are no more users of serial8250_get_port() outside of the 8250
>> core, so drop its EXPORT.
>>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> 
>> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> 
> Why not having Ilpo's Cc in the below list?

He commented on the v1. Now you will be listed here as well.

>> static int aspeed_vuart_probe(struct platform_device *pdev)
> 
>>   	if (of_property_read_bool(np, "auto-flow-control"))
>>   		port.capabilities |= UART_CAP_AFE;
>>   
>> -	rc = serial8250_register_8250_port(&port);
>> -	if (rc < 0)
>> +	struct uart_8250_port *uport = serial8250_register_8250_port(&port);
>> +	if (IS_ERR(uport)) {
>> +		rc = PTR_ERR(uport);
>>   		goto err_sysfs_remove;
>> +	}
> 
> You can get rid of these {} by using PTR_ERR_OR_ZERO().


> Also do not define
> variables in the middle of the code (it's only allowed for auto cleanup
> variables and for-loop iterators).

Why, actually? First, it is used in the kernel quite a few times already 
[1]. Second, while it is sort of c++ism (and I like to use modern c++), 
it makes the life of the variable a lot more obvious.

[1] eg. see output of: rg -U -C 5 '}\n+\s+struct .*\*.*=' drivers/

thanks,
-- 
js
suse labs
