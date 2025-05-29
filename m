Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257321B8F8;
	Thu, 29 May 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509915; cv=none; b=ghYLN3lXIm4zuVS9fbXCBHbEorxK/2XNBotebUt2AtZw8NM7sGftCmd2s09BX8xJaHa5E3C44bdguzPxOSigew7MCaWDn1mfWGWV2iVHD5ExvpQTX1xATrrY1KaMr62VcHuS6KAM2VfVOfX1w6l5bTBuvxX3m4qyQwf0ciKzOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509915; c=relaxed/simple;
	bh=etCnNVCaZm8czOxADU77dWNdPQaJyUulC30i36OyVe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2Y1fPbAJ8c7oVXJWUA20l+8/B/oeXbWtZ2EuiFUs9zrpzC7a/an8n7NE/ZjC0jiSjHVmrE7Fq/ERm2K2eJDyOkUWXbqbjDLKGGR9/aKz/Pf5D37QbjcqNi5B6A6S0+DfvBwhQeAwsw8aHZiizFPU80oNIDPTh8srtpQHWU9ap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RcriyvZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RcriyvZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6395C4CEE7;
	Thu, 29 May 2025 09:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748509915;
	bh=etCnNVCaZm8czOxADU77dWNdPQaJyUulC30i36OyVe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcriyvZB21YKR6aJPzQ60V5EfB1XaZ1CEg1pEFx5z+QaktkoSXrMi0m5xn5opXkfi
	 ebZimSs7m+eO75ZzbQ0VVnPnqzm6KTArhl15l/mpWAu7ZkT/jgJFolRB5ZuU8ob15O
	 fOESYdArrVuE3P7ccPm80MKhP3GdWXs4Tp3LAqjo=
Date: Thu, 29 May 2025 11:11:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zongjian <quic_zongjian@quicinc.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ztu@quicinc.com, quic_haixcui@quicinc.com,
	quic_anupkulk@quicinc.com, quic_msavaliy@quicinc.com,
	quic_vdadhani@quicinc.com
Subject: Re: [PATCH v1] serial: qcom-geni: Add support to increase UART ports
 efficiently
Message-ID: <2025052959-tingly-august-3560@gregkh>
References: <20250529090325.1479702-1-quic_zongjian@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529090325.1479702-1-quic_zongjian@quicinc.com>

On Thu, May 29, 2025 at 05:03:25PM +0800, zongjian wrote:
> Populate members of qcom_geni_uart_ports through a loop for
> better maintainability. 

What does this mean exactly?

> 
> Increase the UART ports to 5, as a few use cases require more than 3 UART ports.

You are doing two different things here in the same patch.  As you know,
this means this should be split up into multiple patches.

> Signed-off-by: zongjian <quic_zongjian@quicinc.com>

We need a full name here, not just an email alias.

> ---
>  drivers/tty/serial/qcom_geni_serial.c | 40 +++++++++------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 140c3ae5ead2..d969c96b9690 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -77,7 +77,7 @@
>  #define STALE_TIMEOUT			16
>  #define DEFAULT_BITS_PER_CHAR		10
>  #define GENI_UART_CONS_PORTS		1
> -#define GENI_UART_PORTS			3
> +#define GENI_UART_PORTS			5

You need a better justification for increasing the number of ports here
in the changelog other than what you wrote :)

>  #define DEF_FIFO_DEPTH_WORDS		16
>  #define DEF_TX_WM			2
>  #define DEF_FIFO_WIDTH_BITS		32
> @@ -153,6 +153,7 @@ static const struct uart_ops qcom_geni_console_pops;
>  static const struct uart_ops qcom_geni_uart_pops;
>  static struct uart_driver qcom_geni_console_driver;
>  static struct uart_driver qcom_geni_uart_driver;
> +static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS];
>  
>  static void __qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
>  static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
> @@ -163,32 +164,15 @@ static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
>  	return container_of(uport, struct qcom_geni_serial_port, uport);
>  }
>  
> -static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
> -	[0] = {
> -		.uport = {
> -			.iotype = UPIO_MEM,
> -			.ops = &qcom_geni_uart_pops,
> -			.flags = UPF_BOOT_AUTOCONF,
> -			.line = 0,
> -		},
> -	},
> -	[1] = {
> -		.uport = {
> -			.iotype = UPIO_MEM,
> -			.ops = &qcom_geni_uart_pops,
> -			.flags = UPF_BOOT_AUTOCONF,
> -			.line = 1,
> -		},
> -	},
> -	[2] = {
> -		.uport = {
> -			.iotype = UPIO_MEM,
> -			.ops = &qcom_geni_uart_pops,
> -			.flags = UPF_BOOT_AUTOCONF,
> -			.line = 2,
> -		},
> -	},
> -};
> +static void qcom_geni_serial_port_init(void)
> +{
> +	for (int i = 0; i < GENI_UART_PORTS; i++) {
> +		qcom_geni_uart_ports[i].uport.iotype = UPIO_MEM;
> +		qcom_geni_uart_ports[i].uport.ops = &qcom_geni_uart_pops;
> +		qcom_geni_uart_ports[i].uport.flags = UPF_BOOT_AUTOCONF;
> +		qcom_geni_uart_ports[i].uport.line = i;
> +	}

If this is such a simple structure, that never changes, why is it needed
at all?  It can be easily determined from the "line" value, right?  Just
remove it entirely please, as it's much better to have a dynamic number
of ports (i.e. what is actually in the system), than a hard-coded one.

thanks,

greg k-h
