From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Date: Wed, 19 Jun 2013 17:10:08 +0300
Message-ID: <20130619141008.GA32331@xps8300>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
 <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org, Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 18, 2013 at 12:12:53PM -0700, David Daney wrote:
> A few differences needed by OCTEON:
> 
> o These are DWC UARTS, but have USR at a different offset.
> 
> o OCTEON must have 64-bit wide register accesses, so we have OCTEON
>   specific register accessors.
> 
> o No UCV register, so we hard code some properties.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

<snip>

> @@ -270,10 +301,8 @@ static int dw8250_probe(struct platform_device *pdev)
>  	uart.port.serial_out = dw8250_serial_out;
>  	uart.port.private_data = data;
>  
> -	dw8250_setup_port(&uart);
> -
>  	if (pdev->dev.of_node) {
> -		err = dw8250_probe_of(&uart.port);
> +		err = dw8250_probe_of(&uart.port, data);
>  		if (err)
>  			return err;
>  	} else if (ACPI_HANDLE(&pdev->dev)) {
> @@ -284,6 +313,9 @@ static int dw8250_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	if (!data->no_ucv)
> +		dw8250_setup_port(&uart);

Moving the dw8250_setup_port() call here breaks dw8250_probe_acpi(). It
expects values from the CPR register for the DMA burst size calculation.

The DMA support can be moved to a separate function. This way it can
be called after this point, and it will then be available for both DT
and ACPI. I can make a patch tomorrow. That should solve this issue.

Thanks,

-- 
heikki
