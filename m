From: kbuild test robot <lkp@intel.com>
Subject: Re: [v6] serial: 8250_dw: Add support for big-endian MMIO accesses
Date: Tue, 6 Oct 2015 16:01:52 +0800
Message-ID: <201510061616.n6BNnxpM%fengguang.wu@intel.com>
References: <1444113590-19722-2-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444113590-19722-2-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

Hi Noam,

[auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]

reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/tty/serial/8250/8250_dw.c:214:27: sparse: incorrect type in argument 1 (different modifiers)
   drivers/tty/serial/8250/8250_dw.c:214:27:    expected void [noderef] <asn:2>*<noident>
   drivers/tty/serial/8250/8250_dw.c:214:27:    got void const [noderef] <asn:2>*addr
   drivers/tty/serial/8250/8250_dw.c: In function '_dw8250_serial_in32be':
   drivers/tty/serial/8250/8250_dw.c:214:20: warning: passing argument 1 of 'ioread32be' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32be(addr);
                       ^
   In file included from arch/x86/include/asm/io.h:203:0,
                    from arch/x86/include/asm/realmode.h:5,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:12,
                    from arch/x86/include/asm/smp.h:12,
                    from arch/x86/include/asm/mmzone_64.h:10,
                    from arch/x86/include/asm/mmzone.h:4,
                    from include/linux/mmzone.h:934,
                    from include/linux/gfp.h:5,
                    from include/linux/device.h:29,
                    from drivers/tty/serial/8250/8250_dw.c:16:
   include/asm-generic/iomap.h:32:21: note: expected 'void *' but argument is of type 'const void *'
    extern unsigned int ioread32be(void __iomem *);
                        ^

vim +214 drivers/tty/serial/8250/8250_dw.c

   198	}
   199	
   200	static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
   201	{
   202		unsigned int value = readl(p->membase + (offset << p->regshift));
   203	
   204		return dw8250_modify_msr(p, offset, value);
   205	}
   206	
   207	static void _dw8250_serial_out32be(unsigned int value, void __iomem *addr)
   208	{
   209		iowrite32be(value, addr);
   210	}
   211	
   212	static unsigned int _dw8250_serial_in32be(const void __iomem *addr)
   213	{
 > 214		return ioread32be(addr);
   215	}
   216	
   217	static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
   218	{
   219		iowrite32be(value, p->membase + (offset << p->regshift));
   220		dw8250_check_LCR(p, offset, value);
   221	}
   222	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
