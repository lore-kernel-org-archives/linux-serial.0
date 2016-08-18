From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 13:42:54 +0200
Message-ID: <20160818114254.GF7427@amd>
References: <20160818011445.22726-1-robh@kernel.org>
 <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
 <28DDAF2B-2341-403B-80D8-DA0A63F51FF1@holtmann.org>
 <20160818105521.GB7031@kroah.com>
 <6A3D5EFF-AC8B-4039-AFF8-652687EB8EDA@holtmann.org>
 <20160818112435.GA20876@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160818112435.GA20876-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi!

> > > I would _love_ to see that happen, but what about the GPS line
> > > discipline that we have today?  How would that match up with a char
> > > device driver?
> > 
> > we have a GPS line discipline? What is that one doing? As far as I
> > know all GPS implementations are fully userspace.
> 
> Hm, for some reason I thought that was what n_gsm.c was being used for,
> but I could be wrong, I've never seen the hardware that uses that
> code...

n_gsm.c seems to be multiplexing support. Splits one serial link into
multiple "virtual" serial links. Nothing to do with GPS explicitely,
altrough it looks NMEA data is going to go over one of the channels
sometimes.

I guess we should care about that later...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
