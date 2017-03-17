From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Console stops with calltrace on cavium octeon2 68XX EVB
Date: Fri, 17 Mar 2017 15:18:00 +0200
Message-ID: <1489756680.19767.55.camel@linux.intel.com>
References: <CAFdej01TKnVy0=SrtDAwnsmaqzq2xnEM3bB2+CCFjp2rDCn2rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFdej01TKnVy0=SrtDAwnsmaqzq2xnEM3bB2+CCFjp2rDCn2rQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Chandran <achandran@mvista.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Cc: jason.uy@broadcom.com, scott.branden@broadcom.com, ray.jui@broadcom.com, wangkefeng.wang@huawei.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, heikki.krogerus@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-03-17 at 18:30 +0530, Arun Chandran wrote:
> Hi,
> 
> I got this on my cavium octeon2 68XX EVB console when booting the
> latest kernel(4.11.0-rc2-00235-gd528ae0).

> And I bisected and reached at this commit
> "6a171b2 serial: 8250_dw: Allow hardware flow control to be used"
> 
> When I printed the value of my "d->clk" inside dw8250_set_termios() it
> was zero.
> Then the below change is solving the problem for me.(No calltrace
> console works fine)

> Can anybody please comment on this?

Have you seen

https://www.spinics.net/lists/linux-serial/msg25483.html

https://patchwork.kernel.org/patch/9603947/

?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
