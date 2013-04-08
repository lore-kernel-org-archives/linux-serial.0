From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: USB serial support / Prolific PL2303 Driver
Date: Mon, 8 Apr 2013 11:19:28 -0700
Message-ID: <20130408181928.GA7880@kroah.com>
References: <CAFyqS9rphU1ua=mzvQhWPRuqJDJHo79s5fq9ZF+oXMMcMXkUjA@mail.gmail.com>
 <20130408150351.GA13824@kroah.com>
 <1365433602.618685252@f30.mail.ru>
 <CAFyqS9oLTcc8dStUzF7XaLQYAQPK+VCsvuVkOmpW8g2rOjvv_Q@mail.gmail.com>
 <20130408160351.GB12665@kroah.com>
 <CAFyqS9qz+cHLY4zt1Bmuf6ubov57T3dKTP7B2d2g=ta=Qwg98g@mail.gmail.com>
 <20130408162945.GA26133@kroah.com>
 <5162FFF5.6040403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:53351 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935491Ab3DHSTw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Apr 2013 14:19:52 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so3376165pab.35
        for <linux-serial@vger.kernel.org>; Mon, 08 Apr 2013 11:19:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5162FFF5.6040403@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hans Beckerus <hans.beckerus@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org

On Mon, Apr 08, 2013 at 07:35:49PM +0200, Hans Beckerus wrote:
> >USB starts as one of the last things in the kernel boot process, so the
> >best you can ever get is a summary of what happened during the boot, not
> >the kernel boot messages as they happen because they happen before the
> >USB device is initialized.
> Sure. That is an acceptable limitation. However, I wonder if this
> will be different once we get U-Boot USB console support on this
> platform?
> Question though is if Linux  ever will be able to benefit from a
> first stage driver already being kicked-off by U-Boot.

For USB, no, that can't really happen, as the whole USB stack has to be
started up "from scratch" after u-boot starts Linux up.  There's no way
that Linux can take a "already discovered" usb stack and continue it's
usage.

Unless you possibly use Linux for your bootloader, and if so, in that
case, you don't need u-boot, and only do all device discovery once,
which is the ideal thing from a speed standpoint.

Good luck,

greg k-h
