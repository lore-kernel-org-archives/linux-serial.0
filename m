From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] ACPI: scan add call to probe amba devices
Date: Tue, 01 Dec 2015 03:16:53 +0100
Message-ID: <8504062.kEYB5C4QA7@vostro.rjw.lan>
References: <1443609530-21524-1-git-send-email-graeme.gregory@linaro.org> <1443609530-21524-3-git-send-email-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1443609530-21524-3-git-send-email-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, shannon.zhao@linaro.org, Len Brown <lenb@kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org

On Wednesday, September 30, 2015 11:38:49 AM Graeme Gregory wrote:
> Call the amba device creation function in the default enumeration path,
> this is the same location platform devices are probed.

First, I'm sorry for the glacially slow response here.

> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> ---
>  drivers/acpi/scan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index f834b8c..aa3184e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1633,8 +1633,10 @@ static void acpi_default_enumeration(struct acpi_device *device)
>  	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
>  			       &is_spi_i2c_slave);
>  	acpi_dev_free_resource_list(&resource_list);
> -	if (!is_spi_i2c_slave)
> +	if (!is_spi_i2c_slave) {
> +		acpi_create_amba_device(device);

Do you really have to add this here?

It would be much cleaner to use a new scan handler instead.

>  		acpi_create_platform_device(device);
> +	}
>  }
>  
>  static const struct acpi_device_id generic_device_ids[] = {
> 

Thanks,
Rafael

