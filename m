Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D73182D9;
	Wed,  4 Dec 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326768; cv=none; b=jYo1/B9Bf3s1r6/SoJuf6QGx0mxg/Wh9AIt3+fpRy/yh16b2MyySu1JeX94pwpc+DwVURO2K4yFwdTfwj3AaJ+pbdG6X64IEFTAmUXWkFWuV9+gBAhwticMQP0wnavNmVhomojXdoFJmb11VDOTUe0ygPtBbsa8/Qi8i/TBJXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326768; c=relaxed/simple;
	bh=xL7uKHUI55ET+bj2OFgIp7IijAK7OQk6sjCXgBPi//c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQNnzryZczG7g7vr/BMGHv0s/Q1l6Oq7keg88uDjYJiwxTpsCaX8xC4o0CR4OkQB3fg55DEQBego7UtmmqbwJjcbRv0rkr8/Ys4Sj+xcC8Z49wzoKBm0Lc+6LPJuGMr9RRui1Fr8iQT/btvMRk8QadNehzJf0BCLTKb9rVn9Rcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3mhpHwA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3mhpHwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62196C4CECD;
	Wed,  4 Dec 2024 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733326765;
	bh=xL7uKHUI55ET+bj2OFgIp7IijAK7OQk6sjCXgBPi//c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3mhpHwAy4vuOGK2PGKBCcq+J6LKivRmR7b3+qT1H+/qMgGbPnnDfjB9y/9LC9z2H
	 S/IgF4sHoYYYrejwxfZF/eboCMD0yv63CdA1MgXDopwRXKTAFZHHGRXGKz4HjjUm2l
	 WJANgXaqHE8TKx2ckvdSP9kfckq7XMB8AFk0Huko=
Date: Wed, 4 Dec 2024 16:39:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: ondra@faster.cz
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: amba-pl011: Fix RTS handling in RS485 mode
Message-ID: <2024120456-shrug-unsafe-7dac@gregkh>
References: <20241123-master-v1-1-260194426ea3@faster.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123-master-v1-1-260194426ea3@faster.cz>

On Sat, Nov 23, 2024 at 09:26:51PM +0100, Miroslav Ondra via B4 Relay wrote:
> From: Miroslav Ondra <ondra@faster.cz>
> 
> Use hrtimer instead of udelay and mdelay calls in interrupt
> handler to support shared interrupt lines.
> Replace simple bool variable rs485_tx_started by 4-state
> variable rs485_tx_state.

This says what you are doing, not _what_ you are doing.  Please fix this
up.

> 
> Signed-off-by: Miroslav Ondra <ondra@faster.cz>
> ---
> Data loss on serial line was observed during communication through
> serial ports ttyAMA1 and ttyAMA2 interconnected via RS485 transcievers.
> Both ports are in one BCM2711 (Compute Module CM40) and they share 
> the same interrupt line.
> 
> The problem is caused by long waiting for tx queue flush in the function
> pl011_rs485_tx_stop. Udelay or mdelay are used to wait.
> The function is called from the interrupt handler. If multiple devices
> share a single interrupt line, late processing of pending interrupts
> and data loss may occur. When operation of both devices are synchronous,
> collisions are quite often.
> 
> This rework is based on the method used in tty/serial/imx.c
> Use hrtimer instead of udelay and mdelay calls.
> Replace simple bool variable rs485_tx_started by 4-state variable
> rs485_tx_state.

This info is great, why not put this in the changelog text instead?

thanks,

greg k-h
