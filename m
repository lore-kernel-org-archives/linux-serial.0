From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
Date: Wed, 11 Oct 2017 11:03:54 +0200
Message-ID: <20171011090354.GS4269@localhost>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, rafael@kernel.org
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org, loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de, hdegoede@redhat.com, greg@kroah.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 11, 2017 at 10:32:12AM +0200, Frédéric Danis wrote:
> Add ACPI support for serial attached devices.
> 
> Currently, serial devices are not set as enumerated during ACPI scan for SPI
> or i2c buses (but not for UART). This should also be done for UART serial
> devices.
> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
> 
> This needs Johan Hovold's "serdev: fix registration of second slave" patch.

In theory this series could go in through the acpi-tree without my
fix. It would only affect an error case where an unlikely failure to
register an ACPI serdev device, would prevent the tty-class device from
being registered instead of the controller. That is, something we can
live with until this all converges in 4.15-rc1 if needed.

That said, I think we should consider taking all serdev changes, and
therefore also the ACPI patch, through the tty tree instead in order to
avoid merge conflicts. Rafael?

Johan
