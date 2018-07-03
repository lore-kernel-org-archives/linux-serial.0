From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
Date: Tue, 03 Jul 2018 16:03:40 +0300
Message-ID: <c9bf4c643f51ab222dbc0221acc47773ee3d1a9a.camel@linux.intel.com>
References: <20180702180428.331b36c5@xhacker.debian>
         <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
         <59b14f97234271a7d859fa07f27bd66ec252ccc9.camel@linux.intel.com>
         <20180703102257.678db6a8@xhacker.debian>
         <20180703104816.031abbfc@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703104816.031abbfc@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2018-07-03 at 10:48 +0800, Jisheng Zhang wrote:
> On Tue, 3 Jul 2018 10:22:57 +0800 Jisheng Zhang wrote:

> patching struct uart_port seems a bit overhead. After reading the code
> again, I propose another solution, similar as what dl_write() is used
> in
> 8250 core:
> 
> 1.introduce the hook to struct uart_8250_port as my previous patches
> do, 
> 
> 2.rename current serial8250_set_divisor() as
> default_serial_get_divisor()
> then introduce a new serial8250_set_divisor() as:
> static inline void serial8250_set_divisor(struct uart_8250_port
> *up,....)
> {
> 	up->set_divisor();
> }
> 
> and point up->set-divisor to default_serial_get_divisor
> 
> what do you think about this solution?

Disagree. See my previous answer for details.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
