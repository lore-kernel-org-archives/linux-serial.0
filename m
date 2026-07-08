Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3B1C84BC;
	Wed,  8 Jul 2026 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490640; cv=none; b=JhRL75MyrjuVWG7Z6oPUj5bmEln8clOaqUlcFV9uQYOUgGqtA/lWe5+mXxw3XVWvX+opSn0Q30X9ebHCxKs8gM/y9/WBDBRu8p29y01T8rMU0EoNB8lcm1Kyh88Wb5Dx5wXH2fvY4dWzU192DjWzOJ6ytd7eRcqw8n9uh71tl/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490640; c=relaxed/simple;
	bh=GHGM6DdqMKYaVkNMvoYlLJ4JgEBlFHcA0prOojP0OkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPYCx04qW7o1tLcqWB6BNUsVQEFhTIohUgG8/WxnDREulYNE+husF9WKMbBH1QwgBTLzVZzR88Et+6WZQMjULEguFBP3BsujP47ulyloQJbyeVL8trkmbNoqJHwYw2gH7HL5tpoybYDPYpALtoyyX4T5LbiTssbrX1A7cojLIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1czfc4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1czfc4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AA31F000E9;
	Wed,  8 Jul 2026 06:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783490638;
	bh=krXgiCcw20UboyAFh1hr7VQZ/rEOaJ/YHz5XUVIESzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N1czfc4x7LSbEyZQduOFeiSBGC2KjuVttAgUTnPlyzKf+Ljd+uFZ5ukQ2uXxq5E8I
	 iZZP2ANSd2gOjYyzI+ijpUnScN+4lWL63ToiXtSZbpzDAJyXW5rbJrxq7wIlXLcE2g
	 1R1YxVe6Gd3r7EPaHYfEqeKwPBeiogx7wCdth0ia0ZwtbTUTvjqhLqdbo5UCrmmIiW
	 9ci87obv72Q5W/WmOZWHKkz/6TJ66R3DQksTZWvTM7kJwlKx3MG5ltDzOo5c3ffCQz
	 JHOh9K9Gj4JMZ2IQBbnZ2URQvg49e9fetNIxzVxIVqg9s2iQhLZi08QIBAuuDubnZW
	 DDkZwzWGuLTLA==
Message-ID: <0ede8499-abe2-41d3-bb0c-095c02c5b699@kernel.org>
Date: Wed, 8 Jul 2026 08:03:55 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] serial: 8250: fix use-after-free in IRQ chain handling
To: Qiliang Yuan <realwujing@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anton Vorontsov <avorontsov@ru.mvista.com>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Wang Zhaolong <wangzhaolong@fnnas.com>
References: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260707-bug-221579-8250-shared-irq-race-v6-1-f8c499a90bdd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ah, now I see you are fixing the same thing as:
https://lore.kernel.org/all/20260708031115.3757150-1-wangzhaolong@fnnas.com/

I did not look up who of you was first.

But:
Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579

Looks like he reported and apparently tries to fix that too ;). You were 
obviously CCed, talk to them and don't send two patches for the same issue.

On 07. 07. 26, 16:06, Qiliang Yuan wrote:
...
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -131,10 +131,11 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
>    * - allocate a new one, add it to the hashtable and return it.
>    */
>   static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_port *up)
> +	__must_hold(&hash_mutex)
>   {
>   	struct irq_info *i;
>   
> -	guard(mutex)(&hash_mutex);
> +	lockdep_assert_held(&hash_mutex);
>   
>   	hash_for_each_possible(irq_lists, i, node, up->port.irq)
>   		if (i->irq == up->port.irq)
> @@ -151,19 +152,37 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
>   	return i;
>   }
>   
> +/*
> + * serial_link_irq_chain() hooks the given 8250 port into the IRQ chain.
> + *
> + * hash_mutex must be held from the hash lookup through the first
> + * request_irq() completion.  Dropping it earlier allows a concurrent
> + * serial_unlink_irq_chain() to race in after i->head is published but
> + * before the IRQ is fully set up — another port sharing the IRQ can then
> + * join the chain and run the shared-IRQ THRE test while IRQ startup is
> + * still in progress, triggering an "Unbalanced enable for IRQ" warning
> + * in kernel/irq/manage.c.
> + */
>   static int serial_link_irq_chain(struct uart_8250_port *up)
>   {
>   	struct irq_info *i;
>   	int ret;
>   
> +	guard(mutex)(&hash_mutex);

hash_mutex is no longer an appropriate name for this lock.

> +
>   	i = serial_get_or_create_irq_info(up);
>   	if (IS_ERR(i))
>   		return PTR_ERR(i);
>   
> +	/*
> +	 * Serialise against the list manipulation in the interrupt handler
> +	 * and in serial_unlink_irq_chain().  hash_mutex is still held which
> +	 * prevents serial_unlink_irq_chain() from entering and freeing the
> +	 * irq_info until the first request_irq() completes.
> +	 */
>   	scoped_guard(spinlock_irq, &i->lock) {
>   		if (i->head) {
>   			list_add(&up->list, i->head);
> -

Unrelated change.

>   			return 0;
>   		}
>   
> @@ -171,11 +190,14 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>   		i->head = &up->list;
>   	}
>   
> -	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
> -	if (ret < 0)
> +	ret = request_irq(up->port.irq, serial8250_interrupt,
> +			  up->port.irqflags, up->port.name, i);
> +	if (ret < 0) {
>   		serial_do_unlink(i, up);
> +		return ret;
> +	}
>   
> -	return ret;
> +	return 0;

Unrelated and mainly unneeded change.

thanks,
-- 
js
suse labs
