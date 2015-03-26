From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 3/4] sc16is7xx: expose RTS inversion in RS-485 mode
Date: Thu, 26 Mar 2015 22:37:01 +0100
Message-ID: <20150326213701.GA29278@kroah.com>
References: <1426548529-21738-1-git-send-email-moorray3@wp.pl>
 <1426548529-21738-4-git-send-email-moorray3@wp.pl>
 <alpine.DEB.2.10.1503171043400.3566@jring-w510-7m3g.gridpoint.com>
 <20150317155700.71a4ad1b@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150317155700.71a4ad1b@north>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Cc: Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>, "Ringle, Jonathan" <Jonathan.Ringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Karol =?utf-8?B?RMSZYm9nw7Nyc2tp?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 17, 2015 at 03:57:00PM +0100, Jakub Kici=C5=84ski wrote:
> On Tue, 17 Mar 2015 10:45:26 -0400 (EDT), Jon Ringle wrote:
> > This makes sense. I did have to fix up my user space app to set=20
> > SER_RS485_RTS_ON_SEND after applying this patch.
>=20
> Yes, perhaps I should have mentioned that this makes the ioctl return
> -EINVAL when neither of SER_RS485_RTS_*_SEND flags is set.  This
> definitely has potential to break people's apps.  Let's see if anyone
> else has an opinion on this.

Yes, don't break people's apps.

I can't take this, sorry.

greg k-h
