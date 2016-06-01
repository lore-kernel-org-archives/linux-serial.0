From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2 1/2] serial: samsung: Fix ERR pointer dereference on
 deferred probe
Date: Wed, 1 Jun 2016 16:57:43 -0400
Message-ID: <46dcde4f-2be6-d633-ad0b-23aa8f684ff6@osg.samsung.com>
References: <1464703206-1615-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1464703206-1615-1-git-send-email-k.kozlowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Krzysztof,

On 05/31/2016 10:00 AM, Krzysztof Kozlowski wrote:
> When the clk_get() of "uart" clock returns EPROBE_DEFER, the next re-probe
> finishes with success but uses invalid (ERR_PTR) values.  This leads to
> dereferencing of ERR_PTR stored under ourport->clk:
> 
> 	12c30000.serial: Controller clock not found
> 	(...)
> 	12c30000.serial: ttySAC3 at MMIO 0x12c30000 (irq = 61, base_baud = 0) is a S3C6400/10
> 	Unable to handle kernel paging request at virtual address fffffdfb
> 
> 	(clk_prepare) from [<c039f7d0>] (s3c24xx_serial_pm+0x20/0x128)
> 	(s3c24xx_serial_pm) from [<c0395414>] (uart_change_pm+0x38/0x40)
> 	(uart_change_pm) from [<c039689c>] (uart_add_one_port+0x31c/0x44c)
> 	(uart_add_one_port) from [<c03a035c>] (s3c24xx_serial_probe+0x2a8/0x418)
> 	(s3c24xx_serial_probe) from [<c03ee110>] (platform_drv_probe+0x50/0xb0)
> 	(platform_drv_probe) from [<c03ecb44>] (driver_probe_device+0x1f4/0x2b0)
> 	(driver_probe_device) from [<c03eb0c0>] (bus_for_each_drv+0x44/0x8c)
> 	(bus_for_each_drv) from [<c03ec8c8>] (__device_attach+0x9c/0x100)
> 	(__device_attach) from [<c03ebf54>] (bus_probe_device+0x84/0x8c)
> 	(bus_probe_device) from [<c03ec388>] (deferred_probe_work_func+0x60/0x8c)
> 	(deferred_probe_work_func) from [<c012fee4>] (process_one_work+0x120/0x328)
> 	(process_one_work) from [<c0130150>] (worker_thread+0x2c/0x4ac)
> 	(worker_thread) from [<c0135320>] (kthread+0xd8/0xf4)
> 	(kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)
> 
> The first unsuccessful clk_get() causes s3c24xx_serial_init_port() to
> exit with failure but the s3c24xx_uart_port is left half-configured
> (e.g. port->mapbase is set, clk contains ERR_PTR).  On next re-probe,
> the function s3c24xx_serial_init_port() will exit early with success
> because of configured port->mapbase and driver will use old values,
> including the ERR_PTR as clock.
> 
> Fix this by cleaning the port->mapbase on error path so each re-probe
> will initialize all of the port settings.
> 
> Fixes: 60e93575476f ("serial: samsung: enable clock before clearing pending interrupts during init")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
