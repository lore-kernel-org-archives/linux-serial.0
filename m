From: "Georg C. F. Greve" <greve@gnu.org>
Subject: kernel 2.6.0 and lirc_serial (Patch #4 20031231) IRQ problems
Date: Tue, 06 Jan 2004 14:26:21 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <m3ptdxqkci.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dsl-213-023-007-187.arcor-ip.net ([213.23.7.187]:24535 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S262128AbUAFN02 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Jan 2004 08:26:28 -0500
List-Id: linux-serial@vger.kernel.org
To: lirc-list@lists.sourceforge.net
Cc: dgp85@users.sourceforge.net, linux-serial@vger.kernel.org

Hi all,

I'm running 

 Linux kernel 2.6.0 

 Lirc Drivers for 2.6.0 Patch #4 20031231
 (http://flameeyes.web.ctonet.it/lirc/patch-lirc-20031231.diff.bz2)
 [necessary because the machine is running a SMP kernel for which
  its own lirc_serial causes a hard freeze/crash without the patch]

The receiver is a homebrew IR serial receiver (lirc_serial module).

It basically works fine until sometimes (no pattern reproduceable)
dmesg outputs:

 irq 4: nobody cared!
 Call Trace:
  [<c010c565>] __report_bad_irq+0x2b/0x8c
  [<c010c64e>] note_interrupt+0x69/0x99
  [<c010c970>] do_IRQ+0x16b/0x197
  [<c010ad2c>] common_interrupt+0x18/0x20
  [<c011e931>] __wake_up+0x45/0x6e
  [<c038d673>] sock_def_readable+0xa6/0xa8
  [<c03e9c66>] unix_stream_sendmsg+0x2bb/0x449
  [<c038a1ce>] sock_aio_write+0xbd/0xd6
  [<c0159147>] do_sync_write+0x89/0xb4
  [<c016b7dc>] kill_fasync+0x3d/0x67
  [<c015924a>] vfs_write+0xd8/0x10c
  [<c015931a>] sys_write+0x3f/0x5d
  [<c010a3bf>] syscall_call+0x7/0xb

 handlers:
 [<f89082d8>] (irq_handler+0x0/0x56d [lirc_serial])
 Disabling IRQ #4

and then the LIRC stops working until after reboot. Un-/Reloading the
lirc_serial module doesn't work/isn't possible.

I've now loaded the lirc_serial module with debug=1 option, if it
crashes again, I'll see whether it produces any useful output and let
you know.

Hope this helps,

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)
