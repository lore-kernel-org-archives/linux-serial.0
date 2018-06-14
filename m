From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
Date: Thu, 14 Jun 2018 12:07:19 +0200
Message-ID: <CAK8P3a0K6qezHLcjkeq0zd+iQJQc_qbT2JhtZGrCNRT495sUvQ@mail.gmail.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com> <20180612054034.4969-5-songjun.wu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612054034.4969-5-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@intel.com, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>, linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>, James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Previous implementation uses platform-dependent functions
> ltq_w32()/ltq_r32() to access registers. Those functions are not
> available for other SoC which uses the same IP.
> Change to OS provided readl()/writel() and readb()/writeb(), so
> that different SoCs can use the same driver.
>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

Are there any big-endian machines using this driver? The original definition
of ltq_r32() uses non-byteswapping __raw_readl() etc, which suggests
that the registers might be wired up in a way that matches the CPU
endianess (this is usally a bad idea in hardware design, but nothing
we can influence in the OS).

When you change it to readl(), that will breaks all machines that rely
on the old behavior on big-endian kernels.

      Arnd
