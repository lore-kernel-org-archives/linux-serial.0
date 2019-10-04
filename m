From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 3/4] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Fri, 4 Oct 2019 15:37:18 +0100
Message-ID: <20191004143718.GM18429@dell>
References: <20190923114636.6748-4-tbogendoerfer@suse.de>
 <201909232145.eyOJqt2k%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201909232145.eyOJqt2k%lkp@intel.com>
Sender: netdev-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>, kbuild-all@01.org, Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 23 Sep 2019, kbuild test robot wrote:

> Hi Thomas,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [cannot apply to v5.3 next-20190920]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Thomas-Bogendoerfer/Use-MFD-framework-for-SGI-IOC3-drivers/20190923-194903
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers//mfd/ioc3.c: In function 'ioc3_eth_setup':
> >> drivers//mfd/ioc3.c:281:54: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
>        sizeof(ioc3_w1_platform_data.dev_id), "ioc3-%012llx",
>                                                    ~~~~~~^
>                                                    %012x
>        ipd->pdev->resource->start);
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~                         

I assume you plan on fixing this Thomas?


-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
