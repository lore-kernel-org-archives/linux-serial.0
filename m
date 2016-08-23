From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 1/3] ACPI / APD: Provide build-in properties of the UART
Date: Tue, 23 Aug 2016 09:37:08 +0300
Message-ID: <20160823063708.GC9065@kuha.fi.intel.com>
References: <1471875855-110782-2-git-send-email-heikki.krogerus@linux.intel.com>
 <201608222208.evSAciq7%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201608222208.evSAciq7%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Ken Xue <Ken.Xue@amd.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On Mon, Aug 22, 2016 at 11:00:49PM +0800, kbuild test robot wrote:
> Hi Heikki,
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.8-rc3 next-20160822]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/Heikki-Krogerus/ACPI-APD-Provide-build-in-properties-of-the-UART/20160822-222543
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: x86_64-randconfig-x016-201634 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/acpi/acpi_apd.c: In function 'acpi_apd_setup':
> >> drivers/acpi/acpi_apd.c:71:11: error: 'struct apd_private_data' has no member named 'properties'
>      if (pdata->properties)
>               ^~
>    drivers/acpi/acpi_apd.c:73:16: error: 'struct apd_private_data' has no member named 'properties'
>               pdata->properties);
>                    ^~
> 
> vim +71 drivers/acpi/acpi_apd.c
> 
>     65						dev_name(&pdata->adev->dev),
>     66						NULL, 0, dev_desc->fixed_clk_rate);
>     67			clk_register_clkdev(clk, NULL, dev_name(&pdata->adev->dev));
>     68			pdata->clk = clk;
>     69		}
>     70	
>   > 71		if (pdata->properties)

Thanks, I'll fix it. I did not get compiler error from this? Weird.


Br,

-- 
heikki
