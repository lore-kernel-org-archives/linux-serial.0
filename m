From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial-uartlite: un-constify uartlite_be/uartlite_le
Date: Tue, 19 Apr 2016 15:12:36 +0900
Message-ID: <20160419061236.GA11703@kroah.com>
References: <20160310100801.37d49aba@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160310100801.37d49aba@kerio.vanmierlo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Brock <m.brock@vanmierlo.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Korsgaard <jacmet@sunsite.dk>, Jiri Slaby <jslaby@suse.com>, Rich Felker <dalias@libc.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 10, 2016 at 10:08:01AM +0100, Maarten Brock wrote:
> I've created a version 2 of this patch immediately which fixes the warning,
> but somehow this stays ignored.
> 
> Please apply my second patch!

Sorry, it was too late, my fault.

greg k-h
