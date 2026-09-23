Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A552F274
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169287; cv=none; b=pt2C089K8tLIhcavLy6poUILadxqo7X4uRY8OIB0au1Xlo8I/1EM3mscRGucizFcgpr9nMD0fSj7W4YiL8ClOufj6KehVkU+xz1Onp+n8wzCYldDTewHf+93hs/XmYAn0vzlkCRa42xGy/+DAY3n8KldWdg9dqihd2pIwTkPK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169287; c=relaxed/simple;
	bh=m73YgzPC/oHtrI30sAdWwdYdyatDQvTggEN9eRhb9vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyqKCn/kfkFHup+sDD1areHiCQWpng3nuEiVB1k5iqr4m6VJ1WqIQLHFypnb8cSUjdke14+Ai4fUbP3i+D0Bm/p59yCklxqqIrIMwXRrpeMW2k6K++vak4kb7RJ+pLT/F87IkkECrm9gTHlO353YJbBr6vOUXg2FSOv7GpiGbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f/b1nBam; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f/b1nBam"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so4915115e9.0
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790169282; x=1790774082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AcmugnOtJIpIvD9XnAZ7QoVrmR1jg4Uar0bF2hc3D/8=;
        b=f/b1nBamlweMaZ8m9c90RcHYz6yWPewMBiYiaoiAwEpkTnOGA/gYTrZtOK1FOGfte8
         N8uz/Ak1yPwHzfO9GQxvb2W5IhOf4cvJleoXb6ho/mTsFORcN0RWtCO26itGM1uY/5+s
         5VpyCueCnQIydfPs0w6W6gHBSNgQ81Op2zeLWJTabqF4iggXuwbCWhUqj/Qq98gQt8w2
         O5q5/+jiW8s92NMElpMmJz/8LmVvVsgxajjXv7H4HH2gUBZfD3DX1qyKchtcqri3TgBt
         IsjxrmCvKj4FH8cwMmHI11ZBYVHo9/l1oJMBbiLscs1dCSlBLtXMV0ToL/KfY4ZP1INJ
         go5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169282; x=1790774082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AcmugnOtJIpIvD9XnAZ7QoVrmR1jg4Uar0bF2hc3D/8=;
        b=p6ijNVSQ7zfTGig2lA7NxVzp5jWQ4aUnq0LaWwEQtGrW3/yRw2jXLYbR3J/U8sFCzK
         Hu7InI8f6XsNqZI2R7hxQk+/qRMyB8xTPlCGpiQqyIOud8vaXUkXK6qpISply1gbbwUV
         wDCIz22M3DSwnxu4UYHR5FfIWzyWda6a1ztEP6WS2n8s1VI8RFEWwmV+E57DBovzCymH
         +x+Mmqqz6FxuHheophD5yZXYwUKTrSuTkpHamQqFSa/keC8gndLaR8jvNzwYj8/0Zq7i
         G1FPdzQ5Aov2F4DdmJfUlxb9hTRanCZ+iYSAPI/BY6zy8+jqykACoN0a2YxZl+IX7VE5
         0Kmg==
X-Forwarded-Encrypted: i=1; AKwUvBxkI265hO3Hx3ZRH+XN04eWYHUOjs4O2g2+XVveRnRn45LQuaqsqySP58oxzxiH24DNNlfn8RD5k82eHUY=@vger.kernel.org
X-Gm-Message-State: AFuF++nSjaimbILuJzl5mdKr6w+xLdVn3jyfPWjoRqr55k4Wtv7Cx70d
	K0ihFjkABd+Vh73So53zu/1dpVPQ0/TX5wgKVNYPkK0p+4gS8yWuK3bLqahvfXEQvWdIbqxjE3F
	kMznYFWM=
X-Gm-Gg: AYBFou2JoELEDZtc9QlVgbWo91CtUAUO6o0bioCaduP5JaWriJtj6GzJCo+ZTjeeyHK
	sa76v0btvnUlU2MFD2d97ipvsqpXwulD/jB+FP4eQM5Xa/be3vv2KBP4YbfBSEu1N9yqFkcAsjE
	U2Oti00ZttSgEuY/BNPR/DkBvUPiBaUi/Q2wloT1gad8kFS0v9HhldndP2C4kDto4MPBQS39RO1
	JL2A4hkTp5qEFcoNDGy5X7uiG6AXgNhmwhKOzl302N8YxKonRYLhsxRxfSi54YMjA2Y9W//EhAl
	2pJOLW647Rm8NjXzO95vWCR3rdFIylol/lYE1hMNloTLC4sDt+3mErPyDKKAG36p/xb0gwM9xv+
	43nc+wLFkMoKQZmHWZGyoMk6b+o2iWnYF2/q1xgNqIN3e/aysYHCE4y/vw60wMzX7J6ANmQxjX4
	BziwMhODjyl1+FCDhZ4l+casBIUX9Mvx25DTCEVMnIUd8rrnZkt2Ni3FdcqIQ7BjvPQTQfsLXGv
	CMcn2RlWBL5JsY=
X-Received: by 2002:a05:600d:644e:10b0:49f:e441:d61f with SMTP id 5b1f17b1804b1-49fe441d6c9mr7010295e9.21.1790169282422;
        Wed, 23 Sep 2026 06:14:42 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde17dab9sm91009135e9.2.2026.09.23.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:14:41 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:14:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [linux-next:master] [serial]  d353934702:
 BUG:kernel_reboot-without-warning_in_test_stage
Message-ID: <arPQwKbl7wM6IM3x@pathway.suse.cz>
References: <202608061008.48a1e76e-lkp@intel.com>
 <87ecek1c8d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecek1c8d.fsf@jogness.linutronix.de>

On Wed 2026-09-23 12:47:22, John Ogness wrote:
> (Added printk folks To/Cc.)
> 
> Hi Oliver,
> 
> On 2026-08-06, kernel test robot <oliver.sang@intel.com> wrote:
> > similar to
> > https://lore.kernel.org/all/202602271552.c972ef9e-lkp@intel.com/
> > we still found we have kernel_reboot-without-warning_in_test_stage by this
> > change in our tests.
> >
> > hard for us to understand the connection, and we cannot capture more useful
> > information from serail. just report FYI what we observed in our tests.
> >
> >
> > kernel test robot noticed "BUG:kernel_reboot-without-warning_in_test_stage" on:
> >
> > commit: d3539347022ad4eeb9dbd29c50bfca17b9d8a146 ("serial: 8250: Switch to nbcon console, take 2")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > in testcase: boot
> >
> > config: i386-randconfig-2006-20250825
> > compiler: gcc-14
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202608061008.48a1e76e-lkp@intel.com
> >
> >
> >
> > [   65.107802][  T272] INFO: lkp CACHE_DIR is /tmp/cache
> > [   65.107809][  T272]
> > BUG: kernel reboot-without-warning in test stage
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20260806/202608061008.48a1e76e-lkp@intel.com
> 
> This problem is because the kernel buffer is not flushed before
> performing the sysrq-triggered emergency restart. The following patch
> sort of addresses this:
> 
> ----- BEGIN RFC PATCH -----
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 695c33e75efd9..5d1ff39b21f90 100644
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
> @@ -92,8 +93,11 @@ static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
>  void emergency_restart(void)
>  {
>  	kmsg_dump(KMSG_DUMP_EMERG);
> +	nbcon_cpu_emergency_enter();
> +	printk_trigger_flush();
>  	system_state = SYSTEM_RESTART;
>  	machine_emergency_restart();
> +	nbcon_cpu_emergency_exit();
>  }
>  EXPORT_SYMBOL_GPL(emergency_restart);
>  
> ----- END RFC PATCH -----
> 
> @pmladek:
> 
> It is necessary to put the CPU into an emergency state, otherwise atomic
> printing will not be used. This is kind of a best effort, as opposed to
> panic() where eventually unsafe flushes are attempted. So if the sysrq-b
> is triggered while another CPU is printing to the console, the user
> still might not see any of the pending messages on reset.
> 
> Any comments from your side on this?

I think that it is a reasonable approach in principle.

The above patch handles only emergency_restart(). The similar problem
would be even in other code paths where the system is going down.
I think about using NBCON_EMERGENCY_PRIO automatically in all
these states, something like:

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d17704fe93ae..48446926dc50 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1446,6 +1446,10 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	if (panic_on_this_cpu())
 		return NBCON_PRIO_PANIC;
 
+	/* Do not rely on kthreads when the system is going down. */
+	if (system_state > SYSTEM_RUNNING)
+		return NBCON_PRIO_EMERGENCY;
+
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
 	if (*cpu_emergency_nesting)
 		return NBCON_PRIO_EMERGENCY;
diff --git a/kernel/reboot.c b/kernel/reboot.c
index d177d89fcc33..776784a82499 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)	"reboot: " fmt
 
 #include <linux/atomic.h>
+#include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -94,6 +95,7 @@ void emergency_restart(void)
 {
 	kmsg_dump(KMSG_DUMP_EMERG);
 	system_state = SYSTEM_RESTART;
+	printk_trigger_flush();
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
@@ -102,6 +104,7 @@ void kernel_restart_prepare(char *cmd)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
+	printk_trigger_flush();
 	usermodehelper_disable();
 	device_shutdown();
 }
@@ -305,6 +308,7 @@ static void kernel_shutdown_prepare(enum system_states state)
 	blocking_notifier_call_chain(&reboot_notifier_list,
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
+	printk_trigger_flush();
 	usermodehelper_disable();
 	device_shutdown();
 }

Note that it would use NBCON_EMERGENCY_PRIO even in SYSTEM_SUSPEND
state. But I think that it does not have any real effect because
it seems to be done after the consoles are suspended. at least
in hibernation_platform_enter().

Best Regards,
Petr
