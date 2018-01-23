From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serdev: add method to set parity
Date: Tue, 23 Jan 2018 08:00:00 +0100
Message-ID: <20180123070000.GA15220@kroah.com>
References: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <33F02495-73E7-47A6-B10B-FA6940F6DE63@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33F02495-73E7-47A6-B10B-FA6940F6DE63@holtmann.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Rob Herring <robh@kernel.org>, linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, geert@linux-m68k.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 22, 2018 at 07:23:00PM +0100, Marcel Holtmann wrote:
> Hi Rob,
> 
> > Adds serdev_device_set_parity() and an implementation for ttyport.
> > The interface uses an enum with the values SERIAL_PARITY_NONE,
> > SERIAL_PARITY_EVEN and SERIAL_PARITY_ODD.
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> > 
> > Hi!
> > 
> > This revision addresses Johan's comments (see below for details) and adds
> > Sebastian's Reviewed-by tag. Thank you for your reviews!
> > 
> > CU
> > Uli
> > 
> > 
> > Changes since v1:
> > - added Reviewed-by tag
> > - expanded commit message
> > - shuffled stuff around to keep line-setting bits together
> > - clear CMSPAR
> > - (hopefully) detect errors correctly by checking tty->termios after call
> >  to tty_set_termios().
> > 
> > 
> > drivers/tty/serdev/core.c           | 12 ++++++++++++
> > drivers/tty/serdev/serdev-ttyport.c | 24 ++++++++++++++++++++++++
> > include/linux/serdev.h              | 10 ++++++++++
> > 3 files changed, 46 insertions(+)
> 
> if there are no objections, I would like to just take this through bluetooth-next tree.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
