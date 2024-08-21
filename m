Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3D1B1D74;
	Wed, 21 Aug 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250044; cv=none; b=QTUaYkGPblVxIBXizTtjIEgZWfl4WjtiOkeL4vNvLlEcOsXYA6R01R1nNNPINLMglDeqbdoZBseKuAjxXL0ADXYEvTOHcocZb6d0kvMMPGI4T11n/N4NfIqCoUUQnYUubg8KZ3plVXAqihGHYGDY8dvn2p8Ac33PMGU/a9lRAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250044; c=relaxed/simple;
	bh=TBCyxE5csIaQurxzlecwIIsJ1XEV19dONNW3gbSPGXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPDR+wpMB8qfz79qU09Wap2+D8J7fPn3VAcjChVEgoyUiUZdIoSBTcxQcRKeFg/4a8rAJk8OiN6/4bG9FUOQ233CyfQVPQedXOogWUnNyhivME0yxj33gFrKv+Wy0Je9QqvZQra7nLcO9ZLpEGDPjLteJRRQDp9ebaEv8nSc5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zKllsyce; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bmJ4oAXq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zKllsyce";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bmJ4oAXq"
Date: Wed, 21 Aug 2024 16:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724250039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWkf/t5VuVH/yqpfjMqKzrDW/D7rk9qR+GndBuJgZeA=;
	b=zKllsycebIr3x4CB8DlQ6e6P5iLrcQSb4CNZmtlPIGPBav4EpZB4lygLtqH2AGFmcUVdY4
	fQJejJBujp68R0ueM9FDBH6cWiwxY8C4dqtVwmo8r0ObjPPEtslpcuUTYmGilQpOsbl8t8
	kdmTNM7AfahPeRua/MGqp37z9zEvFHfjvFe1GNzNFjTAAMRly2i2Scs92J+N22f0X7xtw5
	+U1PejNIzAuSEbo8F7nW6gZ9+Htn/oQbiy0P58BAFoX2S7oZ87cfwILvTSeKNQojVrlqdk
	pvYwzJLv7c3VgYkdwHAs9qtNHsM98oUsodxkGYByS0jkpdxW7uNddGbR3epN/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724250039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWkf/t5VuVH/yqpfjMqKzrDW/D7rk9qR+GndBuJgZeA=;
	b=bmJ4oAXq49hgWBjftm0cGhOZbQEE+tfF0PVYoVnW+YgMtdR2xyyOi2MXWXkR4NWVyCN1TX
	LrD3/DaAgSXGLaCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	Lukas Wunner <lukas@wunner.de>, Feng Tang <feng.tang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH printk v8 00/35] wire up write_atomic() printing
Message-ID: <20240821142037.GOXcEpfi@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <ZsWxpVG8uZ9Nq26h@pathway.suse.cz>
 <20240821092841.j42XmBAk@linutronix.de>
 <ZsX1NztislIJuYsy@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsX1NztislIJuYsy@pathway.suse.cz>

On 2024-08-21 16:09:59 [+0200], Petr Mladek wrote:
> I see. It seems that John has vacation and can't respond quickly.
> 
> OK, I have pushed the patchset into printk/linux.git,
> branch rework/write_atomic. It should appear in
> the next rebase of linux-next.

Thank you.

> Best Regards,
> Petr

Sebastian
