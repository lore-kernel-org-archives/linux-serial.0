From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [RFC v3 1/9] arm: fiq: arbitrary mappings from IRQ to FIQ virqs
Date: Wed, 18 Jun 2014 12:24:04 +0100
Message-ID: <53A176D4.90002@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
 <CAL_JsqK-jCQjCCw4qfJOCfNKLVRDTAYSYsGpmYLDzoSVsBaHrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqK-jCQjCCw4qfJOCfNKLVRDTAYSYsGpmYLDzoSVsBaHrA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Fabio Estevam <festevam@gmail.com>, Linaro Patches <patches@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kumar Gala <galak@codeaurora.org>, "David A. Long" <dave.long@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 13/06/14 15:29, Rob Herring wrote:
> On Thu, Jun 5, 2014 at 4:53 AM, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
>> Currently enable_fiq/disable_fiq use a simple offset to convert an IRQ
>> virq into a FIQ virq. This is too inflexible for multi-platform kernels
>> and makes runtime error checking impossible.
>>
>> We solve this by introducing a flexible mapping that allows interrupt
>> controllers that support FIQ to register those mappings. This, in turn,
>> makes it much possible for drivers in DT kernels to gain access to
>> FIQ virqs.
> 
> I don't get why you need a separate linux irq numbers for FIQ. Isn't
> enabling FIQ simply a property of an irq like edge vs. level trigger?
> Also, given the constraints on FIQ, we can't really have more that 1
> IRQ assigned to FIQ.

No particular reason. I mostly went that way because it mimics the
effect of fiq_start on enable_fiq/disable_fiq whilst supporting
multi-platform.

I'm tempted to keep the radix tree in the FIQ infrastructure but rather
than messing about with shadow virqs use it to lookup a fiq_chip
structure. I think this would keep a clean separation between the ARM
centric (and slightly weird) FIQ from the generic irq code.


Daniel.
