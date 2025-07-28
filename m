Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111645038;
	Mon, 28 Jul 2025 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753675648; cv=none; b=kTop0AoE9EX1FWtU7iz6hifjlH9weNq3Tit4Bv+znrzocmL3NYmQJJAHogrsEfg4vEgbgcebMhVW9uy9LKmMVRONpR3CV6av9fYHSFPCpqWwws3pKrs+AB5fuHsENPtU9USSFRcMlrEEW9X11K6DJttnY5OEK7IEdEI0K2LYqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753675648; c=relaxed/simple;
	bh=fdomNWLnFThVBOP8tgvg4AOSqOTTnoRZvG6osUoYBc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpRukRmDOMrFgqKQjuwBdYa1ezrQNeGp9OD/aLFoY5MT+bZhu3dpAGcee2Ho/qyxlLdr6UBR3W4kmLesUyivzZIIZGtlWFrlZLsv0BymNa9LYv8X1FLKWdrcAP/LZwKCwHg7i80ibcFC6V+bXpOm1gCLQS9Bc2ZFaOOf8nzV6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTGCDQOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTGCDQOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03B0C4CEE7;
	Mon, 28 Jul 2025 04:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753675648;
	bh=fdomNWLnFThVBOP8tgvg4AOSqOTTnoRZvG6osUoYBc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTGCDQOf1KOaG8Hzm+T3oiw/sydty6dZISJjRIgXAWBn6QqzfhCfdhbCZMBVhGmQ6
	 CjIUlZ0I33ohhNfPOWII1Nlyut0aso0TWmpPzwM6IQicfYSHa6mCAZKW2uheeTjK3M
	 dw5nDq/5RGbFv1oJP5jYFaz+n1MTTi6w2l8yYhwM=
Date: Mon, 28 Jul 2025 06:07:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
	john.ogness@linutronix.de, pmladek@suse.com, johan@kernel.org,
	namcao@linutronix.de, timur@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] tty: serial: ucc_uart: use WARN_ON() instead of BUG()
Message-ID: <2025072814-splicing-sassy-f33a@gregkh>
References: <aIbV+WbhFMDamaiW@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIbV+WbhFMDamaiW@bhairav-test.ee.iitb.ac.in>

On Mon, Jul 28, 2025 at 07:14:25AM +0530, Akhilesh Patil wrote:
> Replace BUG() with WARN_ON() as recommended in
> Documentation/process/deprecated.rst
> Fix system entering into unstable/break/undebuggable state due to use
> of BUG(). Follow strict suggestions as per [1] [2].
> 
> Link: https://lore.kernel.org/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/lkml/CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com/ [2]
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>  drivers/tty/serial/ucc_uart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
> index 0613f8c11ab1..6214ab1b67cb 100644
> --- a/drivers/tty/serial/ucc_uart.c
> +++ b/drivers/tty/serial/ucc_uart.c
> @@ -223,7 +223,7 @@ static inline dma_addr_t cpu2qe_addr(void *addr, struct uart_qe_port *qe_port)
>  
>  	/* something nasty happened */
>  	printk(KERN_ERR "%s: addr=%p\n", __func__, addr);
> -	BUG();
> +	WARN_ON(1);
>  	return 0;
>  }
>  
> @@ -242,7 +242,7 @@ static inline void *qe2cpu_addr(dma_addr_t addr, struct uart_qe_port *qe_port)
>  
>  	/* something nasty happened */
>  	printk(KERN_ERR "%s: addr=%llx\n", __func__, (u64)addr);
> -	BUG();
> +	WARN_ON(1);
>  	return NULL;
>  }

You can't just do a search/replace for these types of things, otherwise
we would have done so a long time ago.

How did you test this patch?  The BUG() here assumes that if this ever
fires, the system is really broken, how have you recovered from that
broken state?

thanks,

greg k-h
