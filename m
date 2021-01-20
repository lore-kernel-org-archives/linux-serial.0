Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6887BC433E6
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B0522CE3
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 17:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbhATRG6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:06:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391751AbhATRF7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jan 2021 12:05:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8BCD2137B;
        Wed, 20 Jan 2021 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611162310;
        bh=WtZFfFv8GO9q/O1gGxEeXgX0Wj/VD7wZE2sc6QJ27o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPkkOWw/X0F+3FvGsBJreKu0ARlTqj2ae5kmYBGEHJsL0wFLXH/ry8cs1XUhspE1K
         XWE2Af1UCMcHpVyt6q9crwhI3ePHzZ0Vj4bCUAxRaDHQSvUsEnbm4OoyEt3WbhSM1z
         N0IxR5YOojYYYqiuWotYnZSTFPYMI3RK75JLodGk=
Date:   Wed, 20 Jan 2021 18:05:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom
 STB driver
Message-ID: <YAhiw+6UiUplNcLq@kroah.com>
References: <20210115211543.33563-1-alcooperx@gmail.com>
 <20210115211543.33563-3-alcooperx@gmail.com>
 <CAHp75VdQPQK8jTF3QDKx6mF1QzOg-qiuHrTiojnWn7GskokfoA@mail.gmail.com>
 <71d58a3e-2707-69d7-8074-c67235912e06@gmail.com>
 <CAHp75VfNumFBwbytCuA_YK1w-+kN20vRF+GhogtU+DDG3EB_7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfNumFBwbytCuA_YK1w-+kN20vRF+GhogtU+DDG3EB_7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jan 20, 2021 at 06:47:52PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 19, 2021 at 8:16 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > On 1/19/2021 7:21 AM, Andy Shevchenko wrote:
> > > On Fri, Jan 15, 2021 at 11:19 PM Al Cooper <alcooperx@gmail.com> wrote:
> > >>
> > >> Add a UART driver for the new Broadcom 8250 based STB UART. The new
> > >> UART is backward compatible with the standard 8250, but has some
> > >> additional features. The new features include a high accuracy baud
> > >> rate clock system and DMA support.
> > >>
> > >> The driver will use the new optional BAUD MUX clock to select the best
> > >> one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> > >> the baud rate selection logic for any requested baud rate.  This allows
> > >> for more accurate BAUD rates when high speed baud rates are selected.
> > >>
> > >> The driver will use the new UART DMA hardware if the UART DMA registers
> > >> are specified in Device Tree "reg" property. The DMA functionality can
> > >> be disabled on kernel boot with the argument:
> > >> "8250_bcm7271.disable_dma=Y".
> > >>
> > >> The driver also set the UPSTAT_AUTOCTS flag when hardware flow control
> > >> is enabled. This flag is needed for UARTs that don't assert a CTS
> > >> changed interrupt when CTS changes and AFE (Hardware Flow Control) is
> > >> enabled.
> > >>
> > >> The driver also contains a workaround for a bug in the Synopsis 8250
> > >> core. The problem is that at high baud rates, the RX partial FIFO
> > >> timeout interrupt can occur but there is no RX data (DR not set in
> > >> the LSR register). In this case the driver will not read the Receive
> > >> Buffer Register, which clears the interrupt, and the system will get
> > >> continuous UART interrupts until the next RX character arrives. The
> > >> fix originally suggested by Synopsis was to read the Receive Buffer
> > >> Register and discard the character when the DR bit in the LSR was
> > >> not set, to clear the interrupt. The problem was that occasionally
> > >> a character would arrive just after the DR bit check and a valid
> > >> character would be discarded. The fix that was added will clear
> > >> receive interrupts to stop the interrupt, deassert RTS to insure
> > >> that no new data can arrive, wait for 1.5 character times for the
> > >> sender to react to RTS and then check for data and either do a dummy
> > >> read or a valid read. Sysfs error counters were also added and were
> > >> used to help create test software that would cause the error condition.
> > >> The counters can be found at:
> > >> /sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
> > >> /sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char
> > >
> > > Brief looking into the code raises several questions:
> > >  - is it driver from the last decade?
> >
> > Work on this driver started back in 2018, that was indeed the last decade.
> >
> > >  - why it's not using what kernel provides?
> > >  - we have a lot of nice helpers:
> > >    - DMA Engine API
> >
> > Not sure this makes sense, given that the DMA hardware that was added to
> > this UART block is only used by the UART block and no other pieces of HW
> > in the system, nor will they ever be. Not sure it makes sense to pay the
> > cost of an extra indirection and subsystem unless there are at least two
> > consumers of that DMA hardware to warrant modeling it after a dmaengine
> > driver. I also remember that Al researched before whether 8250_dma.c
> > could work, and came to the conclusion that it would not, but I will let
> > him comment on the specifics.
> 
> I see. In any case I still believe that the driver can be shrinked by
> a notable amount of lines.

Patches always gladly accepted :)
