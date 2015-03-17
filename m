From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] amba-pl011: simplify TX handling
Date: Tue, 17 Mar 2015 14:55:42 +0000
Message-ID: <5508406E.5060607@arm.com>
References: <1426547729-21255-1-git-send-email-moorray3@wp.pl>
 <20150317135844.GA3759@e103592.cambridge.arm.com>
 <20150317154248.1675cd4c@north>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150317154248.1675cd4c@north>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?ISO-8859-2?Q?Jakub_Kici=F1ski?= <moorray3@wp.pl>, Dave P Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub Kicinski <kubakici@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?ISO-8859-2?Q?Karol_D=EAbog=F3rski?= <k.debogorski@a2s.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

[resent with LAKML address fixed]
Hi Jakub,

On 17/03/15 14:42, Jakub Kici=F1ski wrote:
> On Tue, 17 Mar 2015 13:58:44 +0000, Dave P Martin wrote:
>> On Mon, Mar 16, 2015 at 11:15:29PM +0000, Jakub Kicinski wrote:
>>> From: Jakub Kicinski <kubakici@wp.pl>

[ ... ]
>>
>> My update still keeps the softirq stuff.  I wanted to avoid adding
>> status polling inside the interrupt handler's core loop, due to
>> concerns about performance overhead: without the polling, the
>> writes to DR are fire-and-forget, whereas polling FR each time
>> involves a whole round-trip to the UART which may involve significant
>> extra time cost and/or IRQ disable latency; however.
>>
>> Your approach does mitigate some of the cost by only starting to
>> poll after count chars have been transmitted, and will typically
>> halve the number of IRQs taken -- which could lead to a net benefit.
>> It would be good to see some benchmarks to understand how much
>> difference it makes to performance.
> =

> I will *try* to come up with some figures but I don't have any
> high-speed UARTs so my tests run at 115k tops.

Have you tried this?
http://fw.hardijzer.nl/?p=3D138

This drives the RPi PL011 from a higher frequency clock, thus you can
achieve much higher baud rates. Haven't tried this myself, but it looks
reasonable and not too complicated. You need a matching speed at the
other end, of course, AFAIK the FTDI USB chip can do this.

Cheers,
Andre.
