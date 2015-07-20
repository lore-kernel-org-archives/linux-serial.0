From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Mon, 20 Jul 2015 19:25:46 +0200
Message-ID: <20150720172546.GF20628@localhost>
References: <55AC1883.4050605@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55AC1883.4050605@svenbrauch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Brauch <mail@svenbrauch.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>, Peter Hurley <peter@hurleysoftware.com>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[ +CC: Alan, Oliver, Peter, Toby, linux-serial, linux-usb ]

On Sun, Jul 19, 2015 at 11:37:07PM +0200, Sven Brauch wrote:
> Since acm_process_read_urb does not check the return value
> of tty_insert_flip_string, it can happen that not all data
> is copied from the urb to the tty if the tty buffer
> is full and throttling does not set in quickly enough. This
> problem is very evident for devices with high data throughput;
> for a device with ~12 MB/s of data transfer, I get a few
> missing kB of data every few MB transferred randomly.

What kernel version are you using?

> To solve this problem, a check is introduced which verifies
> that indeed all data was copied from the urb to the tty buffer.
> If that is not the case, the urb is held in a queue instead
> of resubmitting it to the USB subsystem right away. When new
> data arrives or the tty is unthrottled, the queue is emptied
> again (as far as possible).
> 
> Effectively, this change will force the transmitting USB device
> to wait until the tty buffer can accept new data again, instead
> of discarding the data in this case.

The idea of adding another layer of buffering in the cdc-acm driver has
been suggested in the past but was rejected (or at least questioned).
See for example this thread:

	https://lkml.kernel.org/r/20110608164626.22bc893c@lxorguk.ukuu.org.uk

The tty buffers are quite large these days, but could possibly be bumped
further if needed to give the ldisc some more time to throttle the
device at very high speeds.

Johan
