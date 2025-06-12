Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FEF22F757;
	Thu, 12 Jun 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722493; cv=none; b=bK2mBdbv2IFgwTFO9JAgnxk/US6xH1MtfACPkh+p3LUG1KEbJLr8SAyH7JSsseVSyulb3TjJl5YykGKJFM4P3h2lRdLEq/3SHXBzVh9QoRYY7Uh/HgdsvTieOZR8aNXh3FdMxfC4q7ZNtsliURR77hcicuLf7jpYD39FU1Io/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722493; c=relaxed/simple;
	bh=pJ74ToXUj57KFJ0etElbTUejyf6DV0UJrXtRbHQ6ehI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW77C4fLASptllUfnIrLU3emPvI8TyGulaTbiLO2gQpUotkuP50Yv75fHYlwSioPchJAJ/DDZKB/11Sm6qpo9WSGAZu7c8wlHOCavJfmMQ/sPMM793Y/gb7QRkqwflmJ3tFLESW6PjFMKQlovuBcRmKjBBGTuep9qFEozOB28KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vONqPqot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vONqPqot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D798C4CEEA;
	Thu, 12 Jun 2025 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749722492;
	bh=pJ74ToXUj57KFJ0etElbTUejyf6DV0UJrXtRbHQ6ehI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vONqPqotIVl7pIjTRibV1WZYkzA6rhn9vzGVtv2JUH0ZdwLSlQ/urOenMqmhpgdkz
	 T+G6UNxzIyv4e1vHjK/HUWSOEjtoGCd9axHxYsKDE1CB279xxyzwCbjJs3RVM+Ql1O
	 YdGrFno/HwubvOQicCoz4yWBj8jt8Z+PXHsSQyZ9FIcj2j9IpwrQFyGizKIoYK7BHU
	 pDePsJWE3HwtBJMUih5+bSpoh9ISqfVfKc3Fg6Z/ZUV7rcwQqG53XDcXtA7a0P/IAF
	 +7nA43oWDVNOJHXWAj95upaiHDXHmEwKnYlS+sVoi/z5xcB6lzVkqEc/1Hp3lzQ8a6
	 AfaH67XFanZVA==
Message-ID: <451ac044-6e91-4895-a5b3-cb30396436e5@kernel.org>
Date: Thu, 12 Jun 2025 12:01:29 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/33] serial: 8250: extract serial8250_set_efr()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial <linux-serial@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-24-jirislaby@kernel.org>
 <2b9d3171-6a71-ad9e-8a73-f07487f0ad6b@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2b9d3171-6a71-ad9e-8a73-f07487f0ad6b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11. 06. 25, 14:58, Ilpo Järvinen wrote:
> On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:
> 
>> serial8250_do_set_termios() consists of many registers and up flags
>> settings. Extract all these into separate functions. This time, setting
>> of EFR for UART_CAP_EFR ports.
>>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> ---
>>   drivers/tty/serial/8250/8250_port.c | 43 +++++++++++++++++------------
>>   1 file changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 2c045a4369fc..0f16398cc86f 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -2768,6 +2768,30 @@ static void serial8250_set_ier(struct uart_port *port, struct ktermios *termios)
>>   	serial_port_out(port, UART_IER, up->ier);
>>   }
>>   
>> +static void serial8250_set_efr(struct uart_port *port, struct ktermios *termios)
>> +{
>> +	struct uart_8250_port *up = up_to_u8250p(port);
>> +	u8 efr_reg = UART_EFR;
>> +	u8 efr = 0;
>> +
>> +	if (!(up->capabilities & UART_CAP_EFR))
>> +		return;
>> +
>> +	/*
>> +	 * TI16C752/Startech hardware flow control.  FIXME:
>> +	 * - TI16C752 requires control thresholds to be set.
>> +	 * - UART_MCR_RTS is ineffective if auto-RTS mode is enabled.
>> +	 */
>> +	if (termios->c_cflag & CRTSCTS)
>> +		efr |= UART_EFR_CTS;
>> +
>> +	if (port->flags & UPF_EXAR_EFR)
> 
> I wonder if it is possible to trigger this at all? Only 8250_exar.c sets
> this flag and does not contain UART_CAP_EFR at all (nor uses
> UPF_BOOT_AUTOCONF)??

Impossible as far as I can tell nowadays. Likely since:
commit 6be254c2113d18984bae002b3b3dfc133cf56ac5
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Wed Jul 31 20:05:56 2019 +0300

     serial: 8250_exar: No need to autoconfigure Exar ports

Andy?

The question is whether we need the code or we can drop it 8-).

> 
>> +		efr_reg = UART_XR_EFR;
>> +
>> +	serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
>> +	serial_port_out(port, efr_reg, efr);
>> +}
>> +
>>   void
>>   serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>>   		          const struct ktermios *old)


-- 
js
suse labs
