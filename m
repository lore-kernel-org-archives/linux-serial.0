From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC,3/3] Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39
Date: Mon, 2 Oct 2017 17:26:07 +0200
Message-ID: <7eb508bb-c071-1e95-7fa1-1fdd33099a48@redhat.com>
References: <1504786214-1866-4-git-send-email-frederic.danis.oss@gmail.com>
 <be4075c9-110a-1415-3d9b-a631fe91b34f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <be4075c9-110a-1415-3d9b-a631fe91b34f@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>, robh@kernel.org, marcel@holtmann.org, sre@kernel.org, loic.poulain@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 02-10-17 09:07, Hans de Goede wrote:
> Hi,
> 
> First of all Frédéric, thank you very much for working on this,
> this is a very much needed patch series.
> 
> I've been testing this on a GPD pocket which has a BCM2E7E
> ACPI device for the BT which is part of the BCM43562A wifi/bt
> combo on this device.
> 
> 2 remarks:
> 
> 1) The following errors show up with this series:
> 
> [   87.059091] synth uevent: /devices/pci0000:00/8086228A:00/serial1: failed to send uevent
> [   87.059097] serial serial1: uevent: failed to send synthetic uevent
> [   87.059178] synth uevent: /devices/pci0000:00/8086228A:01/serial2: failed to send uevent
> [   87.059180] serial serial2: uevent: failed to send synthetic uevent
> [   87.062665] synth uevent: /devices/pnp0/00:01/serial0: failed to send uevent
> [   87.062671] serial serial0: uevent: failed to send synthetic uevent
> 
> This needs to be fixed :)  I haven't looked into this yet.
> 
> 2) As I already suspected when reading the patches, we cannot
> move the ACPI ids over 1 by 1. The first 2 patches in the series
> cause all BCM2E* ACPI devices to no longer get enumerated as
> platform devices, instead they now get enumerated as serdevs.
> 
> So adding only the known to work ACPI ids to the acpi_match_table
> for the bcm_serdev_driver has the undesirable result that it makes
> sure that the other ACPI-ids will not work, as there are not
> platform devices instantiated for the platform driver to bind to.
> 
> I started with simplifying your patch to this:
> 
>  From f8728f5440c85f7e5584ac1eafa1b090b2042276 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>
> Date: Thu, 7 Sep 2017 14:10:14 +0200
> Subject: [PATCH] Bluetooth: hci_bcm: Make ACPI enumerated HCIs use serdev
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Now that the ACPI subsys instantiates ACPI enumerated HCIs as serdevs,
> the ACPI ids for them should be part of the bcm_serdev_driver's
> acpi_match_table.
> 
> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> [hdegoede: Move all ACPI ids over]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>    drivers/bluetooth/hci_bcm.c | 2 +-
>    1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 2285ca673ae3..4db777bb0049 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -942,7 +942,6 @@ static struct platform_driver bcm_driver = {
>        .remove = bcm_remove,
>        .driver = {
>            .name = "hci_bcm",
> -        .acpi_match_table = ACPI_PTR(bcm_acpi_match),
>            .pm = &bcm_pm_ops,
>        },
>    };
> @@ -988,6 +987,7 @@ static struct serdev_device_driver bcm_serdev_driver = {
>        .driver = {
>            .name = "hci_uart_bcm",
>            .of_match_table = of_match_ptr(bcm_bluetooth_of_match),
> +        .acpi_match_table = ACPI_PTR(bcm_acpi_match),
>        },
>    };
> 
> -- 
> 2.14.2
> 
> Unfortunately that is not good enough. The platform driver code also
> has (runtime) pm support using gpios and a host-wake interrupt, which
> the serdev code all lacks and without driving the shutdown gpio to not
> shutdown the BT device connected to the UART we not only are lacking
> pm support, but BT does not work at all.
> 
> So yesterday evening I did a patch to merge all that into the serdev hci_bcm
> code and throw away the platform code as I don't think any users will be left
> after this. With this functionality for the BCM2E7E ACPI device is restored
> again, without needing to do a btattach from userspace, which is great :)
> 
> I've attached the resulting patch. In the mean time I've realized that
> this approach is going to make merging hard. So I'm going to redo the changes
> so that we can have both a complete (with runtime-pm, gpios, etc.) serdev
> driver and keep the platform driver for now. Then we can first merge the
> hci_bcm changes to make the serdev driver side complete and once those are
> merged merge the matching ACPI subsys changes without having a window in
> between where things will not work.

Ok, I've just finished and send out v1 of a patch-series adding (runtime)pm,
GPIO and IRQ support to the serdev based code paths in hci_bcm.c .

Regards,

Hans
