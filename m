From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: linux-3.7.10: possible circular locking dependency detected: tty_lock_nested
 vs. process_one_work
Date: Wed, 13 Mar 2013 23:42:06 +0100
Message-ID: <514100BE.6030601@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:36795 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932547Ab3CMWmK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Mar 2013 18:42:10 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Greg KH <gregkh@linuxfoundation.org>

Hi,
  I was running my laptop on batteries with pppd using /dev/ttyUSB0 with a 3G usb modem
using the slow option serial driver but with pppd's 'debug nodetach'. pppd did not
therefore detach from my shell but I did not care. ;-) While shutting down the whole
system pppd exited but then ...a possible locking issue was reported. Much later
pppd finally exited. Is the locking issue a false alarm or not?


Mar 13 21:43:09 vostro pppd[5140]: Terminating on signal 15
Mar 13 21:43:09 vostro pppd[5140]: Connect time 62.2 minutes.
Mar 13 21:43:09 vostro pppd[5140]: Sent 1712571 bytes, received 10967737 bytes.
Mar 13 21:43:09 vostro pppd[5140]: Script /etc/ppp/ip-down started (pid 6432)
Mar 13 21:43:09 vostro pppd[5140]: sent [LCP TermReq id=0x2 "User request"]
Mar 13 21:43:09 vostro pppd[5140]: rcvd [LCP TermAck id=0x2]
Mar 13 21:43:09 vostro pppd[5140]: Connection terminated.
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: ======================================================
Mar 13 21:43:09 vostro kernel: [ INFO: possible circular locking dependency detected ]
Mar 13 21:43:09 vostro kernel: 3.7.10-default #2 Not tainted
Mar 13 21:43:09 vostro kernel: -------------------------------------------------------
Mar 13 21:43:09 vostro kernel: kworker/0:2/1662 is trying to acquire lock:
Mar 13 21:43:09 vostro kernel: (&tty->legacy_mutex){+.+.+.}, at: [<ffffffff815e4a82>] tty_lock_nested+0x69/0x6e
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: but task is already holding lock:
Mar 13 21:43:09 vostro kernel: ((&tty->hangup_work)){+.+...}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: which lock already depends on the new lock.
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: the existing dependency chain (in reverse order) is:
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: -> #2 ((&tty->hangup_work)){+.+...}:
Mar 13 21:43:09 vostro kernel: [<ffffffff810b4536>] lock_acquire+0x7e/0x94
Mar 13 21:43:09 vostro kernel: [<ffffffff8108b10c>] flush_work+0x47/0x227
Mar 13 21:43:09 vostro kernel: [<ffffffff812e8b01>] tty_ldisc_flush_works+0x16/0x33
Mar 13 21:43:09 vostro kernel: [<ffffffff812e9622>] tty_ldisc_release+0x22/0x5c
Mar 13 21:43:09 vostro kernel: [<ffffffff812e3806>] tty_release+0x44f/0x4cd
Mar 13 21:43:09 vostro kernel: [<ffffffff8111998c>] __fput+0xe8/0x1c4
Mar 13 21:43:09 vostro kernel: [<ffffffff81119a71>] ____fput+0x9/0xb
Mar 13 21:43:09 vostro kernel: [<ffffffff8108d852>] task_work_run+0x7e/0x94
Mar 13 21:43:09 vostro kernel: [<ffffffff8100285b>] do_notify_resume+0x55/0x5c
Mar 13 21:43:09 vostro kernel: [<ffffffff815e57e2>] int_signal+0x12/0x17
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: -> #1 (&tty->legacy_mutex/1){+.+...}:
Mar 13 21:43:09 vostro kernel: [<ffffffff810b4536>] lock_acquire+0x7e/0x94
Mar 13 21:43:09 vostro kernel: [<ffffffff815e2a00>] __mutex_lock_common+0x48/0x350
Mar 13 21:43:09 vostro kernel: [<ffffffff815e2d67>] mutex_lock_nested+0x16/0x18
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4a82>] tty_lock_nested+0x69/0x6e
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4ad4>] tty_lock_pair+0x40/0x45
Mar 13 21:43:09 vostro kernel: [<ffffffff812e3581>] tty_release+0x1ca/0x4cd
Mar 13 21:43:09 vostro kernel: [<ffffffff8111998c>] __fput+0xe8/0x1c4
Mar 13 21:43:09 vostro kernel: [<ffffffff81119a71>] ____fput+0x9/0xb
Mar 13 21:43:09 vostro kernel: [<ffffffff8108d852>] task_work_run+0x7e/0x94
Mar 13 21:43:09 vostro kernel: [<ffffffff8100285b>] do_notify_resume+0x55/0x5c
Mar 13 21:43:09 vostro kernel: [<ffffffff815e57e2>] int_signal+0x12/0x17
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: -> #0 (&tty->legacy_mutex){+.+.+.}:
Mar 13 21:43:09 vostro kernel: [<ffffffff810b3e86>] __lock_acquire+0xaf1/0xdce
Mar 13 21:43:09 vostro kernel: [<ffffffff810b4536>] lock_acquire+0x7e/0x94
Mar 13 21:43:09 vostro kernel: [<ffffffff815e2a00>] __mutex_lock_common+0x48/0x350
Mar 13 21:43:09 vostro kernel: [<ffffffff815e2d67>] mutex_lock_nested+0x16/0x18
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4a82>] tty_lock_nested+0x69/0x6e
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4a92>] tty_lock+0xb/0xd
Mar 13 21:43:09 vostro kernel: [<ffffffff812e24ad>] __tty_hangup+0x65/0x341
Mar 13 21:43:09 vostro kernel: [<ffffffff812e2799>] do_tty_hangup+0x10/0x12
Mar 13 21:43:09 vostro kernel: [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
Mar 13 21:43:09 vostro kernel: [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
Mar 13 21:43:09 vostro kernel: [<ffffffff8108ff0a>] kthread+0xac/0xb4
Mar 13 21:43:09 vostro kernel: [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: other info that might help us debug this:
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: Chain exists of:
Mar 13 21:43:09 vostro kernel: &tty->legacy_mutex --> &tty->legacy_mutex/1 --> (&tty->hangup_work)
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: Possible unsafe locking scenario:
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: CPU0                    CPU1
Mar 13 21:43:09 vostro kernel: ----                    ----
Mar 13 21:43:09 vostro kernel: lock((&tty->hangup_work));
Mar 13 21:43:09 vostro kernel: lock(&tty->legacy_mutex/1);
Mar 13 21:43:09 vostro kernel: lock((&tty->hangup_work));
Mar 13 21:43:09 vostro kernel: lock(&tty->legacy_mutex);
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: *** DEADLOCK ***
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: 2 locks held by kworker/0:2/1662:
Mar 13 21:43:09 vostro kernel: #0:  (events){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
Mar 13 21:43:09 vostro kernel: #1:  ((&tty->hangup_work)){+.+...}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
Mar 13 21:43:09 vostro kernel: 
Mar 13 21:43:09 vostro kernel: stack backtrace:
Mar 13 21:43:09 vostro kernel: Pid: 1662, comm: kworker/0:2 Not tainted 3.7.10-default #2
Mar 13 21:43:09 vostro kernel: Call Trace:
Mar 13 21:43:09 vostro kernel: [<ffffffff815dc588>] print_circular_bug+0x1f8/0x209
Mar 13 21:43:09 vostro kernel: [<ffffffff810b3e86>] __lock_acquire+0xaf1/0xdce
Mar 13 21:43:09 vostro kernel: [<ffffffff810b4536>] lock_acquire+0x7e/0x94
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4a82>] ? tty_lock_nested+0x69/0x6e
Mar 13 21:43:09 vostro kernel: [<ffffffff815e2a00>] __mutex_lock_common+0x48/0x350
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4a82>] ? tty_lock_nested+0x69/0x6e
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4a82>] ? tty_lock_nested+0x69/0x6e
Mar 13 21:43:09 vostro kernel: [<ffffffff812e2471>] ? __tty_hangup+0x29/0x341
Mar 13 21:43:09 vostro kernel: [<ffffffff815e2d67>] mutex_lock_nested+0x16/0x18
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4a82>] tty_lock_nested+0x69/0x6e
Mar 13 21:43:09 vostro kernel: [<ffffffff815e4a92>] tty_lock+0xb/0xd
Mar 13 21:43:09 vostro kernel: [<ffffffff812e24ad>] __tty_hangup+0x65/0x341
Mar 13 21:43:09 vostro kernel: [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
Mar 13 21:43:09 vostro kernel: [<ffffffff810b4944>] ? trace_hardirqs_on_caller+0x121/0x158
Mar 13 21:43:09 vostro kernel: [<ffffffff812e2799>] do_tty_hangup+0x10/0x12
Mar 13 21:43:09 vostro kernel: [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
Mar 13 21:43:09 vostro kernel: [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
Mar 13 21:43:09 vostro kernel: [<ffffffff812e2789>] ? __tty_hangup+0x341/0x341
Mar 13 21:43:09 vostro kernel: [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
Mar 13 21:43:09 vostro kernel: [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
Mar 13 21:43:09 vostro kernel: [<ffffffff8108ff0a>] kthread+0xac/0xb4
Mar 13 21:43:09 vostro kernel: [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
Mar 13 21:43:09 vostro pppd[5140]: Waiting for 1 child processes...
Mar 13 21:43:09 vostro pppd[5140]:   script /etc/ppp/ip-down, pid 6432
Mar 13 21:43:09 vostro pppd[5140]: Hangup (SIGHUP)
Mar 13 21:43:09 vostro pppd[5140]: sending SIGTERM to process 6432
Mar 13 21:43:09 vostro pppd[5140]: Exit.
Mar 13 21:43:09 vostro kernel: [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
Mar 13 21:43:09 vostro kernel: [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
Mar 13 21:43:09 vostro polkitd[4120]: Lost the name org.freedesktop.PolicyKit1 - exiting
Mar 13 21:43:09 vostro acpid: exiting
Mar 13 21:43:09 vostro syslog-ng[3916]: syslog-ng shutting down; version='3.3.5'
Mar 13 21:43:09 vostro kernel: hub 1-1:1.0: hub_suspend
Mar 13 21:43:09 vostro kernel: usb 1-1: unlink qh256-0001/ffff88040ac24980 start 1 [1/0 us]
Mar 13 21:43:09 vostro kernel: usb 1-1: usb auto-suspend, wakeup 1


Thanks,
Martin
