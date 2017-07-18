From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2] serial: 8250: fix error handling in
 of_platform_serial_probe()
Date: Tue, 18 Jul 2017 17:45:21 +0200
Message-ID: <20170718154521.GA7132@localhost>
References: <032e9a8b-8013-fe60-4a49-11cbf5cc28ed@ispras.ru>
 <1500377531-28358-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500377531-28358-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 18, 2017 at 02:32:11PM +0300, Alexey Khoroshilov wrote:
> clk_disable_unprepare(info->clk) is missed in of_platform_serial_probe(),
> while irq_dispose_mapping(port->irq) is missed in of_platform_serial_setup().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

> @@ -167,7 +167,9 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  		port->handle_irq = fsl8250_handle_irq;
>  
>  	return 0;
> -out:
> +err_dispose:
> +	irq_dispose_mapping(port->irq);
> +err_unprepare:
>  	if (info->clk)
>  		clk_disable_unprepare(info->clk);
>  	return ret;

> @@ -217,15 +219,18 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
>  
>  	ret = serial8250_register_8250_port(&port8250);
>  	if (ret < 0)
> -		goto out;
> +		goto err_register;
>  
>  	info->type = port_type;
>  	info->line = ret;
>  	platform_set_drvdata(ofdev, info);
>  	return 0;
> -out:
> -	kfree(info);
> +err_register:
>  	irq_dispose_mapping(port8250.port.irq);
> +	if (info->clk)
> +		clk_disable_unprepare(info->clk);
> +err_setup:
> +	kfree(info);

Please name also these error labels after what they do rather than after
from where you jump to them (i.e. as you did above in
of_platform_serial_setup()).

Thanks,
Johan
