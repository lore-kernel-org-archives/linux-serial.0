From: kbuild test robot <fengguang.wu@intel.com>
Subject: [tty:tty-next 29/36] drivers/staging/sb105x/sb_pci_mp.c:901:19:
 error: 'struct tty_struct' has no member named 'low_latency'
Date: Wed, 16 Jan 2013 14:58:09 +0800
Message-ID: <50f64f81.e/fa1mpz23Din6Vr%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45256 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab3APHBt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 02:01:49 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   4e18585d51434c28269e625e56a06396d70d0ff2
commit: d6c53c0e9bd0a83f9f9ddbc9fd80141a54d83896 [29/36] TTY: move low_latency to tty_port
config: make ARCH=x86_64 allmodconfig

All error/warnings:

   drivers/staging/sb105x/sb_pci_mp.c: In function 'mp_set_info':
>> drivers/staging/sb105x/sb_pci_mp.c:901:19: error: 'struct tty_struct' has no member named 'low_latency'
   drivers/staging/sb105x/sb_pci_mp.c: In function 'mp_open':
   drivers/staging/sb105x/sb_pci_mp.c:1574:5: error: 'struct tty_struct' has no member named 'low_latency'
   drivers/staging/sb105x/sb_pci_mp.c: In function 'receive_chars':
   drivers/staging/sb105x/sb_pci_mp.c:2118:4: warning: passing argument 1 of 'tty_insert_flip_char' from incompatible pointer type [enabled by default]
   In file included from drivers/staging/sb105x/sb_pci_mp.h:4:0,
                    from drivers/staging/sb105x/sb_pci_mp.c:1:
   include/linux/tty_flip.h:15:19: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'
   drivers/staging/sb105x/sb_pci_mp.c:2123:4: warning: passing argument 1 of 'tty_insert_flip_char' from incompatible pointer type [enabled by default]
   In file included from drivers/staging/sb105x/sb_pci_mp.h:4:0,
                    from drivers/staging/sb105x/sb_pci_mp.c:1:
   include/linux/tty_flip.h:15:19: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'

vim +901 drivers/staging/sb105x/sb_pci_mp.c

   895			(new_flags & UPF_CHANGE_MASK);
   896		port->custom_divisor   = new_serial.custom_divisor;
   897		state->close_delay     = new_serial.close_delay;
   898		state->closing_wait    = closing_wait;
   899		port->fifosize         = new_serial.xmit_fifo_size;
   900		if (state->info->tty)
 > 901			state->info->tty->low_latency =
   902				(port->flags & UPF_LOW_LATENCY) ? 1 : 0;
   903	
   904	check_and_exit:

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
