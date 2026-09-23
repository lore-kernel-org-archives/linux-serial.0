Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AB538D69
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179186; cv=none; b=X8i1JtO46WgKn+otfFMM8eGt9tERkdNZnaGzysLJJwghzg2s32+YTthozESmZTSWyN2sQbYddZRWAA1V0n46chLAeYtespqm75wzrN8O+T5lgQA8BN4zU/Tp+G/ddoEvz40XSrwQUe8GxoxNTwd+jiiH1OMB1/dNFpKPkPRN9WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179186; c=relaxed/simple;
	bh=S4sFlisaC8O3zgD+kGxA4xEknznZCvoeYv8Oak6hpr8=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=L13VcdhTk9XqNpnFwxYPM22QSuryMI2z/+bcxV+95b3GyF/YCUet0NWBKqpBHv/1FFSqdehzZLI4gArYb9cvzHZ/DG4hVPu70yVGXi57PDLDLabFZbCl7U2I8hSjlDu9+X1vergqd683IQ4lMvXNMPk5OThq4qk50Zh3ruy24f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=IeqMtE+j; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=OyPWSQTn; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="IeqMtE+j";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="OyPWSQTn"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790179178; bh=bhlp4VhL8v7Ns1qW5hgWGRs
	IKPhpkhLGHULFe8vGGkg=; b=IeqMtE+j0e/L1CWjRCceoYDn7fO+FJBAGFS6xrfalCnEEz9swJ
	z+T0VO4fTbzZEJ0eYV6fk4L+NsFxCK403crwsHEv/mHwwgR5ucHDbSKZBOIZoIlqYz1BWiaJGd9
	M8v/uTLajlwmn7I3sB+dTEmbD+1k/VeCJG4iAyDsgqrtUJzGIMCHHm8tM5HsmmRzRV1hgBh8Syq
	ylQGk67B2Dz0wZP8WUZY9MWTKjDXuhk1rkbMW//9loYjpYhDEArW/MmZArtKck1YZu1t2zQNTJu
	24yo0SBeI6+SfTyqFpmbqNrayXvDTcimw0KM6BW4cIRjhJJdXqv0Q2QeocJusDIyN3A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790179178; bh=bhlp4VhL8v7Ns1qW5hgWGRs
	IKPhpkhLGHULFe8vGGkg=; b=OyPWSQTneBsus40K/2r8uZjPNXxHdhsLqAuf2PL6aa1hUPpHBU
	Zf28lvdoXNQVS0PT4XgWPFQpE+D6mUpfaxAg==;
Date: Wed, 23 Sep 2026 16:59:38 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pmladek@suse.com
CC: gregkh@linuxfoundation.org, john.ogness@linutronix.de,
 linux-serial@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, rostedt@goodmis.org, senozhatsky@chromium.org
Subject: =?US-ASCII?Q?Re=3A_=5Blinux-next=3Amaster=5D_=5Bserial=5D__d353934702=3A_?=
 =?US-ASCII?Q?BUG=3Akernel=5Freboot-without-warning=5Fin=5Ftest=5Fstage?=
In-Reply-To: <arPQwKbl7wM6IM3x@pathway.suse.cz>
Message-ID: <7CB4E0A4-05CA-4C74-91CB-FEFB3B7F5872@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 23 September 2026 14:14:40 BST, Petr Mladek <pmladek@suse.com> wrote:
>On Wed 2026-09-23 12:47:22, John Ogness wrote:
>> (Added printk folks To/Cc.)
>> 
>> Hi Oliver,
>> 
>> On 2026-08-06, kernel test robot <oliver.sang@intel.com> wrote:
>> > similar to
>> > https://lore.kernel.org/all/202602271552.c972ef9e-lkp@intel.com/
>> > we still found we have kernel_reboot-without-warning_in_test_stage by
>this
>> > change in our tests.
>> >
>> > hard for us to understand the connection, and we cannot capture more
>useful
>> > information from serail. just report FYI what we observed in our
>tests.
>> >
>> >
>> > kernel test robot noticed
>"BUG:kernel_reboot-without-warning_in_test_stage" on:
>> >
>> > commit: d3539347022ad4eeb9dbd29c50bfca17b9d8a146 ("serial: 8250:
>Switch to nbcon console, take 2")
>> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
>master
>> >
>> > in testcase: boot
>> >
>> > config: i386-randconfig-2006-20250825
>> > compiler: gcc-14
>> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2
>-m 32G
>> >
>> > (please refer to attached dmesg/kmsg for entire log/backtrace)
>> >
>> >
>> > If you fix the issue in a separate patch/commit (i.e. not just a new
>version of
>> > the same patch/commit), kindly add following tags
>> > | Reported-by: kernel test robot <oliver.sang@intel.com>
>> > | Closes:
>https://lore.kernel.org/oe-lkp/202608061008.48a1e76e-lkp@intel.com
>> >
>> >
>> >
>> > [   65.107802][  T272] INFO: lkp CACHE_DIR is /tmp/cache
>> > [   65.107809][  T272]
>> > BUG: kernel reboot-without-warning in test stage
>> >
>> >
>> >
>> > The kernel config and materials to reproduce are available at:
>> >
>https://download.01.org/0day-ci/archive/20260806/202608061008.48a1e76e-lkp@intel.com
>> 
>> This problem is because the kernel buffer is not flushed before
>> performing the sysrq-triggered emergency restart. The following patch
>> sort of addresses this:
>> 
>> ----- BEGIN RFC PATCH -----
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index 695c33e75efd9..5d1ff39b21f90 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -8,6 +8,7 @@
>>  #define pr_fmt(fmt)	"reboot: " fmt
>>  
>>  #include <linux/atomic.h>
>> +#include <linux/console.h>
>>  #include <linux/ctype.h>
>>  #include <linux/export.h>
>>  #include <linux/kexec.h>
>> @@ -92,8 +93,11 @@ static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
>>  void emergency_restart(void)
>>  {
>>  	kmsg_dump(KMSG_DUMP_EMERG);
>> +	nbcon_cpu_emergency_enter();
>> +	printk_trigger_flush();
>>  	system_state = SYSTEM_RESTART;
>>  	machine_emergency_restart();
>> +	nbcon_cpu_emergency_exit();
>>  }
>>  EXPORT_SYMBOL_GPL(emergency_restart);
>>  
>> ----- END RFC PATCH -----
>> 
>> @pmladek:
>> 
>> It is necessary to put the CPU into an emergency state, otherwise atomic
>> printing will not be used. This is kind of a best effort, as opposed to
>> panic() where eventually unsafe flushes are attempted. So if the sysrq-b
>> is triggered while another CPU is printing to the console, the user
>> still might not see any of the pending messages on reset.
>> 
>> Any comments from your side on this?
>
>I think that it is a reasonable approach in principle.
>
>The above patch handles only emergency_restart(). The similar problem
>would be even in other code paths where the system is going down.
>I think about using NBCON_EMERGENCY_PRIO automatically in all
>these states, something like:
>
>diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>index d17704fe93ae..48446926dc50 100644
>--- a/kernel/printk/nbcon.c
>+++ b/kernel/printk/nbcon.c
>@@ -1446,6 +1446,10 @@ enum nbcon_prio nbcon_get_default_prio(void)
> 	if (panic_on_this_cpu())
> 		return NBCON_PRIO_PANIC;
> 
>+	/* Do not rely on kthreads when the system is going down. */
>+	if (system_state > SYSTEM_RUNNING)
>+		return NBCON_PRIO_EMERGENCY;
>+
> 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> 	if (*cpu_emergency_nesting)
> 		return NBCON_PRIO_EMERGENCY;
>diff --git a/kernel/reboot.c b/kernel/reboot.c
>index d177d89fcc33..776784a82499 100644
>--- a/kernel/reboot.c
>+++ b/kernel/reboot.c
>@@ -8,6 +8,7 @@
> #define pr_fmt(fmt)	"reboot: " fmt
> 
> #include <linux/atomic.h>
>+#include <linux/console.h>
> #include <linux/ctype.h>
> #include <linux/export.h>
> #include <linux/kexec.h>
>@@ -94,6 +95,7 @@ void emergency_restart(void)
> {
> 	kmsg_dump(KMSG_DUMP_EMERG);
> 	system_state = SYSTEM_RESTART;
>+	printk_trigger_flush();
> 	machine_emergency_restart();
> }
> EXPORT_SYMBOL_GPL(emergency_restart);
>@@ -102,6 +104,7 @@ void kernel_restart_prepare(char *cmd)
> {
> 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
> 	system_state = SYSTEM_RESTART;
>+	printk_trigger_flush();
> 	usermodehelper_disable();
> 	device_shutdown();
> }
>@@ -305,6 +308,7 @@ static void kernel_shutdown_prepare(enum system_states state)
> 	blocking_notifier_call_chain(&reboot_notifier_list,
> 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
> 	system_state = state;
>+	printk_trigger_flush();
> 	usermodehelper_disable();
> 	device_shutdown();
> }
>

Hmm....  this is ok? 

Reviewed-by: Bradley Morgan <brads@mainlining.org> (this review was based on correctness :D)

>Note that it would use NBCON_EMERGENCY_PRIO even in SYSTEM_SUSPEND
>state. But I think that it does not have any real effect because
>it seems to be done after the consoles are suspended. at least
>in hibernation_platform_enter().
>
>Best Regards,
>Petr
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
