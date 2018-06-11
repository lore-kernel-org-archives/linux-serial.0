From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 21/24] rave-sp: Support for variants on modalias
 drivers
Date: Mon, 11 Jun 2018 15:38:16 +0200
Message-ID: <8912BE88-4AA3-44ED-9828-57666CB31522@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-22-ricardo.ribalda@gmail.com>
 <CAHp75VeeF4eNjyhhBxocRXboN3fRY=RjrT6QQ72=QJ-s8gvSfA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeeF4eNjyhhBxocRXboN3fRY=RjrT6QQ72=QJ-s8gvSfA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

>> Rave-sp behaves differently based on the device variant.
> 
> 
>>        sp->variant = of_device_get_match_data(dev);
>> +       if (!sp->variant) {
>> +               id = serdev_match_id(rave_sp_serdev_id, serdev);
> 
> I think you may leave the ID table where it is in the code and use link.
> 
>> +               if (id)
>> +                       sp->variant = (const struct rave_sp_variant *)
>> +                                                       id->driver_data;
>> +       }
> 
> Perhaps a helper like it's done for ACPI / OF cases?
> 
> [device_get_match_data() -> ]
>  of_fwnode_device_get_match_data()
>  acpi_fwnode_device_get_match_data()

something like that and frankly this is trying to hard. This driver is currently really DT specific and can be fixed up later. It is causing a lot of noise in this patch series. I would really urge to focus on the core changes get prominent drivers support. I think hci_bcm.c is a good example since a) we need to fix up Edison and b) new ACPI based tablets might be able to allow for easy testing.

Regards

Marcel
