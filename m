From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH V2 3/4] 8250: 8250_f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO UART support
Date: Thu, 28 Jan 2016 19:06:39 +0800
Message-ID: <201601281904.MbBUDU3t%fengguang.wu@intel.com>
References: <1453972838-30268-4-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453972838-30268-4-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: kbuild-all@01.org, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

[auto build test WARNING on gpio/for-next]
[also build test WARNING on v4.5-rc1 next-20160128]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Hung/Transform-Fintek-PCIE-driver-from-8250-to-MFD/20160128-172929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/tty/serial/8250/8250_f81504.c:233:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
