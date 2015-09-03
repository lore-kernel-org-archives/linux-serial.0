From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: earlycon issues in -next with amba-pl011 updates
Date: Thu, 03 Sep 2015 17:08:53 +0100
Message-ID: <55E87095.4030600@arm.com>
References: <20150810232312.GB10728@bivouac.eciton.net>
 <CABymUCNYrDxciKrfWhcTp_kJT1cQFEpEYCkaZ7-sgBiJmgXuyQ@mail.gmail.com>
 <55E81F93.1020104@arm.com> <20150903155255.GA28336@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150903155255.GA28336@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: Jun Nie <jun.nie@linaro.org>, Tyler Baker <tyler.baker@linaro.org>, linux-arm-kernel@lists.infradead.org, Leif Lindholm <leif.lindholm@linaro.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/09/15 16:52, Greg Kroah-Hartman wrote:
> On Thu, Sep 03, 2015 at 11:23:15AM +0100, Marc Zyngier wrote:
>> On 11/08/15 02:48, Jun Nie wrote:
>>> 2015-08-11 7:23 GMT+08:00 Leif Lindholm <leif.lindholm@linaro.org>:
>>>> Hi all,
>>>>
>>>> The kernelci.org bot picked up a complete boot failure (no output past
>>>> UEFI stub) with next-20150806 and Tyler bisected it down to somewhere
>>>> in
>>>> 8cd90e5 uart: pl011: Add support to ZTE ZX296702 uart
>>>> 09dcc7d uart: pl011: Improve LCRH register access decision
>>>> 2c096a9 uart: pl011: Introduce register look up table
>>>> 7b753f3 uart: pl011: Introduce register accessor
>>>>
>>>> The issue only appears with earlycon on command line, for pl011
>>>> consoles.
>>>>
>>>> Some investigation shows that the cause lies with
>>>> commit 7b753f318d14 ("uart: pl011: Introduce register accessor")
>>>> and
>>>> commit 2c096a9eedc6 ("uart: pl011: Introduce register look up table")
>>>>
>>>> Specifically, the changes to pl011_putc() are incorrect:
>>>> The new pl011_ accessors take a (struct uart_amba_port *) input, but
>>>> pl011_putc() directly uses the incoming (struct uart_port *) for this.
>>>>
>>>> Apart from ending up with an unintended/incorrect UART base address,
>>>> the introduction of the lookup table for register offsets also means
>>>> the accessors try to dereference (struct uart_amba_port *)->reg_lut.
>>>>
>>>> The below is a hack that shows/resolves the issue, but some
>>>> refactoring of the original patches might be in order.
>>>>
>>>> /
>>>>     Leif
>>>
>>> Leif,
>>>
>>> Sorry for the inconvenience. I do not have idea of early console till
>>> now and I always have debug console for early panic debug. Learned
>>> more from this issue.
>>>
>>> Suppose Peter's patch will resolve your issue.
>>
>> [+ Greg KH]
>>
>> So -next has now been broken for a while on a number of ARM platforms
>> because of this (they simply cannot boot), and no progress has been made
>> towards resolving this problem.
>>
>> Can we please drop this series (at least commits 7b753f3 and following)
>> from -next until is has been reworked and reviewed?
> 
> I don't have any patches in my -next tree, everything is in Linus's tree
> now.  So if I've missed something, or need to revert something, please
> let me know specifcally what to do.

Gahhh... Given that there is no obvious fix, that the discussion has
stalled and that the author of the series is apparently away, the
following patches should be reverted:

8cd90e50d140 uart: pl011: Add support to ZTE ZX296702 uart
09dcc7dfc05b uart: pl011: Improve LCRH register access decision
2c096a9eedc6 uart: pl011: Introduce register look up table
7b753f318d14 uart: pl011: Introduce register accessor
534e14e2293d uart: pl011: Rename regs with enumeration

(7b753f318d14 being the one breaking everything, but it makes more sense
to revert the whole series until it is properly fixed and reviewed).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
