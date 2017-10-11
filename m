From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 1/2] serdev: Add ACPI support
Date: Wed, 11 Oct 2017 10:43:59 +0200
Message-ID: <20171011084359.GR4269@localhost>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507710734-32520-2-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507710734-32520-2-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org, loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de, hdegoede@redhat.com, rafael@kernel.org, greg@kroah.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 11, 2017 at 10:32:13AM +0200, Frédéric Danis wrote:
> This patch allows SerDev module to manage serial devices declared as
> attached to an UART in ACPI table.
> 
> acpi_serdev_add_device() callback will only take into account entries
> without enumerated flag set. This flags is set for all entries during
> ACPI scan, except for SPI and I2C serial devices, and for UART with
> 2nd patch in the series.
> 
> Check if a serdev device as been allocated during acpi_walk_namespace()
> to prevent serdev controller registration instead of the tty-class device.
> 
> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Johan Hovold <johan@kernel.org>

Thanks for doing this work.

Johan
