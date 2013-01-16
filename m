From: kbuild test robot <fengguang.wu@intel.com>
Subject: [tty:tty-next 27/36] drivers/staging/sb105x/sb_pci_mp.c:2118:4:
 warning: passing argument 1 of 'tty_insert_flip_char' from incompatible
 pointer type
Date: Wed, 16 Jan 2013 14:56:19 +0800
Message-ID: <50f64f13.srdqRS36NV5bHEtJ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4308 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755Ab3APG7l (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 01:59:41 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   4e18585d51434c28269e625e56a06396d70d0ff2
commit: 92a19f9cec9a80ad93c06e115822deb729e2c6ad [27/36] TTY: switch tty_insert_flip_char
config: make ARCH=x86_64 allmodconfig

All warnings:

   drivers/staging/sb105x/sb_pci_mp.c: In function 'receive_chars':
>> drivers/staging/sb105x/sb_pci_mp.c:2118:4: warning: passing argument 1 of 'tty_insert_flip_char' from incompatible pointer type [enabled by default]
   In file included from drivers/staging/sb105x/sb_pci_mp.h:4:0,
                    from drivers/staging/sb105x/sb_pci_mp.c:1:
   include/linux/tty_flip.h:15:19: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'
   drivers/staging/sb105x/sb_pci_mp.c:2123:4: warning: passing argument 1 of 'tty_insert_flip_char' from incompatible pointer type [enabled by default]
   In file included from drivers/staging/sb105x/sb_pci_mp.h:4:0,
                    from drivers/staging/sb105x/sb_pci_mp.c:1:
   include/linux/tty_flip.h:15:19: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'

vim +/tty_insert_flip_char +2118 drivers/staging/sb105x/sb_pci_mp.c

  2102				} 
  2103				if (lsr & UART_LSR_PE)
  2104				{
  2105					mtpt->port.icount.parity++;
  2106					flag = TTY_PARITY;
  2107				}
  2108				if (lsr & UART_LSR_FE)
  2109				{
  2110					mtpt->port.icount.frame++;
  2111					flag = TTY_FRAME;
  2112				}
  2113				if (lsr & UART_LSR_OE)
  2114				{
  2115					mtpt->port.icount.overrun++;
  2116					flag = TTY_OVERRUN;
  2117				}
> 2118				tty_insert_flip_char(tty, ch, flag);
  2119			}
  2120			else
  2121			{
  2122				ch = serial_inp(mtpt, UART_RX);
  2123				tty_insert_flip_char(tty, ch, 0);
  2124			}
  2125	ignore_char:
  2126			lsr = serial_inp(mtpt, UART_LSR);

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
