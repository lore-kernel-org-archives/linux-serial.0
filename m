From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 4/9] tty: constify tty_ldisc_receive_buf buffer pointer
Date: Thu, 19 Jan 2017 17:24:03 +0100
Message-ID: <20170119162403.GA22571@kroah.com>
References: <20170116225436.17505-1-robh@kernel.org>
 <20170116225436.17505-5-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170116225436.17505-5-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 16, 2017 at 04:54:31PM -0600, Rob Herring wrote:
> This is needed to work with the client operations which uses const ptrs.
> 
> Really, the flags pointer could be const, too, but this would be a tree
> wide fix.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-By: Sebastian Reichel <sre@kernel.org>

I've applied the first 4 patches in this series to my tree now, thanks.

greg k-h
