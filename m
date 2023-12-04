Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8auie4n"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7AFA1;
	Mon,  4 Dec 2023 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701696015; x=1733232015;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4NPXnux+c7mfmuxeW1NdbPlpm/f/3Pww4CWNNGCbIWw=;
  b=Q8auie4nwj65b8xzmnA7s6ko+WGC/N2slbZg3Rl0xiM2XhFFDyBZZXUF
   Ip/1yz5WFIyp6Af5j3TIqBAzxa8gu49sM10h16+yaUKmlhrQDciY+j8jh
   fQVtWOUbjIPv93g2ZRhcsaLzbxPWTEAbCv1Fz/p/1bpkfPzLMr5XqiXZ4
   JFCjxcz1kec9lOXqsqUIJ75VFftcOo3BuQGc8b4h86vaTN7oeCiBsiGne
   2t6NklBRbV0NHrAMZk1flo+leysn4rMkUBPmordLb0FulMMUCoQB0ykWI
   DPi1mMH5B1zzdAfzKczTKsJ1NLd+DHf5zHauXpesbRlwGVBLjcf3+M7ph
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="396535976"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="396535976"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:20:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="770534305"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="770534305"
Received: from malladhi-mobl.gar.corp.intel.com ([10.249.34.28])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:20:12 -0800
Date: Mon, 4 Dec 2023 15:20:09 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Dawei Li <dawei.li@shingroup.cn>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Jiri Slaby <jirislaby@kernel.org>, jszhang@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, set_pte_at@outlook.com, 
    stable@kernel.org
Subject: Re: [PATCH] serial: dw8250: Make DLF feature independent of
 ADDITIONAL_FEATURE
In-Reply-To: <20231204130820.2823688-1-dawei.li@shingroup.cn>
Message-ID: <48f6fcce-4b5-a7c0-2fc0-989b9a2fba8@linux.intel.com>
References: <20231204130820.2823688-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 4 Dec 2023, Dawei Li wrote:

> DW apb uart databook defines couples of configuration parameters of
> dw8250 IP, among which there are 2 of them:
> - ADDTIONAL_FEATURE
> " Configure the peripheral to have the option to include FIFO status
>   registers, shadow registers and encoded parameter register. Also
>   configures the peripheral to have UART component version and the
>   peripheral ID registers. "
> 
> - FRACTIONAL_BAUD_DIVISOR_EN
> " Configures the peripheral to have Fractional Baud Rate Divisor.
>   .... "
> 
> These two parameters are completely irrelevant, and supposed to be
> independent of each other. However, in current dw8250 driver
> implementation, they are hooked together.
> 
> The bug was hit when we are bringing up dw8250 IP on our hardware
> platform, in which parameters are configured in such combination:
> - ADDTIONAL_FEATURE disabled;
> - FRACTIONAL_BAUD_DIVISOR_EN enabled;
> 
> Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> Cc: stable@kernel.org
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/tty/serial/8250/8250_dwlib.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 84843e204a5e..136ad093c5b6 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -259,17 +259,6 @@ void dw8250_setup_port(struct uart_port *p)
>  	}
>  	up->capabilities |= UART_CAP_NOTEMT;
>  
> -	/*
> -	 * If the Component Version Register returns zero, we know that
> -	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
> -	 */
> -	reg = dw8250_readl_ext(p, DW_UART_UCV);
> -	if (!reg)
> -		return;
> -
> -	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
> -		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
> -
>  	/* Preserve value written by firmware or bootloader  */
>  	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
>  	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
> @@ -282,6 +271,17 @@ void dw8250_setup_port(struct uart_port *p)
>  		p->set_divisor = dw8250_set_divisor;
>  	}
>  
> +	/*
> +	 * If the Component Version Register returns zero, we know that
> +	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
> +	 */
> +	reg = dw8250_readl_ext(p, DW_UART_UCV);
> +	if (!reg)
> +		return;
> +
> +	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
> +		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
> +
>  	reg = dw8250_readl_ext(p, DW_UART_CPR);
>  	if (!reg) {
>  		reg = data->pdata->cpr_val;
> 

The very same code change is already in tty-next (from another author).

-- 
 i.

