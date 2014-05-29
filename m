From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [RFC v2 04/10] ARM: vexpress: Extend UART with FIQ support
Date: Thu, 29 May 2014 11:31:40 +0100
Message-ID: <53870C8C.1070108@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-5-git-send-email-daniel.thompson@linaro.org>
 <20140523150452.GX3693@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140523150452.GX3693@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Nicolas Pitre <nico@linaro.org>, patches@linaro.org, Anton Vorontsov <anton.vorontsov@linaro.org>, Kumar Gala <galak@codeaurora.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 23/05/14 16:04, Russell King - ARM Linux wrote:
> On Fri, May 23, 2014 at 02:57:52PM +0100, Daniel Thompson wrote:
>> @@ -140,7 +140,7 @@
>>  			v2m_serial0: uart@090000 {
>>  				compatible = "arm,pl011", "arm,primecell";
>>  				reg = <0x090000 0x1000>;
>> -				interrupts = <5>;
>> +				interrupts = <5>, <69>;
> 
> NAK.  This is obviously a Linux implementation detail - the second
> number is your "FIQ" number which you've decided will be offset by
> 64.

Certainly the offset of 64 is a more or less meaningless magic number
that I decided on, however I don't think it originates within Linux. It
is both introduced and consumed within the device tree itself.

I've proposed adding a flag to the gic bindings to mark a FIQ; the GIC
calls interrupt 69 (above) <0 5 0x84> (where 0x80 is the flag to request
FIQ routing alongside 0x04 which is the trigger type).

However vexpress-a15 has an interrupt-map between the UART and the GIC.
Thus far I've not found a way, other by offset, to allow a UART sitting
on a child bus to be provided with both IRQ and FIQ versions of an
interrupt.

> --- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> @@ -233,7 +233,7 @@
>  			 <5 0 0 0x10000000 0x04000000>;
>  
>  		#interrupt-cells = <1>;
> -		interrupt-map-mask = <0 0 63>;
> +		interrupt-map-mask = <0 0 127>;
                                         ^^^^^

The 64 offset is introduced here. Nothing in Linux imposes anything on
the value (I originally had the shadow routings from 59 to 63 and this
also worked).

My code may still be inappropriate but, right now, I'm unsure whether
the proposed changes to the gic bindings are included in the NAK, not in
the NAK or whether they sit in the middle ground where I have to provide
better argumentation.


Daniel.
