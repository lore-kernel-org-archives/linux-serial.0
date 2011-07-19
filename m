From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] serial:blackfin: Correct coding style in bfin
 serial driver.
Date: Tue, 19 Jul 2011 08:28:35 -0700
Message-ID: <1311089315.2286.157.camel@Joe-Laptop>
References: <1311070165-29402-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:4175 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab1GSP2h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Jul 2011 11:28:37 -0400
In-Reply-To: <1311070165-29402-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>

On Tue, 2011-07-19 at 18:09 +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
[]
> @@ -1091,10 +1090,18 @@ bfin_serial_console_get_options(struct bfin_serial_port *uart, int *baud,
>  				*parity = 'o';
>  		}
>  		switch (lcr & 0x03) {
> -			case 0:	*bits = 5; break;
> -			case 1:	*bits = 6; break;
> -			case 2:	*bits = 7; break;
> -			case 3:	*bits = 8; break;
> +		case 0:
> +			*bits = 5;
> +			break;
> +		case 1:
> +			*bits = 6;
> +			break;
> +		case 2:
> +			*bits = 7;
> +			break;
> +		case 3:
> +			*bits = 8;
> +			break;
>  		}

Maybe just:
	*bits = 5 + (lcr & 3);

