Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041446BF;
	Mon, 29 Sep 2025 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126156; cv=none; b=M8VC5EREjYxKPiKHZzjHfu/HMVcVRlMQVNi0X/1Rzd5U5SjKq3EJTbstE/B15YOdNUEG9YAoytdE3lVAH0HAqnmMyLUsj40MQYx8gMomIuFe97Sa2kuc4kPXkeEJSNzm95V1pB6yoKcD2+gkroAy5y9cQhdoIjWwNYvIxnTI3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126156; c=relaxed/simple;
	bh=IG8tzWIrSAtAZZUaasYlx0y8dsNW2En5YbN5RfE8pVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcOYM/bg76q9q958HuJzS+5qZNNIFU9kC6Vggd9/6I2vV8RVpSmp5tuuZXzM+eqveYCYim3s31xkfTZ2Tb53IVPPGzNAiR3DmcVSSl/cEwbFVm+5QhOLYcuRhK7RifsV5iLOTZ6Ga5FpKfBAukYEUCWgROz0oQqP/C65DDu6zAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXHz7tVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXHz7tVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE33C4CEF4;
	Mon, 29 Sep 2025 06:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759126155;
	bh=IG8tzWIrSAtAZZUaasYlx0y8dsNW2En5YbN5RfE8pVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XXHz7tVRtlND88PxvcNH+dLgAxfB0HiGNGMlRR4SnY0Fs9zqHR+JLZDUSh3E8z89+
	 m7hboFgDY5rxnwWbl3saZsy+RdMXvlmhXRPlX5PtNwnsZmKs0ygZcOK/Mr0Q4MZ1Kr
	 I0hF9ClVoHAUz9N1cwTTa6CjCL+Ti4kYf4esRkv8us6T/iUhAWLtuv52S+q2yrqg+C
	 n7MTEXN/WbUJU00UlIFb+gn7Mn513cIvHnwxHIV6Wt6xxAzle3tJIv12DV5nO/9FVf
	 olABFC+dS3GDH9cXk4YUgYTPozBbVoujwkYWCQZCBhfDhyw4MCszsIZC9tJN4VfCCQ
	 XqN4fMWgas70Q==
Message-ID: <0a606585-a7fb-4457-99f5-fe9cc75e366a@kernel.org>
Date: Mon, 29 Sep 2025 08:09:12 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] serial: sc16is7xx: use guards for simple mutex
 locks
To: Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org,
 fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
 <20250924153740.806444-6-hugo@hugovil.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250924153740.806444-6-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 09. 25, 17:37, Hugo Villeneuve wrote:
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
...
> @@ -829,9 +827,6 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
>   		break;
>   	}
>   
> -out_port_irq:
> -	mutex_unlock(&one->lock);
> -
>   	return rc;

No need for rc now AFAICT.

>   }
>   
> @@ -874,9 +869,8 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
>   	    (port->rs485.delay_rts_before_send > 0))
>   		msleep(port->rs485.delay_rts_before_send);
>   
> -	mutex_lock(&one->lock);
> +	guard(mutex)(&one->lock);
>   	sc16is7xx_handle_tx(port);
> -	mutex_unlock(&one->lock);
>   }
>   
>   static void sc16is7xx_reconf_rs485(struct uart_port *port)
> @@ -943,9 +937,8 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
>   	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
>   
>   	if (one->port.state) {
> -		mutex_lock(&one->lock);
> +		guard(mutex)(&one->lock);
>   		sc16is7xx_update_mlines(one);
> -		mutex_unlock(&one->lock);
>   
>   		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);

Now the lock is held till here. R U sure it is OK?

thanks,
-- 
js
suse labs
