From: kbuild test robot <lkp@intel.com>
Subject: Re: [RESEND PATCH v11 5/6] spi: at91-usart: add driver for
 at91-usart as spi
Date: Sun, 2 Sep 2018 05:23:40 +0800
Message-ID: <201809020500.AUGWBTuR%fengguang.wu@intel.com>
References: <20180831134141.9335-6-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831134141.9335-6-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, richard.genoud@gmail.com, pirea.radu@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, jslaby@suse.com, broonie@kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>
List-Id: linux-serial@vger.kernel.org

Hi Radu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[also build test WARNING on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Radu-Pirea/Driver-for-at91-usart-in-spi-mode/20180901-165150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/spi/spi-at91-usart.c:218:5: sparse: symbol 'at91_usart_spi_transfer_one' was not declared. Should it be static?
>> drivers/spi/spi-at91-usart.c:245:5: sparse: symbol 'at91_usart_spi_prepare_message' was not declared. Should it be static?
>> drivers/spi/spi-at91-usart.c:259:5: sparse: symbol 'at91_usart_spi_unprepare_message' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
