Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3928A400;
	Fri, 20 Jun 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421655; cv=none; b=Hr7HkwP9WVUe0G7mzwRSOoXdrSaNzK7lWEa8lX+mIptnbf+gjcD0UFpphHRvehM/wQtj4U4qOaAPm68yOarUyf4rb4xE4VkxqggJ/76MuOQ+P8l/LPuxOPE7D5so43YXvrqr0iqmH3qalyxFWfGsnUW44sS1EHFTKq22XppkWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421655; c=relaxed/simple;
	bh=uPA3zZOta1h4MlibngyuIbcNapjjxOn43fmvaTm5atU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1KiL9iKG8itfPoK1a+ZkdJ5JNSAMPsV1giguK+q7v2dCi6PZ1XL9Lxr5XnmVPD+P8Fg2oQLV9clwHzLX+xe11pTfslGk2tnE80b2AJhzxdkCX0zLACrX56A2ppPOcpIkFZkJ7D1enixYTbLeopW/CwsfnLKyEtOwGZLcV3O5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=je2wVVAm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6MOgFdF3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="je2wVVAm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6MOgFdF3"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750421651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LdCYjtuvmLMLuIsQCkFfX42MSNyvC3c8kve7swVpKU8=;
	b=je2wVVAmkaS/I5Wuc/nAIUrl7S/IKVDL5A7hBXU0Ojbihgh2LX4+0/aOPJ3gnecBWckumh
	Pedz9tIKsrEJejtVWm/3mW45DhqMYHkmsn+pBQgTar/TqAW1AL2wRhiZndiWA134cMhnC2
	PbMCjGd8VjjM0j8XK6BTq5R/k1KwNxp5ox1yoyNlbsd9hdsnGJOp9WEnxwnply1d2UDdwN
	MQ8Hj4OF8xHorvPTNFCo8QHA9raN4Cpt1V8mK2JNjb8Z3cw4F6xYJRe2ewfRvdXg8nWoXk
	WXslq1SDctmS2JSMVNuGbvgVCgIEsZGJLA8gYWv/9rjHjmOCIZugF/gLKd5LVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750421651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LdCYjtuvmLMLuIsQCkFfX42MSNyvC3c8kve7swVpKU8=;
	b=6MOgFdF3pZahsopBGD/JSREaOdFcnFwMLqloe2UXPbToZfry4iajHAqUMIpvAVzckV7p+t
	g0cDQmQyy+puChCA==
To: Yunhui Cui <cuiyunhui@bytedance.com>, arnd@arndb.de,
 andriy.shevchenko@linux.intel.com, benjamin.larsson@genexis.eu,
 cuiyunhui@bytedance.com, gregkh@linuxfoundation.org,
 heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 jirislaby@kernel.org, jkeeping@inmusicbrands.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de,
 paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com,
 sunilvl@ventanamicro.com, tim.kryger@linaro.org
Subject: Re: [PATCH v9 4/4] serial: 8250_dw: assert port->lock is held in
 dw8250_force_idle()
In-Reply-To: <20250610092135.28738-5-cuiyunhui@bytedance.com>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
 <20250610092135.28738-5-cuiyunhui@bytedance.com>
Date: Fri, 20 Jun 2025 14:20:10 +0206
Message-ID: <844iwak3u5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-10, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> Reading UART_RX and checking whether UART_LSR_DR is set should be
> atomic. Ensure the caller of dw8250_force_idle() holds port->lock.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 082b7fcf251db..686f9117a3339 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/lockdep.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> @@ -117,6 +118,9 @@ static void dw8250_force_idle(struct uart_port *p)
>  	struct uart_8250_port *up = up_to_u8250p(p);
>  	unsigned int lsr;
>  
> +	/* Reading UART_LSR and UART_RX should be atomic. */
> +	lockdep_assert_held_once(&p->lock);
> +

It may be possible that during panic the port lock might not be held for
console printing:

serial8250_console_write()
  oops_in_progress and failed trylock
  serial8250_console_restore()
    serial_port_out(..., UART_LCR, ...)
      dw8250_serial_out*()
        dw8250_check_lcr()
          dw8250_force_idle()

A similar incident was discussed before [0]. In that case the result was
that the lockdep assertion was removed.

John Ogness

[0] https://lore.kernel.org/r/20230811064340.13400-1-jirislaby@kernel.org
