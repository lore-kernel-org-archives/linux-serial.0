From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC v3 1/9] arm: fiq: arbitrary mappings from IRQ to FIQ virqs
Date: Thu, 12 Jun 2014 10:37:32 +0200
Message-ID: <CACRpkdaQnpk5FQWOjWXGhhXrnWjNKJo0=mHf2c9YZcrxTGoEPA@mail.gmail.com>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Fabio Estevam <festevam@gmail.com>, Patch Tracking <patches@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kumar Gala <galak@codeaurora.org>, "David A. Long" <dave.long@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@l>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 5, 2014 at 11:53 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:

> Currently enable_fiq/disable_fiq use a simple offset to convert an IRQ
> virq into a FIQ virq. This is too inflexible for multi-platform kernels
> and makes runtime error checking impossible.
>
> We solve this by introducing a flexible mapping that allows interrupt
> controllers that support FIQ to register those mappings. This, in turn,
> makes it much possible for drivers in DT kernels to gain access to
> FIQ virqs.

I always had a big problem with the term "virq" which I take to mean
"virtual IRQ".

The distinction is:

- Hardware IRQ offsets/numbers - a number encoded in HW
  specs which we usually call hwirqs

- Linux IRQ numbers - just some number

Sometimes, just sometimes, the Linux IRQ number matches the
HW numbers, and then I guess the IRQ is regarded "non-virtual".
The only real effect being that the numbers shown in
/proc/interrupts are the same in both columns... the leftmost
column with the Linux IRQ number and the one right next to
the IRQ controller name which is the hwirq local offset.

But all Linux IRQ numbers are virtual by definition. It's just some
number that the kernel use as a cookie to look up the irq_desc.
And one day we may get rid of IRQ numbers altogether.

I would prefer just to s/virq/irq/g on this patch or if that is
disturbing something more to the point like s/virq/linux_irq/g.

Maybe this is a pointless battle, but still...

Yours,
Linus Walleij
