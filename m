From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
Date: Fri, 24 Aug 2012 21:32:02 -0600
Message-ID: <50384732.9060304@nvidia.com>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1345707346-9035-1-git-send-email-linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
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
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 08/23/2012 01:35 AM, Tony Prisk wrote:
> This patchset updates arch-vt8500 to devicetree and removes all the old-style
> code. Support for WM8650 has also been added.
> 
> Example dts/dtsi files are given for the three currently supported models.
> 
> Major changes:
> 
> GPIO code has been converted to a platform_device and rewritten as WM8505
> support was broken. Add support for WM8650 gpio controller.
> 
> UHCI support was missing. Added this as a generic non-pci uhci controller as
> it doesn't require anything special. Should be usable by any system that doesn't
> have special requirements to get the UHCI controller working.
> 
> Framebuffer code patched to support WM8650. The bindings for this are of concern
> but there doesn't seem to be a formalized binding yet. This patch is based off
> Sascha Hauer's current patch on the dri-devel mailing list and should be easily
> patched out when its finalized.
> 
> Patchset based on Arnd's arm-soc/for-next branch.

I believe all the issues I pointed out are fixed in this series. I'm not
sure I reviewed it in enough detail to ack it, but I'm fine with what I saw.
