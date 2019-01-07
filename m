From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH RFC 4/5] usb: cdc-acm: Enable serdev support
Date: Mon, 07 Jan 2019 14:48:26 +0100
Message-ID: <1546868906.3037.37.camel@suse.com>
References: <20190104112131.14451-1-afaerber@suse.de>
         <20190104112131.14451-5-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104112131.14451-5-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fr, 2019-01-04 at 12:21 +0100, Andreas Färber  wrote:
> Switch from tty_port_register_device() to tty_port_register_device_serdev()
> and from tty_unregister_device() to tty_port_unregister_device().
> 
> On removal of a serdev driver sometimes count mismatch warnings were seen:
> 
>   ttyACM ttyACM0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
>   ttyACM ttyACM0: tty_port_close_start: tty->count = 1 port count = 0
> 
> Note: The serdev drivers appear to probe asynchronously as soon as they
> are registered. Should the USB quirks in probe be moved before registration?
> No noticeable difference for the devices at hand.

That is quite drastic a change.
Johan, how complete in terms of features is serdev?

Are you refering to CLEAR_HALT_CONDITIONS in terms of quirks?

	Regards
		Oliver
