Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D932C3745
	for <linux-serial@vger.kernel.org>; Mon, 16 Jun 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082239; cv=none; b=aUA53lNF8B4G/TRZeZqVl5E+i/Dh+KzNLQ5Dtgfy1nrMwOFOZFmdtL67jz93EOtpAE4hoBmGegbs0B3HFFyYBBqX0dPq/qI/o5ocjbkM4MQdZ2b7C+fSqN2e+e35hUNvnweNK2G0p0H+wcG855e9U2OVc/Om3YVn9VLPRFjveME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082239; c=relaxed/simple;
	bh=NH0FX9kt0WubJvwnc+nYK/maDfQ9wwkDesbyODdRkTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKyVXkcjl/78JPf/xlKWdRbtebcyTruf2CzKUV6Jw2xuzto2netOP4LJAoC7lpbrHo9NJ/4AYYpBJUFebxbfc11WUC9Eqb6msSCL6rB9ofFVKTeGUHqsne2OvxeURQtXCOx0t3r3DqGl+tdu8IIfvYh0kx40xuMePQ1NQ/CvKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hGTxF0p6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hGTxF0p6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a36748920cso5370595f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 16 Jun 2025 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750082235; x=1750687035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5U21iemE/c9Sz0YhEWkD1P9gtyQVcNDFZou5zB9HsA=;
        b=hGTxF0p6tGO+hQUegUdTkJeP17/HhQs9wCy334tOFiX1HT+Y/DvpMaGKoSRHZ5597N
         pY7u4a08y3J1KNnDG5DfyU42bZp4mOVeQdh0guB3Uv1B3Wrsa103Wwf69rGXKReMidUc
         jHJJzYnseEc7JWxkZxukJbxcthl0yrx9kL4TTWPD0jJ1FVDSxij8b1UMYVJNgVy3T1BM
         tfSu12FvP+T/IVMiJcsAWIpt2veVuMYy0TQhzKA3ryl0XKuchDwYnHjjTb6N9BeuwTkl
         5C/g6H389IT/4cmQez+9PlnKqdCgH+qaDzmlnMy4eUxVkHrqfIDonY2NpzmkPE9+5fUR
         icBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082235; x=1750687035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5U21iemE/c9Sz0YhEWkD1P9gtyQVcNDFZou5zB9HsA=;
        b=RRI9MU7djYNFtETNafVbe9+jigPbqINKuGDTdcqfFL0k9V1r6SSc3YU6Ad4oJ1kOVN
         rV0X6filsglgMFdVIDnBlyjBNyWNbBzvPmT5AMfU7NobEKKf8XZNxB5fl3LDkDyp4fqF
         ags7SgSejc4FzDZtiy2H2XXjPR+8wzVuGTDeYGOzt/IHHkwuYfZa6e33svqo5g2p5Y2I
         +WmdSiZoUsKQHIxt0z2i6nlo6gpBkRLp/gXmyyun5VOqTeF+i9KAQ0NcSMQ0N4mGnMkw
         uwIMH4y+xYKDLT5SD9h7nmUO2t44jT9HPX+Mou3qVPdrIVqQiAS5s2fPrcjGSevDITMm
         yM2A==
X-Forwarded-Encrypted: i=1; AJvYcCUJgYoWoGX7waIXUeX3g4hSJhmowm1id4E6o0kyysrcU9k0o2uu768egcap306N5ah46N+7nUvjMomG5+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6lujeSj0P/3wZzlsBigpFj58Vn2hzou6GSHunSL/VuArtiTK
	aVa/bEcyEsV5Z+bFxNa3o9WtJ1Hx7fVaQp2PoaJv2+nY7oFY+roMTstD3+YDobV6hQg=
X-Gm-Gg: ASbGnculO3itsKyFnTYh+ta1kRWkLQLdolCFRE8Gtd3kqpAkV+XUBytLG1kZA7bErdK
	ILaWngA+lE2ww7pXYXpDqCj1DiHzotXW3DOLFc0bO2juI+uVs0gQ9OhKhqMIedMHWmNc74MNSmQ
	5Djd+Php/MUSPgZrQyNym3zL3T4NK7bdDJpa8Ldu8keqJoXfWh0rU7tUtBzA3pnu8ZtFJtNNvUa
	5d6PnQ097iRtYdx10UqaC2fVsv6zXnuly+E+d6zk/kWdVDcb/Bk42vvp2tPm+KpQVSdZr4lX16b
	BkK9ZAF2QTjCHBU4SxY25kPS2VLy6gJuec2DOnGmPHeLU3jeMysb4QVTOvAhg+aa
X-Google-Smtp-Source: AGHT+IG5cdNsogAjYlCwwv/Yr99wBxZ5kpKFYKtrzNVTxQPp1q35B4mAJcdg7PMSO6nM0Lz7izNcdg==
X-Received: by 2002:a05:6000:1449:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3a572367734mr6709880f8f.12.1750082235292;
        Mon, 16 Jun 2025 06:57:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea927asm61349195ad.155.2025.06.16.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:57:14 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:56:59 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 6/7] debug: kgd_io: Don't check for CON_ENABLED
Message-ID: <aFAiq3IEic8DuATR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-6-f427c743dda0@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-6-f427c743dda0@suse.com>

On Fri 2025-06-06 23:53:48, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console_srcu are registered, meaning that all of
> them are CON_ENABLED. The code tries to find an active console, so check if the
> console is not suspended instead.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/debug/kdb/kdb_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..cdc1ee81d7332a9a00b967af719939f438f26cef 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -589,7 +589,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	 */
>  	cookie = console_srcu_read_lock();
>  	for_each_console_srcu(c) {
> -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> +		if (console_srcu_read_flags(c) & CON_SUSPENDED)
>  			continue;

I think that this is similar to the 5th patch. We should check
here is_console_usable(con, console_srcu_read_flags(c), true)
because it checks more conditions:

     + the global console_suspended flag. The consoles drivers should
       not be used when it is set...

     + whether NBCON console driver has con->write_atomic

and we should also fix kdb_msg_write() to actually use
con->write_atomic() when it is a NBCON console driver.
There is hard-coded con->write() at the moment.

But it might get more complicated. It would be nice to do it correctly
and use con->write_atomit() only when nbcon_context_try_acquire()
succeeds. We probably should use a context with NBCON_PRIO_EMERGENCY.

And this should be fixed at the beginning of the patchset because
it actually fixes the support of the new NBCON console drivers.

Best Regards,
Petr

>  		if (c == dbg_io_ops->cons)
>  			continue;
> 
> -- 
> 2.49.0
