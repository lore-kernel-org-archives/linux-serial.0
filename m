Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E514AEE2;
	Thu,  7 Aug 2025 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549028; cv=none; b=WSXWbgNa/3vCUTtNKrCqKTvHhEEinKI9tBoQijJFxrlCuMo3c7laQxTvaLpa8BZhEtRrlxyV0APYcCvwzqI6RJFAqwPzxCLTWLOZGJqVRmjau5NSLQ/C1JuyaRk5VetWo82SNZlVlUz0GsdteBjvqxe6a6ViH4VPtiCIla1BifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549028; c=relaxed/simple;
	bh=1IMmTBxYG/qknqYQq7BIw8BK9rTqvbTdhk5QRlq9vU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iLcaNj3EYA6QqlQbAl9o7odYavB5605OLHP5pkUHsGECXhH2QcWYZtVZwnOVdCqGnYwOnL6WnMGf+JIvyaNvDuE/r9SkpEad5QQ5jQx6vlibmdiTsSviE+WCAmtIDfbcg7PEvWkGPKqbjdjAnXsVaalGRUTewFNTtaT6QhsXu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/Cs9Zff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/Cs9Zff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5122C4CEEB;
	Thu,  7 Aug 2025 06:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754549028;
	bh=1IMmTBxYG/qknqYQq7BIw8BK9rTqvbTdhk5QRlq9vU4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=l/Cs9ZffW5Nf9c/YIpemLhHrUqnC8Szc1rTh/MLAeo9Jgo0xwBfv+C+NtuzRvNxS9
	 bnyIaDi37wMFukAIDqm++IFPrKF3IuEEGEuUdIVrhOatrAaZjCr1zLNhW5ByERuBHr
	 QwjFFpQj0tn3rNj7P/cMqRZ1kQfJXAiW4aG5Ial/Ig/Qsd7rYWVuGI4W5Pa/0NGhMi
	 lDS00TTfdyF8hCEtbLNxj9sY0HsNcq19wJO3ZaaUA6YQEhEq2PN//NBIvjRp3BB9Q3
	 SagLbzea1RrRLZnhQGcNfs/iCH4Ybv1DqGvswsxMO1HoSGyJPHXnV0hGKO7qXRtba6
	 LFzlw0JXsAuQw==
Message-ID: <22204a4a-9c10-4aca-8159-a0e69c74cb34@kernel.org>
Date: Thu, 7 Aug 2025 08:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] tty: serial/8250: Fix build warning in
 serial8250_probe_acpi()
From: Jiri Slaby <jirislaby@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
 Abinash Singh <abinashsinghlalotra@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250805195155.742004-1-abinashsinghlalotra@gmail.com>
 <f765eae4-f83e-4c25-9697-2705afd7b9b8@app.fastmail.com>
 <b9f715c0-082f-46a3-b332-d5f6bf53ad71@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <b9f715c0-082f-46a3-b332-d5f6bf53ad71@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07. 08. 25, 7:25, Jiri Slaby wrote:
> On 06. 08. 25, 9:01, Arnd Bergmann wrote:
>> Note how serial8250_register_8250_port() ands up just copying
>> individual members of the passed uart_8250_port structure into
>> the global array of the same type, so one way of addressing
>> this would be to use a structure for initialization that only
>> contains a subset of the uart_8250_port members and can still
>> be allocated on the stack, or possibly be constant.
> 
> Yes:
> https://lore.kernel.org/all/ 
> f84c2ee3-77b4-41c4-8517-26dfb44a2276@kernel.org/

As a PoC, these members from uart_8250_port are really used in 
serial8250_register_8250_port():
struct uart_8250_port2 {
         long unsigned int          iobase;               /*     0     8 */
         resource_size_t            mapbase;              /*     8     8 */
         unsigned char *            membase;              /*    16     8 */
         long unsigned int          irqflags;             /*    24     8 */
         upf_t                      flags;                /*    32     8 */
         enum uart_iotype           iotype;               /*    40     4 */
         unsigned int               tx_loadsz;            /*    44     4 */
         unsigned int               type;                 /*    48     4 */
         u32                        overrun_backoff_time_ms; /*    52 
  4 */
         u32                        capabilities;         /*    56     4 */
         unsigned int               line;                 /*    60     4 */
         /* --- cacheline 1 boundary (64 bytes) --- */
         unsigned int               uartclk;              /*    64     4 */
         unsigned int               ctrl_id;              /*    68     4 */
         unsigned int               port_id;              /*    72     4 */
         unsigned int               irq;                  /*    76     4 */
         unsigned int               fifosize;             /*    80     4 */
         u16                        bugs;                 /*    84     2 */
         u16                        lsr_save_mask;        /*    86     2 */
         unsigned char              regshift;             /*    88     1 */
         unsigned char              hub6;                 /*    89     1 */

         /* XXX 6 bytes hole, try to pack */

         resource_size_t            mapsize;              /*    96     8 */
         struct serial_rs485        rs485;                /*   104    32 */
         /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
         struct serial_rs485        rs485_supported;      /*   136    32 */
         void *                     private_data;         /*   168     8 */
         struct uart_8250_dma *     dma;                  /*   176     8 */
         void                       (*rs485_start_tx)(struct 
uart_8250_port *, bool); /*   184     8 */
         /* --- cacheline 3 boundary (192 bytes) --- */
         void                       (*rs485_stop_tx)(struct 
uart_8250_port *, bool); /*   192     8 */
         void                       (*throttle)(struct uart_port *); /* 
  200     8 */
         void                       (*unthrottle)(struct uart_port *); 
/*   208     8 */
         u32                        (*serial_in)(struct uart_port *, 
unsigned int); /*   216     8 */
         void                       (*serial_out)(struct uart_port *, 
unsigned int, u32); /*   224     8 */
         void                       (*set_termios)(struct uart_port *, 
struct ktermios *, const struct ktermios  *); /*   232     8 */
         void                       (*set_ldisc)(struct uart_port *, 
struct ktermios *); /*   240     8 */
         unsigned int               (*get_mctrl)(struct uart_port *); /* 
   248     8 */
         /* --- cacheline 4 boundary (256 bytes) --- */
         void                       (*set_mctrl)(struct uart_port *, 
unsigned int); /*   256     8 */
         unsigned int               (*get_divisor)(struct uart_port *, 
unsigned int, unsigned int *); /*   264     8 */
         void                       (*set_divisor)(struct uart_port *, 
unsigned int, unsigned int, unsigned int); /*   272     8 */
         int                        (*startup)(struct uart_port *); /* 
280     8 */
         void                       (*shutdown)(struct uart_port *); /* 
  288     8 */
         int                        (*handle_irq)(struct uart_port *); 
/*   296     8 */
         void                       (*pm)(struct uart_port *, unsigned 
int, unsigned int); /*   304     8 */
         void                       (*handle_break)(struct uart_port *); 
/*   312     8 */
         /* --- cacheline 5 boundary (320 bytes) --- */
         int                        (*rs485_config)(struct uart_port *, 
struct ktermios *, struct serial_rs485 *); /*   320     8 */
         struct device *            dev;                  /*   328     8 */
         u32                        (*dl_read)(struct uart_8250_port *); 
/*   336     8 */
         void                       (*dl_write)(struct uart_8250_port *, 
u32); /*   344     8 */

         /* size: 352, cachelines: 6, members: 46 */
         /* sum members: 346, holes: 1, sum holes: 6 */
         /* last cacheline: 32 bytes */
};


-- 
js
suse labs

