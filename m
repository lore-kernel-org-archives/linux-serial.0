Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC12D8382
	for <linux-serial@vger.kernel.org>; Tue, 17 Feb 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318487; cv=none; b=EtS22F8H6AFGvnCGd/D5CXbuTe5D/91nI4ml38nS7N154srF71C/rmeJy1ljNNWq6kQbzuK49wZU93oFGaE6flZlU3AL3AdB9OJi/rbK0Vrd/dTlbj+5QWX/+f5z/3WwJREC+ISBRra5rpXIxjtZqxwgsP8RvCA0Ghig89EnoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318487; c=relaxed/simple;
	bh=U/y+F5lXzT6ipnlHOpj1gEg9m7Car22XHVLh0x06TMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEFfOWT8W6jnVwerhhKd1LVZrJjsev0i3Cel5EAgQK7Pjn43YtNwo87eCFkvQX75X82RRp+meItfjyc0rCuM3kohem2t+nDmvu1C4VJ3KL7tZlOZrJmVbZQa/8l85DOiwxaZ2ge3/F95y39Jt+fGNAwW0zF6/AClfaSFO635fbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eYONv0y+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eYONv0y+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-435f177a8f7so4293291f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Feb 2026 00:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771318484; x=1771923284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hjMcRNdBXILoAJvk/EWdE0yoDcwaUF03VAGg5Yay6bE=;
        b=eYONv0y+pnL9IPnsGqxqqWnKjIQdAfxH7Avfe7WukheLQNrkkjIffecfZORuilpLyN
         8jC92pS/uUnMbUX4SODjLJQGE22/FF5nALRSYCU7cfwQk+NoLeEeEQ5GifX+TGBg8OLR
         oA2Pmyry8R/4vg+reIaIGhJ0ucNpM/cdhheIy5YCCdm7MG0T1LhkVR16OQTIOzlduEQE
         wJN13ssKy+SOzW35HaC6os0J7pn/KWoYnAn1JHx+m46QDG7PHRX1NF8Gd0+yKtLDUcze
         +C9W+ie+2v0UTVdU28wr0mPHBIiVpp+V+SXHDf/3Fv8r894yxACNr8N0zOvsBCdYLBrj
         b4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771318484; x=1771923284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjMcRNdBXILoAJvk/EWdE0yoDcwaUF03VAGg5Yay6bE=;
        b=IcjjS2u5e2y44jQZHJjggHdJ5oFxR+Ihl1EE36aJQmVdrUoNypOZZkZ0ONiyvCpaB+
         W78+J2G3etfBBF/b4ev2mN6SLdiBkvlPQg7c30XEVb7HZZqGAWBZeXKqfZlI8PVVDuZu
         ykZy1dq4jZ1yKFbPdtU7KV4Ho7T6tB1M3RpFKl254yG237FlMvk2DQcdVOeSTEB4eRVq
         MRadwnnP2ujuUn/35Mwc4TuSjsC/2Zb/iO8wKuwVfR05NZWiYwynNqTHDG1MDXP0F7X6
         ZY6pBSJZDFOM5J+CExtYcvLr3DKCByva6Mxr27/+lFjLJDGQNn/U3I76KuVvlBTSmXjt
         qzJw==
X-Forwarded-Encrypted: i=1; AJvYcCUhZNaJAwC48iZL/qCTvRfEOEo/DiZ2Tz5zdvdCn81PCoPfowZNy58ODMcQuVkP1CJJkVHom53evf+K5jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7cDRYyNe565OypasVhHNX6dUeSVp7ltpXj1Te8MyUYyb8OOH
	3/wX6e45z6NVQ79KcGzQnDBwQ7cnUxSL5eXX7pKCCL024+wbcbTjOi+Lq+o2rjvzAgc=
X-Gm-Gg: AZuq6aIl7AFFYMDthO+eEHZcZoD4//N3AwkkdelBLKwRbF3jTx7p2imwlVzXDkJAVBf
	lFpBEbQ0qdTVp9sZ9AYN1M999wLqFjX6vdpSiCYvmygqFijsG0JsHVdpOxeGO8cWAFCxEvmfozs
	+vS93d6QZNJwfejoi3puk01qYFAejB+EHYyKEuAK+Gc6aEGiYZezJPC9TvtLJd+0DwVrAr5alky
	SR9GMFgUYtbardzsTjKGbDWkVOCwlae/FlWDbovvGuFW1/hAB7xZ3RjbwXlfFGwCRVQTZQetE4q
	8Ti1wWfBPeCfaD0ZbFt2ovGig63xFkFXk/Vo47lMzS72VKSh2r5GHut9ZZwFRSdNq39F/Eyrtfi
	Tr5WbG7EJSp9KmmIxxT7BbKH4RjpVfQIowKi5tgRkN337lgKfQ5wwcSb8tV9qmiENUs4uqiEpJE
	4X8QVH7IJC+sfYhHpQ/Mt2p9mtLg==
X-Received: by 2002:a5d:5850:0:b0:437:8f37:882 with SMTP id ffacd0b85a97d-4379db93a97mr20414374f8f.33.1771318483803;
        Tue, 17 Feb 2026 00:54:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd793sm32552682f8f.25.2026.02.17.00.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:54:43 -0800 (PST)
Date: Tue, 17 Feb 2026 09:54:41 +0100
From: Petr Mladek <pmladek@suse.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Calixte Pernot <calixte.pernot@grenoble-inp.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: printk, vt: sleep from invalid context bug
Message-ID: <aZQs0WYk262ZNybc@pathway.suse.cz>
References: <87v7fwdsln.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7fwdsln.fsf@yellow.woof>

On Tue 2026-02-17 09:14:12, Nam Cao wrote:
> Hi,
> 
> Since commit 1bc9a28f076f ("printk: Use console_flush_one_record for
> legacy printer kthread"), I see this warning:
> 
> BUG: sleeping function called from invalid context at kernel/printk/printk.c:3431
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 14, name: pr/legacy
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 4 locks held by pr/legacy/14:
>  #0: ffffffff807dcdf0 (console_lock){+.+.}-{0:0}, at: legacy_kthread_func+0x40/0x114
>  #1: ffffffff807dce30 (console_srcu){....}-{0:0}, at: console_flush_one_record+0x0/0x3c8
>  #2: ffffffff8083af88 (printing_lock){+.+.}-{3:3}, at: vt_console_print+0x48/0x330
>  #3: ffffffff807df2e8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x24/0x138
> CPU: 0 UID: 0 PID: 14 Comm: pr/legacy Not tainted 6.19.0-rvvm-09292-g7449f86bafcd #79 PREEMPT_RT 
> Hardware name: RVVM v0.7-git-g8c45ccf (DT)
> Call Trace:
>     walk_stackframe+0x0/0x80
>     dump_stack_lvl+0x4e/0x74
>     rt_spin_trylock+0x9e/0x138
>     __might_resched+0x19e/0x1e0
>     fbcon_redraw+0x74/0x1a0
>     fbcon_scroll+0xf2/0x13c
>     con_scroll+0x122/0x188
>     lf+0x6a/0x74
>     vt_console_print+0x2ac/0x330
>     console_flush_one_record+0x208/0x3c8
>     console_flush_one_record+0x3c4/0x3c8
>     kthread+0xc6/0x100
>     legacy_kthread_func+0x4c/0x114
>     prio_changed_stop+0xc/0x10
>     kthread+0xc6/0x100
>     ret_from_fork_kernel_asm+0x12/0x18
>     ret_from_fork_kernel+0xe/0x3fc
>     rt_spin_unlock+0x56/0x128
>     kthread_affine_node+0x88/0x8c
>     ret_from_fork_kernel_asm+0x12/0x18
> 
> If I understand it correctly, vt_console_print() grabs the spin lock
> "printing_lock", and then calls fbcon_redraw() which does
> console_conditional_schedule(), triggering the warning.

Sebastian has recently sent a patch which should remove the
cond_resched(), see
https://lore.kernel.org/all/20260126180836.SNCdMW2f@linutronix.de

It seems that the patch has made it upstream in this merge window
for 7.0, see the commit 8e9bf8b9e8c0 ("printk, vt, fbcon: Remove
console_conditional_schedule()").

Best Regards,
Petr

