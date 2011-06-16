From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] amba pl011: workaround for uart registers lockup
Date: Thu, 16 Jun 2011 10:17:51 +0200
Message-ID: <BANLkTikSEVCGGsjF_fTCNZsmjvGoic5u=Q@mail.gmail.com>
References: <1307952693-25232-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51354 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab1FPIRw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 04:17:52 -0400
Received: by qyk29 with SMTP id 29so62606qyk.19
        for <linux-serial@vger.kernel.org>; Thu, 16 Jun 2011 01:17:51 -0700 (PDT)
In-Reply-To: <1307952693-25232-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Mon, Jun 13, 2011 at 10:11 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
>
> This workaround aims to break the deadlock situation
> which raises during continuous transfer of data for long
> duration over uart with hardware flow control. It is
> observed that CTS interrupt cannot be cleared in uart
> interrupt register (ICR). Hence further transfer over
> uart gets blocked.

Ping on this, Greg have you picked these two for the tty next tree?

Thanks,
Linus Walleij
