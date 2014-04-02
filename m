From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v6 1/3] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Wed, 02 Apr 2014 17:09:03 +0200
Message-ID: <533C280F.3060804@gmail.com>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com> <1394469951-21192-2-git-send-email-richard.genoud@gmail.com> <20140317232359.GA8943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:46380 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758641AbaDBPJX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Apr 2014 11:09:23 -0400
Received: by mail-wi0-f169.google.com with SMTP id hm4so6734729wib.0
        for <linux-serial@vger.kernel.org>; Wed, 02 Apr 2014 08:09:22 -0700 (PDT)
In-Reply-To: <20140317232359.GA8943@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Genoud <noreply.rgenoud@gmail.com>, =?ISO-8859-1?Q?Uwe_Klei?= =?ISO-8859-1?Q?ne-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 18/03/2014 00:23, Greg Kroah-Hartman wrote:
> On Mon, Mar 10, 2014 at 05:45:49PM +0100, Richard Genoud wrote:
>> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
>> GPIO.
>> This will be useful for many boards which have a serial controller that
>> only handle CTS/RTS pins (or even just RX/TX).
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I can't take this series through my tty tree as the non-tty patches
> don't apply, so feel free to take them through whatever tree is needed.
> 
> greg k-h
> 

I guess this series won't make it for 3.15, as it doesn't apply on any tree.
However, I'd like to know if I did something wrong, or if there's no
solution when a series depends on several patches that are in different
trees ?

Richard.
