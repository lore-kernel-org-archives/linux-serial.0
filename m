From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 7/9] Bluetooth: hci_bcm: Make acpi_probe get irq from ACPI
 resources
Date: Wed, 4 Oct 2017 15:26:57 +0200
Message-ID: <e648b8ea-923a-6053-e43b-3f48e36d1eb9@redhat.com>
References: <20171002152356.4714-1-hdegoede@redhat.com>
 <20171002152356.4714-8-hdegoede@redhat.com>
 <c06ae2d7-9628-ad70-2509-eca18ba16f0a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <c06ae2d7-9628-ad70-2509-eca18ba16f0a@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 03-10-17 19:21, Frédéric Danis wrote:
> Hi Hans,
> 
> First of all, many thanks for your work on this, it helped me a lot to get full Bluetooth on my Asus T100.

You're welcome thank you for your patches tying everything
together, it will be good to have this all finally working
OOTB.

> Le 02/10/2017 à 17:23, Hans de Goede a écrit :
>> The ACPI subsys is going to move over to instantiating ACPI enumerated
>> HCIs as serdevs, rather then as platform devices.
>>
>> So we need to make bcm_acpi_probe() suitable for use on non platform-
>> devices too, which means that we cannot rely on platform_get_irq()
>> getting called.
>>
>> This commit modifies bcm_acpi_probe() to directly get the irq from
>> the ACPI resources, this is a preparation patch for adding (runtime)pm
>> support to the serdev path.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/bluetooth/hci_bcm.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 5c8371d8aace..48a428909958 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -805,6 +805,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>>       const struct dmi_system_id *dmi_id;
>>       const struct acpi_gpio_mapping *gpio_mapping = acpi_bcm_int_last_gpios;
>>       const struct acpi_device_id *id;
>> +    struct resource_entry *entry;
>>       int ret;
>>       /* Retrieve GPIO data */
>> @@ -821,6 +822,13 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>>                        &resources, bcm_resource, dev);
>>       if (ret < 0)
>>           return ret;
>> +
>> +    resource_list_for_each_entry(entry, &resources) {
>> +        if (resource_type(entry->res) == IORESOURCE_IRQ) {
>> +            dev->irq = entry->res->start;
>> +            break;
>> +        }
>> +    }
>>       acpi_dev_free_resource_list(&resources);
>>       dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
> 
> You should also return 0 in bcm_resource(), otherwise the resources list is empty, ending up with "BCM irq: -22" trace in dmesg.

Right, good one. I did not notice that as on the device I was testing with
the IRQ is specified in the DSDT as a GpioInt rather as an Interrupt.

Fixed for v2 of this series.

Regards,

Hans
