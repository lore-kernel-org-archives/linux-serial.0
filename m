From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH v3] Add support for new devices: Exar's XR17V35x family of
 multi-port PCIe UARTs
Date: Sun, 18 Nov 2012 22:33:33 -0600
Message-ID: <CAJp1Oe6GG34JKaDus9pc8Geo14Wros6S1mmYbAv_oWQQKt7GSQ@mail.gmail.com>
References: <CAJp1Oe4Xh6SDQc43hue5qanm7G5Lw9vMdv-+5nRQ_S+RPpRALQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57719 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab2KSEdz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Nov 2012 23:33:55 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so757237vcm.19
        for <linux-serial@vger.kernel.org>; Sun, 18 Nov 2012 20:33:54 -0800 (PST)
In-Reply-To: <CAJp1Oe4Xh6SDQc43hue5qanm7G5Lw9vMdv-+5nRQ_S+RPpRALQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <greg@kroah.com>, Theodore Ts'o <tytso@mit.edu>

On Thu, Nov 15, 2012 at 5:01 PM, Matt Schulte
<matts@commtech-fastcom.com> wrote:
> Add support for new devices: Exar's XR17V35x family of multi-port PCIe UARTs.
>
> Built against tty-next 54d5f88f25c38e5500a17b16240cb3775af00876
>
> Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
> ---
> v3: Moved overriding of handle_irq to serial8250_config_port
>
> v2: Moved extra interrupt handling to its own custom handle_irq
>
> v1: Hopefully if this gets accepted I will be able to submit an additional
> patch to add support for my company's PCIe cards that use these
> UARTs.

What should I do if I would like to submit an additional patch that
depends on this one that has not yet been accepted?  Should I combine
them and resubmit both or do I just need to wait?

Matt Schutle
