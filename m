Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890D36BCD7
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583203; cv=none; b=MM1KOeYrUCQ0aehx3+3mOSFBDXe5vaRdIKY7reYNz0rG4zAfSAzXo86W91s2mSV7aUu7k8k7CVztMrCjyLw1zO+adNEp6qkiahMAyR8BiUwmHR+ERSeW9azCCWVlGhKtCmiFyEISgc3AFUIWscseSRM1d47Lm64dspiJvK3Kv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583203; c=relaxed/simple;
	bh=/3+DBn48YlGU1ph0lB+UfJKccx+moFZ8NM2Gf88PbpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdTOiE6TLft3ULkkjhspa+QVQJv/mycbWevPxOnn6WXYr91TBgJzzMLAqYQ2jzT7I/3N71rq6PbJzBffLZz5MvckO0ws/WogKHigxyhF7d6W9M8PoK3FBsZOgfmkk2EKVT7vMD52298pd9T4q/2PHRhrkonxe+Ejs31a1qHjsFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=LZmWxT2s; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="LZmWxT2s"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e7109321dso2511941a91.3
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1787583201; x=1788188001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x6l8vCR4QfxmkIZpInMxVnFcCTGyExBCf8cQDqEtwiY=;
        b=LZmWxT2svuW4f/uZZ8F65pZR6noy8MkLVtZGzdcMdPDjIAXsas/8s2eHEWn9vuCxGz
         8wVvt/mP9e+uiTAYBnm7YG7Gbl9glubkllnqsi0do6JlVVKVElfaqyi11zSN9TKeJm+F
         tAtlerguphiXK+7j0F5G9LOg/omfiZDeXZWdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583201; x=1788188001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x6l8vCR4QfxmkIZpInMxVnFcCTGyExBCf8cQDqEtwiY=;
        b=KhMDEC2wvKr1dQnRvFpvdYdsieiQ4ZMXmUo8Jd1W7GjBOvTOyTUl/k06kPKQmT9x8f
         0lcgwwHgxNUTU0TJyNDTIHWOS/qtK0W/JBnz8x8T9YkbAI45ELwIEghGmcmq2OHARanR
         pfHfqXHCaJWW8knvlLR97hBSGCHibKSfpogoKjc4jZGTOsH8NQJD0Dudzs19fe87YO4B
         Wc6xqqkemLXambNvRad2Hnp1DZNqpGWyXWMRbtIuz7ge6/U6iJH+tEAPy4IMjdde+zvw
         qJwNHOoTTE3kr1Nd4WKMXC6BrfleV+xOJMt7svxS44+QGka4q2XYcctBbUPraJZiRtab
         PyLw==
X-Forwarded-Encrypted: i=1; AHgh+RrKtdm2OQGnkI7zHgZmooOwAi40CBb2CTCWB4hZ7fCWXDcLJSmuBscZ3RlBwXW6gjYYqsZmeOJRuNPL4Bo=@vger.kernel.org
X-Gm-Message-State: AFuF++lAALn2YP+Kdh2jAq+mvqQ6gPRDnUmDhxtdhoHXCKCkCREDGEdT
	lKqPikcTJ0bKSDKyY2RCpICSU+NnAUE+H6zQwUgp9+eOOgIg/ZVaU8H2Vi4D5Jss1ro=
X-Gm-Gg: AR+sD13i1QohcOJK2VxVboovJaBaLGu1NHrT1JNxM+tj/YDKg871Lgggb5lPXmM0Vlx
	H4W7MAFXnz51NmjToAakofyuM9JuqsIU0x2KE9tTF86WzJDqLaRcMpMdau4q2HqrwqP/VLDwYNh
	RKGtv9DkP2NVYPVqI1iWFbJM51Olycv+5J4eRAVU9BwDzxd++d36U+wutqP6TPy3rD3djR9b50w
	K178N+O2G2/89gJVuT/Ns68I43T5eRo5uekiyhObmjrhZVW0sKliRenMBStgdGxf42MT+uSYwfB
	NUWDOMKV6v89NKTupRgOjtYURzhanfXP35I0HRYog7pwNkPygfRFc6P9ga6bu46CpaFTjaDa0HN
	eEhFNVRv7vYBJdelsTsr0Zowwx6YLsBY04DPLy69y20iEaq/A4oJHLqvu/POCLv8ZSnuxhXAey7
	jIZn0d/EqLIs6kpgKQWIPRMHH2rHH+zpNVnZa+2gb7EZgqU6N5hMPu9eJiCSjcwgZilOWuaP4iK
	hckANx/W0zbYi6wptCuk2ZLUUyzGUBvQSCXvBQ9X+umzl/zELrRPWPIfLbPAc+2+HmLbJPVuXeo
	3/JzAqGIVDMqSjJVoq8V7KmNSJiParNLXrcRygvDeQXljtctaCR1vA==
X-Received: by 2002:a17:90b:4fc8:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-395c3573cecmr50482150a91.4.1787583200629;
        Mon, 24 Aug 2026 07:53:20 -0700 (PDT)
Received: from leesin ([147.46.121.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4969fb1sm10182274a91.1.2026.08.24.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:53:20 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	eulgyukim@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: [BUG] KASAN: slab-use-after-free Read in __timer_delete
Date: Mon, 24 Aug 2026 23:53:13 +0900
Message-ID: <20260824145314.2148275-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We found a "KASAN: slab-use-after-free Read in __timer_delete" on Linux v7.2.
The issue was found by our own race fuzzer. We have not analyzed the root cause,
so we do not have a proposed fix to offer.

To reproduce the race reliably, we applied the delay patch below to the
kernel and ran the C reproducer as root inside an x86_64 QEMU guest. The
crash log we observed, the delay patch and the reproducer are all included
below.

The following kernel config options are required to reproduce the issue:
    CONFIG_N_GSM=y
    CONFIG_TTY=y
    CONFIG_KASAN=y

We hope this report is useful. Please let us know if any further
information would help.

Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Kernel delay patch:
==================================================================
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -52,6 +52,8 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
 #include <linux/tty_flip.h>
 #include <linux/tty_driver.h>
 #include <linux/serial.h>
@@ -2677,6 +2682,9 @@
 	} else {
 		dlci->data = gsm_dlci_command;
 	}
+	if (addr == 0 && strncmp(current->comm, "syzrepro1", 9) == 0) {
+		mdelay(600);
+	}
 	gsm->dlci[addr] = dlci;
 	return dlci;
 }

==================================================================

C reproducer:
==================================================================
#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <time.h>
#include <unistd.h>

#define SYSCHK(x) ({ long __r = (long)(x); if (__r == -1L) { perror(#x); exit(1); } __r; })

#define N_GSM0710 21
#define GSMIOC_SETCONF 0x404c4701UL

struct gsm_config {
	unsigned int adaption, encapsulation, initiator, t1, t2, t3;
	unsigned int n2, mru, mtu, k, i, unused[8];
};

static int g_fd = -1;
static pthread_barrier_t g_bar;
static const struct gsm_config g_cfg = {
	.adaption = 1, .initiator = 1, .t1 = 200, .t2 = 200,
	.mru = 64, .mtu = 64, .i = 1,
};

static void msleep_(unsigned ms)
{
	struct timespec ts = { ms / 1000, (long)(ms % 1000) * 1000000L };

	while (nanosleep(&ts, &ts) == -1)
		;
}

/* Two threads SETCONF the same gsm mux, re-arming its T1 timer concurrently */
static void *setconf(void *arg)
{
	struct gsm_config c = g_cfg;
	char nm[16];

	snprintf(nm, sizeof(nm), "syzrepro%d", (int)(long)arg);
	prctl(PR_SET_NAME, nm, 0, 0, 0);
	pthread_barrier_wait(&g_bar);
	ioctl(g_fd, GSMIOC_SETCONF, &c);
	return NULL;
}

int main(void)
{
	int ldisc = N_GSM0710, r;
	long i;

	prctl(PR_SET_NAME, "syzrepro2", 0, 0, 0);
	for (r = 0; r < 8; r++) {
		pthread_t th[2];

		g_fd = SYSCHK(open("/dev/ptmx", O_RDWR | O_NOCTTY));
		SYSCHK(ioctl(g_fd, TIOCSETD, &ldisc));
		pthread_barrier_init(&g_bar, NULL, 2);
		for (i = 0; i < 2; i++)
			pthread_create(&th[i], NULL, setconf, (void *)i);
		for (i = 0; i < 2; i++)
			pthread_join(th[i], NULL);
		pthread_barrier_destroy(&g_bar);

		msleep_(2600);		/* let T1 expire, then close */
		close(g_fd);
		msleep_(2600);
	}
	return 0;
}
==================================================================

Crash log:
==================================================================
BUG: KASAN: slab-use-after-free in hlist_unhashed_lockless include/linux/list.h:1012 [inline]
BUG: KASAN: slab-use-after-free in timer_pending include/linux/timer.h:147 [inline]
BUG: KASAN: slab-use-after-free in __timer_delete+0x41/0x3e0 kernel/time/timer.c:1379
Read of size 8 at addr ffff8881076e7350 by task swapper/3/0

CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.2.0-dirty #3 PREEMPT 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x5e/0x80 lib/dump_stack.c:120
 print_address_description+0x77/0x200 mm/kasan/report.c:378
 print_report+0x64/0x70 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 hlist_unhashed_lockless include/linux/list.h:1012 [inline]
 timer_pending include/linux/timer.h:147 [inline]
 __timer_delete+0x41/0x3e0 kernel/time/timer.c:1379
 gsm_dlci_close+0x3d3/0x520 drivers/tty/n_gsm.c:2149
 call_timer_fn+0x32/0xc0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x573/0x790 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0x31/0x60 kernel/time/timer.c:2405
 handle_softirqs+0x173/0x540 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x91/0x1c0 kernel/softirq.c:735
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x74/0x80 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:pv_native_safe_halt+0x16/0x20 arch/x86/kernel/paravirt.c:64
Code: 0f 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 83 3d 25 91 b2 03 00 7e 07 0f 00 2d 70 1d 29 00 fb f4 <c3> cc cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffff888100a27eb8 EFLAGS: 00000246
RAX: ffff88817d8d9000 RBX: ffff888100a01140 RCX: ffffffff999f541a
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 000000000000b0fc
RBP: 0000000000000000 R08: ffff88811adbbd93 R09: 1ffff110235b77b2
R10: dffffc0000000000 R11: ffffed10235b77b3 R12: 0000000000000000
R13: 0000000000000000 R14: 1ffff11020140228 R15: dffffc0000000000
 arch_safe_halt arch/x86/kernel/process.c:767 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:768
 default_idle_call+0x3a/0x70 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x15a/0x490 kernel/sched/idle.c:355
 cpu_startup_entry+0x49/0x70 kernel/sched/idle.c:454
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x150
 </TASK>

Allocated by task 398:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x1d7/0x420 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 gsm_alloc_mux drivers/tty/n_gsm.c:3283 [inline]
 gsmld_open+0xaf/0xa50 drivers/tty/n_gsm.c:3700
 tty_ldisc_open+0x83/0xc0 drivers/tty/tty_ldisc.c:432
 tty_set_ldisc+0x2f8/0x4b0 drivers/tty/tty_ldisc.c:563
 tty_ioctl+0x822/0xa40 drivers/tty/tty_io.c:2728
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 398:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x3a/0x60 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x16c/0x3e0 mm/slub.c:6692
 gsm_free_mux drivers/tty/n_gsm.c:3231 [inline]
 gsm_free_muxr drivers/tty/n_gsm.c:3243 [inline]
 kref_put include/linux/kref.h:65 [inline]
 mux_put+0x10d/0x130 drivers/tty/n_gsm.c:3260
 tty_ldisc_close drivers/tty/tty_ldisc.c:455 [inline]
 tty_ldisc_kill+0xd2/0x190 drivers/tty/tty_ldisc.c:613
 tty_ldisc_release+0x106/0x150 drivers/tty/tty_ldisc.c:781
 tty_release_struct+0x26/0xc0 drivers/tty/tty_io.c:1681
 tty_release+0x946/0xf60 drivers/tty/tty_io.c:1852
 __fput+0x2d7/0x730 fs/file_table.c:512
 fput_close_sync+0x96/0x110 fs/file_table.c:617
 __do_sys_close fs/open.c:1511 [inline]
 __se_sys_close fs/open.c:1496 [inline]
 __x64_sys_close+0x80/0xc0 fs/open.c:1496
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0x99/0xb0 mm/kasan/generic.c:556
 insert_work+0x2d/0x1c0 kernel/workqueue.c:2226
 __queue_work+0x8e1/0xa20 kernel/workqueue.c:2401
 queue_work_on+0x9d/0xd0 kernel/workqueue.c:2452
 gsm_command drivers/tty/n_gsm.c:905 [inline]
 gsm_dlci_begin_close drivers/tty/n_gsm.c:2390 [inline]
 gsm_dlci_t1+0x690/0xc30 drivers/tty/n_gsm.c:2263
 call_timer_fn+0x32/0xc0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x573/0x790 kernel/time/timer.c:2386
 tmigr_handle_remote_cpu kernel/time/timer_migration.c:985 [inline]
 tmigr_handle_remote_up kernel/time/timer_migration.c:1076 [inline]
 __walk_groups_from kernel/time/timer_migration.c:564 [inline]
 __walk_groups kernel/time/timer_migration.c:581 [inline]
 tmigr_handle_remote+0x5ed/0xb50 kernel/time/timer_migration.c:1135
 handle_softirqs+0x173/0x540 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x91/0x1c0 kernel/softirq.c:735
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x74/0x80 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0x99/0xb0 mm/kasan/generic.c:556
 insert_work+0x2d/0x1c0 kernel/workqueue.c:2226
 __queue_work+0x8e1/0xa20 kernel/workqueue.c:2401
 queue_work_on+0x9d/0xd0 kernel/workqueue.c:2452
 gsm_command drivers/tty/n_gsm.c:905 [inline]
 gsm_dlci_begin_open+0x293/0x560 drivers/tty/n_gsm.c:2318
 gsmld_ioctl+0xc2b/0x1120 drivers/tty/n_gsm.c:-1
 tty_ioctl+0x901/0xa40 drivers/tty/tty_io.c:2801
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xb6/0x100 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf7/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff8881076e7000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 848 bytes inside of
 freed 1024-byte region [ffff8881076e7000, ffff8881076e7400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1076e0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100042dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100042dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881076e7200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881076e7280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881076e7300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff8881076e7380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881076e7400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


