From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 2/3] tty: serial_core: make tty_struct optional
Date: Thu, 18 Aug 2016 12:50:38 +0200
Message-ID: <20160818105038.GC7427@amd>
References: <20160818011445.22726-1-robh@kernel.org>
 <20160818011445.22726-3-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160818011445.22726-3-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed 2016-08-17 20:14:44, Rob Herring wrote:
> In order to allow serial drivers to work without a tty, make calls from
> drivers and serial_core work when tty_struct is NULL.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
