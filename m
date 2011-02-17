From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [Nios2-dev] [PATCH 4/4] MAINTAINERS: Add myself as a maintainer
 for  altera_uart/altera_jtaguart
Date: Thu, 17 Feb 2011 11:16:36 +0800
Message-ID: <4D5C9314.8030101@wytron.com.tw>
References: <cover.1297245277.git.tklauser@distanz.ch> <04c107d8032cbaffada91066c1d010b9274aebe1.1297245277.git.tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:46561 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab1BQDNY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Feb 2011 22:13:24 -0500
In-Reply-To: <04c107d8032cbaffada91066c1d010b9274aebe1.1297245277.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: nios2-dev@sopc.et.ntust.edu.tw, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 02/09/2011 05:58 PM, Tobias Klauser wrote:
> Signed-off-by: Tobias Klauser<tklauser@distanz.ch>
> ---
>   MAINTAINERS |   10 ++++++++++
>   1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecef0f1..4e86a11 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -465,6 +465,16 @@ M:	Matt Turner<mattst88@gmail.com>
>   L:	linux-alpha@vger.kernel.org
>   F:	arch/alpha/
>
> +ALTERA UART/JTAG UART SERIAL DRIVERS
> +M:	Tobias Klauser<tklauser@distanz.ch>
> +L:	linux-serial@vger.kernel.org
> +L:	nios2-dev@sopc.et.ntust.edu.tw (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/tty/serial/altera_uart.c
> +F:	drivers/tty/serial/altera_jtaguart.c
> +F:	include/linux/altera_uart.h
> +F:	include/linux/altera_jtaguart.h
> +
>   AMD GEODE CS5536 USB DEVICE CONTROLLER DRIVER
>   M:	Thomas Dahlmann<dahlmann.thomas@arcor.de>
>   L:	linux-geode@lists.infradead.org (moderated for non-subscribers)

Hi Tobias,

As we get more drivers merged into mainline, we might consider adding a 
general entry for all altera related drivers to our mailing list. We 
could add "F: arch/nios2" to this entry in the near future.

1) subject: MAINTAINERS: add Altera related drivers entry
send this to Andrew Morton.

ALTERA EMBEDDED ARCH AND PERIPHERALS DRIVERS
L:	nios2-dev@sopc.et.ntust.edu.tw (moderated for non-subscribers)
S:	Maintained
K:	altera

2) subject: MAINTAINERS: add Altera UART/JTAG UART maintainer

ALTERA UART/JTAG UART SERIAL DRIVERS
M:	Tobias Klauser <tklauser@distanz.ch>
L:	linux-serial@vger.kernel.org
S:	Maintained
F:	drivers/tty/serial/altera_uart.c
F:	drivers/tty/serial/altera_jtaguart.c
F:	include/linux/altera_uart.h
F:	include/linux/altera_jtaguart.h

Regards,
Thomas
