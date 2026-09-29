Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6852CCC3;
	Tue, 29 Sep 2026 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689226; cv=none; b=OnPm8CTKdESAZmm29S8Z6pzAtq0XaWjEUVDGJ1wInPw4yWZcA1zYI6YNYy8Z3KAyf5YEMdWEIPWymsxCz+bfNEGwpGpVFb0pa5LbXk0vPeWJC8ebbauFyxBjK7JQaxLWsggUnf/F4X68zOU/tyFyJKeJFXwyOC2ljSklV+ainRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689226; c=relaxed/simple;
	bh=DRYW0LKbpqTgPVnWgTm5YdrJovtoFZe5WTkvGO+zvFs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pouNAW12mP60GXMjXTCWe1nryj6kpJJLdMd32qUf0fNXwE0GJwItCJG2eqOtnqFcEGlMFgqBHpyRwZ1+FdZN9908HRL5nl8whTBBYkmEteqWWEmSMSkgDMIU6mWh4f8zZvf1KQqHbajBMxsuPeKD1g5bseQ+zs6aMeJlJZ55B6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=V3+8ct++; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="V3+8ct++"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=jMRdUYHOGynfMn704xkiQEazEUtfWIO4Vsir1xip/Ng=; b=V3+8ct++DBx5hirJey7XZYXgvv
	ih8AshbNxEzu/LCdiFQ8/2xqg7Qj5q/VN1GyJWlCW6PZrlHd2eGfcat59WhhZUfuDg9Jy83bfSCc+
	m6XpjXGCxwHzfPRs70Plk+aKNcVDR3aAyz4bjFnnx1O+Ohcir0w6w+5KM3exotdP0Skg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xBY4B-00000000133-3FxI;
	Tue, 29 Sep 2026 09:40:20 -0400
Date: Tue, 29 Sep 2026 09:40:19 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v5 1/8] serial: max310x: don't clobber the TX break bit
 in set_termios
Message-Id: <20260929094019.67a4d5e9f473134dbdd39d93@hugovil.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-1-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
	<20260929-max310x-rs485-sw-delay-v5-1-ae46afa583f2@vaisala.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Tapio,

On Tue, 29 Sep 2026 09:37:55 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> max310x_set_termios() writes the LCR register absolutely, but LCR also

What do you mean by "absolutely"? I think you should rephrase that...


> carries the TX break bit that max310x_break_ctl() drives. A break is a
> state, not an event: TIOCSBRK sets the bit and it must stay set until
> TIOCCBRK. Any termios change in between - no concurrency required -
> rewrites LCR from the termios bits alone and silently ends the break
> early.
> 
> Update only the LCR bits that are derived from termios and leave the
> TX break and RTS pin control bits untouched. Since nothing clears a
> break when a port is closed with the break still asserted - the tty
> core sends no break-off on release, and the absolute write here was
> the accidental recovery - clear TXBREAK in startup(), the same way
> 8250 does.
> 
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>  drivers/tty/serial/max310x.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 022502986c5fcf1ff4de9328746ddc71677be730..4c1e10e0765f45a51e0c74ca965588f39872efd5 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -158,6 +158,8 @@
>  #define MAX310X_LCR_FORCEPARITY_BIT	(1 << 5) /* 9-bit multidrop parity */
>  #define MAX310X_LCR_TXBREAK_BIT		(1 << 6) /* TX break enable */
>  #define MAX310X_LCR_RTS_BIT		(1 << 7) /* RTS pin control */
> +/* LCR bits owned by termios; TX break and RTS are driven elsewhere */
> +#define MAX310X_LCR_TERMIOS_MASK	GENMASK(5, 0)
>  
>  /* IRDA register bits */
>  #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
> @@ -969,8 +971,12 @@ static void max310x_set_termios(struct uart_port *port,
>  	if (termios->c_cflag & CSTOPB)
>  		lcr |= MAX310X_LCR_STOPLEN_BIT; /* 2 stops */
>  
> -	/* Update LCR register */
> -	max310x_port_write(port, MAX310X_LCR_REG, lcr);
> +	/*
> +	 * Update LCR register. Leave the TX break bit alone: it is driven by
> +	 * break_ctl(), and an absolute write here would end a break in

Same here


> +	 * progress.
> +	 */
> +	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TERMIOS_MASK, lcr);
>  
>  	/* Set read status mask */
>  	port->read_status_mask = MAX310X_LSR_RXOVR_BIT;
> @@ -1088,6 +1094,13 @@ static int max310x_startup(struct uart_port *port)
>  
>  	max310x_power(port, 1);
>  
> +	/*
> +	 * Clear a latched break: nothing clears TXBREAK when a port is
> +	 * closed with a break still asserted, and set_termios() no longer
> +	 * rewrites it.
> +	 */
> +	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);
> +
>  	/* Configure MODE1 register */
>  	max310x_port_update(port, MAX310X_MODE1_REG,
>  			    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
> 
> -- 
> 2.47.3
> 
> 
> 


-- 
Hugo Villeneuve
