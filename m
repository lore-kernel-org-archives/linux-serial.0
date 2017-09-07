From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC 2/3] ACPI / scan: Fix enumeration for special UART devices
Date: Fri, 8 Sep 2017 00:26:59 +0200
Message-ID: <20170907222659.GA17417@wunner.de>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-3-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504786214-1866-3-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org, loic.poulain@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 07, 2017 at 02:10:13PM +0200, Frédéric Danis wrote:
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> -static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
> +static bool acpi_is_serial_slave(struct acpi_device *device)
>  {
>  	struct list_head resource_list;
> -	bool is_spi_i2c_slave = false;
> +	bool is_serial_slave = false;
>  
>  	INIT_LIST_HEAD(&resource_list);
> -	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
> -			       &is_spi_i2c_slave);
> +	acpi_dev_get_resources(device, &resource_list, acpi_check_serial_slave,
> +			       &is_serial_slave);
>  	acpi_dev_free_resource_list(&resource_list);
>  
> -	return is_spi_i2c_slave;
> +	return is_serial_slave;
>  }

Commit ca9ef3ab68d3 ("ACPI / scan: Recognize Apple SPI and I2C slaves")
which landed in Linus' tree a few days ago changes the function above
to check for Apple device properties if running on an x86 Mac.

When rebasing, please amend the function to check for:
       fwnode_property_present(&device->fwnode, "baud")

On Macs an empty ResourceTemplate is returned for uart slaves.
Instead the device properties "baud", "parity", "dataBits", "stopBits"
are provided.  An excerpt of the DSDT on a MacBook8,1 is below.

An experimental patch for hci_bcm.c to take advantage of the baud
property is here, though I'm told it doesn't work yet (I don't have
such a machine myself to test):
https://github.com/l1k/linux/commit/8883d6225a92

Discussion on this patch is here:
https://github.com/Dunedan/mbp-2016-linux/issues/29

Thanks,

Lukas

-- cut here --

            Scope (\_SB.PCI0.URT0)
            {
                Device (BLTH)
                {
                    Name (_HID, EisaId ("BCM2E7C"))  // _HID: Hardware ID
                    Name (_CID, "apple-uart-blth")  // _CID: Compatible ID
                    Name (_UID, 0x01)  // _UID: Unique ID
                    Name (_ADR, 0x00)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Name (UBUF, ResourceTemplate ()
                        {
                            UartSerialBus (0x0001C200, DataBitsEight, StopBitsOne,
                                0xC0, LittleEndian, ParityTypeNone, FlowControlHardware,
                                0x0020, 0x0020, "\\_SB.PCI0.URT0",
                                0x00, ResourceProducer, ,
                                )
                        })
                        Name (ABUF, ResourceTemplate ()
                        {
                        })
                        If (LNot (OSDW ()))
                        {
                            Return (UBUF) /* \_SB_.PCI0.URT0.BLTH._CRS.UBUF */
                        }

                        Return (ABUF) /* \_SB_.PCI0.URT0.BLTH._CRS.ABUF */
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
                        {
                            Store (Package (0x08)
                                {
                                    "baud", 
                                    Buffer (0x08)
                                    {
                                         0xC0, 0xC6, 0x2D, 0x00, 0x00, 0x00, 0x00, 0x00   /* ..-..... */
                                    }, 

                                    "parity", 
                                    Buffer (0x08)
                                    {
                                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }, 

                                    "dataBits", 
                                    Buffer (0x08)
                                    {
                                         0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }, 

                                    "stopBits", 
                                    Buffer (0x08)
                                    {
                                         0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   /* ........ */
                                    }
                                }, Local0)
                            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                            Return (Local0)
                        }

                        Return (0x00)
                    }
