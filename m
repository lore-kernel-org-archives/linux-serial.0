From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [STLinux Kernel] [PATCH 3/8] serial: st-asc: Read in all Pinctrl
 states
Date: Wed, 1 Feb 2017 12:47:51 +0000
Message-ID: <20170201124751.f3r7l52vneqgilac@dell>
References: <20170127115458.k4edg42nnna3bv4v@dell>
 <20170130142356.GA18710@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170130153211.j75qemvwsq3cwqve@dell>
 <20170130161041.GA21001@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170130191159.zv5jegvu4fetcmzo@dell>
 <20170130223521.GA12847@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170131101356.bpg5hamkfgprdbpt@dell>
 <20170131113131.GA6427@griffinp-ThinkPad-X1-Carbon-2nd>
 <20170131122717.cwyqezvca3gsti7t@dell>
 <20170201115006.GA23479@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170201115006.GA23479@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

> > > > Again, doesn't matter, since it's the DTB that provides the default
> > > > state.  So, back when it was authored, the default state was HW
> > > > flow-control disabled.  And in a newer DTB (again, until I follow-up
> > > > with more changes), the defaults for UART 1 and UART 2 are HW
> > > > flow-control disabled.
> > > > 
> > > > Your issue seems to be that you've assumed since we now provide the
> > > > possibility of a "manual-rts" state, then the "default" state should
> > > > *only* be HW flow-control capable, which is not the case.
> > > 
> > > No my feedback was that it would be clearer & simpler to make manual-rts the
> > > 'default' state, and 'hw-flow-control' the optional state.
> > 
> > Absolutely not.  The use of "manual-rts" is the corner-case here and
> > is not normally required.
> 
> See below.
> 
> > The "default" state should normally be
> > populated with whatever pins are available i.e. all 4 pins (including
> > "rts, cts") if they are wired up and only 2 pins (just "tx, rx") if
> > they are not.
> 
> Yep OK, I agree :)

\o/

> > The submission of "manual-rts" is only required if the
> > RTS pin is required for some other purpose e.g. resetting a uC on a
> > draughtboard.
> 
> All UARTs the SoC have the same st-asc IP, which suffers from the same
> hw flow control limitation. Also all instances on the SoC have rts/cts
> pins, the only limitation is board wiring.
> 
> So I can't see why would you ever *not* want to deploy this dynamic pin
> switching solution if rts/cts is wired up at board level now the facility
> exists?

Mainly because it's surplus to requirement, in that there is very
seldom any point in manually toggling the RTS line (at least to my
knowledge).  I figure we'd add >1 Pinctrl states only when the need
arises, thus keeping the DTS' as simple as possible.

> Also regarding the naming of the second pin group, 'manual-rts' seems like
> a bad name as a logical extension of this set is to also offer the same
> dynamic switching for the CTS line.
> 
> Maybe a better name would be 'tx-rx-only' or 'no-rts-cts'.

Works for me.  Will fix.

> > > > It's the
> > > > 'uart-has-rtscts' property which determines this *not* whether the
> > > > second state has been provided.
> > > 
> > > Yep, which is why IMO it makes more sense for the optional pin group to be the hw
> > > flow control pins which are obtained if the uart-has-rtscts property is present.
> > 
> > There would normally only be one pin group.  Your method would insist
> > we always provided 2, which would be surplus to requirement.
> 
> Yep OK, agree with your point.

\o/

> Yep OK, I agree.

\o/

> Yep OK, I agree.

\o/

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
