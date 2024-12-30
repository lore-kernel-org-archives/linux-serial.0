Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CBA59;
	Mon, 30 Dec 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735556434; cv=none; b=CQzfBK7TyabeFQExujdK3Lb66PPUq+SBPfJrfnkKZgdfo+RhODEFNCf1v3l/ssgUrd4Oy54voe/6+ikycE4phbTLOg0XdGActO6tQ7j8Zg0PaS6zR8sxpvMaZQqAPPV67Badr/Nep6kJNWxdwCfSWtLeL4cp0TGsDrIkGERIjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735556434; c=relaxed/simple;
	bh=PTsd3+QfpL+V6nSRQ63aEUuuY/516r5Yt375X+t+AmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HnR0VQtTk1PbKFMwGoDleHUpITNgpSw0EsTQcBjHQ3mg6vRyJiu5x0saZlzI27KlGPVmo1gPYB2U0mTFkI7lijMg7b9LT0JhFIL5+p6Jpb68+ko/aYc5CV6N3rShe8FF0gk25LgUH+M0ueMYAi8GLNMiBKpbH5KELLljsRp61+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KgCJarP+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TAY3L6ai; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgCJarP+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAY3L6ai"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735556430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vm1NgCVjgslKq+GaJUj/gh/Sm2mhWSvo2Psz3mBxd7o=;
	b=KgCJarP+wCqCM94xpTM71A4ayqZ0KzEBdNLtVVoJ7jym+nWVH6lQYMVj3Ni2frYtpQay+m
	fjrLasdQvlOn88KoC1LCLQOqfB6/yTlGWRcbQ4XOwVuK5l3DuIz3Dv5aUungpyrFpC7h8z
	5D/FP3DukdSMLJocZ8uGlPPB53Fb2RO5ytJR8oImNNoIkwlcU4Z6l9aATFKcz7C70tfMhX
	hCfOCCe4PXtXYqjvqGUTrb0//I5dwubNmCiQMpXGA+D1QpGQ2lMl8uApA4iPZfbXXFTxvs
	Rg7SYqsfOGuuoUVOOmfkht0Nu5OUj7p40fpudBRZu1m0ryJm1ii5MOhQgkaWTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735556430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vm1NgCVjgslKq+GaJUj/gh/Sm2mhWSvo2Psz3mBxd7o=;
	b=TAY3L6ai3+8KkjlmA6nrxrBsBNF5OurnSwfmxdqHg5/M4bKoZA05v3sfSUzugF00ELa8Hw
	3xgj456KyrtcIMDA==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Rengarajan S <rengarajan.s@microchip.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>,
 Wander Lairson Costa <wander@redhat.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Matt Turner <mattst88@gmail.com>, Stefan
 Wahren <wahrenst@gmx.net>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Griffin Kroah-Hartman <griffin@kroah.com>,
 linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH tty-next v4 0/6] convert 8250 to nbcon
In-Reply-To: <Z3B5TQkz1S-C1wro@smile.fi.intel.com>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <Z3B5TQkz1S-C1wro@smile.fi.intel.com>
Date: Mon, 30 Dec 2024 12:06:29 +0106
Message-ID: <841pxpqvua.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-12-29, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Dec 27, 2024 at 11:51:16PM +0106, John Ogness wrote:
>> This is v4 of a series to convert the 8250 driver to an NBCON
>> console, providing both threaded and atomic printing
>> implementations. v3 of this series is here [0]. Additional
>> background information about NBCON consoles in general is
>> available in the cover letter of v2 [1].
>
> Just to be sure I understand the side effect of this series, i.e.
> the
>
> https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/tty/serial/8250/8250_port.c#L44
> https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/tty/serial/8250/8250_pci.c#L9
>
> are not needed anymore (the first one can be replaced to something like
> dev_dbg() or analogue)?

Correct. With NBCON console drivers it is safe to call printk() while
holding the port lock for non-console-printing purposes because:

1. printing via ->write_atomic() does not use the port lock

   and

2. printing via ->write_thread() is performed in a separate dedicated
   printing kthread that can safely spin on the port lock

John
