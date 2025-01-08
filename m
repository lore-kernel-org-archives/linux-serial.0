Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83B1F942F
	for <linux-serial@vger.kernel.org>; Wed,  8 Jan 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341027; cv=none; b=GdAvNq512aZmpMtt+tYzl8L/KEF2fxa3x/l791fsQG5vpEvHk7My1MAznvCg3nDQsX96vnDUQ8oaoh590b6V6uBC8Ib07w1G2wTaZVSEbhidgAhmqs+CFhV8XuGqB2+CK1aq7KbilgGEpDfpQScqGqh2GTOCSdUjAD29QpVqUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341027; c=relaxed/simple;
	bh=5xBFvOUbvg90XgCy/S23s30dTHT7sn6DrY6FZbeRrLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh3Ir/7fOz0xEGK+HygnLkC7bK0SOCxakIn1Xw2WkxSMhSFSXxgy8VGhq2HjZ5U0JpOnN0lZx45qYGHQ2aZUvz9pkVPkd5PEETl+mmUKLXFctlezPjtzAZV3I2P5ip9UqcNkwacMhjtvrJ7lFqJAAULhi64ZoEBFrWi/hGmSH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=qUWAF5/D; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="qUWAF5/D"
Received: from cwcc.thunk.org (pool-173-48-116-211.bstnma.fios.verizon.net [173.48.116.211])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 508Cuvvn021852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 07:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736341020; bh=KiepcNTyQYYcKT7PLsGajt3tOB/awNqBIyCYLcowh54=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=qUWAF5/DJWEbt4Ca8z3v5JPqLhZELjABtWDRt/XlfdBdhjDqMBg6SOQTs6ydZ7TRV
	 KVwLNR8iwPz2gV0NqSw8vMznfWqytev0pWxJ/NST3AC/f3hYt6tyFyvbOC9O9A/Sng
	 JNw6ZmDVpZrqK/NG7GnldlSfBvxBnoXYyxrUFRq97AGLlO+NYdD6wBgT5zep2gSLuS
	 GJTm3khg3AiwaB812sBGyK/FuGEpLQr/h3lyHYv/L/3yT+KtLhPM+RwE3heehlcCtE
	 fdbJHQwMsdIWg+tZP2TaomXU6YupPYt3/ZMPRL//yhuVk0dqgg9Z+ouNTk5HgMEQ5Q
	 ib2MrFAs3R50Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C5C9715C0108; Wed, 08 Jan 2025 07:56:57 -0500 (EST)
Date: Wed, 8 Jan 2025 07:56:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc: linux-serial@vger.kernel.org
Subject: Re: Precise timing in ldisc? tty_put_char() in hrtimer context?
Message-ID: <20250108125657.GK1284777@mit.edu>
References: <CAH2-hcJVhxubEsRciMSrp2x4WyDrmmYNe0Db9-LzXkiRpBQ0iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2-hcJVhxubEsRciMSrp2x4WyDrmmYNe0Db9-LzXkiRpBQ0iQ@mail.gmail.com>

On Tue, Jan 07, 2025 at 07:07:42PM +0100, Tomáš Mudruňka wrote:
> i am implementing niche rs485-based serial protocol as a tty line
> discipline linux module. Requirement is to hit transmission window
> with precision in low hundreds of microseconds (eg. +-200 uS).
> Transmit window starts 500 uS after message is received.
> 
> It seems that hardware driver calls tty_receive_buf2() with sufficient
> latency, so my idea was to start hrtimer using hrtimer_start() inside
> of tty_receive_buf2(). And then in hrtimer handler call
> for(...){tty_put_char(tty,...)} or tty->ops->write(), but it seems not
> to be a good practice according to my online research. They say it's
> recommended to call tty_put_char() from workqueue, but documentation
> also says that calling a workqueue might introduce latency of couple
> milliseconds, since it's scheduled thread context.

It's going to depend on the hardware driver, but note that the 8250
driver calls tty_receive_buf2() from a workqueue.  So you have one
scheduler thread context hop already.

One of the issues here is that serial port hardware is... interesting,
and the original design goal of the serial and tty layers included
supporting hardware with no FIFO's, so when receiving at 11,520
characters per second, there would be an interrupt every 8 uS.  The
goal was to make sure that we didn't lose any characters when running
at that rate, as well as being able to support multiple 115k baud
serial ports running at full speed on relatively 40 MHz 386
processors.  So the whole system is designed to optimize for
throughput at low oeverhead, and not latency.

If you only care about making it work on your specific serial port
hardware, you might be able to make things work, but some serial ports
have been known to drop transmit interrupts, so there are timeout
mechanisms which will wait for a little bit more time than needed to
empty the FIFO, and if we don't get an transmit interrupt and there
are characters waiting to be transmitted, we'll check to see if the
UART is ready to receive more characters and send the characters as a
backup mechanism if the transmit interrupt gets lost --- which some
hardware would be prone to do.  There is a lot of dodgy serial port
hardware out there.

So it's not just that Linux isn't a realtime OS.  It's that tty layer
wasn't architected for your use case.  Ultimately, if you want the
best latency, you might need to replace the driver which one that
polls and burns a full CPU instead of depending on interrupts, and
then bypass the tty layer altogether.  That would make your solution
specific to a particular hardware back-end, but full generality isn't
possible in any case, not if you are trying to hit tight latency
guarantees.

For example, there is one serial port hardware which would support up
to 128 serial ports, and doesn't use interrupts at all, but instead
has deep hardware buffers, and the driver runs interly off of timer
callbacks.  That's one case where the *hardware* has been optimized
for throughput and low CPU overhead for a very large number of active
serial ports (think: modem banks), and for which latency is terrible,
but that was explicitly designed by the hardware manufacturer for that
use case and a very different set of design constraints than what you
are trying to achieve.  So if you tried to run your rs485 protocol on
that hardware, it would very likely be hopeless.

Cheers,

					- Ted
