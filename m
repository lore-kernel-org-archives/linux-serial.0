From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kmscon: replacing CONFIG_VT
Date: Sat, 19 May 2012 12:55:49 +0100
Message-ID: <20120519125549.1cc105f8@pyramind.ukuu.org.uk>
References: <CANq1E4SGoRZaGjNZqPOA6g4COQmXxNr4kFBPMhxAonZqO_aOtQ@mail.gmail.com>
	<20120516171421.5fca49f3@pyramind.ukuu.org.uk>
	<CANq1E4SwyzLW61v-nrYu2gBvqbuzUNqTkK2cZzbv1ZZNBmWBBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:51472 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab2ESLw5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 19 May 2012 07:52:57 -0400
In-Reply-To: <CANq1E4SwyzLW61v-nrYu2gBvqbuzUNqTkK2cZzbv1ZZNBmWBBg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> So you are basically saying that such an drmcon driver isn't needed,
> anyway? If we keep backwards compatibility to CONFIG_VT, everyone who
> wants a boot-log on the display just needs to enable CONFIG_VT. Sounds
> reasonable.

For a lot of applications I think this will be true.

> > As far as compatibility goes we have the ttyprintk driver which just
> > provides a fake tty which types nothing and whose output goes to the
> > console.
> 
> I haven't found any applications that fail without /dev/tty, however,
> thanks for the hint.

There are quite a few, but ttyprintk means that if you've got a printk
console you've got a console "tty" at least for output. End of problem
therefore.

> Thanks for the answers. So I can concentrate on the user-space parts
> and maybe later implement some drmcon'ish driver.

I think so. And bear in mind a "drmcon'ish driver" for rescue could be a
shared library you can link the boot environment with, one that makes
minimal use of drm and /dev/input to implement a very basic vt.

Alan
