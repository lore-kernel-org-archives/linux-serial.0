From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Out of tree GPL serial tty driver help?
Date: Thu, 25 Apr 2013 17:41:11 -0400
Message-ID: <1366926071.3452.17.camel@thor.lan>
References: <51781A19.5030707@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:49345 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707Ab3DYVlS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Apr 2013 17:41:18 -0400
In-Reply-To: <51781A19.5030707@compro.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: markh@compro.net
Cc: linux-serial@vger.kernel.org, Mark Hounschell <dmarkh@cfl.rr.com>

On Wed, 2013-04-24 at 13:44 -0400, Mark Hounschell wrote:
> I've been sort of maintaining a couple of Digi International serial port 
> card (XP and AP) drivers for years now because, well, they just won't do 
> it anymore. In any case, I'm moving from a 3.4.x kernel, that works just 
> fine, to a 3.8.8 kernel, that does not. I have code that does something 
> like this:
>
>      tty_set_operations(&SerialDriver, &SerialOps);
>      tty_register_driver(&SerialDriver);
>      maxminor = NumBoards * 64;
>      for (i = 0; i < maxminor; i++)
>          tty_register_device(&SerialDriver, i, NULL);

You're correct in diagnosing the problem to cdevs == NULL.
You're missing:

	maxminor = min(num_boards * 64, 256);
	serial_driver = alloc_tty_driver(maxminor);

then,
	/* Fill in pertinent tty_driver fields, esp. */
	serial_driver->flags = TTY_DRIVER_DYNAMIC_DEV;

	tty_set_operations(serial_driver, &serial_ops);
	tty_register_driver(serial_driver);
	for (i = 0; i < maxminor; i++)
		tty_register_device(serial_driver, i, NULL);


Regards,
Peter Hurley

PS - Each board supports 64 individual serial ports??

