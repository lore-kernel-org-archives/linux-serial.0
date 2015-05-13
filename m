From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v4 11/11] drivers: PL011: add ACPI probing for SBSA UART
Date: Wed, 13 May 2015 09:09:53 +0800
Message-ID: <5552A461.4020101@huawei.com>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
 <1431440095-5146-12-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1431440095-5146-12-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>, rmk+kernel@arm.linux.org.uk, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, arnd@arndb.de, Jakub Kicinski <moorray3@wp.pl>, linux-serial@vger.kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 2015/5/12 22:14, Andre Przywara wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> Add the necessary driver boilerplate to let the driver be used when
> the respective ACPI table is discovered by the ACPI subsystem.
>
> [Andre: change table name, add MODULE_DEVICE_TABLE entry and improve
> 	commit message]
>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index cca93d9..79f716c 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -58,6 +58,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sizes.h>
>  #include <linux/io.h>
> +#include <linux/acpi.h>
>  
>  #define UART_NR			14
>  
> @@ -2483,12 +2484,19 @@ static const struct of_device_id sbsa_uart_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
>  
> +static const struct acpi_device_id sbsa_uart_acpi_match[] = {
> +	{ "ARMH0011", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, sbsa_uart_acpi_match);
> +
>  static struct platform_driver arm_sbsa_uart_platform_driver = {
>  	.probe		= sbsa_uart_probe,
>  	.remove		= sbsa_uart_remove,
>  	.driver	= {
>  		.name	= "sbsa-uart",
>  		.of_match_table = of_match_ptr(sbsa_uart_of_match),
> +		.acpi_match_table = ACPI_PTR(sbsa_uart_acpi_match),
>  	},
>  };

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
