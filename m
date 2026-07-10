Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B33413247;
	Fri, 10 Jul 2026 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687021; cv=none; b=PLq05Q4dC1vvfphHWXXC3htlHHJKKDbzLoaChFLpObs6pBhOVwVWK2mSkjmRBlA02FBn+W3xU9POt2ADwQXqyix+zcw6e6Y53oPvsmnfRMmUIKLvIGafRk3/U4HxPYlv2RpdnkVKTADW85ktpaWjVvPWpU/4bzXhyOJvnRfM+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687021; c=relaxed/simple;
	bh=d2Q8m1bm0pj/mmomWzIlqwv8Kb5fp2/h1aDAJ2nhxPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orn2683nzt0SToyOQ3fmqkH4Vpb8x13I8akxFy1enhSV0sDSP+FjubDluvJHOiQyJ9WFEdIVq+1b6XfpcGMXI3fsUAlZV04vjZWti3Qx8xj/56V0Bvow5zyeSMz61JinlOUjkk+bBO39d14q/Nn2dLlV4OftZPi+m4BYj48JFD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RvmbMZ+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RvmbMZ+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D901F00A3A;
	Fri, 10 Jul 2026 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783687019;
	bh=/oKnotSkPygcr5C7b2AwTd5oaePd0MsmYSs/SLp0hz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RvmbMZ+hmsCn+KSfTq57Jvk50knDqfSQTVciIeOsgZKzKtp8PzEzUpcwIxb8hCL3h
	 Q8ZhicQ8IH1Vn66MDBp9rHU4AQ1SnyOUuGggBnBXB7KymmrZZm8pesStQlnuZWCAxO
	 6cVuO00HgIjjTQjKrT1nLmgroguDFRWSf3HR2iJE=
Date: Fri, 10 Jul 2026 14:36:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/2] serial: earlycon: add uart_clk_freq parameter
Message-ID: <2026071048-imprudent-pumice-9b28@gregkh>
References: <20260615-acpi_spcr-v3-0-9a59ebad74ea@posteo.de>
 <20260615-acpi_spcr-v3-1-9a59ebad74ea@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-acpi_spcr-v3-1-9a59ebad74ea@posteo.de>

On Mon, Jun 15, 2026 at 12:40:21AM +0000, Markus Probst wrote:
> Add function `setup_earlycon_with_uartclk`. This allows the
> options string to be reused with `add_preferred_console`, while still
> allowing to set the uart clock frequency. This will be used in the
> following commit ("ACPI: SPCR: Support UART clock frequency field").
> 
> No logical change intended.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  drivers/tty/serial/earlycon.c | 17 ++++++++++++-----
>  include/linux/serial_core.h   | 11 +++++++++--
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index ab9af37f6cda..5a20fe9e3fb6 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -135,11 +135,14 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>  	return 0;
>  }
>  
> -static int __init register_earlycon(char *buf, const struct earlycon_id *match)
> +static int __init register_earlycon(char *buf, unsigned int uart_clk_freq,
> +				    const struct earlycon_id *match)
>  {
>  	int err;
>  	struct uart_port *port = &early_console_dev.port;
>  
> +	port->uartclk = uart_clk_freq;

This looks like a logical change, the code today does not do that
anywhere, right?

thanks,

greg k-h
