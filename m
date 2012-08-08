From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: RE: [PATCH 6/8] arm: vt8500: Update arch-vt8500 to devicetree support.
Date: Wed, 8 Aug 2012 19:37:04 +0000
Message-ID: <76F764B079F92A4E843589C893D0A022D1DCA8C1@SERVER.prisktech.co.nz>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-7-git-send-email-linux@prisktech.co.nz>,
 <5022B6EE.7060006@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5022B6EE.7060006-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Eric Andersson <eric.andersson-TStm8jYLEPpl57MIdRCFDg@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Neil Zhang <zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>Alan
List-Id: linux-serial@vger.kernel.org

>On 08/07/2012 07:39 PM, Tony Prisk wrote:
>> Merged existing board files to a single dt-capable file.
>> Converted irq and timer code to devicetree.
>> Removed existing device files that are no longer required with
>> devicetree support.
>>
>> All existing platform devices are converted to devicetree nodes
>> except GPIO and PWM.

>Perhaps that also explains what I was commenting on in the GPIO driver
>patch. Why not convert GPIO too?

GPIO was converted - I hadn't planned on doing it, but apparently I did it anyway :/
Comment is now removed from the commit message.

>> diff --git a/arch/arm/mach-vt8500/irq.c b/arch/arm/mach-vt8500/irq.c

>>  /*
>> - *  arch/arm/mach-vt8500/irq.c
>> + *  arch/arm/mach-vt8500/irq_dt.c

>This file didn't get renamed?

Not sure what is going on here. I will take a look - it should just be renamed.

>> diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c

>> +void __init vt8500_init(void)
>> +{
>> +     struct device_node *np, *fb;
>> +     void __iomem *gpio_base;
>> +
>> +#ifdef CONFIG_FB_VT8500
>> +     fb = of_find_compatible_node(NULL, NULL, "via,vt8500-fb");
>> +     if (fb) {
>> +             np = of_find_compatible_node(NULL, NULL, "via,vt8500-gpio");
>> +             if (np) {
>> +                     gpio_base = of_iomap(np, 0);
>> +
>> +                     if (!gpio_base)
>> +                             pr_err("%s:of_iomap(gpio_mux) failed\n", __func__);
>> +
>> +                     of_node_put(np);
>> +             } else {
>> +                     gpio_base = ioremap(LEGACY_GPIO_BASE, 0x1000);
>> +                     if (!gpio_base)
>> +                             pr_err("%s:ioremap(legacy_gpio_mux) failed\n", __func__);
>> +             }
>> +             if (gpio_base) {
>> +                     writel(readl(gpio_base + VT8500_GPIO_MUX_REG) | 1,
>> +                             gpio_base + VT8500_GPIO_MUX_REG);
>> +                     iounmap(gpio_base);
>> +             } else
>> +                     pr_err("%s: Could not remap GPIO mux\n", __func__);
>> +
>> +             of_node_put(fb);
>> +     }
>> +#endif

>That looks quite suspicious. What's it doing? Is this something that
>should be part of a pinctrl driver, or the GPIO driver?

This code is carried over from the original implementation but converted for device
tree. It should be part of a pinctrl driver, but we don't have one. It is basically selecting
between CCIR or LCD. 

Annoyingly, the bit-fields changed between models, so we have it twice, once for each
framebuffer driver. It needs to check for compatible nodes so that it only applies the setting
for the framebuffer type being requested by the dts because of the conflicting bit-fields.

Tony Prisk
