Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD44CDDCA;
	Mon,  5 Oct 2026 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215155; cv=none; b=NxyXRTKqUH4AbGFg2aTSTmlo1cIRPssUEvKNDfRM0i6BgMiug//KspQqrTWwZ1XMdtYXZ+O5tUMyq44qHqNadz9ZKNZRm1n3ezGxx10fRC7x+8LweGaWTbfRSHxFzso4/waxSUclYg1NdV3YqU9cJIiin4oooVTaSub1iUU13+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215155; c=relaxed/simple;
	bh=pjKjnNLNtpL/SCqwL2/Wv1J4bwS4096iwxHuiyTCoRk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M4OsY7oA3Ypn3TV6pr7OajqUaDAEnZv+QFC33sqSrGyXJh+yvDEKTgW2bilfpa/PAgTFhGcfsAvh4+Iq8Cdmkp081iu7xoJCJCl5+9BPwP3G/Noayo/RRWb2X9QZqw9MmgkB3/yIPVBzwSfDTqT8TdfvmcEN5TvlBJvcUYsRDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=PfEU3Eja; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="PfEU3Eja"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=7e9GMwhuF4F9yCfe61G+u9tWCIpCD/dkfhRhkg8Lbp4=; b=PfEU3Eja0+5/Iu1O57U7R3rCwe
	YcRS1pp0vhjIau1UzZnCi7ZBWA1hnya06NQEZvSsEkjwk4shH1ehRrYPM7tDNM+TMV1arfHdwuPOG
	K4o/C2i0Yegn989+11pYy2TqARkG2/49mLysKafCmdb6GI5D2W2YnY5oB3opnXhR2wJc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xDksk-000000001m3-2iyY;
	Mon, 05 Oct 2026 11:45:40 -0400
Date: Mon, 5 Oct 2026 11:45:39 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v6 1/9] serial: max310x: don't clobber the TX break bit
 in set_termios
Message-Id: <20261005114539.a7244a974fb7a63414095517@hugovil.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-1-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
	<20261004-max310x-rs485-sw-delay-v6-1-3a0ef13ed9e3@vaisala.com>
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

On Sun, 04 Oct 2026 12:16:21 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> max310x_set_termios() overwrites the whole LCR register, but LCR
> also carries the TX break bit that max310x_break_ctl() drives. A break
> is a state, not an event: TIOCSBRK sets the bit and it must stay set
> until TIOCCBRK. Any termios change in between - no concurrency
> required - rewrites LCR from the termios bits alone and silently ends
> the break early.

A little bit confusing, because termios bits alone would not clear Tx
break. Maybe:

"rewrites LCR from the termios bits with Tx break cleared, thus
silently ending the break early" ?


> 
> Update only the LCR bits that are derived from termios and leave the
> TX break and RTS pin control bits untouched. Since nothing clears a
> break when a port is closed with the break still asserted - the tty
> core sends no break-off on release, and the unconditional write here
> was the accidental recovery - clear TXBREAK in startup(), the same way
> 8250 does.

You say that Tx break bit must stay set until TIOCCBRK, but you clear
it in startup, so does the comment should indicate that it must stay
set until TIOCCBRK or port closing or startup?



> 
> Fixes: f65444187a66 ("serial: New serial driver MAX310X")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
>  drivers/tty/serial/max310x.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 022502986c5fcf1ff4de9328746ddc71677be730..fead9c51163d8372d1b609ee9cd5b87faa917fc1 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -158,6 +158,8 @@
>  #define MAX310X_LCR_FORCEPARITY_BIT	(1 << 5) /* 9-bit multidrop parity */
>  #define MAX310X_LCR_TXBREAK_BIT		(1 << 6) /* TX break enable */
>  #define MAX310X_LCR_RTS_BIT		(1 << 7) /* RTS pin control */
> +/* LCR bits owned by termios; TX break and RTS are driven elsewhere */
> +#define MAX310X_LCR_TERMIOS_MASK	GENMASK(5, 0)

owned -> modified ?

driven -> configured or modified?

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
> +	 * break_ctl(), and a whole-register write here would end a break in
> +	 * progress.

Maybe simpler:

"Update LCR register except TX break and RTS. Clearing TX break would
end..." ?


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

TXBREAK -> "TX break" (consistent with your previous comments)

rewrites -> clears

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


-- 
Hugo Villeneuve
