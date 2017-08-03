From: kbuild test robot <lkp@intel.com>
Subject: Re: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
Date: Thu, 3 Aug 2017 22:35:44 +0800
Message-ID: <201708032250.cmVljGeY%fengguang.wu@intel.com>
References: <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch, linux-serial@vger.kernel.org, mec@shout.net, vadimp@maellanox.com, system-sw-low-level@mellanox.com, Oleksandr Shamray <oleksandrs@mellanox.com>, Jiri Pirko <jiri@mellanox.com>
List-Id: linux-serial@vger.kernel.org

Hi Oleksandr,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.13-rc3 next-20170803]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/JTAG-driver-introduction/20170803-110721


coccinelle warnings: (new ones prefixed by >>)

>> drivers/jtag/jtag-aspeed.c:724:37-40: ERROR: Missing resource_size with res

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
