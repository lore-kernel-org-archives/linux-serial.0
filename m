From: "Maarten Brock" <m.brock@vanmierlo.com>
Subject: Re: [PATCH] serial-uartlite: un-constify uartlite_be/uartlite_le
Date: Tue, 19 Apr 2016 09:51:43 +0200
Message-ID: <20160419095143.a28d59c0@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Korsgaard <jacmet@sunsite.dk>, Jiri Slaby <jslaby@suse.com>, Rich Felker <dalias@libc.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

----- Original Message -----
From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
To: Maarten Brock [mailto:m.brock@vanmierlo.com]
Cc: Arnd Bergmann [mailto:arnd@arndb.de], Peter Korsgaard [mailto:jacmet@sunsite.dk], Jiri Slaby [mailto:jslaby@suse.com], Rich Felker [mailto:dalias@libc.org], linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Sent: Tue, 19 Apr 2016 08:12:36 +0200
Subject: Re: [PATCH] serial-uartlite: un-constify uartlite_be/uartlite_le


> On Thu, Mar 10, 2016 at 10:08:01AM +0100, Maarten Brock wrote:
> > I've created a version 2 of this patch immediately which fixes the
> > warning, but somehow this stays ignored.
> > 
> > Please apply my second patch!
> 
> Sorry, it was too late, my fault.
> 
> greg k-h

Hello Greg,

Now that the original patch is reverted, can you apply my second version of the
patch which includes extra casts to suppress the warnings?

Maarten
