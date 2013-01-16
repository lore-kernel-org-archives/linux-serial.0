From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [tty:tty-next 53/55] drivers/tty/serial/8250/8250_dma.c:55:2:
 warning: passing argument 1 of 'tty_insert_flip_string' from incompatible
 pointer type
Date: Wed, 16 Jan 2013 14:00:31 +0200
Message-ID: <20130116120031.GA6814@xps8300>
References: <50f65584.FqCm5ry12q5pGYVU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43067 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128Ab3APMAg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 07:00:36 -0500
Content-Disposition: inline
In-Reply-To: <50f65584.FqCm5ry12q5pGYVU%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, Jan 16, 2013 at 03:23:48PM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> head:   852e4a8152b427c3f318bb0e1b5e938d64dcdc32
> commit: 9ee4b83e51f741a645c43e61b9f3f8075ca0fdf4 [53/55] serial: 8250: Add support for dmaengine
> config: x86_64-randconfig-s640 (attached as .config)
> 
> All warnings:
> 
>    drivers/tty/serial/8250/8250_dma.c: In function '__dma_rx_complete':
> >> drivers/tty/serial/8250/8250_dma.c:55:2: warning: passing argument 1 of 'tty_insert_flip_string' from incompatible pointer type [enabled by default]
>    In file included from drivers/tty/serial/8250/8250_dma.c:12:0:
>    include/linux/tty_flip.h:28:19: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'
> >> drivers/tty/serial/8250/8250_dma.c:58:2: warning: passing argument 1 of 'tty_flip_buffer_push' from incompatible pointer type [enabled by default]
>    In file included from drivers/tty/serial/8250/8250_dma.c:12:0:
>    include/linux/tty_flip.h:13:13: note: expected 'struct tty_port *' but argument is of type 'struct tty_struct *'

Looks like the tty buffer functions have been changed. I'll fix this
right away. 

Thanks,

-- 
heikki
