From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] serial: ifx6x60: add missing variable initialization
Date: Wed, 27 Feb 2013 10:53:09 +0100
Message-ID: <512DD785.5050001@suse.cz>
References: <008e01ce14a7$c1406580$43c13080$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:33622 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab3B0JxO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Feb 2013 04:53:14 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so292360eek.9
        for <linux-serial@vger.kernel.org>; Wed, 27 Feb 2013 01:53:13 -0800 (PST)
In-Reply-To: <008e01ce14a7$c1406580$43c13080$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Chen Jun' <jun.d.chen@intel.com>

On 02/27/2013 06:03 AM, Jingoo Han wrote:
> Fixed build warning as below:
> 
> drivers/tty/serial/ifx6x60.c:753:8: warning: 'more' may be used uninitialized in this function [-Wuninitialized]

This needs some more investigation and explanation than that. Are you
fixing a real compiler warning or hiding a bug here?

> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/tty/serial/ifx6x60.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
> index 68d7ce9..3d78baf 100644
> --- a/drivers/tty/serial/ifx6x60.c
> +++ b/drivers/tty/serial/ifx6x60.c
> @@ -687,7 +687,7 @@ static void ifx_spi_complete(void *ctx)
>  	struct tty_ldisc *ldisc = NULL;
>  	int length;
>  	int actual_length;
> -	unsigned char more;
> +	unsigned char more = 0;
>  	unsigned char cts;
>  	int local_write_pending = 0;
>  	int queue_length;
> 


-- 
js
suse labs
