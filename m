From: kbuild test robot <fengguang.wu@intel.com>
Subject: [tty:tty-next 53/55] drivers/tty/serial/8250/8250_dma.c:55:32:
 sparse: incorrect type in argument 1 (different base types)
Date: Wed, 16 Jan 2013 15:50:48 +0800
Message-ID: <50f65bd8.pc78DQRJBXSRxgwH%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46597 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758223Ab3APHwI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 02:52:08 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   852e4a8152b427c3f318bb0e1b5e938d64dcdc32
commit: 9ee4b83e51f741a645c43e61b9f3f8075ca0fdf4 [53/55] serial: 8250: Add support for dmaengine


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/8250/8250_dma.c:55:32: sparse: incorrect type in argument 1 (different base types)
   drivers/tty/serial/8250/8250_dma.c:55:32:    expected struct tty_port *port
   drivers/tty/serial/8250/8250_dma.c:55:32:    got struct tty_struct *tty
   drivers/tty/serial/8250/8250_dma.c:58:30: sparse: incorrect type in argument 1 (different base types)
   drivers/tty/serial/8250/8250_dma.c:58:30:    expected struct tty_port *port
   drivers/tty/serial/8250/8250_dma.c:58:30:    got struct tty_struct *tty
   drivers/tty/serial/8250/8250_dma.c: In function '__dma_rx_complete':
   drivers/tty/serial/8250/8250_dma.c:55:2: warning: passing argument 1 of 'tty_insert_flip_string' from incompatible pointer type [enabled by default]
   In file included from drivers/tty/serial/8250/8250_dma.c:12:0:
   include/linux/tty_flip.h:28:19: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'
   drivers/tty/serial/8250/8250_dma.c:58:2: warning: passing argument 1 of 'tty_flip_buffer_push' from incompatible pointer type [enabled by default]
   In file included from drivers/tty/serial/8250/8250_dma.c:12:0:
   include/linux/tty_flip.h:13:13: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'

vim +55 drivers/tty/serial/8250/8250_dma.c

    39		}
    40	}
    41	
    42	static void __dma_rx_complete(void *param)
    43	{
    44		struct uart_8250_port	*p = param;
    45		struct uart_8250_dma	*dma = p->dma;
    46		struct tty_struct	*tty = p->port.state->port.tty;
    47		struct dma_tx_state	state;
    48	
    49		dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
    50					dma->rx_size, DMA_FROM_DEVICE);
    51	
    52		dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
    53		dmaengine_terminate_all(dma->rxchan);
    54	
  > 55		tty_insert_flip_string(tty, dma->rx_buf, dma->rx_size - state.residue);
    56		p->port.icount.rx += dma->rx_size - state.residue;
    57	
    58		tty_flip_buffer_push(tty);
    59	}
    60	
    61	int serial8250_tx_dma(struct uart_8250_port *p)
    62	{
    63		struct uart_8250_dma		*dma = p->dma;

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
