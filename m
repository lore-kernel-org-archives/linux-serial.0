Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908525487C;
	Mon,  3 Aug 2026 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785732416; cv=none; b=rc8pxy1bzxB60kwoy2HnggEM7Q0sYwvxyqXLg8INI5Ia8tZmWUuX8QQnyz5pbVYZjlZ5jtJ1YaV5bvQV4DNOvt0Lida0spQxVhxpqR33ZEXvQtDkCj+h2FCxzfA2lppXb4CV7S+KT+GfzAF39svs6W4XNk9wU/teZnNtsYQ2nfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785732416; c=relaxed/simple;
	bh=ssCjDaDCm81QLG8YnQ9oWOUT0noCAg1hmg5X8ReqBjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBLGZ5EXvm6gFCK+qoAKzmj9nt7xYTG/uIuXM0iZ0gGhkVs4wuaCYzXNiiTuDQWFyZrOIWIq4mgorFzy6ytRiikGBDSNdfMFUZntgTJyKjiiU2dVKcU1xVvbIAbPUsbcN/2f2I0laQeLHbQ0ePbL1p9fGxGmqA46SC/sI3lWfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8VoA1xo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8VoA1xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44A71F000E9;
	Mon,  3 Aug 2026 04:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785732415;
	bh=THNhJrW8qY0WU/HoVHqGfzwC7VukSSewoNV72JuUbSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M8VoA1xo85IoPPM138W4P5hR1bQL7tSYAbZl6WM6Kc+ADKVCuH6siNUBLBPxUXAwG
	 z6BUkxum7eWvyBFBEbl31VMctiEdCyAWHQtxkPeNJNKMIJy3wYoDjo7cNpVXYo7rD3
	 kOOUdnWO3TrdbHtUwYYGsnvoUwENUORk+UY1NuIfXNK6z1JPV7HmeEPV2CQfBlPwZQ
	 L1yzZ85XjUSPtxztHTzb1Rf3HQQER045vVVGs5YFTl8mNjSEccLpB4e2enUGYgTGuS
	 zupYHC7O6e0Yl0MXF0Hjh2e6PCDM+Tml6ays7XFeojH3CGKru1nGmjueZ52cReWFBo
	 IwQjZJ7wDcRNg==
Message-ID: <7a4900a7-bd31-46ee-81ee-d597899a34de@kernel.org>
Date: Mon, 3 Aug 2026 06:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] serial: 8250_mxpcie: speed up TX using
 memory-mapped FIFO window
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
 <20260731074820.735619-9-crescentcy.hsieh@moxa.com>
 <CAHp75VdL71oE-E85fOLbz36bhs3EKg1iL_vtNP+TQzek5PNqnQ@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CAHp75VdL71oE-E85fOLbz36bhs3EKg1iL_vtNP+TQzek5PNqnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02. 08. 26, 11:10, Andy Shevchenko wrote:
> On Fri, Jul 31, 2026 at 10:49 AM Crescent Hsieh
> <crescentcy.hsieh@moxa.com> wrote:
>>
>> The MUEx50 UART provides a memory-mapped TX FIFO data window along with
>> a TX FIFO level counter.
>>
>> Fill the TX FIFO in bulk via the MMIO FIFO window based on available
>> FIFO space, using uart_port_tx_limited() for the common serial-core TX
>> handling.
> 
> ...
> 
>> +static void mxpcie8250_tx_chars(struct uart_8250_port *up)
>> +{
>> +       struct uart_port *port = &up->port;
>> +       unsigned int offset = 0;
>> +       unsigned char c;
>> +
>> +       uart_port_tx_limited(port, c, port->fifosize - serial_in(up, MOXA_PUART_TX_FIFO_CNT),
>> +                            true,
>> +                            serial_out(up, MOXA_PUART_TX_FIFO_MEM + offset++, c),
>> +                            ({}));
>> +}
> 
> At least three randomly chosen drivers use the empty tx_done, perhaps
> it's time to have a helper that embeds this ugly piece in it and hides
> from the driver?

I haven't tried, can we make the helper a variadic macro?

-- 
js
suse labs
