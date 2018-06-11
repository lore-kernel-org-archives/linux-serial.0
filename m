From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 17:28:16 +0200
Message-ID: <B4BC9DB0-2D7C-4F9D-99FE-8227D4DC3D54@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com>
 <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
 <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, "David S. Miller" <davem@davemloft.net>, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, netdev@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Marcel,

>> the commit message is misleading me. If I build something with ACPI or DT support, then modinfo will show all modalias information for ACPI and DT compatible strings. What else does udev/modprobe actually need? Is something broken with the modalias export?
> 
> The main purpose is to autoload drivers for devices that have been
> created via sysfs or another module.
> 
> Eg1: We have a serial port on a standard computer that has connected a
> GPS module. Since it is something that is not in the ACPI nor the DT
> table the user will run
> 
> echo serdev_gps > /sys/bus/serial/devices/serial0/new_device
> 
> Eg2 module: https://github.com/ribalda/linux/blob/415bb3f0076c2b846ebe5409589b8e1e3004f55a/drivers/tty/serdev/test_platform.c
> 
> Modprobe does not know what module to load for that device unless
> there is a matching MODULE_DEVICE_TABLE
> Today, we have the same functionality for i2c devices
> https://www.kernel.org/doc/Documentation/i2c/instantiating-devices

but why does this have to be the driver name? I would rather say, create a generic string that describes the hardware and then use that. I think you also want the special handling, as from USB for example, that lets you reference an existing .compatible or ACPI ID as reference so that the driver_data is copied.

Regards

Marcel
