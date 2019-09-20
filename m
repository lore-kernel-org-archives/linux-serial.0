From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
Date: Fri, 20 Sep 2019 10:50:25 +0200
Message-ID: <79c9533f-882d-f2b2-b6f3-b94fa49b4367@redhat.com>
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919195624.1140941-1-luzmaximilian@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Maximilian,

Interesting patch. Some comments about the i2c situation below.

Also I will give this a test-run on some of the existing devices
which rely on the instantiation of serdev devices for ACPI
devices which are childs of the uart device.

On 19-09-2019 21:56, Maximilian Luz wrote:
> When registering a serdev controller, ACPI needs to be checked for
> devices attached to it. Currently, all immediate children of the ACPI
> node of the controller are assumed to be UART client devices for this
> controller. Furthermore, these devices are not searched elsewhere.
>=20
> This is incorrect: Similar to SPI and I2C devices, the UART client
> device definition (via UARTSerialBusV2) can reside anywhere in the ACPI
> namespace as resource definition inside the _CRS method and points to
> the controller via its ResourceSource field. This field may either
> contain a fully qualified or relative path, indicating the controller
> device. To address this, we need to walk over the whole ACPI namespace,
> looking at each resource definition, and match the client device to the
> controller via this field.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> This patch is similar to the the implementations in drivers/spi/spi.c
> (see commit 4c3c59544f33e97cf8557f27e05a9904ead16363) and
> drivers/i2c/i2c-core-acpi.c. However, I think that there may be an
> issues with these two implementations: Both walk over the whole ACPI
> namespace, but only match the first SPI or I2C resource (respectively),
> so I think there may be problems when multiple SPI or I2C resources are
> defined under the same ACPI device node (as in second or third SPI/I2C
> resource definitions being ignored).

Right, so from the i2c side of things, the story with multiple
I2cSerialBusV2 resources is that normally we want to instantiate
only 1 kernel "struct device" for 1 ACPI "Device()" definition.

If a single I2C chip/device listens on multiple addresses then
usually the other addresses can be derived from the first one and
the device-driver can get a handle to access the other addresses by
using e.g. i2c_new_dummy or i2c_new_secondary_device.

With that said of course there are exceptions where vendors get
creative and put multiple I2cSerialBusV2 resources in a single
ACPI "Device()" even though they point to separate chips.

For this we have some special handling in:
drivers/platform/x86/i2c-multi-instantiate.c

Also note how drivers/platform/x86/i2c-multi-instantiate.c maps the
original ACPI HID as e.g. "BSG1160" to per device match strings,
because if there are multiple I2cSerialBusV2 resources and they
point to separate chips, then we need something to get the right
driver to bind to each I2cSerialBusV2 address, so the normal
modalias of e.g. acpi:BSG1160 is no good, we need a different modalias
for each I2cSerialBusV2 address.

Another way of looking at this is a typical _CRS for a device with
*SerialBusV2 resources will also have 1 or more Interrupt resources
and 1 or more GPIO resources. We are not instantiating separate
"struct device"-s in the kernel for each of those, since all the
resources together describe a single device, so we instantiate e.g.
an i2c_client and then the i2c_driver's probe method calls e.g.
platform_get_irq() to get the IRQ(s).

Given the above I think you may want to also limit your patch to
only instantiate a "struct device" for the first UARTSerialBusV2
in an ACPI "Device()"'s  .

I hope this sheds some clarity on the (muddy) situation wrt
I2cSerialBusV2 handling.

Regards,

Hans
