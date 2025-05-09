Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F8238C16;
	Fri,  9 May 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810272; cv=none; b=ImVILovvjSKdbqHBJVeZe4AKgkzqeICFNK9jbewNexVHGcUG/xGdsZOsMpwKnZP+SAVl2zzuHsgeNz+R3FWpba+ga0O2dxTMTYChzJIknPyTtqzTepYvLmORun0BXuwMzfT6isoZ7xqLNnkFGRubTgtAR458aYdNH3MI6fwdJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810272; c=relaxed/simple;
	bh=Nkv6IKHXCYUek8fh7AoYuM8l9DOttVnrkqI5DhG25sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nif6r22FWJDAubvY9ZFPjvbuwXd+XS//18N9KNj9iw/ODSgFfNjcJvwii28/EuRAgjyjJgMj5nFTDiqdwadQWevmjGO1Rqj+GuRK/fgCc/u1wodfvZ97NViWK4HoUNo6M/R+BbpEdraD4w4icLLWqDq9k5P2rU7Uw/84ahqDEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjzK/3ae; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjzK/3ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CADCC4CEE4;
	Fri,  9 May 2025 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746810271;
	bh=Nkv6IKHXCYUek8fh7AoYuM8l9DOttVnrkqI5DhG25sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjzK/3aeSYXIF8bhlpxZPZO6jjh180oKxg+OAj9qPXFU9ntAY8K6RJWo4P+eHOGpm
	 Ad7LnN9reiWLrtjB6/mdI8kxzx08pv4GVK84bUjVme/teEOuQTmAPhvKuHLO1Y3g5U
	 ZI8MTiH5ocNl1R+2CHhv7UODcLpqDb58QMpHzVf0l0+QMDDlaBVtjvYSXsjxDSmJxk
	 sop16G6oygpTYCfh//O70fepRaRBcBMKXrVSSTcmsovKqa3VlWgxylpbRg4b0cA7UR
	 2yQdYr50VE7pNPxO2GkB3ogTfl81PHcJSWU/I1zEJCvWuDWEFI1fKr5VrBd9fu9Fx7
	 iwm4xaR87qRoA==
Date: Fri, 9 May 2025 10:04:28 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org,
	linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 10/12] sysctl: Move sysctl_panic_on_stackoverflow to
 kernel/panic.c
Message-ID: <202505091003.FCBA48E47D@keescook>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-10-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-10-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:14PM +0200, Joel Granados wrote:
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Another undocumented sysctl. ;) This one should be called
"panic_on_stack_exhaustion", but so be it. :)

Reviewed-by: Kees Cook <kees@kernel.org>

> ---
>  kernel/panic.c  | 10 ++++++++++
>  kernel/sysctl.c | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213c6c9d6a750ff3d17f3cf530b37c619cd816f4..401f0997f654797acc3351040bbbda1845ce00c1 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -183,6 +183,16 @@ static const struct ctl_table kern_panic_table[] = {
>  		.mode           = 0644,
>  		.proc_handler   = proc_douintvec,
>  	},
> +#if (defined(CONFIG_X86_32) || defined(CONFIG_PARISC)) && \
> +	defined(CONFIG_DEBUG_STACKOVERFLOW)
> +	{
> +		.procname	= "panic_on_stackoverflow",
> +		.data		= &sysctl_panic_on_stackoverflow,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +#endif
>  };
>  
>  static __init int kernel_panic_sysctls_init(void)
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index d5bebdd02cd4f1def7d9dd2b85454a9022b600b7..446d77ec44f57a4929389b64fc23d3b180f550b4 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1552,16 +1552,6 @@ static const struct ctl_table kern_table[] = {
>  		.mode		= 0444,
>  		.proc_handler	= proc_dointvec,
>  	},
> -#if (defined(CONFIG_X86_32) || defined(CONFIG_PARISC)) && \
> -	defined(CONFIG_DEBUG_STACKOVERFLOW)
> -	{
> -		.procname	= "panic_on_stackoverflow",
> -		.data		= &sysctl_panic_on_stackoverflow,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -#endif
>  #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
>  	{
>  		.procname	= "ignore-unaligned-usertrap",
> 
> -- 
> 2.47.2
> 
> 

-- 
Kees Cook
