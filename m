From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: RS485: RTS pin logical level before/after sending
Date: Tue, 23 Sep 2014 09:56:12 +0200
Message-ID: <CAGm1_kviHeZZ71Bk+rRN8G_G-hgZYqZdZjtVjFZuSbwhaW8Hvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40164 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbaIWH4d (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Sep 2014 03:56:33 -0400
Received: by mail-pa0-f43.google.com with SMTP id kx10so6110927pab.30
        for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2014 00:56:32 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

What's the purpose of being able to define both states? AFAIK
omap_serial.c is working as follows:

        if (of_property_read_bool(np, "rs485-rts-active-high"))
                rs485conf->flags |= SER_RS485_RTS_ON_SEND;
        else
                rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;

If RTS should be on before send, then it automatically selects RTS off
for after send scenario. Are there systems, that would really set
levels for both cases to the same value? Is this intended for RS422
case, where transmitter can be always on?

Regards,
Yegor
