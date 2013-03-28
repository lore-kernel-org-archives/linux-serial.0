From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_dw: add support for clk api
Date: Thu, 28 Mar 2013 16:09:23 -0700
Message-ID: <20130328230923.GA14536@kroah.com>
References: <1364387748-13015-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130328230342.GA24556@kroah.com>
 <5154CD0C.60901@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5154CD0C.60901@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 29, 2013 at 12:06:52AM +0100, Maxime Ripard wrote:
> Hi Greg,
>=20
> Le 29/03/2013 00:03, Greg Kroah-Hartman a =E9crit :
> > On Wed, Mar 27, 2013 at 01:35:48PM +0100, Maxime Ripard wrote:
> >> From: Emilio L=F3pez <emilio@elopez.com.ar>
> >>
> >> This commit implements support for using the clk api; this lets us=
 use
> >> the "clocks" property with device tree, instead of having to use
> >> clock-frequency.
> >>
> >> Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>
> >> ---
> >=20
> > Why aren't you signing off on this patch as well?
>=20
> Hmm, I forgot to do so, and no one pointed that one before. Sorry.
>=20
> Do you want me to resend it with my SoB?

Yes, please do.

thanks,

greg k-h
