From: Mattias Wallin <mattias.ml.wallin@gmail.com>
Subject: Support for rs485 in 8250_dw
Date: Tue, 2 Sep 2014 15:08:07 +0200
Message-ID: <CABZax46GOhk+pe6bYbPTg2QjzT83=Yihf4JoEDUFNU14ptqpFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f194.google.com ([209.85.223.194]:53788 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbaIBNII (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 09:08:08 -0400
Received: by mail-ie0-f194.google.com with SMTP id rl12so2283471iec.1
        for <linux-serial@vger.kernel.org>; Tue, 02 Sep 2014 06:08:07 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,
I would like to add rs485 support to the Synopsys DesignWare uart,
8250_dw.c but need help on how this should be done.

rs485 background:
Simplified rs485 is a half duplex standard where the RTS signal needs
to be high during the whole transmit and low during receive. The Atmel
AT91 for example have a rs485 mode where the hardware handles the RTS
signal automatically. Most other uart controllers don't have this mode
feature so toggling RTS needs to be done manually or
semi-automatically from the driver.

problem:
To toggle RTS i would like to implement code in ops->start_tx and
possibly ops->startup or ops->stop_tx. I also need to implement a
ioctl callback to configure the rs485 part. These ops are not
available in 8250_dw.c but in the framework 8250_core.c (except for
ioctl). So should I add the rs485 support to the 8250 framework or
should I export callbacks and implement the functionality in the
8250_dw.c? Any suggestions?

BR,
Mattias Wallin
