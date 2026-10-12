Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C023D3CEA;
	Mon, 12 Oct 2026 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814460; cv=none; b=EIdOKPdViTXNBRUE+HZb+1ISy7h7VggNOkOPiXr7qENQSGfu+C77qfF/RKdVsNLY8mHM2goZQOQKA05J36e6i0EQ2zUweMTLRtzBDn+EUovm5NA3jlYwNsiKGWKbeVS6cQv7yvj3aM55yfPilvvIZfKOxRAmdgzSQW52BSBWUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814460; c=relaxed/simple;
	bh=kV73uqIkz1gigmsOedM7PoqESt/yOwPLUTsBM7w0c7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgKef5gDrnnjdR3UvVw1sl9uAtIhhWF6mVRQdRjfSnJxm6CRhpvHG0tgJeS7I0kugCY4xBl9Ve0/QrIOSJ4GgRPXHLfx6AgkWa9IvN9eUBdizPQI5iaPpd3Jkt6nSu/48dadBFhb2c2em+FiMz/Ct4EGYMkMCo0DnmgZtjF/zpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXuNRqHy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XENPiXtK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXuNRqHy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XENPiXtK"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791814457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAhC3w4x6SO8S0tKilkyEO20IHMEvKk4g6c9AZ0BlC0=;
	b=OXuNRqHyLqtOYD1KPGh3MgZUc5sohbm8SH+eE0LoWJRIbOOYgpzsl/dRA4BABC8giI4ldx
	bzD4wpdTLcDH73kujqdeVkLAGpKreaIshxJxz0hrjWjl5AJI4EbGT0S7EsWF7RYyE9kyNN
	e3plsfRcjnyR8YukDPUFuGfRHbu3HPG6DCWa8bXOej6YBLljWrHrU3xDxO0UcpfGIcpHZ0
	gyipJyg+fID6ORT5GnGsx8osxrqHF2vMxH6/NciemG+97tkal6dRVC5VFegsaqcOOYUQnQ
	cuY37HKgeDEkonf8HjGssENXrZEolsuoOeOW9FxASSikm5JVwnKIULecUezk9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791814457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAhC3w4x6SO8S0tKilkyEO20IHMEvKk4g6c9AZ0BlC0=;
	b=XENPiXtKoyygKkz7Chpoc1n6BCA2zILBMJr1oHQTMKLxFqcGW7gnkeZLQAl/v7V7IITTQz
	xXo3LDx7vMEjYfAw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek
 <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Oleg
 Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-serial@vger.kernel.org,
 oliver.sang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on reboot
In-Reply-To: <87jynnxd5v.fsf@jogness.linutronix.de>
References: <20261008150852.8286-1-pmladek@suse.com>
 <20261009065152.udyfFRHx@linutronix.de>
 <87jynnxd5v.fsf@jogness.linutronix.de>
Date: Mon, 12 Oct 2026 16:20:16 +0206
Message-ID: <87h5irxayv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-12, John Ogness <john.ogness@linutronix.de> wrote:
>> while this seems okay, didn't we have pr_flush() to flush the output on
>> shutdown/ reboot?
>
> We have the syscore.ops.shutdown registered notifier that gracefully
> shuts down the kthread printers and transitions to atomic printing.
>
> There is a pr_flush() in kernel_power_off(), but actually that is no
> longer needed and should be removed.

After reviewing [0] I am reminded why pr_flush() exists in
kernel_power_off(). It is purely for legacy consoles on PREEMPT_RT.

I am wondering if instead printk_kthreads_shutdown() should make an
effort in this case (legacy + PREEMPT_RT):

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0bbf6409d467a..10b655f05fa56 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3776,6 +3776,15 @@ static void printk_kthreads_shutdown(void *data)
 		 */
 		nbcon_atomic_flush_pending();
 	}
+
+	/*
+	 * If legacy kthread printing is in use, give it a chance to
+	 * flush any backlog. The kthread is not stopped because when
+	 * forced, it is the only way legacy consoles can print.
+	 */
+	if (force_legacy_kthread() && printk_legacy_kthread)
+		pr_flush(1000, true);
+
 	console_list_unlock();
 }

That would still not cover the final "Power down", so probably the
pr_flush() should also continue to exist in kernel_power_off(). But it
is PREEMPT_RT + legacy specific, so I am not too happy about it.

John

[0] https://lore.kernel.org/lkml/a68e2e94-b4c6-4791-b581-ecbf3fee28e9@paulmck-laptop
