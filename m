Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791382;
	b=z06kq5I7D1Y8KR3ASH0svkUVtq6JQwJi+X3GHBZLqatyOJF4iWwvnDDqps6w4iIcJDCQ
	 eBR4trllZVWWVEn0pUaglI0knMOcA759fqJO6WW+FodRNoHJUwptU/tqX/nOjdWeUynt0
	 sDDuu1IHb3TPRkbuwrX5+hoxVhVqvfYNLcr7gNIj3Kb/HsHUnFT3orQ57drShBw1jMZUX
	 WsGFeoeJm7wnCntrNnLFbE/Y0e9XFo0A8cv9cUt6ui9pHEtvjLCYu7g0AdGJXfaBCKQG7
	 5fEH+J8Snj86/qyCTzsoiEWJcP46B8fb+3UA5lItW1All8YMkC1J036wWQZWhkX/zOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791382;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=SnHo2u9kIasWx9hfw1cGrJ/JFwdeMAcsODx6Pj+X94k=;
	b=HRbKlkrAD++hXN5J7KKBZj08IOQADZcbfhUOYWQm4UdPzC/mGWe+PODJgvh9zHcl1etR
	 wdHe2cqHHW2+PJWbPx/xLItph/HPl8FHxKUrzkY9aB7S/5bCTlhSGKF9MVThPyeMKYZLs
	 x00ohgtFtQ10KP9cPre/EQjE6Bt4Iw/mO0XoNy7GQEm3ByFxafXMePZZkzsvIi5dMSStV
	 qKYcxpmL3PPR8Lnjb92fTwsLF/F52N/d0n3j9L7UUyGLUvqvknwwWOxQ1Khk4d4K9CKXU
	 k+ro/4belbOuW6liuMUY06cQAhZNC2PK/xV5co0TU3Iy+wqJVOu1T72Eh5Uu92sD51Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=y7fFzXdc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ltE1QQtZ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1F606A31B;
	Wed,  4 Nov 2026 11:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB1F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=y7fFzXdc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ltE1QQtZ
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793791379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnHo2u9kIasWx9hfw1cGrJ/JFwdeMAcsODx6Pj+X94k=;
	b=y7fFzXdcFhh7qcukk7/4l36Dauvnb0J2Bo/9fNFsGcqQSfU/+qIziaNPnsihGv7aNiVrqq
	sm6Bg4vsfZ9EYpZneTNGz0gYrQ5DK16r5g/PrGdIPgcVASF65BSgM2td7oQmI1nzgOXBRa
	ZnQ4BtgwyxyNe65aD3Wqh6Mxa8jMOHFhvFATTUPXBCFSbVRIhNh6nG6ifZ4JjtTgTwAlqC
	q1ymuk5GWs4t+p45Z4r9yp+ZZhCbqVssTkHQQB2VWe1wfAfLWExmPiA57UFKQAfFkFwEb/
	NkmUOV/0FNmMqmCbNypHoZ7eZRrplnmxDnsw1Nv8oyJ5vtVHcTztTZtddaSm2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793791379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnHo2u9kIasWx9hfw1cGrJ/JFwdeMAcsODx6Pj+X94k=;
	b=ltE1QQtZbUydL7Sm/Vy82I9DN8kuW5KtLu+1++esE9JMjf8+Yu8ymgM4HjLzO2Z/7h+Xyo
	1qVASUzehN0YVcDQ==
To: Breno Leitao <leitao@debian.org>, Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Petr Mladek
 <pmladek@suse.com>, Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] serial: amba-pl011: touch the watchdogs in write_atomic()
In-Reply-To: <20261104-pl011_touch-v1-1-e292bd834e14@debian.org>
References: <20261104-pl011_touch-v1-1-e292bd834e14@debian.org>
Date: Wed, 04 Nov 2026 12:28:59 +0106
Message-ID: <87zevoalik.fsf@jogness.linutronix.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 2026-11-04, Breno Leitao <leitao@debian.org> wrote:
> In emergency context, such as WARN(), nbcon prints the pending records
> through write_atomic() with preemption disabled.
>
> On arm64, WARN()  can run with IRQs masked, so the whole backlog is
> printed with IRQs off as well.
>
> Commit 9bd18e1262c0 ("printk/nbcon: Restore IRQ in atomic flush after
> each emitted record") does not help here, as it only restores the
> caller's IRQ state between records.
>
> pl011_console_write_atomic() busy-waits on the UART for every
> character, and at 115200 baud it prints about 11.5KB per second.
> Flushing a few hundred kilobytes outlasts the hard lockup threshold
> (10 seconds by default), so the printing CPU is reported, or the
> machine panics with hardlockup_panic set. See [1].
>
> The 8250 driver avoids this by calling touch_nmi_watchdog() while it
> polls the transmitter. Do the same in pl011_console_write_atomic(),
> once per record.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Link: https://lore.kernel.org/all/87wlqtxb14.fsf@jogness.linutronix.de/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
