Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F350188596;
	Wed, 24 Jun 2026 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271925; cv=none; b=o1JrwFQxPt8/+/EoFQUvI6bAigI0AgRflWJA7hs+P6eKJQOeo3b6R8Ou243i/VaCYIBBwThjHlbMNLskT8wILf4EOCmjTZhHntWuIPfydMvZhi7LvKNVZb3NXPmx4R9z48NLTf28cpf7WXF5ZkHTMdS8b3eObWxrbPHs3IqDFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271925; c=relaxed/simple;
	bh=Do996C2/sNloJuN03hi+YYXlKvuiUb4MDDsPVqk7FIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1WewUUQnXVoo2swnMIWMr4m/cCoOX5HEJICs6fsO34+CZjNJxKteK46CX9llhoa6DEZg3zIXpf0E1nyRs/Py6iJvPlj+pi5EKx7oNHBZlzFp+GGnS+wmbCI3OWkgmWkzbsAVP+6t3rBu5KkOn34ZTVwF0k4o3hsyluWczmcwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flY7wNiB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flY7wNiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465B61F000E9;
	Wed, 24 Jun 2026 03:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782271923;
	bh=s13ZmqMEmPLgIpo1OWWaAt11YxtksIFc2Keai7UrMIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=flY7wNiBzy/eC/0QaJ8fIDEq74vHrqLGuSscuHZ09w1xEhznQH2uS3n3QPOju1Kf9
	 mXLAfhFLmcwyqmY5fy4vmu3D4z7WdVP7MCeIhBN12QzxwReX3b52Aqq9gmhGbYxXe7
	 wVALwuei/lwqqxPLPO0msdcvmeddU8W6fcmn3Km5Wcge+RtFWfS7wkXh3zW8ye1Ula
	 jM/WBiIf00wBjzXAswdF4l1CGPU0qGLS8yTfdUV6ry+gPhuXvsyYJi7Sh+YKgxv0yh
	 1Ci4EAhNumQnWEX9MtAAvHIKGSQDfM1KX5erQA14+slddB85mKmodEf/wpwR8UcpFU
	 7ukqOPDtL8AZg==
Message-ID: <b7c51606-e95a-4a15-9aff-d0c293ebe986@kernel.org>
Date: Wed, 24 Jun 2026 05:31:59 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] serial: 8250: fix use-after-free in IRQ chain handling
To: Qiliang Yuan <realwujing@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anton Vorontsov <avorontsov@ru.mvista.com>, Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Wang Zhaolong <wangzhaolong@fnnas.com>
References: <20260624-bug-221579-8250-shared-irq-race-v5-1-15d841f89e1e@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260624-bug-221579-8250-shared-irq-race-v5-1-15d841f89e1e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 06. 26, 3:21, Qiliang Yuan wrote:
> serial_unlink_irq_chain() holds hash_mutex and calls free_irq() + kfree(i)
> when it sees an empty port list.  serial_link_irq_chain() released
> hash_mutex after serial_get_or_create_irq_info() but before acquiring
> i->lock.  This gap allowed a concurrent unlink to observe list_empty()
> as true while a new port was still being added, free i, and trigger a
> use-after-free.
> 
> Dropping hash_mutex before request_irq() completes also allows another
> port sharing the same IRQ to join the chain and run the shared-IRQ THRE
> test while IRQ startup is still in progress, which can also trigger the
> "Unbalanced enable for IRQ" warning (kernel/irq/manage.c:774) because
> irq_shutdown() in the premature free_irq() path increments desc->depth,
> breaking the disable_irq/enable_irq pairing in serial8250_THRE_test().
> 
> Fix by pulling hash_mutex into serial_link_irq_chain() and holding it
> across the first request_irq() completion (including the error path)
> so that no concurrent unlink or second-port join can race with IRQ
> setup or cleanup.
> serial_unlink_irq_chain() already holds hash_mutex throughout, so the
> race window is closed.
> 
> Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
> Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
> V4 -> V5:
> - Add __must_hold(&hash_mutex) annotation to
>    serial_get_or_create_irq_info() for static analysis.
> 
> V3 -> V4:
> - Move cleanup under hash_mutex on request_irq() failure to prevent a
>    second port from joining the chain before the irq_info is cleaned up.
> - Fix inaccurate description of irq_shutdown() in commit message.
> 
> V2 -> V3:
> - Hold hash_mutex across the first request_irq() completion to prevent a
>    second port from joining the chain and running the shared-IRQ THRE test
>    while IRQ startup is still in progress.
> 
> V1 -> V2:
> - Add Reported-by tag from Wang Zhaolong.
> 
> v4: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v4-1-cfda63b4420f@gmail.com
> v3: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com
> v2: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com
> v1: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com
> ---
>   drivers/tty/serial/8250/8250_core.c | 56 ++++++++++++++++++++++++++++---------
>   1 file changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index a428e88938eb7..a86505c3dcb67 100644
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
> @@ -151,31 +152,60 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
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
> +	mutex_lock(&hash_mutex);
> +
>   	i = serial_get_or_create_irq_info(up);
> -	if (IS_ERR(i))
> +	if (IS_ERR(i)) {
> +		mutex_unlock(&hash_mutex);
>   		return PTR_ERR(i);
> +	}
>   
> -	scoped_guard(spinlock_irq, &i->lock) {
> -		if (i->head) {
> -			list_add(&up->list, i->head);
> -
> -			return 0;
> -		}
> +	/*
> +	 * Serialise against the list manipulation in the interrupt handler
> +	 * and in serial_unlink_irq_chain().  hash_mutex is still held which
> +	 * prevents serial_unlink_irq_chain() from entering and freeing the
> +	 * irq_info until the first request_irq() completes.
> +	 */
> +	spin_lock_irq(&i->lock);
> +	if (i->head) {
> +		list_add(&up->list, i->head);
> +		spin_unlock_irq(&i->lock);
> +		mutex_unlock(&hash_mutex);

So what is the reason to switch from guards to manual locking?

>   
> -		INIT_LIST_HEAD(&up->list);
> -		i->head = &up->list;
> +		return 0;
>   	}
>   
> -	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
> -	if (ret < 0)
> +	INIT_LIST_HEAD(&up->list);
> +	i->head = &up->list;
> +	spin_unlock_irq(&i->lock);
> +
> +	ret = request_irq(up->port.irq, serial8250_interrupt,
> +			  up->port.irqflags, up->port.name, i);
> +	if (ret < 0) {
>   		serial_do_unlink(i, up);
> +		mutex_unlock(&hash_mutex);
> +		return ret;
> +	}
>   
> -	return ret;
> +	mutex_unlock(&hash_mutex);
> +
> +	return 0;
>   }
>   
>   static void serial_unlink_irq_chain(struct uart_8250_port *up)
> 
> ---
> base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
> change-id: 20260528-bug-221579-8250-shared-irq-race-581e4900a178
> 
> Best regards,


-- 
js
suse labs
