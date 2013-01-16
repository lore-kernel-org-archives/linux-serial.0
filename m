From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [tty:tty-next 30/41] drivers/staging/sb105x/sb_pci_mp.c:2129:2:
 warning: passing argument 1 of 'tty_flip_buffer_push' from incompatible
 pointer type
Date: Wed, 16 Jan 2013 23:30:10 +0800
Message-ID: <20130116153010.GA5946@localhost>
References: <50f65045.xf8AiUb4vjF7e0Fu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21605 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab3APPaZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 10:30:25 -0500
Content-Disposition: inline
In-Reply-To: <50f65045.xf8AiUb4vjF7e0Fu%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org


Hi Jiri,

FYI, there are new compile warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   496c907740ff083499f5449d2907af442e79ceb0
commit: 2e124b4a390ca85325fae75764bef92f0547fa25 [30/41] TTY: switch tty_flip_buffer_push
config: make ARCH=x86_64 allmodconfig

All warnings:

   drivers/staging/sb105x/sb_pci_mp.c: In function 'mp_set_info':
   drivers/staging/sb105x/sb_pci_mp.c:901:19: error: 'struct tty_struct' has no member named 'low_latency'
   drivers/staging/sb105x/sb_pci_mp.c: In function 'mp_open':
   drivers/staging/sb105x/sb_pci_mp.c:1574:5: error: 'struct tty_struct' has no member named 'low_latency'
   drivers/staging/sb105x/sb_pci_mp.c: In function 'receive_chars':
   drivers/staging/sb105x/sb_pci_mp.c:2118:4: warning: passing argument 1 of 'tty_insert_flip_char' from incompatible pointer type [enabled by default]
   In file included from drivers/staging/sb105x/sb_pci_mp.h:4:0,
                    from drivers/staging/sb105x/sb_pci_mp.c:1:
   include/linux/tty_flip.h:16:19: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'
   drivers/staging/sb105x/sb_pci_mp.c:2123:4: warning: passing argument 1 of 'tty_insert_flip_char' from incompatible pointer type [enabled by default]
   In file included from drivers/staging/sb105x/sb_pci_mp.h:4:0,
                    from drivers/staging/sb105x/sb_pci_mp.c:1:
   include/linux/tty_flip.h:16:19: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'
>> drivers/staging/sb105x/sb_pci_mp.c:2129:2: warning: passing argument 1 of 'tty_flip_buffer_push' from incompatible pointer type [enabled by default]
   In file included from drivers/staging/sb105x/sb_pci_mp.h:4:0,
                    from drivers/staging/sb105x/sb_pci_mp.c:1:
   include/linux/tty_flip.h:13:13: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'

vim +/tty_flip_buffer_push +2129 drivers/staging/sb105x/sb_pci_mp.c

68a81291 Steven Rostedt 2012-11-16  2113  			if (lsr & UART_LSR_OE)
68a81291 Steven Rostedt 2012-11-16  2114  			{
68a81291 Steven Rostedt 2012-11-16  2115  				mtpt->port.icount.overrun++;
68a81291 Steven Rostedt 2012-11-16  2116  				flag = TTY_OVERRUN;
68a81291 Steven Rostedt 2012-11-16  2117  			}
68a81291 Steven Rostedt 2012-11-16  2118  			tty_insert_flip_char(tty, ch, flag);
68a81291 Steven Rostedt 2012-11-16  2119  		}
68a81291 Steven Rostedt 2012-11-16  2120  		else
68a81291 Steven Rostedt 2012-11-16  2121  		{
68a81291 Steven Rostedt 2012-11-16  2122  			ch = serial_inp(mtpt, UART_RX);
68a81291 Steven Rostedt 2012-11-16  2123  			tty_insert_flip_char(tty, ch, 0);
68a81291 Steven Rostedt 2012-11-16  2124  		}
68a81291 Steven Rostedt 2012-11-16  2125  ignore_char:
68a81291 Steven Rostedt 2012-11-16  2126  		lsr = serial_inp(mtpt, UART_LSR);
68a81291 Steven Rostedt 2012-11-16  2127  	} while ((lsr & UART_LSR_DR) && (max_count-- > 0));
68a81291 Steven Rostedt 2012-11-16  2128  
68a81291 Steven Rostedt 2012-11-16 @2129  	tty_flip_buffer_push(tty);
68a81291 Steven Rostedt 2012-11-16  2130  }
68a81291 Steven Rostedt 2012-11-16  2131  
68a81291 Steven Rostedt 2012-11-16  2132  
68a81291 Steven Rostedt 2012-11-16  2133  
68a81291 Steven Rostedt 2012-11-16  2134  
68a81291 Steven Rostedt 2012-11-16  2135  static _INLINE_ void transmit_chars(struct mp_port *mtpt)
68a81291 Steven Rostedt 2012-11-16  2136  {
68a81291 Steven Rostedt 2012-11-16  2137  	struct circ_buf *xmit = &mtpt->port.info->xmit;



---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
