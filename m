From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
Date: Tue, 12 Jun 2018 11:13:29 +0300
Message-ID: <CAHp75Vc_EVgfj1MpuA_hKHgy6SiQdU7JQDdtVHfOT1sZ_K-nRQ@mail.gmail.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com> <20180612054034.4969-5-songjun.wu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612054034.4969-5-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@intel.com, Linux MIPS Mailing List <linux-mips@linux-mips.org>, qi-ming.wu@intel.com, linux-clk@vger.kernel.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 12, 2018 at 8:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Previous implementation uses platform-dependent functions
> ltq_w32()/ltq_r32() to access registers. Those functions are not
> available for other SoC which uses the same IP.
> Change to OS provided readl()/writel() and readb()/writeb(), so
> that different SoCs can use the same driver.

This patch consists 2 or even 3 ones:
- whitespace shuffling (indentation fixes, blank lines), I dunno if
it's needed at all
- some new registers / bits
- actual switch to readl() / writel()

Please, split.

> +#define asc_w32_mask(clear, set, reg)  \
> +       ({ typeof(reg) reg_ = (reg);    \
> +       writel((readl(reg_) & ~(clear)) | (set), reg_); })

This would be better as a static inline helper, and name is completely
misleading, it doesn't mask the register bits, it _updates_ them.

-- 
With Best Regards,
Andy Shevchenko
