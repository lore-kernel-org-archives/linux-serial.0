From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Wed, 22 Jul 2015 17:01:43 +0200
Message-ID: <1437577303.5445.7.camel@suse.com>
References: <55AC1883.4050605@svenbrauch.de>
		 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>
		 <20150721091838.GG20628@localhost> <55AE7714.80306@hurleysoftware.com>
	 <1437554428.5445.0.camel@suse.com> <55AFA900.6040605@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AFA900.6040605@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Johan Hovold <johan@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, Sven Brauch <mail@svenbrauch.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2015-07-22 at 10:30 -0400, Peter Hurley wrote:
> 3. Pre-allocate space _before_ the data arrives (with
> tty_buffer_request_room());
>    this is applicable to subsystems which know how much data can be
> in-flight
>    at any one time. This guarantees that when rx data arrives buffer
> space is
>    available (since it has already been allocated).
> 
> Drivers that use method 2 typically attempt to recopy the buffered
> data
> when either new data arrives or @ unthrottle. I've seen others use
> deferred
> work as well.
> 
> AFAIK no driver/subsystem is using method 3 for guaranteed delivery
> of in-flight data, but it seems ideally suited to usb serial.

Indeed. But flow control is still done by throttle/unthrottle, isn't it?

	Regards
		Oliver
