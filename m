From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: of-serial: Remove device_type = "serial" registration
Date: Mon, 13 Apr 2015 11:50:16 -0400
Message-ID: <552BE5B8.4050204@hurleysoftware.com>
References: <b8ba9c125be49a8a70a04807179c5f7fe79b1ae0.1428935724.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <b8ba9c125be49a8a70a04807179c5f7fe79b1ae0.1428935724.git.michal.simek@xilinx.com>
Sender: stable-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

[ + Arnd ]

Hi Michal,

On 04/13/2015 10:35 AM, Michal Simek wrote:
> Do not probe all serial drivers by of_serial.c which are using
> device_type = "serial"; property. Only drivers which have valid
> compatible strings listed in the driver should be probed.

What does this fix?
Is there some kind of probe problem you're trying to address?
Are you trying to silence the error message?

> When PORT_UNKNOWN probe will fail anyway.

Ok, but doesn't device_attach() just continue to try to match other
drivers on the platform bus?

Regards,
Peter Hurley

> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> CC: <stable@vger.kernel.org>
> ---
> 
>  drivers/tty/serial/of_serial.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> index 33fb94f78967..0a52c8b55a5f 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -344,7 +344,6 @@ static struct of_device_id of_platform_serial_table[] = {
>  	{ .compatible = "ibm,qpace-nwp-serial",
>  		.data = (void *)PORT_NWPSERIAL, },
>  #endif
> -	{ .type = "serial",         .data = (void *)PORT_UNKNOWN, },
>  	{ /* end of list */ },
>  };
>  
> 
