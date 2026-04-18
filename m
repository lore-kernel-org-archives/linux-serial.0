Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3C283FE6;
	Sat, 18 Apr 2026 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776496846; cv=none; b=fBvTNt14pJKvYR5bwoO/uIM8kktfNgc6NvBJZWYHvSygRoz/jEOuVmgT5Nejs7vuxd7F4DlixqLGSH9DvfH1niUKDc4Rhh0ddFdQjw/4QKPA5ZS623nGPnsym9kinYSFX9nKYZKbnxZ/buzxn1ZuwxnrSbek9NxCjl47rDmsW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776496846; c=relaxed/simple;
	bh=HXn/tXx4Her6JOWy7/hI4hpd9CpVnkssdruoadF/Y9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHWxjx6Dus2ucHXfH3H2JCtho2zB+SxfeZhMGfaUU8ClTIwHF2PhrGYpc/4ryxknjQdGv1FDaFqILL8SQrBkJuSe6XpycL1uBE1qYHSWOC9/AsLBSdI/c4n+Iy3LUBhoYUX5jmGK+bU2RHmRl4iO375Etyg/lP6EoaOPHRx54zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lXTDNUUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lXTDNUUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E0DC19424;
	Sat, 18 Apr 2026 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776496846;
	bh=HXn/tXx4Her6JOWy7/hI4hpd9CpVnkssdruoadF/Y9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXTDNUUyFyZLkh2imUzzMTjoZ9p1YIKC8WRYqlZW6RyjkMytv2af8+lfhub7FUj6O
	 oW6BoCZo7QxvuIJGrgYoBmVq+60NfX9eNoaFp0hJKOqaxejYBFjLrRP6hHxgNR6gT9
	 U6l7uwZ1niUydFWnAQMLaEqLzRM7j6l/PsZZVoDc=
Date: Sat, 18 Apr 2026 09:20:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: jirislaby@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] sysrq: add optional logging of caller info on
 /proc/sysrq-trigger write
Message-ID: <2026041830-visibly-underpaid-6dc8@gregkh>
References: <20260416131419.1231012-1-gxxa03070307@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416131419.1231012-1-gxxa03070307@gmail.com>

On Thu, Apr 16, 2026 at 09:14:19PM +0800, Xiang Gao wrote:
> From: Xiang Gao <gaoxiang17@xiaomi.com>
> 
> When /proc/sysrq-trigger is written to, there is no record of which
> process triggered the sysrq operation. This makes it difficult to audit
> or debug who initiated a sysrq action, especially when the write comes
> from a shell spawned by system()/popen() where the immediate caller is
> "sh" rather than the originating application.
> 
> Add CONFIG_MAGIC_SYSRQ_TRIGGER_LOG (default n) and a runtime toggle via
> module parameter sysrq.trigger_log (default off). When both are enabled,
> the kernel logs the triggering process's comm, pid, tgid, uid, and walks
> up to 5 levels of the parent process chain. This allows tracing the
> original initiator even through system()/popen()/fork+exec indirection.
> 
> Example output:
>   sysrq: proc trigger: comm=sh pid=68 tgid=68 uid=0
>   sysrq:   parent[0]: comm=my_app pid=67 tgid=67
>   sysrq:   parent[1]: comm=init pid=1 tgid=1
> 
> Usage:
>   # Compile-time: enable CONFIG_MAGIC_SYSRQ_TRIGGER_LOG=y
>   # Runtime: echo 1 > /sys/module/sysrq/parameters/trigger_log
>   # Or boot parameter: sysrq.trigger_log=1
> 
> Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> ---
>  drivers/tty/sysrq.c | 29 +++++++++++++++++++++++++++++
>  lib/Kconfig.debug   | 16 ++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index c2e4b31b699a..e9277e7de35b 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -48,6 +48,9 @@
>  #include <linux/uaccess.h>
>  #include <linux/moduleparam.h>
>  #include <linux/jiffies.h>
> +#ifdef CONFIG_MAGIC_SYSRQ_TRIGGER_LOG
> +#include <linux/cred.h>
> +#endif

We really do not want or like #ifdef in .c files, and for stuff like
this, it is not needed at all.

>  #include <linux/syscalls.h>
>  #include <linux/of.h>
>  #include <linux/rcupdate.h>
> @@ -59,6 +62,12 @@
>  static int __read_mostly sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
>  static bool __read_mostly sysrq_always_enabled;
>  
> +#ifdef CONFIG_MAGIC_SYSRQ_TRIGGER_LOG
> +static bool sysrq_trigger_log;
> +module_param_named(trigger_log, sysrq_trigger_log, bool, 0644);
> +MODULE_PARM_DESC(trigger_log, "Log caller info on /proc/sysrq-trigger write");
> +#endif

Module parameters are really not the way for stuff like this.  And why
would such a "tiny" option need a config option at all?  If you don't
use/need it, it's only a single bool being used?


> +
>  static bool sysrq_on(void)
>  {
>  	return sysrq_enabled || sysrq_always_enabled;
> @@ -1209,6 +1218,26 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
>  	bool bulk = false;
>  	size_t i;
>  
> +#ifdef CONFIG_MAGIC_SYSRQ_TRIGGER_LOG
> +	if (sysrq_trigger_log) {
> +		struct task_struct *task;
> +		int depth = 0;
> +
> +		pr_info("proc trigger: comm=%s pid=%d tgid=%d uid=%u\n",
> +			current->comm, current->pid, current->tgid,
> +			from_kuid(&init_user_ns, current_uid()));

The kernel log is not there for doing audits and the like, so is this
just a debug option?  

> +
> +		rcu_read_lock();
> +		task = current;
> +		while (task->pid > 1 && depth < 5) {
> +			task = rcu_dereference(task->real_parent);
> +			pr_info("  parent[%d]: comm=%s pid=%d tgid=%d\n",
> +				depth++, task->comm, task->pid, task->tgid);
> +		}
> +		rcu_read_unlock();

This might cause problems for when the system is hung and sysrq is the
only way to reboot the box.  Have you tried it in that situation?



> +	}
> +#endif
> +
>  	for (i = 0; i < count; i++) {
>  		char c;
>  
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index aac60b6cfa4b..46bd361decd0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -705,6 +705,22 @@ config MAGIC_SYSRQ_SERIAL_SEQUENCE
>  
>  	  If unsure, leave an empty string and the option will not be enabled.
>  
> +config MAGIC_SYSRQ_TRIGGER_LOG
> +	bool "Log caller info on /proc/sysrq-trigger write"
> +	depends on MAGIC_SYSRQ
> +	default n

n is always the default, no need to add it again.

thanks,

greg k-h
