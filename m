Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017653C2F;
	Thu,  5 Jun 2025 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108500; cv=none; b=W/eUX6sxzouIuvi9pwj1dd+dMHe2V/ZZGV3O4RIuhgToHFYJWne40WNaZKW/sFCO/JTArijBVNZSwfoMtA/LOZx5VVGDS2Y8ZOWsgVLkfakoE1OFkKzusMU+BmuEEEA+Md6x+ztQZAiQJjiLy6po24WOxZk4DJM75tpVaqt050Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108500; c=relaxed/simple;
	bh=ZOw3IuAiSmo2ua+6HTrwwvoBdIWpFhsXQJL3DZeQDqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UoS0K4Jlr1ocZdOvnfEtfaQ7h9VUS+cC6Ga7Rs1mEXRlb2+K3iQH0zGngAqdgZX8KFNJV/bhVtNArPPY4GnInLxxjcQbGfD5Zf8+IRaTaa4dxgCNBOe2t3FxX+hsAwEBnZTGKyOH1cdoDfwVoZY+AfgvNQ+CDezEmduTktmVPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=44wjUv4U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7nGuYZc8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="44wjUv4U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nGuYZc8"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749108495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOw3IuAiSmo2ua+6HTrwwvoBdIWpFhsXQJL3DZeQDqA=;
	b=44wjUv4U8VcgzA+cI4nC/yZ4EMPg422vwZJduguOFeROcMjNTL07XvDd2a5lgWN7OAplCW
	M7h5625mTQDVX/ADYe4Cbgsj/8KlU0PMcRpqSfJpqnuuOF5QaaRIUyQC7CkNaC2MmGmxIi
	CuFnbnELZoxV3ltt8TYyjtBcjZ00ztQ3QPJZJAXPxll4lnXHys1kg2xNPPZFLSL33vx2bw
	OoHn2YyeZTKyM/yepIPCaBRZ/ajvct/b+5tb0n0+sQjH3CGxjfJ9++5LqmiuaPB8HEVUlA
	nr/D/8pmTtbhvv2u/U3q9m0Q/08lI/R/Z78QsixFLUQlak6KdJglhjX+0ChCTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749108495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOw3IuAiSmo2ua+6HTrwwvoBdIWpFhsXQJL3DZeQDqA=;
	b=7nGuYZc8BQ1hTssqk4Hwlv9FfX55u6JC5KchirFvKP22YkFKPLmANKURzniOyiYeVOiNBm
	rjkbve3cKhMLPXCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, Michael Cobb
 <mcobb@thegoodpenguin.co.uk>, rostedt@goodmis.org,
 senozhatsky@chromium.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Allow to use the printk kthread immediately
 even for 1st nbcon
In-Reply-To: <20250604142045.253301-1-pmladek@suse.com>
References: <20250604142045.253301-1-pmladek@suse.com>
Date: Thu, 05 Jun 2025 09:34:15 +0206
Message-ID: <84jz5qve9c.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-04, Petr Mladek <pmladek@suse.com> wrote:
> The kthreads for nbcon consoles are created by nbcon_alloc() at
> the beginning of the console registration. But it currently works
> only for the 2nd or later nbcon console because the code checks
> @printk_kthreads_running.
>
> The kthread for the 1st registered nbcon console is created at the very
> end of register_console() by printk_kthreads_check_locked(). As a result,
> the entire log is replayed synchronously when the "enabled" message
> gets printed. It might block the boot for a long time with a slow serial
> console.
>
> Prevent the synchronous flush by creating the kthread even for the 1st
> nbcon console when it is safe (kthreads ready and no boot consoles).
>
> Also inform printk() to use the kthread by setting
> @printk_kthreads_running. Note that the kthreads already must be
> running when it is safe and this is not the 1st nbcon console.
>
> Symmetrically, clear @printk_kthreads_running when the last nbcon
> console was unregistered by nbcon_free(). This requires updating
> @have_nbcon_console before nbcon_free() gets called.
>
> Note that there is _no_ problem when the 1st nbcon console replaces boot
> consoles. In this case, the kthread will be started at the end
> of registration after the boot consoles are removed. But the console
> does not reply the entire log buffer in this case. Note that
> the flag CON_PRINTBUFFER is always cleared when the boot consoles are
> removed and vice versa.
>
> Closes: https://lore.kernel.org/r/20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks Petr! And thank you Michael for looking into this. I think this
will be a big improvement in boot times for a lot of developers.

John
