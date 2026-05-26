Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2C3B19CA;
	Tue, 26 May 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812353; cv=none; b=K5N+R+HEDc3R0sJ3vDhN/9SX4Mpkm2WBa7pQKzoZ4/wpz7fozOP8g6lVxzv4pAMdw+8ElzWrGshFcjuEuTBFQuOB+F1Rd8m9kn7a+Zilc42h7yNHcMeuNCzk5oISVv4P+Fvz9Ml23lD2dSEfSHxCDn0GwiOp7GihcyOLwvdQohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812353; c=relaxed/simple;
	bh=JsbwqLDVRIMBLhhNOpxsNPRxl0mWwcQVd7ods2rLmNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miPN5YcTNJrQY808B4VOY4lGvJd2klzy1jFlhwYLoM+raEAjGetd7yuO9lDoDFoht77T4xpqNoTLfFVvSD6JQvMsRSac/oRZyZIAWYvx58X95OYvghv+fud6CGHdMSqiKNbLzc1t6Ragyoo9pCm/IHFlHYIor6TeyrKJNtdbAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4vLM4Y2J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4vLM4Y2J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6GtP/vCVv6ZGz1w+hYno+nyoatWi44mbRGtrpc4eVcg=; b=4vLM4Y2JSEzy5CK7Gy/p2wfAn0
	DxE1/eXYHy1iHNZOA6pK1/Rhc0t8Iaa+2XG/U9RuN/D1Xgw6brhps21H2/JP6FipB7EFkpVMowoXy
	qTkMT/YCINSfcb8NCZV4czfXzOsFNix518SCR69dUGQXvcLP5d9xsheGWy05v2VlD2js2ahnKCcX0
	LIEEVseRmSxNLd671PJnbY/k5JrLSLDX1pUBMI2DF+xpbIVeMRRRurYJexRPMYLsdYD6LHo9Q1kG6
	dYmuI9xUOWcrFxr1MdKKTHtfBb8q98cApsPhDpg3ZfbYIQp+oHVMSvAGw1G/c0yd3gnIfxMM8oP1I
	W1ocNcfA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRuUh-00000002Uh5-23fX;
	Tue, 26 May 2026 16:19:03 +0000
Message-ID: <abad0e96-99dc-432d-b81d-553adbd08aa4@infradead.org>
Date: Tue, 26 May 2026 09:19:02 -0700
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: max310x: fix compile errors if
 CONFIG_SPI_MASTER is disabled
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260521153333.2336642-1-hugo@hugovil.com>
 <48b0e694-e75c-4d0a-8698-b0848ccaefeb@infradead.org>
 <20260526093410.6162be940a20372bf766db46@hugovil.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260526093410.6162be940a20372bf766db46@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/26/26 6:34 AM, Hugo Villeneuve wrote:
> On Mon, 25 May 2026 10:43:40 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>>
>>
>> On 5/21/26 8:33 AM, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> Since commit 20ffe4b3330a8 ("serial: max310x: allow driver to be built with
>>> SPI or I2C"), if I2C is enabled and SPI_MASTER is disabled, we have these
>>> compile errors:
>>>
>>>   drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
>>>   drivers/tty/serial/max310x.c: error: 'max310x_spi_driver' undeclared...
>>>   drivers/tty/serial/max310x.c: In function ‘max310x_uart_init’:
>>>   drivers/tty/serial/max310x.c: error: label ‘err_spi_register’
>>>   defined but not used...
>>>   drivers/tty/serial/max310x.c: error: ‘regcfg’ defined but not used
>>>
>>> Fix by properly encapsulating i2c/spi code/variables in their respective
>>> context with IS_ENABLED() macros for CONFIG_I2C and CONFIG_SPI_MASTER.
>>>
>>> Also fix link failure with SERIAL_MAX310X=y and I2C=m by modifying Kconfig
>>> depends.
>>>
>>> Fixes: 20ffe4b3330a8 ("serial: max310x: allow driver to be built with SPI or I2C")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202605121847.N9DVLNg2-lkp@intel.com/
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> ---
>>> note: not Cc-ing stable as the commit is still in tty-next, and even if the
>>> errors originate from original commit that added I2C support, they were not
>>> trigerred because the driver could not be selected/compiled if
>>> CONFIG_SPI_MASTER was disabled.
>>>
>>> Changes for v3:
>>> - Fix link failure with SERIAL_MAX310X=y and I2C=m (Arnd Bergmann)
>>>
>>> Changes for v2:
>>> - replace #ifdef with #if IS_ENABLED() to suppoirt both built-in and modules
>>>   options
>>> ---
>>>  drivers/tty/serial/Kconfig   |  2 +-
>>>  drivers/tty/serial/max310x.c | 48 +++++++++++++++++++-----------------
>>>  2 files changed, 27 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>> index f834e5d292fd7..4accbfa75074c 100644
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -321,7 +321,7 @@ config SERIAL_MAX3100
>>>  
>>>  config SERIAL_MAX310X
>>>  	tristate "MAX310X support"
>>> -	depends on SPI_MASTER || I2C
>>> +	depends on (SPI_MASTER && !I2C) || I2C
>>>  	select SERIAL_CORE
>>>  	select REGMAP_SPI if SPI_MASTER
>>>  	select REGMAP_I2C if I2C
>>
>> Other than preferring Arnd's Kconfig dependencies (easier to
>> read/understand IMO), this is all good.
>> Thanks.
> 
> Hi Randy,
> thank you for testing this.
> 
> I personnaly think both syntaxes are confusing :)
> 
> I have a long term goal of converting this driver to core and
> I2C/SPI parts eventually, like I did for the sc16is7xx...

Yes, I've noticed that some similar drivers are actually 2 drivers.

For the Kconfig, another option is:

	depends on SPI_MASTER || I2C
	depends on I2C if I2C	# limits this config to m if I2C=m

(not tested :)
but it's not necessarily better, just different.

-- 
~Randy

