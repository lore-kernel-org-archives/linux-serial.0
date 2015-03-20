From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
Date: Fri, 20 Mar 2015 23:48:36 +0000
Message-ID: <20150320234836.1B6A3C407F7@trevor.secretlab.ca>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
	<1416872182-6440-4-git-send-email-cernekee@gmail.com>
	<54F4624D.6000909@hurleysoftware.com>
	<CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com>
	<54F48B03.5040205@hurleysoftware.com>
	<CAJiQ=7CKE5Nw=maewN_ChkySh1NReoUnddLO_ohOJQfwo_FXAg@mail.gmail.com>
	<54F4A1B6.8030701@hurleysoftware.com>
	<CAJiQ=7CDAifvcMkrAsseXHHC_GGMJg-+UiWVY03JAzDqSFzi+g@mail.gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJiQ=7CDAifvcMkrAsseXHHC_GGMJg-+UiWVY03JAzDqSFzi+g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 2 Mar 2015 10:57:41 -0800
, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 wrote:
> On Mon, Mar 2, 2015 at 9:45 AM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
> >> This doesn't change the behavior of pre-existing drivers that
> >> implement the *-endian properties in a different way.  There are not
> >> many of these drivers and they can be documented as special cases.
> >
> > Yeah, ok, as long as there's no expectation that existing drivers
> > meet this criteria when they add big-endian support.
> 
> The intention is to make it easy for existing drivers with LE register
> accesses (i.e. mostly drivers taken from an x86 + PCI environment) to
> work on systems with native to BE register accesses.  8250 and USB are
> the first two examples of this.

I think the right solution here is to drop any specified default in the
common properties binding and replace with something like, "If a binding
supports these properties, then that binding should also specify the
default if none of these properties are present. In such cases,
little-endian is the preferred default, but it is not a requirement"

g.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
