Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A76C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 18:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6353560F36
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 18:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhKBTBb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 15:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhKBTBb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 15:01:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D06816008E;
        Tue,  2 Nov 2021 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635879536;
        bh=RrrDLEf8oJzZORYkXzS8DRbSEYthUuWaSc6mbtmKIAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuKeutkzPaN4vLj6Fa5vBMbCY+VWLQLg1IlO2oXnB7T1oz/2fRY9epI1MLcSU2OBw
         hf48JhtEYaotYt9po22yvBehkVDPjb76/b4iT1C1k56abzndmD+pj169oJf6eQy7AB
         hqFMpikKE8ZUIjxhYAjT0Ckt7mMgjAmnqsNxkBrM=
Date:   Tue, 2 Nov 2021 19:58:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jochen <jochen@mades.net>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Extending serial port linux driver to toggle RS485 direction pin
 (GPIO)
Message-ID: <YYGKbfvFki8VN4HN@kroah.com>
References: <731e2516-9703-8c9a-7e56-e7e7b362de94@mades.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731e2516-9703-8c9a-7e56-e7e7b362de94@mades.net>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 02, 2021 at 06:55:56PM +0100, Jochen wrote:
> Hello,
> 
> I have a RS485 hardware shield connected to the hardware uart of a raspberry PI3, where you have to toggle the RS485 driver DIRECTION-pin from within your software during write-commands. The DIR-Pin is connected to a GPIO pin of the PI.
> 
> As I do not want to do that in every application software, I thought it could be a good idea to enhance the serial-port driver (locally on my PI) with that functionality. Looking to the sources of amba-pl011.c I thought the "pl011_write"-function could be the right place to do so....but to be honest it seems not to work
> 
> Could you please give me a hint where to do that best in the serial port driver? (or is there already a RS485 driver with configurable Dir-GPIO-pin).
> Is there a documentation of the serial-port architecture available which could help me to solve my problem?

Other drivers do this today, using gpio pins for this.  One example is
the drivers/tty/serial/ar933x_uart.c driver (look at the
ar933x_uart_tx_chars() function)

You could do much the same in the pl011_rs485_tx_start() function when
SER_RS485_RX_DURING_TX and SER_RS485_RTS_ON_SEND are checked, right?

As for making it "generic", I think there are other drivers that allow
the gpio pins to be selected as part of their device tree, look in the
drivers/tty/serial/ directory for the use of gpio values in lots of
different drivers.

hope this helps,

greg k-h
