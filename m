From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH RFC 4/5] usb: cdc-acm: Enable serdev support
Date: Mon, 7 Jan 2019 16:02:38 +0100
Message-ID: <20190107150238.GB14782@localhost>
References: <20190104112131.14451-1-afaerber@suse.de>
 <20190104112131.14451-5-afaerber@suse.de>
 <1546868906.3037.37.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546868906.3037.37.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 07, 2019 at 02:48:26PM +0100, Oliver Neukum wrote:
> On Fr, 2019-01-04 at 12:21 +0100, Andreas Färber  wrote:
> > Switch from tty_port_register_device() to tty_port_register_device_serdev()
> > and from tty_unregister_device() to tty_port_unregister_device().
> > 
> > On removal of a serdev driver sometimes count mismatch warnings were seen:
> > 
> >   ttyACM ttyACM0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> >   ttyACM ttyACM0: tty_port_close_start: tty->count = 1 port count = 0
> > 
> > Note: The serdev drivers appear to probe asynchronously as soon as they
> > are registered. Should the USB quirks in probe be moved before registration?
> > No noticeable difference for the devices at hand.
> 
> That is quite drastic a change.
> Johan, how complete in terms of features is serdev?

serdev doesn't support hangups yet, and that's precisely why it's not
enabled for hotpluggable buses. That would need to be fixed before
accepting something like this.

Johan
