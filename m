From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 2/2] ACPI / scan: Fix enumeration for special UART
 devices
Date: Sun, 15 Oct 2017 11:57:23 +0200
Message-ID: <20171015095723.GA15524@wunner.de>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507710734-32520-3-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507710734-32520-3-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org, loic.poulain@gmail.com, johan@kernel.org, hdegoede@redhat.com, rafael@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 11, 2017 at 10:32:14AM +0200, Frédéric Danis wrote:
> UART devices is expected to be enumerated by SerDev subsystem.
> 
> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
> enumerated, allowing them to be enumerated by their respective parents.
> 
> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for serial
> devices on serial buses (SPI, I2C or UART).
> 
> On Macs an empty ResourceTemplate is returned for uart slaves.
> Instead the device properties "baud", "parity", "dataBits", "stopBits" are
> provided. Add a check for "baud" in acpi_is_serial_bus_slave().

Tested-by: Ronald Tschalär <ronald@innovation.ch>
Tested-by: Peter Y. Chuang <peteryuchuang@gmail.com>

Ronald and Peter both report success for the above-mentioned Mac-specific
change on GitHub: https://github.com/l1k/linux/pull/1#issuecomment-336126330

Thanks,

Lukas
