Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E961BD014;
	Fri,  3 Jan 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895310; cv=none; b=BLyt8Becx+ka4VppkIvrnGtOKWAW5gGcPekKPGOYPRimVfeczkK0OR+k214kF9FXDw5eHCv8WcF2PgFHPUV0VjIkNk6rO6Cxw9sUcFZDq5z74ebylIg1HM4xP6j/P2YIX4uXY2pXTWgD1Tml89YVbBpG3dVcWEy9HYKdQ7bM4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895310; c=relaxed/simple;
	bh=xoxHFAgHRdoej0zk0dyolEm8H1TV6AphErXB7meDbqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU5J0HgtTMAStApjT9meacU2fso7S/yXTuezAXDcviDhxVzu+wqcdZZBJey0XUE3FLgqPNtb0u6IrXJhkJr3mefzb345uAR+JbCDn/EVGbqqTjuptWnFbtF2RtB80ZDiX+Oy0+doV2gpgyu0sFBTlW89tZqCjDw8lNJ26A8VPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLvVKCPo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLvVKCPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BB7C4CECE;
	Fri,  3 Jan 2025 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735895309;
	bh=xoxHFAgHRdoej0zk0dyolEm8H1TV6AphErXB7meDbqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLvVKCPoam84SeIeUJQay78DWSY6Z7DFlDlSFkWwCwi2a4h3mVYTXW5khkq+EtIHp
	 GUbx/U1Iw8wa37fEL7oWIgFrUtqJrNDiGGCaqHIw39NZSjsH2IkrlfHKNMtuuOQsrU
	 8aTg0G/hZUCfo1oHmT2oFfpVBUT59n/yJVIYwJkM=
Date: Fri, 3 Jan 2025 10:08:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Message-ID: <2025010351-overlap-matchless-5c00@gregkh>
References: <20250103071154.3070924-1-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103071154.3070924-1-sherry.sun@nxp.com>

On Fri, Jan 03, 2025 at 03:11:54PM +0800, Sherry Sun wrote:
> Some SoCs like the i.MX943 have aliases for up to 12 UARTs, need to
> increase UART_NR from 8 to 12 to support lpuart9-12 to avoid
> initialization failures.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 57b0632a3db6..7cb1e36fdaab 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -245,7 +245,7 @@
>  
>  #define DRIVER_NAME	"fsl-lpuart"
>  #define DEV_NAME	"ttyLP"
> -#define UART_NR		8
> +#define UART_NR		12

Why not fix this properly and make this dynamic and get rid of the
static array causing all of this problem?  That way when you get a
system with 13 uarts, you will be ok :)

thanks,

greg k-h
