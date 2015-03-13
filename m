From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC] With 8250 Designware UART, if writes to the LCR failed the
 kernel will hung up
Date: Fri, 13 Mar 2015 17:36:24 +0200
Message-ID: <CAHp75Vd5UhG1nLfmLw3KgUjYsVi5JBq2=UZx1A=ec0Bu5htAMw@mail.gmail.com>
References: <54F96F5B.2090601@huawei.com>
	<54F9DACA.3020103@hurleysoftware.com>
	<CAD7vxxJXEz8KfXd9fBjkxTi5Nnjyw0=wwvbw5qCSwCMbBd64eA@mail.gmail.com>
	<54FD4779.3020902@huawei.com>
	<1425907939.3838.182.camel@linux.intel.com>
	<CAD7vxxJvL61BjD9AMBF34Y8xnY+D-umuWLUq8Dh7ZbSm5tCE9w@mail.gmail.com>
	<1425913502.3838.185.camel@linux.intel.com>
	<CAD7vxx+WYgOujpTAxXsUmcr8T4zHS9MYfwrWu8hV2t=TudLamQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD7vxx+WYgOujpTAxXsUmcr8T4zHS9MYfwrWu8hV2t=TudLamQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, "long.wanglong" <long.wanglong@huawei.com>, Peter Hurley <peter@hurleysoftware.com>, Zhang Zhen <zhenzhang.zhang@huawei.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jamie Iles <jamie@jamieiles.com>, Arnd Bergmann <arnd@arndb.de>, shenjiangjiang@huawei.com, Wang Kai <morgan.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 10, 2015 at 4:47 AM, Tim Kryger <tim.kryger@gmail.com> wrote:
> On Mon, Mar 9, 2015 at 8:05 AM, Alan Cox <alan@linux.intel.com> wrote:
>
>> Ah no - I meant what is their official software workaround for existing
>> parts with the bug ? Presumably they have an errata document that
>> discusses this and the correct methods they recommend to avoid the
>> hang ?
>
> As far as I know, the only advice they provided was rather naive.
>
> The documentation I saw suggested stashing a copy of the LCR and then
> rewriting it when the special LCR write failed interrupt was raised.
>
> That approach was not workable as the LCR might be written while the
> interrupt is masked causing the sequence of register writes to occur
> in an order other than what was desired.
>
> Additionally, when the LCR needed to be re-written but the UART stayed
> busy, the interrupt would keep firing and the driver would starve out
> everything else on the CPU.
>
> The current workaround of clearing fifos and retrying a fixed number
> of times isn't ideal but I'm not sure what else can be done given the
> way this hardware works.
>
> Additional background is in c49436b657d0a56a6ad90d14a7c3041add7cf64d

I hit the similar problem as Zhang described quite long ago when I
tried to write to the port chosen as console.
In my case seems the same (DW) IP is enumerated via PCI. Do we need to
tweak PCI cases as well?


-- 
With Best Regards,
Andy Shevchenko
