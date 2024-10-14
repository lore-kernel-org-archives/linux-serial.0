Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7314375D;
	Mon, 14 Oct 2024 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886240; cv=none; b=gwI0pXf/1WwMVQtyWJY3NMe8wVXYrLmugVms92n0oE2oYls597XHiUpH47nIM4Ni/jtLkdTbe3Ey4ZzBVyvpiX4Z/IHQzv2n5mqSHq/Z6zYqITI3wYty1dlHkMsygut8xeIMamnLOVqbR7VqSmQnKuwA/4LBF1F/SYfRLNleQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886240; c=relaxed/simple;
	bh=vtOULXzKh1W2zjoRRH7MNf2bpYcEKecnN3dY3aNLMSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqclVnQcdKc1Pm50jiEmXbiWQENGq4CsAGgWDyw/OHzUjeYn1Q+5ZYAPLFEbgTl00Ujv1UkWbK+krUfd63wHsoSbGUYXiYvn6hpUlUJhwQ4MV3fQluiwWluZuQ+sMPcdOE7VJAUtchuXsBG6kxjDJgx5GOA+JRHYHHmT1B+fGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e5kxh8wd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e5kxh8wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44453C4CEC3;
	Mon, 14 Oct 2024 06:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728886239;
	bh=vtOULXzKh1W2zjoRRH7MNf2bpYcEKecnN3dY3aNLMSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5kxh8wdesQJ0pTug01/NkZeExuwthoVgZUktUVr+s/szlFweo7jeFGN5DGAw641X
	 1HqC/vulNeN0xjiBXuGBENKV/QLDFKwV/tobl31ROkTUGKA/9r+x/rAa1R/qNGU/b1
	 mJIYxxMrwmdXVJ2c+gJB78DB7j/keAhi5pGYExM4=
Date: Mon, 14 Oct 2024 08:10:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] tty: hvc: riscv_sbi: instantiate the legcay console
 earlier
Message-ID: <2024101402-starlet-riverside-02d4@gregkh>
References: <20241014000857.3032-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014000857.3032-1-jszhang@kernel.org>

On Mon, Oct 14, 2024 at 08:08:57AM +0800, Jisheng Zhang wrote:
> The hvc_instantiate() is an early console discovery mechanism, it is
> usually called before allocating hvc terminal devices. In fact, if
> we check hvc_riscv_sbi's hvc_instantiate() return value, we'll find
> that it's -1. So the calling hvc_instantiate() is too late.
> 
> We can remove the hvc_instantiate() to only rely on the hvc_alloc() to
> register the kernel console. We can also move its calling earlier so
> the kernel console is registered earlier, so that we can get kernel
> console msg earlier. We take the 2nd choice in this patch.
> 
> Before the patch:
> [    0.367440] printk: legacy console [hvc0] enabled
> [    0.401397] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> 
> After the patch:
> 
> [    0.004665] printk: legacy console [hvc0] enabled
> [    0.050183] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
> 
> As can be seen, now the kernel console is registered much earlier before
> the BogoMIPS calibrating.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

What commit id does this fix?

> ---
>  drivers/tty/hvc/hvc_riscv_sbi.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
> index cede8a572594..d2ecfbf7c84a 100644
> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> @@ -68,12 +68,10 @@ static int __init hvc_sbi_init(void)
>  		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_dbcn_ops, 256));
>  		if (err)
>  			return err;
> -		hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
>  	} else if (IS_ENABLED(CONFIG_RISCV_SBI_V01)) {
>  		err = PTR_ERR_OR_ZERO(hvc_alloc(0, 0, &hvc_sbi_v01_ops, 256));
>  		if (err)
>  			return err;
> -		hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
>  	} else {
>  		return -ENODEV;
>  	}
> @@ -81,3 +79,18 @@ static int __init hvc_sbi_init(void)
>  	return 0;
>  }
>  device_initcall(hvc_sbi_init);
> +
> +static int __init hvc_sbi_console_init(void)
> +{
> +	int err;
> +
> +	if (sbi_debug_console_available)
> +		err = hvc_instantiate(0, 0, &hvc_sbi_dbcn_ops);
> +	else if (IS_ENABLED(CONFIG_RISCV_SBI_V01))
> +		err = hvc_instantiate(0, 0, &hvc_sbi_v01_ops);
> +	else
> +		return -ENODEV;
> +
> +	return err < 0 ? -ENODEV : 0;

Please spell out a ? : line, it's not required here.

> +}
> +console_initcall(hvc_sbi_console_init);

Are you sure this will always work properly?  For some reason the
original code did not do this, you might want to check the
lore.kernel.org archives to find out why.

thanks,

greg k-h
