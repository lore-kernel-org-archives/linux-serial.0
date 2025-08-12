Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E82356DA;
	Tue, 12 Aug 2025 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980200; cv=none; b=cSMXAeFjhIIHT1gZ6WD5JsZ+sOkG4NX4ixi+Um7Gj6JrboqdZUaU4Bb0P3los3Iv+Kntt73d9Rd9Ir0/RD74IAE08+kIr6QwV4fyp+KKcq0EWAwZL2kYTKEYYhrOVfl8rdDMvr9a/k6Azm7PyGIHNNa6iR0Pf5XlEmBSTNPfIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980200; c=relaxed/simple;
	bh=W654n7RF45wpHdN+QMI2JUWbDH4VKCOmQJrlzHySStA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ+ekTDSkLOMVostkan4zcClV4V/UcwjUZF5sCNZ0y6bEay6MCXklrdSeT3m9HgOww/eOrS415vdDNcA7Sgy3tXdNyqi+yme01A/m6IbLDnsEErvBbMgyXlfOBXsIwPyeopibzlZ3QwxzsqlsHUzg/zF7vF9Re5JNza666mZ1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSSK2EVw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSSK2EVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A177C4CEF0;
	Tue, 12 Aug 2025 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754980199;
	bh=W654n7RF45wpHdN+QMI2JUWbDH4VKCOmQJrlzHySStA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSSK2EVwyIKV5UNNZbLxw1QG0HTJAvM06AyuaPp4Rmmw4yHZyu3+NnIJJN3Oox8mC
	 ZrQD+bxxfm2xcynM/oa6Tz19KcGN2L3BhhRkgiXhCYtgSP7hX/+AS7o1sFJDjbNkce
	 x4CzyvUVQ7t7uZw7VgoiH4iA5aFAgnx68JFBiA+U=
Date: Tue, 12 Aug 2025 08:29:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zong Jiang <quic_zongjian@quicinc.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_ztu@quicinc.com, quic_anupkulk@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vdadhani@quicinc.com
Subject: Re: [PATCH 2/2] serial: qcom-geni: Make UART port count configurable
 via Kconfig
Message-ID: <2025081249-amusement-spongy-e052@gregkh>
References: <20250812054819.3748649-1-quic_zongjian@quicinc.com>
 <20250812054819.3748649-3-quic_zongjian@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812054819.3748649-3-quic_zongjian@quicinc.com>

On Tue, Aug 12, 2025 at 01:48:19PM +0800, Zong Jiang wrote:
> Replace the hardcoded GENI_UART_PORTS macro with a new Kconfig option
> SERIAL_QCOM_GENI_UART_PORTS to allow platforms to configure the maximum
> number of UART ports supported by the driver at build time.
> 
> This improves flexibility for platforms that require more than the
> previously fixed number of UART ports, and avoids unnecessary allocation
> for unused ports.
> 
> Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com>
> ---
>  drivers/tty/serial/Kconfig            | 8 ++++++++
>  drivers/tty/serial/qcom_geni_serial.c | 5 ++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 44427415a80d..e661f5951f55 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -928,6 +928,14 @@ config SERIAL_QCOM_GENI_CONSOLE
>  	  Serial console driver for Qualcomm Technologies Inc's GENI based
>  	  QUP hardware.
>  
> +config SERIAL_QCOM_GENI_UART_PORTS
> +	int "Maximum number of GENI UART ports"
> +	depends on SERIAL_QCOM_GENI
> +	default "8"
> +	help
> +	  Set this to the maximum number of serial ports you want the driver
> +	  to support.

Why do you need a static number of ports at all?  Why not just handle
how ever many there are in the system at the moment?  Or is this due to
some restriction in the serial core that requires this?

thanks,

greg k-h
