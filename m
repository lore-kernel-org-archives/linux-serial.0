From: Ville Tervo <ville.tervo@nokia.com>
Subject: tty: n_gsm: System lockup when closing n_gsm ldisc
Date: Tue, 24 Jan 2012 13:52:59 +0200
Message-ID: <4F1E9B9B.1090008@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:58461 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756261Ab2AXLxs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Jan 2012 06:53:48 -0500
Received: from [172.21.22.171] (helruo-dhcp022171.ntc.nokia.com [172.21.22.171])
	by mgw-sa02.nokia.com (Switch-3.4.4/Switch-3.4.4) with ESMTP id q0OBrkQK030278
	for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2012 13:53:46 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

n_gsm seems to lockup when I do following actions.

1) open n_gsm on tty
2) open /dev/ttygsm1 and keep it open
4) close n_gsm

Now I get following warning from lockdep. tty_vhangup() in n_gsm.c is 
trying to acquire BTM while tty_set_ldisc is already holding it.

Inserting tty_unlock()/tty_lock() pair around tty_vhangup "solves" the 
lockup problem, but still leaves lockdep warning for 
lock(&tty->ldisc_mutex) and lock(big_tty_mutex) in SMP case.

Any ideas how to fix this for real?

=============================================
[ INFO: possible recursive locking detected ]
3.3.0-rc1-2-generic+ #51 Not tainted
---------------------------------------------
n_gsm_test/891 is trying to acquire lock:
  (big_tty_mutex){+.+.+.}, at: [<c1497a74>] tty_lock+0x14/0x20

but task is already holding lock:
  (big_tty_mutex){+.+.+.}, at: [<c1497a74>] tty_lock+0x14/0x20

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(big_tty_mutex);
   lock(big_tty_mutex);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

2 locks held by n_gsm_test/891:
  #0:  (big_tty_mutex){+.+.+.}, at: [<c1497a74>] tty_lock+0x14/0x20
  #1:  (&tty->ldisc_mutex){+.+.+.}, at: [<c1279ea3>] 
tty_set_ldisc+0x173/0x2b0

stack backtrace:
Pid: 891, comm: n_gsm_test Not tainted 3.3.0-rc1-2-generic+ #51
Call Trace:
  [<c1488e16>] ? printk+0x1d/0x1f
  [<c10763ea>] print_deadlock_bug+0xda/0xe0
  [<c1077ab2>] validate_chain.isra.35+0x5d2/0x6b0
  [<c107977b>] __lock_acquire+0x34b/0x810
  [<c107b7d0>] lock_acquire+0x90/0x1c0
  [<c1497a74>] ? tty_lock+0x14/0x20
  [<c10607d5>] ? local_clock+0x65/0x70
  [<c149457d>] mutex_lock_nested+0x6d/0x340
  [<c1497a74>] ? tty_lock+0x14/0x20
  [<c127270d>] ? __tty_hangup+0x4d/0x3d0
  [<c1497a74>] ? tty_lock+0x14/0x20
  [<c1497a74>] tty_lock+0x14/0x20
  [<c1272712>] __tty_hangup+0x52/0x3d0
  [<c10784bb>] ? trace_hardirqs_on+0xb/0x10
  [<c1272abd>] tty_vhangup+0xd/0x10
  [<c127f514>] gsm_cleanup_mux+0xd4/0x1d0
  [<c104e200>] ? abort_exclusive_wait+0x80/0x80
  [<c127fbc2>] gsmld_close+0x42/0x80
  [<c1279905>] tty_ldisc_close.isra.5+0x35/0x50
  [<c1279ec6>] tty_set_ldisc+0x196/0x2b0
  [<c10da815>] ? might_fault+0x95/0xa0
  [<c1274d5a>] tty_ioctl+0x65a/0x7c0
  [<c112b032>] ? fsnotify+0x252/0x680
  [<c112ae56>] ? fsnotify+0x76/0x680
  [<c1279c9d>] ? tty_ldisc_deref+0xd/0x10
  [<c127203f>] ? tty_write+0x17f/0x230
  [<c1077e42>] ? check_flags+0x12/0x20
  [<c1274700>] ? no_tty+0x30/0x30
  [<c11029a9>] do_vfs_ioctl+0x79/0x300
  [<c1498415>] ? sysenter_exit+0xf/0x1a
  [<c1102c62>] sys_ioctl+0x32/0x60
  [<c14983dc>] sysenter_do_call+0x12/0x3c


-- 
Ville
