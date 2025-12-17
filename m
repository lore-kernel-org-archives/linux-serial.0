Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212733FE0C;
	Wed, 17 Dec 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980032; cv=none; b=sZONVBMH6wbefx/i2CshC7PK58DQmHwJQbAlWDIqCseJB/JPo4d0PRBQK6SxCHarwWU04M/iZW+rPfeR2Hvgq0bLUoD9Irsvz/T3HfHar6uvo/53j4sZuGbc5UTCdVeU3SbSwG1hjt+0HUBUTgmllgCUrrvsBbJ3gcMODmE2TmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980032; c=relaxed/simple;
	bh=C32QoLOurgy32uXLrbXDeYFU35/vvlYvZn9JIIVCUgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X79BHRN8w4twr7IydiH88Ooa7hynNkIprFpHPYeL0/DS5Vuh9rra2gvryxA8FspaIfN4RXcoBKgHKGX/2R4HpKk9XKit0WBSeOBnzPOoDD0u1HlDO/+WHyFCYXUuLp/5qcCTcYQbzCmdIaJ9rT5a0Ad3zzep/G9KOHAgxyU8seY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7Y2fxFF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7Y2fxFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8A8C113D0;
	Wed, 17 Dec 2025 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765980031;
	bh=C32QoLOurgy32uXLrbXDeYFU35/vvlYvZn9JIIVCUgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7Y2fxFF40whznV6R7FjtvoXM7YjuCmOol0gTnG4k3XJUOzqGBx4D8wmHuE1X87im
	 ptxehAJAri3lbookqXPKLTHRIAtFtqkh5vJrkQNEH1CTFJtBZXb2sp4iCo7wLKahaI
	 xfiKUnDmpV86htquOQFzma1HRv0XE+XLOHKNviDU=
Date: Wed, 17 Dec 2025 15:00:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Filip Jensen <dev-Felipe.Jensen@duagon.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: Re: [PATCH 2/2] serial: 8250_men_mcb: Parameter for base clockrate
Message-ID: <2025121711-landing-vending-e4e0@gregkh>
References: <20251210164804.94801-1-dev-Felipe.Jensen@duagon.com>
 <20251210164804.94801-3-dev-Felipe.Jensen@duagon.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210164804.94801-3-dev-Felipe.Jensen@duagon.com>

On Wed, Dec 10, 2025 at 05:48:04PM +0100, Filip Jensen wrote:
> A parameter is needed for allowing to change the base clockrate for
> each uart port, as this fpga units have no fixed base clock. If the
> parameter is not set or is set to 0, it will use the default value.
> Allows setting the clockrate up to 64 UARTs.
> 
> Reviewed-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
> Signed-off-by: Filip Jensen <dev-Felipe.Jensen@duagon.com>
> ---
>  drivers/tty/serial/8250/8250_men_mcb.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
> index 6ba7464bb2dd..01dcb9c17b0c 100644
> --- a/drivers/tty/serial/8250/8250_men_mcb.c
> +++ b/drivers/tty/serial/8250/8250_men_mcb.c
> @@ -28,6 +28,7 @@
>  #define MEN_UART3_MASK	0x04
>  #define MEN_UART4_MASK	0x08
>  
> +#define MEN_8250_MAX_SETUP		64
>  #define MEN_Z025_MAX_UARTS		4
>  #define MEN_UART_MEM_SIZE		0x10
>  #define MEM_UART_REGISTER_SIZE		0x01
> @@ -45,12 +46,18 @@ struct serial_8250_men_mcb_data {
>  	int line[MEN_Z025_MAX_UARTS];
>  	unsigned int offset[MEN_Z025_MAX_UARTS];
>  };
> +static int portindex;
> +static ulong uartclk[MEN_8250_MAX_SETUP];
> +module_param_array(uartclk, ulong, NULL, 0664);
> +MODULE_PARM_DESC(
> +	uartclk,
> +	"Base for baudrate generation for each port. E.g.: uartclk=1843200,1843200,1041666,1041666. If set to 0 it will use board's default");

This is not the 1990's, please do nto add new module parameters.  That
way lies madness and an inability to handle dynamic devices in any way.

Why can't this be found out some other way?  Device discovery?  Device
tree?  quirk for something else?  This should not be so broken that you
need to manually come up with kernel boot lines like this.  What about
fixing the hardware itself to not need this at all?

thanks,

greg k-h
