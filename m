From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial-uartlite: un-constify uartlite_be/uartlite_le
Date: Tue, 19 Apr 2016 17:33:22 +0900
Message-ID: <20160419083322.GA18866@kroah.com>
References: <20160419095143.a28d59c0@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160419095143.a28d59c0@kerio.vanmierlo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Brock <m.brock@vanmierlo.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Korsgaard <jacmet@sunsite.dk>, Jiri Slaby <jslaby@suse.com>, Rich Felker <dalias@libc.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 19, 2016 at 09:51:43AM +0200, Maarten Brock wrote:
> ----- Original Message -----
> From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> To: Maarten Brock [mailto:m.brock@vanmierlo.com]
> Cc: Arnd Bergmann [mailto:arnd@arndb.de], Peter Korsgaard [mailto:jacmet@sunsite.dk], Jiri Slaby [mailto:jslaby@suse.com], Rich Felker [mailto:dalias@libc.org], linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
> Sent: Tue, 19 Apr 2016 08:12:36 +0200
> Subject: Re: [PATCH] serial-uartlite: un-constify uartlite_be/uartlite_le
> 
> 
> > On Thu, Mar 10, 2016 at 10:08:01AM +0100, Maarten Brock wrote:
> > > I've created a version 2 of this patch immediately which fixes the
> > > warning, but somehow this stays ignored.
> > > 
> > > Please apply my second patch!
> > 
> > Sorry, it was too late, my fault.
> > 
> > greg k-h
> 
> Hello Greg,
> 
> Now that the original patch is reverted, can you apply my second version of the
> patch which includes extra casts to suppress the warnings?

Can you please resend it?  I don't see it in my queue :(
