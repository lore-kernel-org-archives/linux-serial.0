From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 12:57:59 +0200
Message-ID: <20160818105759.GA642@kroah.com>
References: <20160818011445.22726-1-robh@kernel.org>
 <118926C8-F4D0-41F5-B6A8-690E0312F3FB@goldelico.com>
 <20160818104749.GB7427@amd>
 <1ED14975-FC0C-44AB-8F05-782DBC9E98F8@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1ED14975-FC0C-44AB-8F05-782DBC9E98F8@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 18, 2016 at 12:54:15PM +0200, H. Nikolaus Schaller wrote:
> Hi Pavel,
> 
> > Am 18.08.2016 um 12:47 schrieb Pavel Machek <pavel@ucw.cz>:
> > 
> > 
> >> 
> >> Thereof 4 files, ~260 changes w/o gps demo and documentation/bindings.
> > 
> > So what do you use for the serial devices? platform_device was vetoed
> > for that purpose by Greg.
> 
> device tree?

No.

This patchset from Rob is the way I have been saying it should be done
for years now.  Yes, a "bus" takes up more boilerplate code (blame me
for that), but overall, it makes the drivers simpler, and fits into the
rest of the kernel driver/device model much better.

greg k-h
