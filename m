From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/2] tty: serial: add driver for the SiFive UART (fwd)
Date: Fri, 19 Oct 2018 19:27:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1810191926360.5513@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-serial@vger.kernel.org, kbuild-all@01.org, Paul Walmsley <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Wesley Terpstra <wesley@sifive.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-serial@vger.kernel.org

Hello,

It looks like an unlock is needed before the return on line 562.

julia

---------- Forwarded message ----------
Date: Fri, 19 Oct 2018 18:12:04 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/2] tty: serial: add driver for the SiFive UART

CC: kbuild-all@01.org
In-Reply-To: <20181018234352.26788-3-paul.walmsley@sifive.com>
References: <20181018234352.26788-3-paul.walmsley@sifive.com>
TO: Paul Walmsley <paul.walmsley@sifive.com>
CC: linux-serial@vger.kernel.org
CC: Paul Walmsley <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Wesley Terpstra <wesley@sifive.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Hi Paul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v4.19-rc8 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Walmsley/dt-bindings-serial-add-documentation-for-the-SiFive-UART-driver/20181019-165529
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
:::::: branch date: 77 minutes ago
:::::: commit date: 77 minutes ago

>> drivers/tty/serial/sifive.c:562:2-8: preceding lock on line 558

# https://github.com/0day-ci/linux/commit/15d0af7ab79ba53f984613f23e668cade495babb
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 15d0af7ab79ba53f984613f23e668cade495babb
vim +562 drivers/tty/serial/sifive.c

15d0af7a Paul Walmsley 2018-10-18  552
15d0af7a Paul Walmsley 2018-10-18  553  static irqreturn_t sifive_serial_irq(int irq, void *dev_id)
15d0af7a Paul Walmsley 2018-10-18  554  {
15d0af7a Paul Walmsley 2018-10-18  555  	struct sifive_serial_port *ssp = dev_id;
15d0af7a Paul Walmsley 2018-10-18  556  	u32 ip;
15d0af7a Paul Walmsley 2018-10-18  557
15d0af7a Paul Walmsley 2018-10-18 @558  	spin_lock(&ssp->port.lock);
15d0af7a Paul Walmsley 2018-10-18  559
15d0af7a Paul Walmsley 2018-10-18  560  	ip = __ssp_readl(ssp, SIFIVE_SERIAL_IP_OFFS);
15d0af7a Paul Walmsley 2018-10-18  561  	if (!ip)
15d0af7a Paul Walmsley 2018-10-18 @562  		return IRQ_NONE;
15d0af7a Paul Walmsley 2018-10-18  563
15d0af7a Paul Walmsley 2018-10-18  564  	if (ip & SIFIVE_SERIAL_IP_RXWM_MASK)
15d0af7a Paul Walmsley 2018-10-18  565  		__ssp_receive_chars(ssp);
15d0af7a Paul Walmsley 2018-10-18  566  	if (ip & SIFIVE_SERIAL_IP_TXWM_MASK)
15d0af7a Paul Walmsley 2018-10-18  567  		__ssp_transmit_chars(ssp);
15d0af7a Paul Walmsley 2018-10-18  568
15d0af7a Paul Walmsley 2018-10-18  569  	spin_unlock(&ssp->port.lock);
15d0af7a Paul Walmsley 2018-10-18  570
15d0af7a Paul Walmsley 2018-10-18  571  	return IRQ_HANDLED;
15d0af7a Paul Walmsley 2018-10-18  572  }
15d0af7a Paul Walmsley 2018-10-18  573

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
