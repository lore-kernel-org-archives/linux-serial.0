From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [PATCH 3/5] tty/serial: Add GPIOLIB helpers for controlling modem
 lines
Date: Mon, 28 Apr 2014 07:52:30 +0200
Message-ID: <535DEC9E.4070105@visionsystems.de>
References: <1398437561-4289-1-git-send-email-richard.genoud@gmail.com> <1398437561-4289-4-git-send-email-richard.genoud@gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:58370 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaD1Fwt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 Apr 2014 01:52:49 -0400
In-Reply-To: <1398437561-4289-4-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, Linus Walleij <linus.walleij@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 25.04.2014 16:52, Richard Genoud wrote:
> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> GPIO.
> This will be useful for many boards which have a serial controller that
> only handle CTS/RTS pins (or even just RX/TX).
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Yegor Yefremov <yegorslists@googlemail.com>

Yegor
