From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC] With 8250 Designware UART, if writes to the LCR failed
 the kernel will hung up
Date: Sun, 15 Mar 2015 10:50:30 -0400
Message-ID: <55059C36.10307@hurleysoftware.com>
References: <54F96F5B.2090601@huawei.com>	<54F9DACA.3020103@hurleysoftware.com>	<CAD7vxxJXEz8KfXd9fBjkxTi5Nnjyw0=wwvbw5qCSwCMbBd64eA@mail.gmail.com>	<54FD4779.3020902@huawei.com>	<1425907939.3838.182.camel@linux.intel.com>	<CAD7vxxJvL61BjD9AMBF34Y8xnY+D-umuWLUq8Dh7ZbSm5tCE9w@mail.gmail.com>	<1425913502.3838.185.camel@linux.intel.com>	<CAD7vxx+WYgOujpTAxXsUmcr8T4zHS9MYfwrWu8hV2t=TudLamQ@mail.gmail.com> <CAHp75Vd5UhG1nLfmLw3KgUjYsVi5JBq2=UZx1A=ec0Bu5htAMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd5UhG1nLfmLw3KgUjYsVi5JBq2=UZx1A=ec0Bu5htAMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Alan Cox <alan@linux.intel.com>, "long.wanglong" <long.wanglong@huawei.com>, Zhang Zhen <zhenzhang.zhang@huawei.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jamie Iles <jamie@jamieiles.com>, Arnd Bergmann <arnd@arndb.de>, shenjiangjiang@huawei.com, Wang Kai <morgan.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On 03/13/2015 11:36 AM, Andy Shevchenko wrote:
> On Tue, Mar 10, 2015 at 4:47 AM, Tim Kryger <tim.kryger@gmail.com> wrote:
>> On Mon, Mar 9, 2015 at 8:05 AM, Alan Cox <alan@linux.intel.com> wrote:
>>
>>> Ah no - I meant what is their official software workaround for existing
>>> parts with the bug ? Presumably they have an errata document that
>>> discusses this and the correct methods they recommend to avoid the
>>> hang ?
>>
>> As far as I know, the only advice they provided was rather naive.
>>
>> The documentation I saw suggested stashing a copy of the LCR and then
>> rewriting it when the special LCR write failed interrupt was raised.
>>
>> That approach was not workable as the LCR might be written while the
>> interrupt is masked causing the sequence of register writes to occur
>> in an order other than what was desired.
>>
>> Additionally, when the LCR needed to be re-written but the UART stayed
>> busy, the interrupt would keep firing and the driver would starve out
>> everything else on the CPU.
>>
>> The current workaround of clearing fifos and retrying a fixed number
>> of times isn't ideal but I'm not sure what else can be done given the
>> way this hardware works.
>>
>> Additional background is in c49436b657d0a56a6ad90d14a7c3041add7cf64d
> 
> I hit the similar problem as Zhang described quite long ago when I
> tried to write to the port chosen as console.
> In my case seems the same (DW) IP is enumerated via PCI. Do we need to
> tweak PCI cases as well?

Currently, 8250_dw only supports platform devices.

To support your use-case, the 8250_dw i/o accessors would need to be
set for that hardware. Otherwise, even if you get this hardware past
the PCI probe, it will lockup anytime the LCR is written while data is
still in the RX fifo.

Regards,
Peter Hurley
