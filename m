From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Mon, 28 Jan 2013 02:58:00 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88BF46D2@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
 <20130125214121.GA30924@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88BF41C7@SHSMSX101.ccr.corp.intel.com>
 <20130126034232.GB5066@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130126034232.GB5066@kroah.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Jiri Slaby (jslaby@suse.cz)" <jslaby@suse.cz>, "Heikki Krogerus (heikki.krogerus@linux.intel.com)" <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi, Greg

Thanks for the comments.
How I wished so much that I can have you opinion earlier because I have some design aspects need to be discussed with the driver core and PM core designers.

> > Considering a more complex scenario:
> > There are two or more target devices under the ttyS0 and can be selected by
> some external GPIOs.
> > Actually, BIOS will do this putting many test devices under the ttyS0.
> > The step 3 then can never be put ahead of step 2.

What about this DSDT, this is what we actually can obtain from some real BIOS.
How can a single ttyS0 attribute file enumerate so many slave devices under single UART:
            Device (UA00)
            {
                Device (BTH0)
                {
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Name (UBUF, ResourceTemplate ()
                        {
                            UartSerialBus (...)
                        })
                        Return (UBUF)
                    }
                }

                Device (GPS0)
                {
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Name (UBUF, ResourceTemplate ()
                        {
                            UartSerialBus (...)
                        })
                        Return (UBUF)
                    }
                }

                Device (SER0)
                {
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Name (UBUF, ResourceTemplate ()
                        {
                            UartSerialBus (...)
                        })
                        Return (UBUF)
                    }
                }

                Device (SER1)
                {
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Name (UBUF, ResourceTemplate ()
                        {
                            UartSerialBus (...)
                        })
                        Return (UBUF)
                    }
                }
            }

This DSDT is compatible with recent ACPI 5.0 updates on the new functionality - UART serial enumeration.

> > (It might be implemented using some exist kernel mechanisms like the
> > SCSI contribute container devices...)
> 
> No, don't look at SCSI for sysfs ideas or driver core usage, it's a mess and is
> wrong in places.  Look at how USB and PCI do it if you are curious how to
> implement a bus.

Yes, I can see this.
I've completed a driver model investigation prior to authorizing this patch set.
IMO, there are many driver models existed in the kernel:
1. bus driver model: where the subsystem is a bus, IMO, hardware related PM operations should only be enabled on such devices.
2. user driver model: there are devt(s) associated to such devices and the subsystem is a class
3. transport driver model: the SCSI hacks where SCSI happens to be a bus thus ATA has to be a transport class
And so on (system driver model, net driver model)...
IMO, a PM friendly device driver hierarchy should:
1. implement hardware related PM operations on bus devices.
2. other devices should call APIs exported by the functionality of the bus to inc/dec PM refcnts where the bus devices resident.
Thus, tty class device is not suitable for enabling hardware related PM operations that might appear in the slave devices.

If you've monitored this series of patch set, you'll find the v2 patches.
Here is the links:
http://marc.info/?l=linux-serial&m=135467950218063&w=2
http://marc.info/?l=linux-serial&m=135467951018065&w=2
http://marc.info/?l=linux-serial&m=135467951818068&w=2
http://marc.info/?l=linux-serial&m=135467953118073&w=2
http://marc.info/?l=linux-serial&m=135467953218074&w=2

I actually followed the following existing kernel facilities to implement my target: ACPI 5.0 UART enumeration:
1. following the usb-serial-bus, implemented the serial-bus and created target devices below the serial-bus.
2. following the ACPI 5.0 I2C enumeration, implemented the UART enumeration.

According to Alan's comments, implementing tty_enum bus can help to extend this benefit to other serial drivers which do not relies on the serial layer (CONFIG_SERIAL_CORE).

Considering the analogy to the SPI bus layer:
Platform bus device / pci bus device
  |
Spi master device (this is also a class device and can be easily converted to a devt device)
  |
Spi slave device (spi bus device)
The PM call chains will call the APIs exported by the SPI cores which will:
1. inc/dec PM refcnts implemented in the spi bus device drivers for spi slaves and
2. inc/dec PM refcnts implemented in the pdev/pci bus device drivers for spi masters.

This hierarchy looks reasonable if we convert it into a Windows compatible driver model:
Platform bus device / pci bus device (PDOs)
  |
Spi master device (FDOs)
  |
Spi slave device (PDOs)

Thus, I accepted the suggestion, moving the uart target device from uart layer.
This has been done in the v3-v4 revisions.
And I don't see any objections in the community, thus I converted the v4 into v5, removing the RFC marks.
Now the hierarchy will look like:
Platform bus device / pci bus device (PDOs)
  |
Tty communication device (FDOs)
  |
tty slave device (PDOs, the new tty_enum bus device)

Which one do you think is better? V2 or V5 (I have completed the test and now I have the V6 ones, I can send them out if you think the tty_enum bus is better than the serial_bus).

Thanks and best regards
-Lv
