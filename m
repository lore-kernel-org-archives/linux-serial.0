From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 02/10] ARM: dts: N900: Add bluetooth
Date: Tue, 7 Mar 2017 08:37:43 -0800
Message-ID: <20170307163743.GT20572@atomide.com>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-3-sre@kernel.org>
 <20170306160841.GH20572@atomide.com>
 <CAL_JsqKJO6aGwv-fWzvHrbc5n6rdjtZ9Zn9Jg7r1L8-yP2JbSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKJO6aGwv-fWzvHrbc5n6rdjtZ9Zn9Jg7r1L8-yP2JbSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

* Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170307 08:34]:
> On Mon, Mar 6, 2017 at 10:08 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170304 04:00]:
> >> Add bcm2048 node and its system clock to the N900 device tree file.
> >> Apart from that a reference to the new clock has been added to
> >> wl1251 (which uses it, too).
> >>
> >> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >
> > Picking this patch into omap-for-v4.12/dt thanks.
> 
> The binding is not yet settled.

Oh sorry I thought the binding was already done. Will revert.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
