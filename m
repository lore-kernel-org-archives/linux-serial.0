From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [3/3] ARM: da850: Add ti, da830-uart compatible for serial ports
Date: Mon, 2 Jan 2017 13:36:40 +0530
Message-ID: <11bdcd56-de34-a5ff-7af5-24e4a0e8cd2c@ti.com>
References: <1482265384-715-4-git-send-email-david@lechnology.com>
 <2982bdd0-0997-f4a7-71c3-9d232237cc23@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2982bdd0-0997-f4a7-71c3-9d232237cc23-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thursday 22 December 2016 09:36 PM, Franklin S Cooper Jr wrote:
> 
> 
> On 12/20/2016 02:23 PM, David Lechner wrote:
>> TI DA8xx/OMAPL13x/AM17xx/AM18xx SoCs have extra UART registers beyond
> 
> Similar comment about adding Keystone SoCs to the list of SoCs.
> 
>> the standard 8250 registers, so we need a new compatible string to
>> indicate this. Also, at least one of these registers uses the full 32
>> bits, so we need to specify reg-io-width in addition to reg-shift.
>>
>> "ns16550a" is left in the compatible specification since it does work
>> as long as the bootloader configures the SoC UART power management
>> registers.
>>
>> Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/da850.dtsi | 9 ++++++---
> 
> Similar changes should be made to the various Keystone dtsi files.

That will be a different patch though since the two changes will go
through different trees. And I strongly suspect David does not have
access to a keystone board. So it will have to be done by someone at TI.

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
