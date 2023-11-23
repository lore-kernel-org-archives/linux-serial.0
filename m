Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7F405C2
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbXjB2Bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA634C43391;
	Thu, 23 Nov 2023 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700760176;
	bh=r3SxNvUBmnsHaNki4VDL+z3dKpTAlqM3g+IFMWeGKZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbXjB2BocU+UI6sPiH8wBmSuXF7P0SStfzI8JAEYAWKM3au6YJa39iCCw7SDXOwlY
	 ljrhBwcyrIuHfmpzSQC7CBDkk1v0o4e+IsC+K6+9VPipuEqZB3SSqjqBdqS2J5s7ET
	 Amz+cMRpcuOPsrttCpogfe/jwqPsnfWep011zalw=
Date: Thu, 23 Nov 2023 14:16:46 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v5] tty: serial: Add RS422 flag to struct serial_rs485
Message-ID: <2023112346-immunity-clamshell-51c7@gregkh>
References: <20231121095122.15948-1-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121095122.15948-1-crescentcy.hsieh@moxa.com>

On Tue, Nov 21, 2023 at 05:51:22PM +0800, Crescent CY Hsieh wrote:
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -11,6 +11,7 @@
>  #ifndef _UAPI_LINUX_SERIAL_H
>  #define _UAPI_LINUX_SERIAL_H
>  
> +#include <linux/const.h>
>  #include <linux/types.h>
>  
>  #include <linux/tty_flags.h>
> @@ -137,17 +138,19 @@ struct serial_icounter_struct {
>   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
>   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
> + * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.
>   */
>  struct serial_rs485 {
>  	__u32	flags;
> -#define SER_RS485_ENABLED		(1 << 0)
> -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> -#define SER_RS485_RX_DURING_TX		(1 << 4)
> -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> -#define SER_RS485_ADDRB			(1 << 6)
> -#define SER_RS485_ADDR_RECV		(1 << 7)
> -#define SER_RS485_ADDR_DEST		(1 << 8)
> +#define SER_RS485_ENABLED		_BITUL(0)
> +#define SER_RS485_RTS_ON_SEND		_BITUL(1)
> +#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> +#define SER_RS485_RX_DURING_TX		_BITUL(3)
> +#define SER_RS485_TERMINATE_BUS		_BITUL(4)
> +#define SER_RS485_ADDRB			_BITUL(5)
> +#define SER_RS485_ADDR_RECV		_BITUL(6)
> +#define SER_RS485_ADDR_DEST		_BITUL(7)
> +#define SER_RS485_MODE_RS422		_BITUL(8)

You just broke userspace by changing the flags for existing values :(

Please be much more careful in the future, do not do "cleanup" patches
along with a "add a new feature" patch, as it would have been much more
obvious as to what happened here if you had done that.

thanks,

greg k-h
