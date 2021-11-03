Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB4BC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  3 Nov 2021 07:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF72603E9
	for <linux-serial@archiver.kernel.org>; Wed,  3 Nov 2021 07:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhKCH0T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Nov 2021 03:26:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:33674 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKCH0T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Nov 2021 03:26:19 -0400
X-Greylist: delayed 48465 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Nov 2021 03:26:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635924219;
    s=strato-dkim-0002; d=mades.net;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=mgLDG833zDLeXeGtebw3f5XHKLLDcf03m74r2FIUXxg=;
    b=PzKmUVtZPQJz/zTKiLxk8HsvnYg8ZFq7ohayQCtyc+sga9PVjonDrXB/NydTAe6n1A
    AZNMb76/iRpiqKDbtQKYM8UcMPGrZSxyfyON6szJxvkDFE3yH+YVstwYpkktxtQJxSpU
    YgZ53Mshq5CouHep2rJg5hfD68RcdKEliKgjrkUbZZZtKabM9rlLxBIuvuOI2dy+qvwY
    ImsgOZFokgRlArzaEJFHUDSwTQAGSoaXfXpYP9BcGMIUNHabxLoW6Ceo8krkrfG1rzxp
    D7OfcXbGEfmGokFcN1vnGIsG7w5y7CngByRIu0jX0FCYb+EW8tQPC9LxoFfEL20Xslsq
    jhPg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JmMHfUWmW/JCZ5q3rSbjoqaGiJoG2nOuw/BEppjnAC9QlFFS7UbO3fgyYpMDJqZr"
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.34.1 AUTH)
    with ESMTPSA id f02274xA37Ndtbj
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 3 Nov 2021 08:23:39 +0100 (CET)
Date:   Wed, 3 Nov 2021 08:23:38 +0100 (CET)
From:   Jochen Mades <jochen@mades.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Message-ID: <527160377.1225435.1635924219001@webmail.strato.com>
In-Reply-To: <YYGKbfvFki8VN4HN@kroah.com>
References: <731e2516-9703-8c9a-7e56-e7e7b362de94@mades.net>
 <YYGKbfvFki8VN4HN@kroah.com>
Subject: Re: Extending serial port linux driver to toggle RS485 direction
 pin (GPIO)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev26
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

thanks for your fast reply. I checked the sources you mentioned below, that helps a bit..

Could you please give me some more background what you mean with your question:
> You could do much the same in the pl011_rs485_tx_start() function when
> SER_RS485_RX_DURING_TX and SER_RS485_RTS_ON_SEND are checked, right?

Is there already a concept for RS485 drivers? ...or where to find "pl011_rs485_tx_start()"?

Bests
Jochen


> On 02/11/2021 19:58 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>  
> On Tue, Nov 02, 2021 at 06:55:56PM +0100, Jochen wrote:
> > Hello,
> > 
> > I have a RS485 hardware shield connected to the hardware uart of a raspberry PI3, where you have to toggle the RS485 driver DIRECTION-pin from within your software during write-commands. The DIR-Pin is connected to a GPIO pin of the PI.
> > 
> > As I do not want to do that in every application software, I thought it could be a good idea to enhance the serial-port driver (locally on my PI) with that functionality. Looking to the sources of amba-pl011.c I thought the "pl011_write"-function could be the right place to do so....but to be honest it seems not to work
> > 
> > Could you please give me a hint where to do that best in the serial port driver? (or is there already a RS485 driver with configurable Dir-GPIO-pin).
> > Is there a documentation of the serial-port architecture available which could help me to solve my problem?
> 
> Other drivers do this today, using gpio pins for this.  One example is
> the drivers/tty/serial/ar933x_uart.c driver (look at the
> ar933x_uart_tx_chars() function)
> 
> You could do much the same in the pl011_rs485_tx_start() function when
> SER_RS485_RX_DURING_TX and SER_RS485_RTS_ON_SEND are checked, right?
> 
> As for making it "generic", I think there are other drivers that allow
> the gpio pins to be selected as part of their device tree, look in the
> drivers/tty/serial/ directory for the use of gpio values in lots of
> different drivers.
> 
> hope this helps,
> 
> greg k-h
