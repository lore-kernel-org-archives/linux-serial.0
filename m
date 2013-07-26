From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 0/3] serial: max310x: Add support for MAX3109 & MAX14830
Date: Fri, 26 Jul 2013 21:05:23 +0400
Message-ID: <20130726210523.08bcb38b1589a67ba9bae6d1@mail.ru>
References: <1372483459-11836-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp50.i.mail.ru ([94.100.177.110]:56409 "EHLO smtp50.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758651Ab3GZRFe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Jul 2013 13:05:34 -0400
In-Reply-To: <1372483459-11836-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

On Sat, 29 Jun 2013 09:24:16 +0400
Alexander Shiyan <shc_work@mail.ru> wrote:

> This series adds support for dual (MAX3109) and quad (MAX14830) ICs
> into the max310x driver.
> There are lot of changes in the code, as we had to change almost every
> function to achieve the required functionality. Because of this
> the first part of the patch can not be divided into smaller parts.
> Result was checked for a long time:
> MAX3107 with SPI on Cirrus Logic EP7312,
> MAX14830 with SPI on Freescale i.MX51 (two ports simultaneously).
> 
> Alexander Shiyan (3):
>   serial: max310x: Driver rework
>   serial: max310x: Add MAX3109 support
>   serial: max310x: Add MAX14830 support
> 
>  drivers/tty/serial/Kconfig            |   6 +-
>  drivers/tty/serial/max310x.c          | 996 ++++++++++++++++++----------------
>  include/linux/platform_data/max310x.h |   9 +-
>  3 files changed, 531 insertions(+), 480 deletions(-)
> 
> -- 
> 1.8.1.5

Ping.

-- 
Alexander Shiyan <shc_work@mail.ru>
