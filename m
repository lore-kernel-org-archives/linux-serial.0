Return-Path: <SRS0=PqTn=BF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD8EC433DF
	for <linux-serial@archiver.kernel.org>; Sun, 26 Jul 2020 23:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D30220738
	for <linux-serial@archiver.kernel.org>; Sun, 26 Jul 2020 23:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpQIkHpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgGZXgl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgGZXgk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Jul 2020 19:36:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC953C0619D2;
        Sun, 26 Jul 2020 16:36:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so7100139ple.0;
        Sun, 26 Jul 2020 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EZ/as6CqLbaXJo+vixNLU5exP2XVeWjOrfMNE1tqJak=;
        b=DpQIkHpaYQI5ZkZtmQIKRChquDLNbVL/xWr5pOKM+fXhnWZt4po1EMitgZkp3FJ93a
         /be4hzhNr1QyIsI0yiXXYKvXokWFO9MuRbibj/h/NVk174KzmhqmlzwlN0NI0m4L8p5t
         lONuhyJT47to4CN2GkyP1tczDG75JWG6UbcGfqwWs0Iz51UDzqBEUMOurXo+Y4VTk3Ro
         LXeiXRTIdZEGZWoSXkr7Whvkarj89eBFXudjgcOzoigiD/XjiznAtMyuMx7HVfxcc/8y
         oBDO+y9YLdE5rk5CoOMqIF/2nPyLCETlPManYE8QUsUsXkdyzd9WH/kw6Sr5eG1SuPs6
         yPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EZ/as6CqLbaXJo+vixNLU5exP2XVeWjOrfMNE1tqJak=;
        b=cp3qkwa3FVVXxBLRhlfAPgLX9dKlIab/VThrFDEHFemu4rbCCa85e42L+LLES3ywRw
         3fUC7ezw777cujCsSLtaXWuB3I3MtDPUpwNcf+SJpS5mlBBTxrXdCGCMI8D9riuEDvSv
         laOtNZHeLWiJH6mxSks0uUROWuBI6fLFL6pOV14ZTxtd+4AQ3sOzOFXbwwWvh4PK9kyf
         ezsAS6+uGrUQtwdJu+RCP8T8ZgVxsZ7j/WqfCNRMPSif76cK54ZeThRfSs6KPB+Qvx9x
         GaglbkGYaOZTE77cTLrgmIktpxTkZ4nKI6/rFLpL5Hw58Ad6NkBhw1HFVRZYpmDvXhKV
         Ojhg==
X-Gm-Message-State: AOAM533db3dhFsP2PWazAVGPm3ukjxMSnFImu2orzlhC4oT5ef/eVgRG
        KkC23Jd5lkYrrtjfiZmQCfY=
X-Google-Smtp-Source: ABdhPJy8Oc+JbduYiNYK8/H5XuwnnJ5W306/cn4Pfi8uRX3D/eNVBVT15tnpZ38a0Aj1TEeFn7pnNg==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr17432545pll.79.1595806599173;
        Sun, 26 Jul 2020 16:36:39 -0700 (PDT)
Received: from localhost (g155.222-224-148.ppp.wakwak.ne.jp. [222.224.148.155])
        by smtp.gmail.com with ESMTPSA id d65sm12822423pfc.97.2020.07.26.16.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 16:36:38 -0700 (PDT)
Date:   Mon, 27 Jul 2020 08:36:36 +0900
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
Message-ID: <20200726233636.GE80756@lianli.shorne-pla.net>
References: <20200722122704.1153221-3-mholenko@antmicro.com>
 <202007251829.A4shNHeo%lkp@intel.com>
 <20200725211416.GB80756@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725211416.GB80756@lianli.shorne-pla.net>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Mateusz,

There may be a problem here, see below.

On Sun, Jul 26, 2020 at 06:14:16AM +0900, Stafford Horne wrote:
> On Sat, Jul 25, 2020 at 06:29:51PM +0800, kernel test robot wrote:
> > Hi Mateusz,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on robh/for-next]
> > [also build test WARNING on tty/tty-testing usb/usb-testing staging/staging-testing driver-core/driver-core-testing linus/master v5.8-rc6 next-20200724]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Mateusz-Holenko/LiteX-SoC-controller-and-LiteUART-serial-driver/20200722-183024
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > config: openrisc-randconfig-s032-20200725 (attached as .config)
> > compiler: or1k-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.2-93-g4c6cbe55-dirty
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 
> 
> Note, this is OpenRISC
> 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > 
> > >> drivers/soc/litex/litex_soc_ctrl.c:61:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
> > >> drivers/soc/litex/litex_soc_ctrl.c:61:24: sparse:     expected unsigned int [usertype] value
> > >> drivers/soc/litex/litex_soc_ctrl.c:61:24: sparse:     got restricted __le32 [usertype]
> > >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> > >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> > >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> > >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> > >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> > >> drivers/soc/litex/litex_soc_ctrl.c:77:32: sparse: sparse: cast to restricted __le32
> >    drivers/soc/litex/litex_soc_ctrl.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/io.h, include/linux/litex.h):
> 
> I think this is something I need to fix up in the openrisc io.h header.

There are issues with the openrisc io.h header, but after closer inspection the
new warnings above do not seem to be related to this.  See more notes below.

> It seems the sparse annotations are messed up.  Working on it...
> 
> -Stafford
> 
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
> >    include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
> >    include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> >    include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
> > 
> > vim +61 drivers/soc/litex/litex_soc_ctrl.c
> > 
> >     32	
> >     33	/*
> >     34	 * LiteX SoC Generator, depending on the configuration,
> >     35	 * can split a single logical CSR (Control & Status Register)
> >     36	 * into a series of consecutive physical registers.
> >     37	 *
> >     38	 * For example, in the configuration with 8-bit CSR Bus,
> >     39	 * 32-bit aligned (the default one for 32-bit CPUs) a 32-bit
> >     40	 * logical CSR will be generated as four 32-bit physical registers,
> >     41	 * each one containing one byte of meaningful data.
> >     42	 *
> >     43	 * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
> >     44	 *
> >     45	 * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> >     46	 * the logic of writing to/reading from the LiteX CSR in a single
> >     47	 * place that can be then reused by all LiteX drivers.
> >     48	 */
> >     49	void litex_set_reg(void __iomem *reg, unsigned long reg_size,
> >     50			    unsigned long val)
> >     51	{
> >     52		unsigned long shifted_data, shift, i;
> >     53		unsigned long flags;
> >     54	
> >     55		spin_lock_irqsave(&csr_lock, flags);
> >     56	
> >     57		for (i = 0; i < reg_size; ++i) {
> >     58			shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> >     59			shifted_data = val >> shift;
> >     60	
> >   > 61			writel(cpu_to_le32(shifted_data), reg + (LITEX_REG_SIZE * i));

writel is defined to expect cpu endian u32 and it will internally convert it to
le32.  There shouldbe no need for cpu_to_le32.  This is from asm-generic/io.h
used by openrisc:

   #ifndef writel
   #define writel writel
   static inline void writel(u32 value, volatile void __iomem *addr)
   {
   	__io_bw();
   	__raw_writel(__cpu_to_le32(value), addr);
   	__io_aw();
   }
   #endif

The call to cpu_to_le32() is what is causing the sparse warnings above.

> >     62		}
> >     63	
> >     64		spin_unlock_irqrestore(&csr_lock, flags);
> >     65	}
> >     66	EXPORT_SYMBOL_GPL(litex_set_reg);
> >     67	
> >     68	unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
> >     69	{
> >     70		unsigned long shifted_data, shift, i;
> >     71		unsigned long result = 0;
> >     72		unsigned long flags;
> >     73	
> >     74		spin_lock_irqsave(&csr_lock, flags);
> >     75	
> >     76		for (i = 0; i < reg_size; ++i) {
> >   > 77			shifted_data = le32_to_cpu(readl(reg + (LITEX_REG_SIZE * i)));

Same issue here, readl is already returning cpu endian u32.  No need to convert it
to cpu.

    #ifndef readl
    #define readl readl
    static inline u32 readl(const volatile void __iomem *addr)
    {
    	u32 val;

    	__io_br();
    	val = __le32_to_cpu((__le32 __force) __raw_readl(addr));
    	__io_ar(val);
    	return val;
    }
    #endif

Note, of LE machines like riscv the le32_to_cpu and le32_to_cpu will be no-ops
so this will not cause issues.  But likely this is broken on OpenRISC.  I have
not run these drivers for a while.

-Stafford

> >     78	
> >     79			shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> >     80			result |= (shifted_data << shift);
> >     81		}
> >     82	
> >     83		spin_unlock_irqrestore(&csr_lock, flags);
> >     84	
> >     85		return result;
> >     86	}
> >     87	EXPORT_SYMBOL_GPL(litex_get_reg);
> >     88	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
