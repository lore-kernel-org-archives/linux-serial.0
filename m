From: kbuild test robot <lkp@intel.com>
Subject: [tty:tty-testing 42/52] drivers/tty/serial/8250/8250_pci.c:1330:1:
 sparse: sparse: symbol 'pericom_do_set_divisor' was not declared. Should it
 be static?
Date: Tue, 18 Jun 2019 19:23:49 +0800
Message-ID: <201906181948.HzE13NAX%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jay Dolan <jay.dolan@accesio.com>
Cc: kbuild-all@01.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   13b18d35909707571af9539f7731389fbf0feb31
commit: 6bf4e42f1d19de10800f4483b4bb7945aab283cb [42/52] serial: 8250: Add support for higher baud rates to Pericom chips
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 6bf4e42f1d19de10800f4483b4bb7945aab283cb
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/8250/8250_pci.c:1330:1: sparse: sparse: symbol 'pericom_do_set_divisor' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
