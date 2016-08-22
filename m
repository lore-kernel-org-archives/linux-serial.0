From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/3]
Date: Mon, 22 Aug 2016 14:32:18 +0300
Message-ID: <1471865538.4887.207.camel@linux.intel.com>
References: <1468580485-28567-1-git-send-email-wangkefeng.wang@huawei.com>
         <1470758477.25395.12.camel@linux.intel.com>
         <471cc4e4-7e08-7cbf-022f-05d4fe3f378b@huawei.com>
         <f10ce2dd-dd7a-ff02-83c7-7d73461d0841@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <f10ce2dd-dd7a-ff02-83c7-7d73461d0841@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, guohanjun@huawei.com, z.liuxinliang@hisilicon.com, xuwei5@hisilicon.com, graeme.gregory@linaro.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-08-19 at 14:26 +0800, Kefeng Wang wrote:
> 
> Make dw8250_set_termios() as the default set_termios callback
> > > > for 8250
> > > > dw uart, correct me
> > > > if I am wrong.
> > > > 
> > > > Then add ACPI support for uart on Hisilicon Hip05 soc, be
> > > > careful that
> > > > it is not 16500
> > > > compatible. Meanwhile, set dw8250_serial_out32 to keep
> > > > consistent
> > > > between serial_out
> > > > and serial_in in ACPI.
> > > 
> > > I will review it perhaps late this week.
> > 
> 
> Hi Andy, kindly ping...

Sorry for being a bit late, but here we are.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
