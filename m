Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6150EC06;
	Tue, 13 Oct 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907764; cv=none; b=l+N+K/FvuNvq3GPePWfCHY+iHNvvfNR1pqb9+VmvzdnGNEcLA9HmNxS2FrBPkTLc7TrEQMU6yWU1Gd3ezbS4d85TFlTl5L3XEsT5SgFzdhABCTlFlw7iSG37UZ8SffAW0RxzVbB2qnR2n/sWQxKBdsoISrKCeOgjKmQjY/eKQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907764; c=relaxed/simple;
	bh=toSHnaXwo8OipMtV95mQ0+bIEgPdHGxNdIicEgNFjBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h42vVM8bFfyOIT90BMf7yOArqUbpdNj9Djwa8X8Gg8HEObBHX2FAF9Iu5zX8c+sDZbTn9L+P1l92XziHjB9DOHlW5TCTNkmJ92dl+hzV6XTEPZzribSV4QxZAhlWLHe0OdNv50+1zdCMYQwSpvbw7Um/nZnUIp5Tf/vnuu6AGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUSDQgjd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5vBNhBok; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUSDQgjd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5vBNhBok"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791907760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=toSHnaXwo8OipMtV95mQ0+bIEgPdHGxNdIicEgNFjBo=;
	b=iUSDQgjdnIMeCW4dOrq/TKf27xgIsXLss10RyLNuK2jVNQmfvKSHdwEMDvh8CMIa7Ss64N
	6cbu6ozPIay9OKzbc7kijjS6GRkV2MLPHn1PUQMrUqB/Oxzl2UaAOquTaljA839EVN18ER
	FR7h6CPqx7EqnjuyU+BZXP8aBuQ4Eam/j0wRR38PkBMYqwaHarroR70FVDPa3jWa5hjABn
	/cHd5973t31WoQ0TFhKsple80zkJ/PFejMcXOMSSEi7zvd9lUXcYyDAoE3M4qotb++fvcz
	/880Cpw6Tpk4aDPqOmsS4KdD81kaSI6KAUY4679+ZjWbNZ4BAqKSVIZbKvmK3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791907760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=toSHnaXwo8OipMtV95mQ0+bIEgPdHGxNdIicEgNFjBo=;
	b=5vBNhBok7eBVITv0mNcN3OaB1vhxHbLytNMBmiCScPNONkbqSg8NzeUH/mA7aV6UnQplvL
	Xq+WagF8UHlazfBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Oleg
 Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] nbcon/reboot: Switch NBCON consoles into the
 emergency mode in emergency_restart()
In-Reply-To: <20261013154141.94016-1-pmladek@suse.com>
References: <20261013154141.94016-1-pmladek@suse.com>
Date: Tue, 13 Oct 2026 18:15:19 +0206
Message-ID: <87y0c1vaz4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-13, Petr Mladek <pmladek@suse.com> wrote:
> When the system is going down a normal way, the NBCON kthreads are
> flushed and stopped properly via a syscore shutdown callback, see
> printk_kthreads_shutdown().
>
> One missing piece is emergency_restart() where the kthreads are not
> stopped. It might be called from several non-panic code paths,
> e.g. sysrq-o, kdb_reboot(), or some watchdogs.
>
> Fix it by explicitly entering the emergency (atomic) mode and trying
> to flush the consoles there.
>
> Note that printk_trigger_flush() must be used instead of pr_flush()
> because the later is not safe in an atomic context.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202608061008.48a1e76e-lkp@intel.com/
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thanks, Petr.
