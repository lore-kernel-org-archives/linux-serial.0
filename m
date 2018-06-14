From: "Wu, Songjun" <songjun.wu@linux.intel.com>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
Date: Thu, 14 Jun 2018 15:05:25 +0800
Message-ID: <4d2482dc-a77c-6a1f-5e71-f7f14d66bf80@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-5-songjun.wu@linux.intel.com>
 <CAHp75Vc_EVgfj1MpuA_hKHgy6SiQdU7JQDdtVHfOT1sZ_K-nRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc_EVgfj1MpuA_hKHgy6SiQdU7JQDdtVHfOT1sZ_K-nRQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@intel.com, Linux MIPS Mailing List <linux-mips@linux-mips.org>, qi-ming.wu@intel.com, linux-clk@vger.kernel.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org



On 6/12/2018 4:13 PM, Andy Shevchenko wrote:
> On Tue, Jun 12, 2018 at 8:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> Previous implementation uses platform-dependent functions
>> ltq_w32()/ltq_r32() to access registers. Those functions are not
>> available for other SoC which uses the same IP.
>> Change to OS provided readl()/writel() and readb()/writeb(), so
>> that different SoCs can use the same driver.
> This patch consists 2 or even 3 ones:
> - whitespace shuffling (indentation fixes, blank lines), I dunno if
> it's needed at all
> - some new registers / bits
> - actual switch to readl() / writel()
>
> Please, split.
It will be split to four patches, coding style, new registers, 
readl()/writel() and asc_update_bits.
>> +#define asc_w32_mask(clear, set, reg)  \
>> +       ({ typeof(reg) reg_ = (reg);    \
>> +       writel((readl(reg_) & ~(clear)) | (set), reg_); })
> This would be better as a static inline helper, and name is completely
> misleading, it doesn't mask the register bits, it _updates_ them.
It will be changed to asc_update_bits.
