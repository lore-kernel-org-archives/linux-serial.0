Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC22D7D2F;
	Tue, 27 Jan 2026 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523864; cv=none; b=WbRqVK1xgA5oyPk3hUmFYL9kiLWw/RoBMJ+4S9n1mE7rfcmAlDEaNb/1o0zHxJIqVO8fE5kmKRy4VnAcnwI/MshCrczJh9eFTSdm3pqVEo7UZ0iFVzFZfVNjvN4ANF+/X3Y8CzCjUDeV+Wnyze7PG8pXyjVDpyqNwQC5HdXZG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523864; c=relaxed/simple;
	bh=/X+4BfoLMHfHUsv/F8snNQqOAYWNbZ5/49zAJRESWvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrcN4r/cqVFR7pDaVqfSrhKyQHbopeZ+MLM84CNOAq5c09KDPGHXeyiQETadmwNZcTNk/BuOW7fRisKK1LHxIBBIrvIA0V2vCyCkhpBhKJplfp9wJNNQkCGKwmRnuVSDdejjUWcnr1p6kgXZ/L+vr6oAszh7MjJE7nw0zgnjE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNnZbYPh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNnZbYPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EC2C116C6;
	Tue, 27 Jan 2026 14:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769523863;
	bh=/X+4BfoLMHfHUsv/F8snNQqOAYWNbZ5/49zAJRESWvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNnZbYPha4qPCkxHaN7h3JcGPinzgjSakSyg1u2eCYlCihPom7g4T7gNWn3vx24kv
	 8KcWMqAwUoVI0suAlFjYXs9oG1Nfa7Je89Bwavm1G7knB4Ut4H47IoNyPfp84N44ab
	 1Wcak7mL/CrcFaZFp8ehfr4k0KL103c6klQc2wak=
Date: Tue, 27 Jan 2026 15:24:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] printk, vt, fbcon: Remove console_conditional_schedule()
Message-ID: <2026012757-voting-griminess-ca35@gregkh>
References: <20260126180836.SNCdMW2f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126180836.SNCdMW2f@linutronix.de>

On Mon, Jan 26, 2026 at 07:08:36PM +0100, Sebastian Andrzej Siewior wrote:
> do_con_write(), fbcon_redraw.*() invoke console_conditional_schedule()
> which is a conditional scheduling point based on printk's internal
> variables console_may_schedule. It may only be used if the console lock
> is acquired for instance via console_lock() or console_trylock().
> 
> Prinkt sets the internal variable to 1 (and allows to schedule)
> if the console lock has been acquired via console_lock(). The trylock
> does not allow it.
> 
> The console_conditional_schedule() invocation in do_con_write() is
> invoked shortly before console_unlock().
> The console_conditional_schedule() invocation in fbcon_redraw.*()
> original from fbcon_scroll() / vt's con_scroll() which originate from a
> line feed.
> 
> In console_unlock() the variable is set to 0 (forbids to schedule) and
> it tries to schedule while making progress printing. This is brand new
> compared to when console_conditional_schedule() was added in v2.4.9.11.
> 
> In v2.6.38-rc3, console_unlock() (started its existence) iterated over
> all consoles and flushed them with disabled interrupts. A scheduling
> attempt here was not possible, it relied that a long print scheduled
> before console_unlock().
> 
> Since commit 8d91f8b15361d ("printk: do cond_resched() between lines
> while outputting to consoles"), which appeared in v4.5-rc1,
> console_unlock() attempts to schedule if it was allowed to schedule
> while during console_lock(). Each record is idealy one line so after
> every line feed.
> 
> This console_conditional_schedule() is also only relevant on
> PREEMPT_NONE and PREEMPT_VOLUNTARY builds. In other configurations
> cond_resched() becomes a nop and has no impact.
> 
> I'm bringing this all up just proof that it is not required anymore. It
> becomes a problem on a PREEMPT_RT build with debug code enabled because
> that might_sleep() in cond_resched() remains and triggers a warnings.
> This is due to
> 
>  legacy_kthread_func-> console_flush_one_record ->  vt_console_print-> lf
>    -> con_scroll -> fbcon_scroll
> 
> and vt_console_print() acquires a spinlock_t which does not allow a
> voluntary schedule. There is no need to fb_scroll() to schedule since
> console_flush_one_record() attempts to schedule after each line.
> !PREEMPT_RT is not affected because the legacy printing thread is only
> enabled on PREEMPT_RT builds.
> 
> Therefore I suggest to remove console_conditional_schedule().
> 
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Fixes: 5f53ca3ff83b4 ("printk: Implement legacy printer kthread for PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> A follow-up to
> 	https://lore.kernel.org/all/20260114145955.d924Z-zu@linutronix.de/
> 
>  drivers/tty/vt/vt.c              |  1 -
>  drivers/video/fbdev/core/fbcon.c |  6 ------
>  include/linux/console.h          |  1 -
>  kernel/printk/printk.c           | 16 ----------------
>  4 files changed, 24 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 59b4b5e126ba1..53daf7614b1af 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3236,7 +3236,6 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
>  			goto rescan_last_byte;
>  	}
>  	con_flush(vc, &draw);
> -	console_conditional_schedule();
>  	notify_update(vc);
>  
>  	return n;

No objection from me about removing this if it's not needed anymore!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
