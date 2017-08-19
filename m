From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 2/3] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
Date: Sat, 19 Aug 2017 14:27:37 +0200
Message-ID: <CAK8P3a3H5QUBn9LDqqrwuES6UUH438B4asWXQ-PDhgb-oaWFHA@mail.gmail.com>
References: <1502791207-26951-3-git-send-email-oleksandrs@mellanox.com> <201708190909.9GRNaEaj%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201708190909.9GRNaEaj%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Oleksandr Shamray <oleksandrs@mellanox.com>, kbuild-all@01.org, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, mec@shout.net, vadimp@maellanox.com, system-sw-low-level@mellanox.com, Rob Herring <robh+dt@kernel.org>, openocd-devel-owner@lists.sourceforge.net, Jiri Pirko <jiri@mellanox.com>, Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-Id: linux-serial@vger.kernel.org

On Sat, Aug 19, 2017 at 3:21 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Oleksandr,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.13-rc5 next-20170817]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Oleksandr-Shamray/drivers-jtag-Add-JTAG-core-driver/20170818-114739
> config: um-allyesconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=um
>
> All errors (new ones prefixed by >>):
>
>    drivers/auxdisplay/img-ascii-lcd.o: In function `img_ascii_lcd_probe':
>    drivers/auxdisplay/img-ascii-lcd.c:386: undefined reference to `devm_ioremap_resource'
>    drivers/jtag/jtag-aspeed.o: In function `aspeed_jtag_init':
>>> drivers/jtag/jtag-aspeed.c:635: undefined reference to `devm_ioremap_resource'
>    collect2: error: ld returned 1 exit status

So arch/um now provides an ioremap() stub despite the absence of
CONFIG_HAS_IOMEM, but the respective devm_* interface from
lib/devres.c is not available.

We can either work around this for new drivers as we used to do for
ioremap() by adding a correct 'depends on HAS_IOMEM' Kconfig
dependency, or we could find a way for arch/um to provide stubs
for the additional functions as well.

      Arnd
