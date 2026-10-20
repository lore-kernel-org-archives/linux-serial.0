Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478078;
	b=35XiSZak+bjk92tI2v+sLgq4XoOeKID9f33Gxt8m+jr6xo8ttkeCbAr3DGLkne4868BE
	 /SuAa24k5uNXQ+rOuXN46uZgQtSqvJY/fKKV98y4veYQjXJ+D5lOAD+AffDyGgmQdgnSW
	 Y6AtKRuumsrR7nme9wBAR/DxuKIFHukd+cjCa8yUIOKmgfrlMtUwes+mdubwbHCEIWFuH
	 t50m/YHHPtyP2EoCBoOVxmCEo2/hCbGN1vJ+zSzACeH+ETLF/Y9TnOYkc4izrxgMu3lX+
	 jWGRW8OPRIPMWhaJvkr3yHxJLoKiTMYL5gs+a9sq5ewd7mZ4aw7Oo4Atpj5buIny1og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478078;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TdM65JEhfC/yLgAsZZOfD84vlUQN7UeBtmUtK5nblaA=;
	b=IjY1XcUdL6943/t9BvVceEPe2OqlTtnNKZB+u7IxrD+hpSMAKEu8QaK/YWhip4BchHXn
	 G/TLugIgn2pn3q1c4OUfz9OQE/3gP5g5tzmYRsAzm2Qk2cMIhktD2ewZD2nEfRE3l4upg
	 U5oc+ZtkX/KqOZbtG2Wsm3JJciLNbePQnrSkgINr8BLokrCYSoKnGN8zJNhJ8RuB67HDJ
	 c625BhY1jPDQdP69qsH6XQ0c44PmNYhfHHXB9YpbGrmIPPgfdey/JLN98ShP9eD2bJFtK
	 TdSyYl7cQx39sv00iQ6TJTnpdp2hLGsfVCp/VzAaU7r36I3haTcRh7d5owBVsXw/COQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hJLosUCF;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649C606A31B
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 06:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A649C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hJLosUCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792478077; x=1824014077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oTRRnPMpooR6lIVPxhneZWRM90bGD6ZmUq7Fq200N3U=;
  b=hJLosUCFWwy9kZ7m1d4C+3hQaW2te7XvYgzVb8l9s+XPaaVGiwykWTgu
   GRiKTlhF7NyZzBafT+uGFDXyfMdqLATZl91eb1chaqM+3oggE4f1SCgD/
   jKaibEeiCdXZWBhg7TwByWflPc+BG75HNwhxWzRIf4fjYt/7hVu2Xa7hf
   qrfK6UmyXhB/D5jk7K0NUqB9pEHoYTZWB3yOCKdkpztockVZuPVjYkqN+
   Mshr+EubPNhjMisrAGfBSOEPulkAcX8J1DFqMphpayr8d31INiIOfg8Ed
   9jHzwFxUq7INvQexMjPl6fu3piE1azbLm/pkluDfnyPIKPtPX8GqbcX9r
   Q==;
X-CSE-ConnectionGUID: wN9j9krdTuC1/jSuyYMewA==
X-CSE-MsgGUID: /5YrnXH9SuWd2bFIxQSezA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1064776"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1064776"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 23:34:36 -0700
X-CSE-ConnectionGUID: 8FMi0m4NSe249u4y/yejsw==
X-CSE-MsgGUID: sQe+Ju+kRJK69VwAxHvJuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2793633"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 23:34:34 -0700
Date: Tue, 20 Oct 2026 14:34:30 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [linux-next:master] [serial]  d353934702:
 BUG:kernel_reboot-without-warning_in_test_stage
Message-ID: <atcLdg5RvEMnkzvJ@ly-workstation>
References: <202608061008.48a1e76e-lkp@intel.com>
 <87ecek1c8d.fsf@jogness.linutronix.de>
 <arPQwKbl7wM6IM3x@pathway.suse.cz>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arPQwKbl7wM6IM3x@pathway.suse.cz>

On Wed, Sep 23, 2026 at 03:14:40PM +0200, Petr Mladek wrote:
> On Wed 2026-09-23 12:47:22, John Ogness wrote:
> > (Added printk folks To/Cc.)
> > 
> > Hi Oliver,
> > 
> > On 2026-08-06, kernel test robot <oliver.sang@intel.com> wrote:
> > > similar to
> > > https://lore.kernel.org/all/202602271552.c972ef9e-lkp@intel.com/
> > > we still found we have kernel_reboot-without-warning_in_test_stage by this
> > > change in our tests.
> > >
> > > hard for us to understand the connection, and we cannot capture more useful
> > > information from serail. just report FYI what we observed in our tests.
> > >
> > >
> > > kernel test robot noticed "BUG:kernel_reboot-without-warning_in_test_stage" on:
> > >
> > > commit: d3539347022ad4eeb9dbd29c50bfca17b9d8a146 ("serial: 8250: Switch to nbcon console, take 2")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > >
> > > in testcase: boot
> > >
> > > config: i386-randconfig-2006-20250825
> > > compiler: gcc-14
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202608061008.48a1e76e-lkp@intel.com
> > >
> > >
> > >
> > > [   65.107802][  T272] INFO: lkp CACHE_DIR is /tmp/cache
> > > [   65.107809][  T272]
> > > BUG: kernel reboot-without-warning in test stage
> > >
> > >
> > >
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20260806/202608061008.48a1e76e-lkp@intel.com
> > 
> > This problem is because the kernel buffer is not flushed before
> > performing the sysrq-triggered emergency restart. The following patch
> > sort of addresses this:
> > 
> > ----- BEGIN RFC PATCH -----
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index 695c33e75efd9..5d1ff39b21f90 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -8,6 +8,7 @@
> >  #define pr_fmt(fmt)	"reboot: " fmt
> >  
> >  #include <linux/atomic.h>
> > +#include <linux/console.h>
> >  #include <linux/ctype.h>
> >  #include <linux/export.h>
> >  #include <linux/kexec.h>
> > @@ -92,8 +93,11 @@ static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
> >  void emergency_restart(void)
> >  {
> >  	kmsg_dump(KMSG_DUMP_EMERG);
> > +	nbcon_cpu_emergency_enter();
> > +	printk_trigger_flush();
> >  	system_state = SYSTEM_RESTART;
> >  	machine_emergency_restart();
> > +	nbcon_cpu_emergency_exit();
> >  }
> >  EXPORT_SYMBOL_GPL(emergency_restart);
> >  
> > ----- END RFC PATCH -----
> > 
> > @pmladek:
> > 
> > It is necessary to put the CPU into an emergency state, otherwise atomic
> > printing will not be used. This is kind of a best effort, as opposed to
> > panic() where eventually unsafe flushes are attempted. So if the sysrq-b
> > is triggered while another CPU is printing to the console, the user
> > still might not see any of the pending messages on reset.
> > 
> > Any comments from your side on this?
> 
> I think that it is a reasonable approach in principle.
> 
> The above patch handles only emergency_restart(). The similar problem
> would be even in other code paths where the system is going down.
> I think about using NBCON_EMERGENCY_PRIO automatically in all
> these states, something like:
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index d17704fe93ae..48446926dc50 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1446,6 +1446,10 @@ enum nbcon_prio nbcon_get_default_prio(void)
>  	if (panic_on_this_cpu())
>  		return NBCON_PRIO_PANIC;
>  
> +	/* Do not rely on kthreads when the system is going down. */
> +	if (system_state > SYSTEM_RUNNING)
> +		return NBCON_PRIO_EMERGENCY;
> +
>  	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
>  	if (*cpu_emergency_nesting)
>  		return NBCON_PRIO_EMERGENCY;
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index d177d89fcc33..776784a82499 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -8,6 +8,7 @@
>  #define pr_fmt(fmt)	"reboot: " fmt
>  
>  #include <linux/atomic.h>
> +#include <linux/console.h>
>  #include <linux/ctype.h>
>  #include <linux/export.h>
>  #include <linux/kexec.h>
> @@ -94,6 +95,7 @@ void emergency_restart(void)
>  {
>  	kmsg_dump(KMSG_DUMP_EMERG);
>  	system_state = SYSTEM_RESTART;
> +	printk_trigger_flush();
>  	machine_emergency_restart();
>  }
>  EXPORT_SYMBOL_GPL(emergency_restart);
> @@ -102,6 +104,7 @@ void kernel_restart_prepare(char *cmd)
>  {
>  	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
>  	system_state = SYSTEM_RESTART;
> +	printk_trigger_flush();
>  	usermodehelper_disable();
>  	device_shutdown();
>  }
> @@ -305,6 +308,7 @@ static void kernel_shutdown_prepare(enum system_states state)
>  	blocking_notifier_call_chain(&reboot_notifier_list,
>  		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
>  	system_state = state;
> +	printk_trigger_flush();
>  	usermodehelper_disable();
>  	device_shutdown();
>  }
> 
> Note that it would use NBCON_EMERGENCY_PRIO even in SYSTEM_SUSPEND
> state. But I think that it does not have any real effect because
> it seems to be done after the consoles are suspended. at least
> in hibernation_platform_enter().
>

Applied this fix on top of the commit d353934702. The
kernel_reboot-without-warning issue cannot be reproduced.
 
> Best Regards,
> Petr
