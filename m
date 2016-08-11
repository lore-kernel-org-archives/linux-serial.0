From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v9 1/4] of/serial: move earlycon early_param handling to
 serial
Date: Fri, 12 Aug 2016 01:06:18 +0800
Message-ID: <201608120110.sf8xniKf%fengguang.wu@intel.com>
References: <20160811153152.755-2-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160811153152.755-2-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
Cc: kbuild-all@01.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Leif,

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.8-rc1 next-20160811]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aleksey-Makarov/ACPI-parse-the-SPCR-table/20160811-233625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: sh-allnoconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   In file included from arch/sh/kernel/cpu/sh2/probe.c:13:0:
   include/linux/of_fdt.h: In function 'early_init_dt_scan_chosen_stdout':
>> include/linux/of_fdt.h:98:68: error: 'ENODEV' undeclared (first use in this function)
    static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
                                                                       ^
   include/linux/of_fdt.h:98:68: note: each undeclared identifier is reported only once for each function it appears in

vim +/ENODEV +98 include/linux/of_fdt.h

    92	extern void unflatten_and_copy_device_tree(void);
    93	extern void early_init_devtree(void *);
    94	extern void early_get_first_memblock_info(void *, phys_addr_t *);
    95	extern u64 of_flat_dt_translate_address(unsigned long node);
    96	extern void of_fdt_limit_memory(int limit);
    97	#else /* CONFIG_OF_FLATTREE */
  > 98	static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
    99	static inline void early_init_fdt_scan_reserved_mem(void) {}
   100	static inline void early_init_fdt_reserve_self(void) {}
   101	static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--PNTmBPCT7hxwcZjr
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
FwjrGKP/B55k1PKESQAA

--PNTmBPCT7hxwcZjr--
