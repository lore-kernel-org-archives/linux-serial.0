Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33293313E24;
	Fri, 12 Jun 2026 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257853; cv=none; b=EM7NCo+pxOWZ5/tzmQFhN4UBFDCEtad9Z2+XqmiG5by6MP9JBROn6iY1w3/8t+byY6/Nse3HjXw9ud779xe7NODyIs/XumS1pUtOLNqcbQD3aXMBVQiSi6TyUWkycPHhh5Syhczt+bTFxLMPbEokgvaJWRN5gnM7YAYzJckOYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257853; c=relaxed/simple;
	bh=GBrdFC0uWgn5LAqaAyymbMjSlnnehDuIW8Zlmb70uu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3hLdj+yAjzxOE3fnjWTRB6F0wrsUgPBfQj/p+uKqq63D8GAyS14uOfh20WA3dSQSfcJH2LGyEEwfNS0SlsmXhZb26jo5OqwaHhAPiBY1OcBBEutA1thK+l9ids8zx/r2mxLVvAGSu4Af5xGjTX1tpuU0ALRmg1ULWLW21VCdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GHlgVXWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHlgVXWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A751F000E9;
	Fri, 12 Jun 2026 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781257851;
	bh=2RYHgtibAlHPmf7N1hADwXKJ+xJHRiagQX+I9HPvVRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GHlgVXWlK3yt8yw1TuL3zDLV0cbGX5V9VfMt23B2qw2ho9IeAMdSzlLqd3Lyioi0/
	 eTZU4jXAZML6klOfmuoKf8vaCi/xwLZEIzLhu8DztNgbtkCp5rsCwUW+qAYTlyarSP
	 HLVPFyo+OrN+2FE4OnL/SQ6lM6K+p2xWHVA6XQsA=
Date: Fri, 12 Jun 2026 11:49:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Wang Zhaolong <wangzhaolong@fnnas.com>
Subject: Re: [PATCH v4] serial: 8250: fix use-after-free in IRQ chain handling
Message-ID: <2026061213-blinker-portable-a198@gregkh>
References: <20260529-bug-221579-8250-shared-irq-race-v4-1-cfda63b4420f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-bug-221579-8250-shared-irq-race-v4-1-cfda63b4420f@gmail.com>

On Fri, May 29, 2026 at 04:23:34PM +0800, Qiliang Yuan wrote:
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

What real systems causes this to happen?  How are you triggering this
warning to happen?  How was this tested?

> 
> Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
> Reported-by: Wang Zhaolong <wangzhaolong@fnnas.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221579
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
> V3 -> V4:
> - Move cleanup under hash_mutex on request_irq() failure to prevent a
>   second port from joining the chain before the irq_info is cleaned up.
> - Fix inaccurate description of irq_shutdown() in commit message.
> 
> V2 -> V3:
> - Hold hash_mutex across the first request_irq() completion to prevent a
>   second port from joining the chain and running the shared-IRQ THRE test
>   while IRQ startup is still in progress.
> 
> V1 -> V2:
> - Add Reported-by tag from Wang Zhaolong.
> 
> v3: https://lore.kernel.org/r/20260529-bug-221579-8250-shared-irq-race-v3-1-fe4d430862a9@gmail.com
> v2: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com
> v1: https://lore.kernel.org/r/20260528-bug-221579-8250-shared-irq-race-v1-1-30980cca02f3@gmail.com
> ---
>  drivers/tty/serial/8250/8250_core.c | 55 ++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index a428e88938eb7..70d5acfa591bf 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -134,7 +134,7 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
>  {
>  	struct irq_info *i;
>  
> -	guard(mutex)(&hash_mutex);
> +	lockdep_assert_held(&hash_mutex);

Shouldn't the function be marked as requiring this lock to be held?
Just putting in this lockdep_assert will not catch the static analysis
tools :(

thanks,

greg k-h
