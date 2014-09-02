From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tty/serial: fix config dependencies for samsung serial
Date: Tue, 02 Sep 2014 17:46:23 +0200
Message-ID: <3749760.naNt3fHoTI@wuerfel>
References: <1409671320-7604-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:49362 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbaIBPqz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 11:46:55 -0400
In-Reply-To: <1409671320-7604-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Pankaj Dubey <pankaj.dubey@samsung.com>, naveenkrishna.ch@gmail.com

On Tuesday 02 September 2014 20:52:00 Naveen Krishna Chatradhi wrote:
> Make the config symbols SERIAL_SAMSUNG_UARTS_4 and
> SERIAL_SAMSUNG_UARTS depend on SERIAL_SAMSUNG rather than
> PLAT_SAMSUNG.

Please always describe why you are doing a change. This patch
seems really pointless.

>  config SERIAL_SAMSUNG_UARTS_4
>         bool
> -       depends on PLAT_SAMSUNG
> +       depends on SERIAL_SAMSUNG
>         default y if !(CPU_S3C2410 || CPU_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
>         help
>           Internal node for the common case of 4 Samsung compatible UARTs
>  
>  config SERIAL_SAMSUNG_UARTS
>         int
> -       depends on PLAT_SAMSUNG
> +       depends on SERIAL_SAMSUNG
>         default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
>         default 3
>         help
> 

Have you checked that it still builds on all samsung platforms when
SERIAL_SAMSUNG is disabled? We have had build errors in this area
in the past.

	Arnd
