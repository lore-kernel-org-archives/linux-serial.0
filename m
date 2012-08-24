From: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Subject: Re: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
Date: Fri, 24 Aug 2012 19:18:12 +1200
Message-ID: <1345792692.23550.3.camel@gitbox>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
 <201208231322.23077.arnd@arndb.de> <1345758702.2061.6.camel@gitbox>
 <201208240540.12316.arnd@arndb.de> <1345787536.23177.3.camel@gitbox>
 <CABjd4Yxxf5XDc6gs0WABZgF3SOd89J7CfjsU9uitOg4qpQ4WEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CABjd4Yxxf5XDc6gs0WABZgF3SOd89J7CfjsU9uitOg4qpQ4WEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alexey Charkov <alchark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org" <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, vt8500-wm8505-linux-kernel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2012-08-24 at 09:54 +0400, Alexey Charkov wrote:
> 2012/8/24 Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>:
> > On Fri, 2012-08-24 at 05:40 +0000, Arnd Bergmann wrote:
> >> On Thursday 23 August 2012, Tony Prisk wrote:
> >> > I was about to say that if Mike has any issues with the driver that I
> >> > can fix the patch conflict at the same time, but I just realised that
> >> > its more work than I originally thought :)
> >> >
> >> > I was going to move the arch-vt8500 part of the clocks patch back into
> >> > the clocks patch - but that will just move the issue from arm-soc to
> >> > clocks because Mike's branch won't have the arch-vt8500 patch so the
> >> > patch will fail.
> >>
> >> But that's ok, because without the arch-v8500 part, nothing uses
> >> the vt8500-clock driver, so nothing breaks. You can introduce broken
> >> code in the meantime as long as it's impossible to enable and it will
> >> work afterwards.
> >>
> >>       Arnd
> >
> > You lost me a little bit there :)
> > If it stays as is now, the arch-vt8500 patch will introduce an
> > unresolved symbol.
> > If I move the clock code from the arch-vt8500 patch to the clock patch,
> > then the clock patch won't apply because it needs the arch-vt8500 patch
> > first and Mike won't have that patch, but it would be fine if both
> > patches went in via your tree.
> 
> Why don't you add a #define in the first patch that makes your
> to-be-unresolved symbol a no-op and then drop it within the clock
> patch?
> 
> Best,
> Alexey
> 
Actually - that doesn't resolve the problem unless it all goes in via
the same tree still because the clock patch can only drop the #define if
the arch-vt8500 patch exists still - same as problem #2 I mentioned.

If the clock patch goes via Mikes tree he will need the arch-vt8500
patch as well - don't think it can be avoided.

Still easier to send the whole lot via arm-soc, then at least we can
resolve the patch conflicts without having to apply the patches twice.

Regards
Tony P
