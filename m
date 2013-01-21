From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/7] tty: of_serial: Add pinctrl support
Date: Mon, 21 Jan 2013 15:42:10 -0800
Message-ID: <20130121234210.GB9322@kroah.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
 <1358544639-14761-7-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdYNOTcTVNMqD-q8sJ50nuwoXZLUJZpMXWa=mrZGnGY9+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:40256 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab3AUXmO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jan 2013 18:42:14 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2913865dak.2
        for <linux-serial@vger.kernel.org>; Mon, 21 Jan 2013 15:42:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACRpkdYNOTcTVNMqD-q8sJ50nuwoXZLUJZpMXWa=mrZGnGY9+g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Stefan Roese <sr@denx.de>, Alejandro Mery <amery@geeks.cl>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 21, 2013 at 11:13:55PM +0100, Linus Walleij wrote:
> On Fri, Jan 18, 2013 at 10:30 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > Use pinctrl to configure the SoCs pins directly from the driver.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> You can poke Greg about this which is fun because it does become
> superfluous with the patch titled
> "[PATCH v4] drivers/pinctrl: grab default handles from device core"
> http://marc.info/?l=linux-kernel&m=135879594515932&w=2
> 
> Which will auto-grab the default state on any device.
> 
> Greg, can I have your ACK on that device core grab patch
> so you don't have to merge this patch but can point out that
> it solves the boilerplate problem?

Yes you now do.

greg k-h
