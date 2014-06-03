From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [RFC v2 04/10] ARM: vexpress: Extend UART with FIQ support
Date: Tue, 03 Jun 2014 13:41:43 +0100
Message-ID: <538DC287.9060900@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>	<1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>	<1400853478-5824-5-git-send-email-daniel.thompson@linaro.org>	<20140523150452.GX3693@n2100.arm.linux.org.uk>	<53870C8C.1070108@linaro.org>
 <CAL_JsqL0pYOEiyo8KfJA1aO_MOmwvn6a4hibZcamm0Jcw4Q6bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqL0pYOEiyo8KfJA1aO_MOmwvn6a4hibZcamm0Jcw4Q6bA@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Linaro Patches <patches@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kumar Gala <galak@codeaurora.org>, "David A. Long" <dave.long@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz>
List-Id: linux-serial@vger.kernel.org

On 29/05/14 14:44, Rob Herring wrote:
> On Thu, May 29, 2014 at 5:31 AM, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
>> On 23/05/14 16:04, Russell King - ARM Linux wrote:
>>> On Fri, May 23, 2014 at 02:57:52PM +0100, Daniel Thompson wrote:
>>>> @@ -140,7 +140,7 @@
>>>>                      v2m_serial0: uart@090000 {
>>>>                              compatible = "arm,pl011", "arm,primecell";
>>>>                              reg = <0x090000 0x1000>;
>>>> -                            interrupts = <5>;
>>>> +                            interrupts = <5>, <69>;
>>>
>>> NAK.  This is obviously a Linux implementation detail - the second
>>> number is your "FIQ" number which you've decided will be offset by
>>> 64.
> 
> +1
> 
>> Certainly the offset of 64 is a more or less meaningless magic number
>> that I decided on, however I don't think it originates within Linux. It
>> is both introduced and consumed within the device tree itself.
>>
>> I've proposed adding a flag to the gic bindings to mark a FIQ; the GIC
>> calls interrupt 69 (above) <0 5 0x84> (where 0x80 is the flag to request
>> FIQ routing alongside 0x04 which is the trigger type).
> 
> That would be better than the magic number, but I'm not convinced that
> belongs in the DT either.
> 
> Whether the uart uses FIQ is not dependent on this DT setting, but
> based on whether the user wants to use the uart for kdb or not. You
> have enough information already to figure out which interrupt. What's
> missing is whether you have the capability to use FIQ or not. I don't
> recall if you can tell that from the GIC or not.

Ok.

I've just started playing with an idea that keeps the shadow virqw for
FIQ idea but doesn't require any device tree changes...

Another RFC will follow in due course.


Daniel.
