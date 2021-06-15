Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B14C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 12:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31B861441
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 12:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhFOMJQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 08:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhFOMJP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 08:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B67CC61437;
        Tue, 15 Jun 2021 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623758831;
        bh=06ztI+MTLaXy1iv82xOZiQE88Vi8ZQzLJLj4x4b5etQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXKvwelSaU9vMTvzZjdjKHMSdeSuz6nQp56HRHJIdpj7cpkU6HAfBNVj6qt9w/+h2
         LAvJNd/82DooX5hr+TR9vvbKyJgr/V/DdIpZtJ6JehJQj5pPcIhiw6rSG8QzlgkUL5
         bXm6uVO0WVSo9nXmXT+3rXzFQpHtKwNo8TYXrTkM=
Date:   Tue, 15 Jun 2021 14:07:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] serial: 8250: Fixes for Oxford Semiconductor 950
 UARTs
Message-ID: <YMiX7LAEtL0uQuVl@kroah.com>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 10, 2021 at 08:38:55PM +0200, Maciej W. Rozycki wrote:
> Hi,
> 
>  In the course of verifying support for SMSC FDC37M817 Super I/O chip's 
> data rate of 460800bps with an EXSYS EX-44072 option card based on the 
> Oxford Semiconductor OXPCIe952 device I have observed the inability to 
> transfer any data correctly at this rate between the two devices.  Lower 
> rates, including 230400bps, appeared to work correctly, also with other 
> kinds of serial ports referred to with my previous patch series, which 
> strongly indicated something being wrong with the Oxford device.
> 
>  In the end I have tracked the issue down to our baud base set to 4000000 
> for the device being off by 2.4%.  Enough for an incorrect divisor value 
> of 9 to be chosen to yield the bit rate of 460800bps being particularly 
> inaccurate for the baud base selected and caused the actual rate of 
> 434027.78bps of being used, -5.8% off.  Consequently the ten bits of data 
> sent with every 8-bit character were enough for the drift to accumulate up 
> to the two ends to get out of sync, with the stop bit interpreted as bit 7 
> of data.  Obviously whoever wrote this code never actually tried higher 
> data rates, or only connected Oxford devices to each other causing the 
> systematic errors at both ends to cancel each other.
> 
>  With the baud base corrected to the chip's default of 3906250 for the 650 
> mode which we use (the reset default for the initial 450 mode is 115314, 
> approximated for maximum backwards compatibility with legacy OS drivers by 
> dividing the device's 62.5MHz clock by 33.875), the new calculated divisor 
> value and the new actual bit rate became 8 and 488281.25bps respectively.  
> Now +5.96% off, so the stop bit could be missed causing data corruption 
> with continuous data streams, but at least that could be worked around by 
> using two stop bits instead.  Not a good solution though.
> 
>  So I chose to implement proper clock handling for the chip.  The bit rate 
> with this device is worked out from the 62.5MHz clock first by choosing an 
> oversampling rate between 4 and 16 inclusive, then by the clock prescaler 
> between 1 and 63.875 in increments of 0.125, and finally a 16-bit unsigned 
> divisor, all of which divide the input clock by the respective value.
> 
>  By choosing the right values of these three parameters either exact or 
> highly-accurate actual bit rates can be programmed for standard and many 
> non-standard rates from 1bps up to 15625000bps, e.g. for the data rate of 
> 460800bps concerned here I was able to get the accuracy of 0.0064% by 
> choosing the values of 7, 3.875, and 5 respectively for the oversampling 
> rate, the clock prescaler, and the clock divisor.
> 
>  Additionally even with my considerably mighty POWER9 box I have observed 
> frequent input overruns with the bit rates of 460800bps and higher, and I 
> have noticed we have the receive interrupt trigger level set particularly 
> high in terms of FIFO usage percentage for 16C950 UARTs and then we don't 
> make the levels configurable.  Lowering the default to a saner value made
> the overruns go away altogether for rates below 921600bps.  As I've only 
> verified these changes in terminal environment rather than with modems I 
> could not make use of hardware flow control which this chip supports and 
> which I presume would prevent overruns from happening even with higher bit 
> rates.
> 
>  There's more that could be done here, for example we don't make use of 
> the 950 mode where FIFO trigger levels can be fine-tuned in increments of 
> 1, which, interestingly, could help with the lower rate modes as reception 
> is quite choppy with them, owing to the minimum receive interrupt trigger 
> level of 16 in the 650 mode.  I gave the 950 mode a try, but it made the 
> chip freeze frequently until new data was received, so clearly I must have 
> missed something in the chip's configuration, which I did not investigate.  
> Something for a different time perhaps then.
> 
>  I have verified these changes for standard termios rates between 300bps 
> and 460800bps with my WTI CPM-800 site manager device and my Malta board's 
> serial ports, as suitable, all working flawlessly in terminal mode now.  
> I have verified standard termios rates between 500000bps and 4000000bps as 
> well, however for the lack of other high-speed hardware with a pair of 
> Oxford devices only.  Except for input overruns noted above and growing in 
> numbers as the rate increased rates of up to 3500000bps worked flawlessly.  
> In particular the rate of 576000bps, still without input overruns, gave 
> this nice feeling as if working with a virtual terminal rather than over a 
> serial line!
> 
>  Conversely the rate of 4000000bps showed significant data corruption, 
> happening randomly, i.e. some characters went through just fine, while 
> other ones became garbled in no particular pattern, unlike with the rate 
> inaccuracy described above.  Also with no input overruns whatsoever.  I 
> have double-checked that all the three parameters making up the bit rate 
> from the clock rate have been programmed correctly.
> 
>  Therefore I have concluded this is not an issue with my change (or indeed 
> any other part the driver) and it is simply that the rate has exceeded 
> either the maximum frequency the EX-44072 board's serial transceivers 
> support (I haven't checked the chip types used and I can't persuade myself 
> to disassemble the system just to have a look at the board again), or the 
> bandwidth of the transmission line used (a flat 8-core telephone cable of 
> a standard Cisco console cable assembly).  Not an issue to be addressed in 
> software and I find it rather astonishing anyway it worked so well for up 
> to 3.5MHz already!
> 
>  I have no modems, so I couldn't verify DCE interoperation, but I don't 
> expect issues with the bit rates being more accurate now, or the default 
> FIFO receiver trigger level tweaked to be more conservative.
> 
>  Finally the 16-bit UART_DIV_MAX limitation of the baud rate requested 
> with `serial8250_get_baud_rate' makes the standard rates of 200bps and 
> lower inaccessible in the regular way with the baud base of 15625000.  
> That could be avoided by tweaking our 8250 driver core appropriately, but 
> I have figured out with modern serial port usage that would not be the 
> best use of my time.  Someone who does have a real need to use an Oxford 
> device at these low rates can step in and make the necessary chances.
> 
>  Meanwhile I took advantage of the ancient spd_cust feature we thankfully 
> continue supporting and actually did verify not only the standard rates 
> between 50bps and 200bps, but the rates of 4bps and 2bps as well, using my 
> old x86 server's serial port with the baud base of 115200.  That was, 
> ahem, an interesting experience both by itself and also with 2bps, which 
> revealed a phenomenon with SMSC Super I/O ports not working as documented 
> (already noted in the preceding patch series).  Eventually I verified the 
> 2bps rate with a plain ISA multi I/O card and its 16450 UART my EISA 486 
> box has as the remote console, which does support the divisor value of 
> 57600 required.
> 
>  See individual change descriptions for further details including figures.
> 
>  Please apply.

This patch series causes the following build warning to be added:

drivers/tty/serial/8250/8250_pci.c: In function ‘pci_oxsemi_tornado_setup’:
drivers/tty/serial/8250/8250_pci.c:1258:32: warning: unsigned conversion from ‘int’ to ‘unsigned char’ changes value from ‘-129’ to ‘127’ [-Woverflow]
 1258 |                 up->mcr_mask = ~UART_MCR_CLKSEL;
      |                                ^


Can you fix this up and resend?

thanks,

greg k-h
