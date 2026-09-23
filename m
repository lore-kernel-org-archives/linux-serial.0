Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11B4A1E01
	for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160096; cv=none; b=NUXBZQVVt2X6I51LttSo+rbemxs0AKavD+/4W74zTI0nXHZOySUUZ7YrvYdp8HFWvOngtjfg7n7MN7UJ8jlTNdUtGU5HG5LDmP7oNubSC76AuodmGKJ+5zCq8ARQ2NNV8oMs1h4GCi4ZAfVHlvAsKJRFZBRtOhYFB87cyYr8epY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160096; c=relaxed/simple;
	bh=Mg8XHhySgzeRr9d9Cl/wJfKCnUgqbAUBBffT/dlh+1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrneatWStejVPhI44ky9A3ZJkI/WNA6u0HLrJ4OrhV/pvSCuxpX5YRGMdW0OfoLSUpmJuwocz6RiNICRCSlglLIzmTGPrjGRNwIKKC0XtLp50yNIkX9Qw+TkcoGFDGzYNMOhuGyRM3zXbUIGK9vZZrOrn759CQMAQlNv7yAwQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/Q2xUds; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VnUZYME; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/Q2xUds";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VnUZYME"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790160083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7oBGNeI1AM2SpjAuLOGSJw37UBdqeg5sGlVmTPCvqk=;
	b=W/Q2xUdsijof6tU6I2CtRgjRDNC1kLBwHu8VfmHk1hAo+78mZV7TokpTOq1+h5iZcnTD/o
	uxRfqlhf5HgM6uKoUZM8eFiSDcXbf9sViBHRYcLmUa2JhQ3zDs9Fte+2CyBHsEEverNlPg
	Ltw+qsRTXs4NfcVo9cTK5o+707NhXMldOTv4ghhL1QL6LRrkESnM4gdfOIxfjnyd+Ls3Ge
	F4mI/6LpsOnjO0YQ0cEmjIyT3/uB+kHQyQKgrTyO9kga+kznaemeZtm9naCEOa9EWOZXEN
	VrdoQUhby+1XuBG8RLDEuJOXPdrm+gAI7H3iOqdkGmPhh+zfZHO6HOy6FyCg0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790160083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W7oBGNeI1AM2SpjAuLOGSJw37UBdqeg5sGlVmTPCvqk=;
	b=1VnUZYMEb6OdA++eOedg9QzI5yGbFfuu+Rw/nYMS0uc79odWycUL1+YA6rBxTwKSrOHc4K
	4ogREtnGEEobKwDA==
To: kernel test robot <oliver.sang@intel.com>, Petr Mladek <pmladek@suse.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
 oliver.sang@intel.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [linux-next:master] [serial]  d353934702:
 BUG:kernel_reboot-without-warning_in_test_stage
In-Reply-To: <202608061008.48a1e76e-lkp@intel.com>
References: <202608061008.48a1e76e-lkp@intel.com>
Date: Wed, 23 Sep 2026 12:47:22 +0206
Message-ID: <87ecek1c8d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Added printk folks To/Cc.)

Hi Oliver,

On 2026-08-06, kernel test robot <oliver.sang@intel.com> wrote:
> similar to
> https://lore.kernel.org/all/202602271552.c972ef9e-lkp@intel.com/
> we still found we have kernel_reboot-without-warning_in_test_stage by this
> change in our tests.
>
> hard for us to understand the connection, and we cannot capture more usef=
ul
> information from serail. just report FYI what we observed in our tests.
>
>
> kernel test robot noticed "BUG:kernel_reboot-without-warning_in_test_stag=
e" on:
>
> commit: d3539347022ad4eeb9dbd29c50bfca17b9d8a146 ("serial: 8250: Switch t=
o nbcon console, take 2")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: boot
>
> config: i386-randconfig-2006-20250825
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 3=
2G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202608061008.48a1e76e-lkp@intel.=
com
>
>
>
> [   65.107802][  T272] INFO: lkp CACHE_DIR is /tmp/cache
> [   65.107809][  T272]
> BUG: kernel reboot-without-warning in test stage
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260806/202608061008.48a1e76e-lk=
p@intel.com

This problem is because the kernel buffer is not flushed before
performing the sysrq-triggered emergency restart. The following patch
sort of addresses this:

----- BEGIN RFC PATCH -----
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd9..5d1ff39b21f90 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)	"reboot: " fmt
=20
 #include <linux/atomic.h>
+#include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
@@ -92,8 +93,11 @@ static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
 void emergency_restart(void)
 {
 	kmsg_dump(KMSG_DUMP_EMERG);
+	nbcon_cpu_emergency_enter();
+	printk_trigger_flush();
 	system_state =3D SYSTEM_RESTART;
 	machine_emergency_restart();
+	nbcon_cpu_emergency_exit();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
=20
----- END RFC PATCH -----

@pmladek:

It is necessary to put the CPU into an emergency state, otherwise atomic
printing will not be used. This is kind of a best effort, as opposed to
panic() where eventually unsafe flushes are attempted. So if the sysrq-b
is triggered while another CPU is printing to the console, the user
still might not see any of the pending messages on reset.

Any comments from your side on this?

@oliver.sang:

Note that the LKP script does not wait for the sync:

https://github.com/intel/lkp-tests/blob/master/bin/lkp-setup-rootfs#L97

Since printk() calls no longer block on UART TX, the script will end up
triggering the reboot before the sync is completed. This means that with
the above patch applied, instead of seeing:

LKP: ttyS0: 251: LKP: tbox cant kexec and rebooting forcely
[   46.796412][  T251] sysrq: Emergency Sync
[   46.797173][  T149] Emergency Sync complete
[   46.797635][  T251] sysrq: Resetting

you only see (and the sync does not complete):

LKP: ttyS0: 253: LKP: tbox cant kexec and rebooting forcely
[   48.059434][  T253] sysrq: Emergency Sync
[   48.059868][  T253] sysrq: Resetting

Adding a delay (like "sleep 10") to the script before triggering the
reboot works, but gives the other LKP tasks time to output as well. So
you end up seeing:

LKP: ttyS0: 253: LKP: tbox cant kexec and rebooting forcely
[   47.755504][  T253] sysrq: Emergency Sync
[   47.756180][  T103] Emergency Sync complete
[   48.128796][  T269] LKP: stdout: 253: Kernel tests: Boot OK!
[   48.128807][  T269]
[   49.434596][  T271] check_nr_cpu: lscpu_nr_cpu 1 mismatchs with nr_cpu 2
[   49.434608][  T271]
[  OK  ] Finished Remove Stale Onli=E2=80=A6ext4 Metadata Check Snapshots.
[   50.402642][  T271] ls: cannot access '/boot/config-*': No such file or =
directory
[   50.402654][  T271]
[   54.455304][  T269] LKP: stdout: 253: HOSTNAME vm-snb, MAC 52:54:00:12:3=
4:56, kernel 7.2.0-rc5-00056-gd3539347022a-dirty 7
[   54.455316][  T269]
[   54.457150][  T269] install debs round one: dpkg -i --force-confdef --fo=
rce-depends /opt/deb/gawk_1%3a5.1.0-1_i386.deb
[   54.457155][  T269]
[   54.458339][  T269] Selecting previously unselected package gawk.
[   54.458344][  T269]
[   54.459720][  T269] (Reading database ... 16439 files and directories cu=
rrently installed.)
[   54.459725][  T269]
[   54.460981][  T269] Preparing to unpack .../deb/gawk_1%3a5.1.0-1_i386.de=
b ...
[   54.460985][  T269]
[   54.461760][  T269] Unpacking gawk (1:5.1.0-1) ...
[   54.461765][  T269]
[   54.476817][  T269] Setting up gawk (1:5.1.0-1) ...
[   54.476827][  T269]
[   54.477316][  T269] NO_NETWORK=3D
[   54.477322][  T269]
[   54.478078][  T269] INFO: lkp CACHE_DIR is /tmp/cache
[   54.478084][  T269]
[   57.782143][  T253] sysrq: Resetting

I am not sure what you prefer. But if the sysrq-sync is important, the
script needs to wait for it to complete.

John Ogness
