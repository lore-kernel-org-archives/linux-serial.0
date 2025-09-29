Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989922F74E
	for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135179; cv=none; b=NwY/jPFjr4K/8UARycqCZH0GrnqVQGatYE1WkRBBkQ+kY5cE4ZDnfsHY/gm5rQv/3M+BRx0us4r0+YoGBAxS7vD71BnSCGYKV1RpqdiDZkgtgMPKvEqlem9NYRfWnuFIiTQAJ/Pw4rvOKZwv2UUku7d+0kvDDJAffmaWI09li/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135179; c=relaxed/simple;
	bh=zdXHfYiqqEfNUFSLYiYIWqzt+Vby+zwT42p0bQKU5fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJt7ilhM5hFr6C/s8aqthb1zVsxZLO4dskNvB+MG4BvuAvoBerU8VjQa5FqxcvtiKqsef0HhJRrGMThxUuxftSFjZznkpKepjH+x4wwLAEtKgTNZtXn8Lg0RHFx0VMemX+ngyRHr3bza+tGGzT9i4HYtLJR+szAZOd8LukhxLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=yco22s5K; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="yco22s5K"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-427e5121313so12537755ab.0
        for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759135175; x=1759739975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7+yZewoV3/hMV333NTGgFLedG7WjFfUKL3HMCvn71Hw=;
        b=yco22s5KVtawXud3CBaJvaeoMuuSO3HE/qU8AZo8yFk4dXcVs5LTwBKuw4brMB+km1
         qUmJryPuW0fQphzoUMMD/8Eoq/9yagQojGKjUX5LoqApS2irmkc1q1oUbbnTgGJep0Ag
         Po7N3a1nPBB8lYDb6D5CVqHG1ygpsSJFFSfVBc4RZ2haStIWntRK7wfsE6bShO36MKAp
         Ba/7tjzyyCRXtO4vWwA2vSkfRFkSIXLBRGrtApes3bZAT9k4A8k2z6qjDuSALMG87S67
         aZ+siUifEedFom2bX9SrZDVOvPqIkveuY0sEZMe7K/s1MJpojlRcRwqdkVaW+dJmtq5F
         FAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135175; x=1759739975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+yZewoV3/hMV333NTGgFLedG7WjFfUKL3HMCvn71Hw=;
        b=ZBi6zdwQ9QqLY+hPRsgw2sftj8eSJ/GIZ3vCyWW2Ww0Kyvwk5gLvkavTds5GZjTMNx
         EpUdMHpJQ6YoC1a7MxKjy9XoGKzVnfI7SZ5sWAO0g2hLjspy3V3COxK0l+ITxyLim5Tb
         +98SOPWDE3Gwb3tMyPeG24q6Yup9SejEOlbf0Rh+5bpm5nH0Zkks3GV+kTmCYxvpkSqO
         Mlb+KNca8jgvKHQnqwWwstF5XDhr3xuPOHGrmkG5tVSDiuWEKShzdCoj0QVcpE9BJCfL
         3hqobare5xdGLkXPjWcFUmkkQmW7pfwxRQJUbhib4DChRXjuTEc3qh4H+4kNvAATYOaU
         6pjA==
X-Forwarded-Encrypted: i=1; AJvYcCUy8ifZ4jdb5j/+1oQ0jAl4YpmI1nKawYVrtwHR5krk6OQ8WqhzMofX6HD1J6ufddTSB9pePsbI7PFcVQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTH0x/WYiM7qnAsfXlVORm+NrgyQ0zEWBLCorBS7+YCwTEVgl
	iD/WYUhAtb3kjPLUd35udIa6jqvy3kRtv/bsFGSW1ltTI4kK7vhCFmJ4o5SGs+oK7/GamYFWaPT
	HW1ky6V0QGSUX/qQgWLDtObAWr+vqXwTg816cRwQz0A==
X-Gm-Gg: ASbGnctQpXjqb1gphIPfUd5yHP+D+FSZTB9a5lOGZQ/1E5a632x1bo38wlAFXy+QOLH
	ZM/WwKZ15pto5fg5ZLTKPy3LcLlDGDAubmvuvMILTdVtK3EyJHORc27sbGZc0pTozXTu+6n7LRb
	BuPT4RjaW+gzmEf+0U8eQJXOBdugkBgUGZZpC90mLYtGLezvAcB41mR1wIWuuVM29WlWD1Ezd4L
	YfOAI+xc6fUZqym94Lxi9kt8v7ea+TRJQtdTX8oysmeIYM5idc=
X-Google-Smtp-Source: AGHT+IGH0RD4zyGfaK6z15i7jobE8xMNaqJ74RouKvg9EZSyUDLrkj+1EJNMbNJpFYXh0Kfv76FxouXZMzCplRpBspw=
X-Received: by 2002:a05:6e02:4409:b0:423:fb44:e8d4 with SMTP id
 e9e14a558f8ab-425955d00a2mr225611195ab.6.1759135175264; Mon, 29 Sep 2025
 01:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926124912.243464-1-pmladek@suse.com> <20250926124912.243464-3-pmladek@suse.com>
In-Reply-To: <20250926124912.243464-3-pmladek@suse.com>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 29 Sep 2025 09:39:23 +0100
X-Gm-Features: AS18NWB1cWWMcOl-z-W0vgKnyVgsKKGijSL3OTnvX-cbjFUjnGidqrhxQAvwHCQ
Message-ID: <CALqELGxuA+5Zqqrsw0XtXrDLua_rcD_odrYjV29fOXai+M0qaw@mail.gmail.com>
Subject: Re: [PATCH 2/3] printk/nbcon/panic: Allow printk kthread to sleep
 when the system is in panic
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Tony Lindgren <tony@atomide.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 13:50, Petr Mladek <pmladek@suse.com> wrote:
>
> The printk kthread might be running when there is a panic in progress.
> But it is not able to acquire the console ownership any longer.
>
> Prevent the desperate attempts to acquire the ownership and allow sleeping
> in panic. It would make it behave the same as when there is any CPU
> in an emergency context.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/internal.h | 1 +
>  kernel/printk/nbcon.c    | 6 ++++--
>  kernel/printk/printk.c   | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index ef282001f200..6e8578102fb3 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -332,6 +332,7 @@ struct printk_message {
>         unsigned long           dropped;
>  };
>
> +bool panic_in_progress(void);
>  bool other_cpu_in_panic(void);
>  bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>                              bool is_extended, bool may_supress);
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 08b196e898cd..219ae0c8b5ed 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1178,7 +1178,8 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>          * where the context with a higher priority takes over the nbcon console
>          * ownership in the middle of a message.
>          */
> -       if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
> +       if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)) ||
> +           unlikely(panic_in_progress()))
>                 return false;
>
>         cookie = console_srcu_read_lock();
> @@ -1236,7 +1237,8 @@ static int nbcon_kthread_func(void *__console)
>                  * Block the kthread when the system is in an emergency or panic
>                  * mode. See nbcon_kthread_should_wakeup() for more details.
>                  */
> -               if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)))
> +               if (unlikely(atomic_read(&nbcon_cpu_emergency_cnt)) ||
> +                   unlikely(panic_in_progress()))
>                         goto wait_for_event;
>
>                 backlog = false;
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ebf10352736f..174d42041594 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -345,7 +345,7 @@ static void __up_console_sem(unsigned long ip)
>  }
>  #define up_console_sem() __up_console_sem(_RET_IP_)
>
> -static bool panic_in_progress(void)
> +bool panic_in_progress(void)
>  {
>         return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
>  }
> --
> 2.51.0
>

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

Thanks,

Andrew Murray
