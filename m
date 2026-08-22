Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080D17C203;
	Sat, 22 Aug 2026 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787358768; cv=none; b=ciwV9CTSVImK6s9QFT7jRbk/QIhCnaaHEO4WY3ibzNXGVpQxrvsakEBMr3zE3bIGYaO6/S5GfM3hLcKifLaEo8ZAaURftULwl/lsCpC1pqJ7rof5vAts4fqpKpun015iHYav+ueY+j6v31hbHIN7wBofwoxvOTo/QoWtojL/198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787358768; c=relaxed/simple;
	bh=jeNPfoQSWRsd2UTJg5/tdON68Hu2ry07ldbht8mCOaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tCFd7y11pH3bN3D6FmKpI6B+WJfjedm4V41SzKZ/J+8fFfYYYHeGZkGRvQz9+xirm9MSfpAyij4FcUgTSomLdZPaTCARMBqhawSxQEkQ9KweuXNn6Os1GkegnK5FI95KKvxHxvtwi6/pJyNx6xZdiMFanX9IDjOzXg6jEStQ5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kal4hAZz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cf6ySnY0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kal4hAZz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cf6ySnY0"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787358765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbWQl23qxR3vhOY9t59UGeJScSSFNgMuPCCbzHBilmk=;
	b=Kal4hAZzdXGpHcyqETjs/peTKtXo3G8rrdUspypgQJwMou2cGT1YJv2Q7uUJHU3eOllBRh
	X800/wvyATpyEbo2UM+3LKjYkUWcTkRdklbfhYIDT6WWh4O9I3LpTowpecgHqHGHIoSLhW
	qCPL8JK3IDUY0kjycp60HAuAqYLl5eLPikzyRR3XwUZH6pxNtAIG/zHuhI0az0QmpcA0D9
	slnHaFuAnZgQOrkcV9PanOvih7HmLkFSFTI3El1uNOI4ZVqHblYZeJjjBMbAhL4uGMIHZB
	FHvQq1Wyy3TpMAd+Qlrmw4khH1Q3E5+jfaDe/blN2wqL+l6usiekcW4kIMMYZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787358765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbWQl23qxR3vhOY9t59UGeJScSSFNgMuPCCbzHBilmk=;
	b=cf6ySnY0eWEdheBn1EG9q36G54JJ5Z4hSUvxlHNELO32lp0doXY5+azH54tsFESQVnfYps
	c/plLfUWnyZsnDBQ==
To: Jon Hunter <jonathanh@nvidia.com>, Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Fushuai Wang <wangfushuai@baidu.com>, Marco
 Felsch <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
 <877bll9d91.fsf@jogness.linutronix.de>
 <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
Date: Sat, 22 Aug 2026 02:38:28 +0206
Message-ID: <875x139eqr.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-08-21, Jon Hunter <jonathanh@nvidia.com> wrote:
> I replaced the WARN with a pr_err() and I see the same issue.

Thanks for testing. But just to be certain, can you restore the original
code (with the warning) and apply this horrible hack to force atomic
printing? I want to be certain that the problem goes away when nbcon
deferred printing is not active. For thet test you should boot normally
(without keep_bootcon).

===== BEGIN HACK =====
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 85fbf1801cbe0..5806815fa11b2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -202,6 +202,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 				ft->nbcon_offload = true;
 			else
 				ft->nbcon_atomic = true;
+			ft->nbcon_atomic = true;
 		}
 
 		/* Legacy consoles are flushed directly when possible. */
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 4b03b019cd5ee..152d9ac28176d 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1185,6 +1185,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 
 	if (kthread_should_stop())
 		return true;
+	return false;
 
 	/*
 	 * Block the kthread when the system is in an emergency or panic mode.
===== END HACK =====

I am expecting that this will work and the warning will be cleanly
visible on the UART console.

If the above test was successful, I am wondering if cpuidle should be
disabling the deferred printing as this seems quite similar to suspend.

Could you perform another test using the following hack _instead_ of the
above hack? This is probably a bit extreme since it does more than just
disable deferring, but it could help us figure out what is going on.

===== BEGIN HACK2 =====
diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index aca907a62bb5d..0fb449e23f677 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -15,6 +15,7 @@
 #define pr_fmt(fmt)	"tegra-cpuidle: " fmt
 
 #include <linux/atomic.h>
+#include <linux/console.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -165,6 +166,8 @@ static __cpuidle int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 {
 	int err;
 
+	console_suspend_all();
+
 	/*
 	 * CC6 state is the "CPU cluster power-off" state.  In order to
 	 * enter this state, at first the secondary CPU cores need to be
@@ -176,7 +179,7 @@ static __cpuidle int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 	if (index == TEGRA_CC6) {
 		err = tegra_cpuidle_coupled_barrier(dev);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	local_fiq_disable();
@@ -204,6 +207,8 @@ static __cpuidle int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
 	cpu_pm_exit();
 	tegra_pm_clear_cpu_in_lp2();
 	local_fiq_enable();
+out:
+	console_resume_all();
 
 	return err ?: index;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3fcdf4b4e2e53..8d126b5068684 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2787,7 +2787,7 @@ void console_suspend_all(void)
 	struct console *con;
 
 	if (console_suspend_enabled)
-		pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
+		pr_info_once("Suspending console(s) (use no_console_suspend to debug)\n");
 
 	/*
 	 * Flush any console backlog and then avoid queueing irq_work until
===== END HACK2 =====

John Ogness
