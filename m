From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: RE: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
Date: Thu, 23 Aug 2012 12:58:29 +0000
Message-ID: <76F764B079F92A4E843589C893D0A022DAF68C14@SERVER.prisktech.co.nz>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>,
 <201208231040.16702.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201208231040.16702.arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWNGWvitb5QawA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

>On Thursday 23 August 2012, Tony Prisk wrote:
>> Patchset based on Arnd's arm-soc/for-next branch.
>>
>>
>> Could I get this reviewed, hopefully for inclusion into v3.7.

>I can take them into the arm-soc tree if there are no new comments.
>For the last two patches, you need to get an Acked-by comment from the
>gpio and clk maintainers, respectively, or you should send them
>the patches for inclusion in those subsystem trees.

>        Arnd


Linus W has provided some feedback on the gpio driver - I missed the
issues he raised the first time around so just waiting for him to take a look
at v4 when he's got time.

I haven't heard from Mike T in regards to the new clock code - He did
reply about the original patch (pre-devicetree) but I asked him to hold off
reviewing it because it was going to be rewritten.

EHCI/UHCI has gone to -next (on patchv2) via usb-next
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
There haven't been any changes to it in v3/v4.

GPIO going via another tree isn't really an issue if necessary.

Without the clock patch (9/9), the mach-vt8500 patch (6/9) won't compile
due to unresolved symbols.

In arch/arm/mach-vt8500/vt8500.c - you will get an unresolved symbol
for 'vtwm_clk_init'

Not sure if this matters, thought I should point it out.
Does it need to compile cleanly in your tree (which is what I would assume),
or just once its all combined in -next?
Does it matter that the usb patches are already in -next?

I don't really understand the requirements around submitting to individual
trees and which (if any) of these points are actually issues.

Regards

Tony Prisk
