From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Sat, 7 Oct 2017 17:19:34 +0200
Message-ID: <20171007151934.GJ2618@localhost>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1507107090-15992-3-git-send-email-frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 04, 2017 at 10:51:30AM +0200, Frédéric Danis wrote:
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
> 
> Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

So just to reiterate what I just mentioned in a comment to one of Hans's
hci_bcm patches:

This one would silently break PM for such devices on any system which
does not have serdev enabled (as the corresponding platform devices
would no longer be registered). And with serdev enabled, hciattach
(btattach) would start failing as the tty device would no longer be
registered (but I assume everyone is aware of that, and fine with it, by
now).

Perhaps the hci_bcm driver should start depending on
SERIAL_DEV_CTRL_TTYPORT when ACPI is enabled?

Johan
