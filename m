From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] serdev: Update drivers/tty/serdev/Kconfig for
 ACPI serdev support
Date: Sun, 8 Oct 2017 09:26:55 +0200
Message-ID: <20171008072655.GA3444@kroah.com>
References: <82b477ef-757a-c953-45e8-fd68b28286e5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <82b477ef-757a-c953-45e8-fd68b28286e5@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, hdegoede@redhat.com, frederic.danis.oss@gmail.com, robh@kernel.org, sre@kernel.org, Loic Poulain <loic.poulain@gmail.com>, lukas@wunner.de, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 08, 2017 at 02:20:07PM +1100, Ian W MORRISON wrote:
> ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented for serdev. This is only possible if serdev support is compiled in as the code hooks into TTY. Otherwise PM will silently break as the corresponding platform devices would no longer be registered and as the tty class device is also gone and hciattach (btattach) will also fail.
> 
> This patch set addresses this by making BT_HCIUART_BCM dependent on SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS and ensures that if SERIAL_DEV_BUS is selected is the code is build it.

Please properly line-wrap your changelog comments like your editor is
asking you to do...

thanks,

greg k-h
