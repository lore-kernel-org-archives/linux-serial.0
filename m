From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
Date: Thu, 23 Aug 2012 13:22:22 +0000
Message-ID: <201208231322.23077.arnd@arndb.de>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
 <201208231040.16702.arnd@arndb.de>
 <76F764B079F92A4E843589C893D0A022DAF68C14@SERVER.prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <76F764B079F92A4E843589C893D0A022DAF68C14-A1+cU8XkcJSYgi1/3OOQJ8krCUz0bFs7@public.gmane.org>
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
To: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWNGWvitb5QawA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thursday 23 August 2012, Tony Prisk wrote:
> >On Thursday 23 August 2012, Tony Prisk wrote:

> 
> Without the clock patch (9/9), the mach-vt8500 patch (6/9) won't compile
> due to unresolved symbols.
> 
> In arch/arm/mach-vt8500/vt8500.c - you will get an unresolved symbol
> for 'vtwm_clk_init'
> 
> Not sure if this matters, thought I should point it out.
> Does it need to compile cleanly in your tree (which is what I would assume),
> or just once its all combined in -next?
> Does it matter that the usb patches are already in -next?
> 
> I don't really understand the requirements around submitting to individual
> trees and which (if any) of these points are actually issues.

The rule is that each changeset should be free of regressions compared
to the version before. So if you have a set of 7 patches in one branch
that you want me to pick up, the result after applying those 7 patches
should work, and each previous step should also work. You cannot for
instance add a call to a function in one patch and then provide that
function in the following patch.

There are multiple ways to achieve this:

* when you have dependencies, get everything merged through one
maintainer tree, and get Acks for each patch that belongs to another
maintainer.

* submit a branch with the patches that other stuff depends on to
both the subsystem maintainer who is responsible for it and to
the subsystem maintainer who gets the other patches that are built
on top of this branch. If you do this, you have to make sure that
the first branch never gets rebased and that the second branch is
not sent before the first one is upstream.

* change the code so that no dependencies exist, e.g. by introducing
a dummy implementation in one patch and the proper one in another.
This can generate merge conflicts, but that's usually ok.

	Arnd
