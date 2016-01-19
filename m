From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file
Date: Mon, 18 Jan 2016 22:56:50 -0500
Message-ID: <20160119035649.GA1696@windriver.com>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

[[PATCH 0/3] 8250: Split Fintek PCIE to UART to independent file] On 19/01/2016 (Tue 10:41) Peter Hung wrote:

> Fintek F81504/508/512 is a multi-functional PCIE device. It contains
> GPIO and serial port with high baudrate & RTS auto direction for RS485.
> 

Some general high level comments (meaning I've not looked at the code in
detail, but have looked at this series) and I wonder about some issues:

> The serial ports support from 50bps to 1.5Mbps with Linux baudrate
> define excluding 1.0Mbps due to not support 16MHz clock source.

How does this differ from what was achieved or possible with the old way
of things?  What was the limitation in the existing 8250 code sharing
that required Fintek code to fork and become independent? 

How much code was just copied 8250 boilerplate vs. being a new
implementation?  The diffstat shows approx 500 lines of new code.  What
does that add vs. just copying?

Don't get me wrong -- forking workarounds for buggy hardware into
smaller workaround files and/or Kconfigs can be a win for everyone else,
but we should be clear on why we do them.

> 
> IC function list:
> 	F81504: Max 2x8 GPIOs and max 4 serial ports
> 			port2/3 are multi-function
> 	F81508: Max 6x8 GPIOs and max 8 serial ports
> 			port2/3 are multi-function, port8/9/10/11 are gpio only
> 	F81512: Max 6x8 GPIOs and max 12 serial ports
> 			port2/3/8/9/10/11 are multi-function
> 
> We'll spilt from 8250_pci.c to new file 8250_fintek_pci.c and make it
> as a kernel module with first & second patch, implements GPIOLIB with
> third patch. 

> 
> Peter Hung (3):
>   serial: 8250_pci: Remove Fintek PCIE UART driver

If someone had 8250 (PCI) builtin before, and Fintek stops working,
they will most guaranteed bisect to this commit above where you remove
support.  That is less than ideal.  We try to avoid code deletions or
Kconfig addtions that will be obvious bisect magnets.

>   8250_fintek_pci: Add Fintek PCIE UART driver

This creates a new Kconfig var. which is default=m.  How does that work
if people were using these for built-in early console support in the
past?  Are these cards universal, or should it be default=m if (...)
based on a Kconfig where this hardware exists?

>   8250_fintek_pci: Add GPIOLIB support

What does this add?  The commit log is not at all clear.  Leaving me to
ask if it does belong in the core PCI support code at all?  I honestly
don't know, since I don't know the hardware details here.  The commit
long logs could go a long way to closing this knowledge gap if the 0/N
listed the shortcomings and the 3/3 here indicated what the GPIO magic
had managed to add.

Again, this may be obvious to others, but the long logs should try and
give a hint to people on the fringe who maybe don't have all the
specific Fintek hardware details when reading the logs.

P.
