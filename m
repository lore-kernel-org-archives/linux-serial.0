From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Mon, 25 Mar 2019 16:42:39 +0800
Message-ID: <201903251609.fCox8jWl%lkp@intel.com>
References: <20190324164139.23899-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190324164139.23899-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, pakki001@umn.edu, kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Aditya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v5.1-rc2 next-20190325]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aditya-Pakki/tty-8250-fix-a-missing-check-for-pci_ioremap_bar/20190325-151723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/8250/8250_lpss.c:207:26: sparse: incorrect type in argument 1 (different base types) @@    expected struct pci_dev *dev @@    got truct pci_dev *dev @@
   drivers/tty/serial/8250/8250_lpss.c:207:26:    expected struct pci_dev *dev
   drivers/tty/serial/8250/8250_lpss.c:207:26:    got struct device *dma_dev
>> drivers/tty/serial/8250/8250_lpss.c:207:52: sparse: cannot dereference this type
>> drivers/tty/serial/8250/8250_lpss.c:207:20: sparse: call with no type!

vim +207 drivers/tty/serial/8250/8250_lpss.c

   197	
   198	static void qrk_serial_exit_dma(struct lpss8250 *lpss)
   199	{
   200		struct dw_dma_slave *param = &lpss->dma_param;
   201	
   202		if (!param->dma_dev)
   203			return;
   204	
   205		dw_dma_remove(&lpss->dma_chip);
   206	
 > 207		pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);
   208	}
   209	#else	/* CONFIG_SERIAL_8250_DMA */
   210	static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
   211	static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
   212	#endif	/* !CONFIG_SERIAL_8250_DMA */
   213	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
