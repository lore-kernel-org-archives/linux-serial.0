From: Johan Hovold <johan@kernel.org>
Subject: Re: SV: Serial port of dw-abp-uart missing due to serial dev bus
 activation
Date: Fri, 26 Oct 2018 11:19:32 +0200
Message-ID: <20181026091932.GE27852@localhost>
References: <20181025094145.GB9071@luon.net>
 <1540544242255.28274@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1540544242255.28274@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Einar Vading <einar.vading@axis.com>
Cc: Paul van Tilburg <paulvt@debian.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Shrirang Bagul <shrirang.bagul@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-serial@vger.kernel.org

[ Adding Hans, Rafael, Rob and more people from the below thread. ]

On Fri, Oct 26, 2018 at 08:57:22AM +0000, Einar Vading wrote:
> Hi,
> 
> I think that this could explain your problem: https://marc.info/?l=linux-acpi&m=152464754828003&w=2
> 
> "In short, when we added ACPI support to serdev, serdev started claiming
> all slave devices to UARTs that happen to described by ACPI. Regardless
> of whether there's a kernel driver for them or not."

Right.

> But I don't know if it is fixed.

I'm afraid that discussion didn't go anywhere, so this hasn't been
addressed as far as I know.

Johan

> ________________________________________
> Från: linux-serial-owner@vger.kernel.org <linux-serial-owner@vger.kernel.org> för Paul van Tilburg <paulvt@debian.org>
> Skickat: den 25 oktober 2018 11:41
> Till: linux-serial@vger.kernel.org
> Ämne: Serial port of dw-abp-uart missing due to serial dev bus activation
> 
> Dear all,
> 
> This is a forward of a Debian bug report at the request of the Debian
> kernel maintainers.  The original bug report is located here:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911831
> 
> Since the upgrade of our system from Debian 9 (Stretch) to 10 (Buster),
> but also from Ubuntu 16.04 LTS (Xenial) to 18.04 LTS (Bionic), the
> serial port of our Atom E3950-based board can no longer be used.
> 
> I have traced the cause to the enabling of CONFIG_SERIAL_DEV_BUS=y and
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=y in the kernel config of versions
> 4.17.0-3 (Debian) and 4.15.0.36.38 (Ubuntu).
> 
> In a working system the dw-abp-uart driver exposes two tty devices:
> 
>   # dmesg | grep tty
>   [    2.437836] dw-apb-uart.2: ttyS0 at MMIO 0x8121c000 (irq = 4, base_baud = 115200) is a 16550A
>   [    2.439193] dw-apb-uart.3: ttyS1 at MMIO 0x8121a000 (irq = 6, base_baud = 115200) is a 16550A
> 
> of which we always use ttyS1.  (I do not know why ttyS0 does nothing,
> supposedly this system has only one UART?) The corresponding udev info
> is:
> 
>   looking at device '/devices/pci0000:00/0000:00:18.0/dw-apb-uart.2/tty/ttyS0':
>     KERNEL=="ttyS0"
>     SUBSYSTEM=="tty"
>     DRIVER==""
> 
>   looking at parent device '/devices/pci0000:00/0000:00:18.0/dw-apb-uart.2':
>     KERNELS=="dw-apb-uart.2"
>     SUBSYSTEMS=="platform"
>     DRIVERS=="dw-apb-uart"
>     ATTRS{driver_override}=="(null)"
> 
>   looking at parent device '/devices/pci0000:00/0000:00:18.0':
>     KERNELS=="0000:00:18.0"
>     SUBSYSTEMS=="pci"
>     DRIVERS=="intel-lpss"
>     ATTRS{ari_enabled}=="0"
>     ATTRS{broken_parity_status}=="0"
>     ATTRS{class}=="0x118000"
>     ATTRS{consistent_dma_mask_bits}=="32"
>     ATTRS{d3cold_allowed}=="1"
>     ATTRS{device}=="0x5abc"
>     ATTRS{dma_mask_bits}=="32"
>     ATTRS{driver_override}=="(null)"
>     ATTRS{enable}=="1"
>     ATTRS{index}=="9"
>     ATTRS{irq}=="4"
>     ATTRS{label}=="Onboard - Other"
>     ATTRS{local_cpulist}=="0-3"
>     ATTRS{local_cpus}=="f"
>     ATTRS{msi_bus}=="1"
>     ATTRS{numa_node}=="-1"
>     ATTRS{revision}=="0x0b"
>     ATTRS{subsystem_device}=="0x7270"
>     ATTRS{subsystem_vendor}=="0x8086"
>     ATTRS{vendor}=="0x8086"
> 
>   looking at device '/devices/pci0000:00/0000:00:18.2/dw-apb-uart.3/tty/ttyS1':
>     KERNEL=="ttyS1"
>     SUBSYSTEM=="tty"
>     DRIVER==""
> 
>   looking at parent device '/devices/pci0000:00/0000:00:18.2/dw-apb-uart.3':
>     KERNELS=="dw-apb-uart.3"
>     SUBSYSTEMS=="platform"
>     DRIVERS=="dw-apb-uart"
>     ATTRS{driver_override}=="(null)"
> 
>   looking at parent device '/devices/pci0000:00/0000:00:18.2':
>     KERNELS=="0000:00:18.2"
>     SUBSYSTEMS=="pci"
>     DRIVERS=="intel-lpss"
>     ATTRS{ari_enabled}=="0"
>     ATTRS{broken_parity_status}=="0"
>     ATTRS{class}=="0x118000"
>     ATTRS{consistent_dma_mask_bits}=="32"
>     ATTRS{d3cold_allowed}=="1"
>     ATTRS{device}=="0x5ac0"
>     ATTRS{dma_mask_bits}=="32"
>     ATTRS{driver_override}=="(null)"
>     ATTRS{enable}=="1"
>     ATTRS{index}=="10"
>     ATTRS{irq}=="6"
>     ATTRS{label}=="Onboard - Other"
>     ATTRS{local_cpulist}=="0-3"
>     ATTRS{local_cpus}=="f"
>     ATTRS{msi_bus}=="1"
>     ATTRS{numa_node}=="-1"
>     ATTRS{revision}=="0x0b"
>     ATTRS{subsystem_device}=="0x7270"
>     ATTRS{subsystem_vendor}=="0x8086"
>     ATTRS{vendor}=="0x8086"
> 
> 
>   looking at parent device '/devices/pci0000:00':
>     KERNELS=="pci0000:00"
>     SUBSYSTEMS==""
>     DRIVERS==""
> 
> However, when the serial device bus with the serial TTY control port is
> enabled, ttyS1 disappears:
> 
>   # dmesg | grep tty
>   [    2.499748] dw-apb-uart.2: ttyS0 at MMIO 0x8121c000 (irq = 4, base_baud = 115200) is a 16550A
>   [    2.500852] dw-apb-uart.3: ttyS1 at MMIO 0x8121a000 (irq = 6, base_baud = 115200) is a 16550A
>   [    2.500996] serial serial0: tty port ttyS1 registered
> 
> The difference in the udev info is:
> 
>   looking at device '/devices/pci0000:00/0000:00:18.2/dw-apb-uart.3/serial0/serial0-0':
>     KERNEL=="serial0-0"
>     SUBSYSTEM=="serial"
>     DRIVER==""
> 
>   looking at parent device '/devices/pci0000:00/0000:00:18.2/dw-apb-uart.3/serial0':
>     KERNELS=="serial0"
>     SUBSYSTEMS=="serial"
>     DRIVERS==""
> 
> and there is no longer tty under /sys/devices/pci0000:00/0000:00:18.2/dw-apb-uart.3.
> 
> Attached is the full dmesg output for the broken tty port instance.  Let
> me know if more information is required.
> 
> I must also note that I am currently not a list member and am not very
> knowledgeable about the serial interface internals, so feel free to
> point me to any further reading to understand what is going on under the
> hood.
> 
> Kind regards,
> Paul van Tilburg
