From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] asm/uapi: Add definition of TIOC[SG]RS485
Date: Thu, 18 Sep 2014 21:59:58 -0700
Message-ID: <541BB84E.5030705@roeck-us.net>
References: <1411022745-6198-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42099 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaISFAD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 01:00:03 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XUqIb-002YI5-IQ
	for linux-serial@vger.kernel.org; Fri, 19 Sep 2014 05:00:01 +0000
In-Reply-To: <1411022745-6198-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org

On 09/17/2014 11:45 PM, Ricardo Ribalda Delgado wrote:
> Commit: e676253b19b2d269cccf67fdb1592120a0cd0676 (serial/8250: Add
> support for RS485 IOCTLs), adds support for RS485 ioctls for 825_core on
> all the archs. Unfortunaltely the definition of TIOCSRS485 and

s/Unfortunaltely/Unfortunately/

> TIOCGRS485 was missing on the ioctls.h file
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/alpha/include/uapi/asm/ioctls.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
> index 92c557b..f30c94a 100644
> --- a/arch/alpha/include/uapi/asm/ioctls.h
> +++ b/arch/alpha/include/uapi/asm/ioctls.h
> @@ -90,6 +90,8 @@
>   #define TIOCSBRK	0x5427  /* BSD compatibility */
>   #define TIOCCBRK	0x5428  /* BSD compatibility */
>   #define TIOCGSID	0x5429  /* Return the session ID of FD */
> +#define TIOCGRS485	_IOR('T', 0x2E, struct serial_rs485)
> +#define TIOCSRS485	_IOWR('T', 0x2F, struct serial_rs485)
>   #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
>   #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
>   #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
>

