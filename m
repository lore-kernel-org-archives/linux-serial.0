Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4EBC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 19:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE60C61151
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 19:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhJOTT7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:19:59 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36928 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJOTT7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 15:19:59 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Oct 2021 15:19:58 EDT
Date:   Fri, 15 Oct 2021 22:10:00 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 055608030802
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Johan Hovold <johan@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: 8250: fix racy uartclk update
Message-ID: <20211015191000.hspyxgkwwd47w4nl@mobilestation>
References: <20211015111422.1027-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211015111422.1027-1-johan@kernel.org>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 15, 2021 at 01:14:19PM +0200, Johan Hovold wrote:
> Here's a fix for the asynchronous uartclk-update hack which was added
> last year and a couple of related clean ups.

Yeah, that was very unfortunate patchset. Thank you very much for the fix.
I'll test it out tomorrow.

-Sergey

> 
> Johan
> 
> 
> Johan Hovold (3):
>   serial: 8250: fix racy uartclk update
>   serial: 8250: rename unlock labels
>   serial: 8250_dw: drop bogus uartclk optimisation
> 
>  drivers/tty/serial/8250/8250_dw.c   | 11 ++++------
>  drivers/tty/serial/8250/8250_port.c | 31 ++++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 16 deletions(-)
> 
> -- 
> 2.32.0
> 
