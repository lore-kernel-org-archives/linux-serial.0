Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F478C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 06:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FDE61AA5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 06:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhKPGrK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 01:47:10 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:21997 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhKPGq6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 01:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637045032;
    s=strato-dkim-0002; d=mades.net;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8B5DY2j1s39vyQyBLLK/NOLgoTJncuIIPjS5zaN+ujw=;
    b=XmVTWOc9OIpU2ZRiv+8+abMsNHbmw/EQG5qPECrPXyhTX09TXN6LH73KEbO47TXB0t
    7T5S1C4FQbhi5YDuD1kWYxqpQ9kGQC5sl8er/opINCqcwvJf36Ri9nO1/gNq++/iT+wr
    ItD06xEsHjfBPKtgaUl+7RLV8mNn8aMrmMObpvUOQ0pLbnaGuLSOtF+SzKqmxeQNcdZa
    21SfNmqSB0GVxVxf3fqzGGOvMZTRzyDNzDRyu191MW/o+JErJVnw+XFlQ18Ff2i/nVjB
    8qKA8XjQYl5xOz2tdTMP9Pf3eaSzmDSX3P6FwuUP9v4+/3IFxaWb+VnCbiO2C3HeuQ24
    UEEQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JmMHfUWmW/JCZ5q3rSbjoqaGiJoG2nOuw/BEppjnAC9QlFFS7UbO3fgyYpMDJqZr"
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.34.5 AUTH)
    with ESMTPSA id K04312xAG6hqTtV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 16 Nov 2021 07:43:52 +0100 (CET)
Date:   Tue, 16 Nov 2021 07:43:52 +0100 (CET)
From:   Jochen Mades <jochen@mades.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "sistik@3ksolutions.sk" <sistik@3ksolutions.sk>
Cc:     linux-serial@vger.kernel.org
Message-ID: <236176398.157022.1637045032216@webmail.strato.com>
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
X-Mailer: Open-Xchange Mailer v7.10.5-Rev27
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg, Hi Ivan,

as would like to extend the RS485 behavior on my raspberry PI I did some "deep-diving" into the amba-pl011 driver and soon recognized the missing hardware support to detect "FIFO empty". Googling around I found the following patch, describing exactly my problem:
https://lore.kernel.org/linux-arm-kernel/20200107072831.GB1014453@kroah.com/T/

As I'm not familiar with your processes, I kindly ask you where I can find the patched sources of this Soft-Rs485-Amba driver and if it is planned to be intergrated in a future kernel release?

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
