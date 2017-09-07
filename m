From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 3/3] Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39
Date: Thu, 7 Sep 2017 19:27:05 +0200
Message-ID: <95562F35-CB13-4AEC-8DD3-2729FE0B235C@holtmann.org>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-4-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1504786214-1866-4-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, sre@kernel.org, loic.poulain@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Fred,

> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 2e358cc..b1cf07e 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -922,7 +922,6 @@ static const struct hci_uart_proto bcm_proto = {
> #ifdef CONFIG_ACPI
> static const struct acpi_device_id bcm_acpi_match[] = {
> 	{ "BCM2E1A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> -	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> 	{ "BCM2E3A", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> 	{ "BCM2E3D", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> 	{ "BCM2E3F", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> @@ -942,6 +941,14 @@ static const struct acpi_device_id bcm_acpi_match[] = {
> MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
> #endif
> 
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id bcm_serdev_acpi_match[] = {
> +	{ "BCM2E39", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, bcm_serdev_acpi_match);
> +#endif
> +
> /* Platform suspend and resume callbacks */
> static const struct dev_pm_ops bcm_pm_ops = {
> 	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
> @@ -999,6 +1006,7 @@ static struct serdev_device_driver bcm_serdev_driver = {
> 	.driver = {
> 		.name = "hci_uart_bcm",
> 		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
> +		.acpi_match_table = ACPI_PTR(bcm_serdev_acpi_match),
> 	},
> };

I think doing this one device at a time is actually fine. However please add a proper commit message for it explaining it.

Regards

Marcel

