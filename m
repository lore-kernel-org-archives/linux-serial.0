Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054994DAF93;
	Fri,  2 Oct 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953553; cv=none; b=Cdx5Qe35Gtl1DbOrFAgqnM2/GCVW8jBP5Xwu6ttVUFlRG/X+IXQrW3tc/HmVqt24ehORWepyBAUKnt6AgEBRvpM2gEmE8dWntTMS3+o6SmgyaNG5IzIIO7mNWeaxLCwvD2tbIP511hEgK6cGWl3Qnq8Y3lDpP9cdHVGUlvEw4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953553; c=relaxed/simple;
	bh=sQORPzUPi3w5BTcfpDRUw5sRLfIFP8k9BQvPVGWbkvM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=egUUkTOwj7teQEX0FWNEfiCEqs9+VnXRcXVoaoVIhoXsAMz43fOk88ppnpeUJkaXOUyCuotdhvP7/GNBYnaDbimOITdYTUJvUt/muaE2fxa3W2gC5HWemUuhdBARpTnSjgLy9GZ65npPKrTyzMGm6tFBIUh40vv2lFdBWmcmihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=QkmJCXEJ; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="QkmJCXEJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=F9VOg7PXzN6PL9gIOl8uac5PElhOwysRXjBBGiefKhU=; b=QkmJCXEJOQhOiBzmDFjrf0IDp3
	vV0aIT9p5PNp4z73kVj14jsJQDroRIYHAov7BZYiX2WyuZYmuAZhYi1WA17p/J+6LchSyAeWYsNgg
	bFK8DE+1c7UZzv+vsdMUyVF+op+FRT6G1eCxzjm5orRe9mMjedSze6MXcJhQ86tZXTIE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xCelL-000000007Xx-0Eyu;
	Fri, 02 Oct 2026 11:01:28 -0400
Date: Fri, 2 Oct 2026 11:01:27 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
Subject: Re: [PATCH v5 4/8] serial: max310x: wait for TX to drain before
 powering down in shutdown
Message-Id: <20261002110127.cb172b3f28d20aa5330990c4@hugovil.com>
In-Reply-To: <e1c4b08c-8e91-4368-8fde-6deb989995e9@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
	<20260929-max310x-rs485-sw-delay-v5-4-ae46afa583f2@vaisala.com>
	<20261001160020.5ba190a2b747f0c66f8b30d7@hugovil.com>
	<e1c4b08c-8e91-4368-8fde-6deb989995e9@vaisala.com>
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
On Fri, 2 Oct 2026 10:28:59 +0300
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> Hi Hugo,
> 
> On Thu, 1 Oct 2026 16:00:20 -0400, Hugo Villeneuve wrote:
> > > +	unsigned int		one_char_duration_us;
> >
> > char_time_us?
> 
> Renamed in v6.
> 
> > > +	to_max310x_port(port)->baud = baud;
> > > +	to_max310x_port(port)->one_char_duration_us =
> > > +		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
> >
> > Would it be a good idea to if you moved these two lines after
> > max310x_set_rts_ctl_params(), then you could probably leave the
> > original comments and simply add a new comment to indicate "Compute
> > time it takes to clock out one character", simplifying the diff
> > (review) and readability?
> 
> I would prefer not to move them: the helper consumes both values.
> The baud is what the millisecond-to-bit-time conversion divides by,
> so it must be cached before the call. And as of v6 the helper can
> also arm the after-send hold directly - v6 adds a fix for the case
> where a reconfigure moves the port off the hardware RTS path while a
> transmission is still in flight, and the takeover computes the hold
> from char_time_us - so the character time has to be current at that
> point as well.

I meant only these two lines:
    to_max310x_port(port)->one_char_duration_us =
	DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);

> 
> > > +	unsigned int loops = port->fifosize + 1;
> >
> > tries?
> 
> Renamed in v6.
> 
> > Based on these comments, does it mean that the FIFO has already been
> > validated empty at this point by the tty layer, so you don't need the
> > loop at all, just the unconditional last fsleep()?
> 
> No - that wait is not guaranteed. uart_wait_until_sent() runs only on
> the close path and is bounded by closing_wait, which can be configured
> to none, and hangup reaches shutdown() with no wait at all. In
> testing, a vhangup issued mid-transfer entered shutdown() with the
> chip FIFO still holding over a hundred characters; this loop is what
> drained them before power-down.

Its unfortunate that you trimmed some parts of the original email so we
no longer see the relevant code...

But maybe you should reword/improve your comments then?

> 
> > For certain combinations of large fifo_sizes and high-baud rates,
> > that could mean a lot of I2C/SPI transactions?
> 
> It is bounded at one FIFO-level read per character time, at most
> fifosize + 1 of them, only on the close/hangup path, and it stops as
> soon as the FIFO reads empty - in total no longer than the remaining
> transmit time of the data itself. At high baud rates the character
> time shrinks, so the polls get more frequent but the window they can
> occupy shrinks with it.

So at 115200, this could mean 128 reads each ~90-100 us?

Could using the interrupt to detect tx empty could improve
efficiency and reduce load on I2C/SPI bus?

I am not saying your approach is wrong, but it just made me think of
potential issues and things to consider.

-- 
Hugo Villeneuve
