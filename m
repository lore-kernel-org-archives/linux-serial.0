Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56562C433E0
	for <linux-serial@archiver.kernel.org>; Sat, 13 Feb 2021 08:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2228164E23
	for <linux-serial@archiver.kernel.org>; Sat, 13 Feb 2021 08:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBMI1Y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 Feb 2021 03:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBMI1X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Feb 2021 03:27:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64A0164E12;
        Sat, 13 Feb 2021 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613204803;
        bh=Hx2lvOO3U9lYskzR0Wudu5H3Pog0MfYpZs0Ec1Ipnuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJGBRk7B5CmmdyjhBy8Ds4gW+j0vhYFeWuzjJmZ/wpBT4ROdtjJZhBWs7w9+NqCgh
         DkeSnaAU+Agk6wPBpl6ls/vGET9YgxvCrIFJCrTDUxQhghyv1DUL16N0Dao9tycGLl
         O+Ak5oHlV258P+ItDh5WGL5A9QDZzoXJFYhcwob4=
Date:   Sat, 13 Feb 2021 09:26:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] serial: 8250: Add new 8250-core based Broadcom
 STB driver
Message-ID: <YCeNQERg1wm34lDE@kroah.com>
References: <20210212195736.45328-1-alcooperx@gmail.com>
 <20210212195736.45328-3-alcooperx@gmail.com>
 <8cb4bae6-5617-8dd5-4c0f-4c81cb4d741b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cb4bae6-5617-8dd5-4c0f-4c81cb4d741b@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 12, 2021 at 12:47:02PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/12/2021 11:57 AM, Al Cooper wrote:
> > Add a UART driver for the new Broadcom 8250 based STB UART. The new
> > UART is backward compatible with the standard 8250, but has some
> > additional features. The new features include a high accuracy baud
> > rate clock system and DMA support.
> > 
> > The driver will use the new optional BAUD MUX clock to select the best
> > one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> > the baud rate selection logic for any requested baud rate.  This allows
> > for more accurate BAUD rates when high speed baud rates are selected.
> > 
> > The driver will use the new UART DMA hardware if the UART DMA registers
> > are specified in Device Tree "reg" property.
> > 
> > The driver also sets the UPSTAT_AUTOCTS flag when hardware flow control
> > is enabled. This flag is needed for UARTs that don't assert a CTS
> > changed interrupt when CTS changes and AFE (Hardware Flow Control) is
> > enabled.
> > 
> > The driver also contains a workaround for a bug in the Synopsis 8250
> > core. The problem is that at high baud rates, the RX partial FIFO
> > timeout interrupt can occur but there is no RX data (DR not set in
> > the LSR register). In this case the driver will not read the Receive
> > Buffer Register, which clears the interrupt, and the system will get
> > continuous UART interrupts until the next RX character arrives. The
> > fix originally suggested by Synopsis was to read the Receive Buffer
> > Register and discard the character when the DR bit in the LSR was
> > not set, to clear the interrupt. The problem was that occasionally
> > a character would arrive just after the DR bit check and a valid
> > character would be discarded. The fix that was added will clear
> > receive interrupts to stop the interrupt, deassert RTS to insure
> > that no new data can arrive, wait for 1.5 character times for the
> > sender to react to RTS and then check for data and either do a dummy
> > read or a valid read. Sysfs error counters were also added and were
> > used to help create test software that would cause the error condition.
> > The counters can be found at:
> > /sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
> > /sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char
> > 
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  MAINTAINERS                            |    8 +
> >  drivers/tty/serial/8250/8250_bcm7271.c | 1099 ++++++++++++++++++++++++
> >  drivers/tty/serial/8250/Kconfig        |   11 +
> >  drivers/tty/serial/8250/Makefile       |    1 +
> >  drivers/tty/serial/8250/bcm7271_uart.h |  158 ++++
> >  5 files changed, 1277 insertions(+)
> >  create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c
> >  create mode 100644 drivers/tty/serial/8250/bcm7271_uart.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 64c7169db617..bb6ad2fc4376 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3582,6 +3582,14 @@ S:	Supported
> >  F:	Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
> >  F:	drivers/i2c/busses/i2c-brcmstb.c
> >  
> > +BROADCOM BRCMSTB UART DRIVER
> > +M:	Al Cooper <alcooperx@gmail.com>
> > +L:	linux-usb@vger.kernel.org
> 
> This should probably be linux-serial, copy pasted from the USB entry
> down below presumably.

Yes, it should not be linux-usb, and that explains why these
serial-driver patches were cc:ed to that list :(

thanks,

greg k-h
