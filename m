Return-Path: <SRS0=9wZM=BE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669F2C433E1
	for <linux-serial@archiver.kernel.org>; Sat, 25 Jul 2020 21:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A874206D8
	for <linux-serial@archiver.kernel.org>; Sat, 25 Jul 2020 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H96tTE1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgGYVOU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Jul 2020 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgGYVOU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Jul 2020 17:14:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF8C08C5C0;
        Sat, 25 Jul 2020 14:14:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f9so1119760pju.4;
        Sat, 25 Jul 2020 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aLIZiWWNI44jorci6AX4IXNjooopKj5eCQllmxvjfeI=;
        b=H96tTE1pyBNdMZYF9XCb0EYpzaMWSzyLTkvN7aJePbOBIZuw4J979IjXD+bqi2mNo5
         nxDPoW8T0M7N4T3vQJi9LEDRwyARfQ8RzAjUiUZSUXSRw32nX87h5ZbYvaYQeltYR6Er
         XhHSpIlnFI8WOzNd931vKTiWot8prpNfEdd1gf10rUdH+q8HfveS+zVvxziB44I/39iH
         w6OmVWglaSJWMbFBWwh80JA/pV5SBtvMY5EXehdcQitdk2f+XForBlKcWu2yi6hMY1n5
         v3tVk/tmnBcbYMz/Ih9nXj+9pI4PqAAwdMOEM4DXnPPjgRrMzJp7ybdywCYMUA4eOBZz
         0zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aLIZiWWNI44jorci6AX4IXNjooopKj5eCQllmxvjfeI=;
        b=XYn0dERb90n7Wyt88pkO/oCz3enSNu0CmjuoyBAM6rshJqb1SNrwhCyzLwhU2yPgnL
         iIb9L//NaLe8xkZho7a29BI3icBhcyc92Qfjgq86c43lTgssPb1glApe2Kx7C1DVfjY5
         d9JmQrzqx88frzp/ndm6zTJ+xHWn01SXEHLrfyG+qri1jGRfv8v9iYeT0b6czhi8tPrN
         YT90BT1tKoQbVW2Goi/efr6RKBnuKD0MOlzA3MMHCXNWyDsSO+MKMTBsF/7tMpM+YXdQ
         1yQ25FwPrSoJ4tQGZ7/dZ+J4vy2TETQ84BODNtJoOp3qJrXDzUAhc2rLCW9c8Bj1SKSH
         gzUQ==
X-Gm-Message-State: AOAM533cBbQZOWGQ6Z/etnJzmrjzRP+Aa9uJfqgP8bc4Ldx5xmzX8IwR
        LUxoj0dOCearIGdK7cXGU5c=
X-Google-Smtp-Source: ABdhPJz32dafmz2l3WVKWq7N8Uk7iQ+w+LdGlgkndqWf2SODn8nSMVkrG7imBj8ITXF3+0M278opEw==
X-Received: by 2002:a17:90a:f6d8:: with SMTP id er24mr10876599pjb.203.1595711658929;
        Sat, 25 Jul 2020 14:14:18 -0700 (PDT)
Received: from localhost (g155.222-224-148.ppp.wakwak.ne.jp. [222.224.148.155])
        by smtp.gmail.com with ESMTPSA id a17sm9849255pgw.60.2020.07.25.14.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 14:14:18 -0700 (PDT)
Date:   Sun, 26 Jul 2020 06:14:16 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mateusz Holenko <mholenko@antmicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, kbuild-all@lists.01.org,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v9 3/5] drivers/soc/litex: add LiteX SoC Controller driver
Message-ID: <20200725211416.GB80756@lianli.shorne-pla.net>
References: <20200722122704.1153221-3-mholenko@antmicro.com>
 <202007251829.A4shNHeo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007251829.A4shNHeo%lkp@intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jul 25, 2020 at 06:29:51PM +0800, kernel test robot wrote:
> Hi Mateusz,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on tty/tty-testing usb/usb-testing staging/staging-testing driver-core/driver-core-testing linus/master v5.8-rc6 next-20200724]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Mateusz-Holenko/LiteX-SoC-controller-and-LiteUART-serial-driver/20200722-183024
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: openrisc-randconfig-s032-20200725 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-93-g4c6cbe55-dirty
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

Note, this is OpenRISC

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/soc/litex/litex_soc_ctrl.c:61:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
> >> drivers/soc/litex/litex_soc_ctrl.c:61:24: sparse:     expected unsigned int [usertype] value
> >> drivers/soc/litex/litex_soc_ctrl.c:61:24: sparse:     got restricted __le32 [usertype]
> >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
>    drivers/soc/litex/litex_soc_ctrl.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/io.h, include/linux/litex.h):

I think this is something I need to fix up in the openrisc io.h header.

It seems the sparse annotations are messed up.  Working on it...

-Stafford

>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
>    include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
>    include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
>    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> 
> vim +61 drivers/soc/litex/litex_soc_ctrl.c
> 
>     32	
>     33	/*
>     34	 * LiteX SoC Generator, depending on the configuration,
>     35	 * can split a single logical CSR (Control & Status Register)
>     36	 * into a series of consecutive physical registers.
>     37	 *
>     38	 * For example, in the configuration with 8-bit CSR Bus,
>     39	 * 32-bit aligned (the default one for 32-bit CPUs) a 32-bit
>     40	 * logical CSR will be generated as four 32-bit physical registers,
>     41	 * each one containing one byte of meaningful data.
>     42	 *
>     43	 * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
>     44	 *
>     45	 * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
>     46	 * the logic of writing to/reading from the LiteX CSR in a single
>     47	 * place that can be then reused by all LiteX drivers.
>     48	 */
>     49	void litex_set_reg(void __iomem *reg, unsigned long reg_size,
>     50			    unsigned long val)
>     51	{
>     52		unsigned long shifted_data, shift, i;
>     53		unsigned long flags;
>     54	
>     55		spin_lock_irqsave(&csr_lock, flags);
>     56	
>     57		for (i = 0; i < reg_size; ++i) {
>     58			shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
>     59			shifted_data = val >> shift;
>     60	
>   > 61			writel(cpu_to_le32(shifted_data), reg + (LITEX_REG_SIZE * i));
>     62		}
>     63	
>     64		spin_unlock_irqrestore(&csr_lock, flags);
>     65	}
>     66	EXPORT_SYMBOL_GPL(litex_set_reg);
>     67	
>     68	unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
>     69	{
>     70		unsigned long shifted_data, shift, i;
>     71		unsigned long result = 0;
>     72		unsigned long flags;
>     73	
>     74		spin_lock_irqsave(&csr_lock, flags);
>     75	
>     76		for (i = 0; i < reg_size; ++i) {
>   > 77			shifted_data = le32_to_cpu(readl(reg + (LITEX_REG_SIZE * i)));
>     78	
>     79			shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
>     80			result |= (shifted_data << shift);
>     81		}
>     82	
>     83		spin_unlock_irqrestore(&csr_lock, flags);
>     84	
>     85		return result;
>     86	}
>     87	EXPORT_SYMBOL_GPL(litex_get_reg);
>     88	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


