Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157D35AC13;
	Mon, 12 Oct 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811615; cv=none; b=ZDLDm/iN6cHSuZKiBESl71b1OZu2v90Z2ZtQ6JD5wqJEuWdUUwNjUNjZgtE9rqftDOD2pQgY5ccMwvDSr3MiagLuwpq36HG92Y2MNDwkyKKTwyOC7NzCWHtq/Bpx35936tahs5RKYX1jMq+5UCeWn3PX70cDks2e1kENi7BMkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811615; c=relaxed/simple;
	bh=McNc7mRTi630L5RqDTDS443M5FD6Fc0Itp5qOeegxH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7IP5f5FqQ0PeTCbRzqBVI1Oq/KbgMyMnfRuUnCjMzl0zAOEwYJmE6IAyv1v946BRxVz2qk4DYUHsD0zKFNKyaBbXGJ/UFn6EvRv9e4xCqCR9cDQNtjb7pW8HiYNwZDJcZdNkg81uHCpAfBs9UPzSXLJUkG0Ikr6Qk45Dr0AWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VcfGqVop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UprahD6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VcfGqVop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UprahD6"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791811612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgLAVkZt/7rBLyE1mX9JLdyuSLcSvPA8gtPWdNWj7ak=;
	b=VcfGqVop8XJJYefC5bUNNNjG6Khren4y6XjCNWE2Dfs9gT66ri7YX3lrA9gZZjW+2dPLcj
	92IBhjr+/zo2ur7cXCBGn1OYtFtrHxIp2ifQaXqGlupikHp8mIWax1BeCejwYwdG/dJLh4
	GTSpQ7mqRC1bE3FHqwhl8z943raw4v0LporlsjIQgsaKldMMzh4TyDfd+DqqDdlaaEciig
	o6KYYvlC36lmtiVbW/XQu7jay7kYMXfCOZmYzeq6NkIa+HbVse7m9JBrpElYyAsTc1F4iH
	duYl09CLhI1jHy92GaaZuXS5rJu04t3vuj2S/BCrnhHdmk9RCFzcaxxCKMADHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791811612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgLAVkZt/7rBLyE1mX9JLdyuSLcSvPA8gtPWdNWj7ak=;
	b=0UprahD6++I23LPrRtaDG5Rw7QyBaNltGlTmqEfNe+Nqjmd8HaxwHcKw2PlIVXHAxcDRVT
	LdEVCMUcoKadC5Cg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek
 <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Oleg
 Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-serial@vger.kernel.org,
 oliver.sang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on reboot
In-Reply-To: <20261009065152.udyfFRHx@linutronix.de>
References: <20261008150852.8286-1-pmladek@suse.com>
 <20261009065152.udyfFRHx@linutronix.de>
Date: Mon, 12 Oct 2026 15:32:52 +0206
Message-ID: <87jynnxd5v.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-09, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2026-10-08 17:08:52 [+0200], Petr Mladek wrote:
>> NBCON consoles emit messages in a dedicated kthreads when the system
>> is working properly. printk() tries to flush them synchronously in
>> explicitly marked emergency context and in panic().
>> 
>> Another situation where printk() could not rely on kthreads are the various
>> reboot and halt code paths. They can be detected by the `system_state`
>> variable.
>> 
>> Let's default to NBCON_PRIO_EMERGENCY for the post-running states.
>> printk() will automatically try flushing the consoles synchronously.
>> Also do not rely on printk() and explicitly flush the consoles
>> after these states are set.
>
> while this seems okay, didn't we have pr_flush() to flush the output on
> shutdown/ reboot?

We have the syscore.ops.shutdown registered notifier that gracefully
shuts down the kthread printers and transitions to atomic printing.

There is a pr_flush() in kernel_power_off(), but actually that is no
longer needed and should be removed.

John
