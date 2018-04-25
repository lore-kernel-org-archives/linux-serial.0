From: Ciro Santilli <ciro.santilli@gmail.com>
Subject: Re: [RFC PATCH v3] tty: pl011: Avoid spuriously stuck-off interrupts
Date: Wed, 25 Apr 2018 13:47:42 +0100
Message-ID: <CAFXrp_djBYwrp664A8tLrqZDw=3L6w4Uadk-Rin_ZTwfE2QwGw@mail.gmail.com>
References: <1524490888-849-1-git-send-email-Dave.Martin@arm.com>
 <CAFEAcA8Q97YNKomCgkujgoY0MoES3edHoFEk_jjXGMCdzBpd9w@mail.gmail.com>
 <20180425122000.cts26gtvjuje4j7f@kamzik.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180425122000.cts26gtvjuje4j7f@kamzik.brq.redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Wei Xu <xuwei5@hisilicon.com>, linux-serial@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, arm-mail-list <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 25, 2018 at 1:20 PM, Andrew Jones <drjones@redhat.com> wrote:
> On Mon, Apr 23, 2018 at 02:49:30PM +0100, Peter Maydell wrote:
>> On 23 April 2018 at 14:41, Dave Martin <Dave.Martin@arm.com> wrote:
>> > This is an update to a previous RFC v2 [1], to fix a problem observed by
>> > the qemu community that causes serial input to hang when booting a
>> > simulated system with data already queued in the UART FIFO [2].
>> >
>> > After discussion, I decided that the approach in [1] was over-
>> > engineered: it tries to preserve a guarantee that people shouldn't be
>> > relying on anyway, namely that data sent to the UART prior to kernel
>> > boot will be received by the kernel; or more generally that data
>> > received by the UART while the pl011 driver is not opened will be
>> > received (either intact or at all) by the driver.
>> >
>> > If anyone can please test the following and let me know the results,
>> > that would be much appreciated!
>> >
>> >  a) Check that you can still reproduce the bug on mainline without this
>> >     patch.
>> >
>> >  b) Check whether this patch fixes the problem.
>>
>> Thanks. I'm cc'ing Ciro and Drew, who are the two people I
>> recall reporting this issue to me.
>> Link to the patch for their benefit:
>>  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573120.html
>>
>
> Hi Dave,
>
> v3 does not resolve the issue for me. v2 does, and, fwiw, v3 applied on
> top of v2 (i.e. applying both), still works.
>

I also confirm that v2 + v3 on top of Linux kernel v4.16, QEMU v2.11.0
solves the problem on arm and aarch64, otherwise if I hit Ctrl + C
during boot my terminal become irresponsive after boot. Test setup:
https://github.com/cirosantilli/linux-kernel-module-cheat/tree/14965a40d27c8d9d1ff5b023ace827b288a024ef

> If you choose to go with v2, then you can add my tested-by.
>
> Thanks,
> drew
