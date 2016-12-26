From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] serial: 8250_dw: #ifdef out dw8250_acpi_match if ACPI
 isn't set
Date: Mon, 26 Dec 2016 13:28:23 +0800
Message-ID: <20161226132823.65f6ff6b@xhacker>
References: <20161223123355.1370-1-jszhang@marvell.com>
        <20161223180923.GA26878@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161223180923.GA26878@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On Fri, 23 Dec 2016 19:09:23 +0100 Greg KH wrote:
> 
> On Fri, Dec 23, 2016 at 08:33:55PM +0800, Jisheng Zhang wrote:
> > dw8250_acpi_match is used only when ACPI is enabled. Fix the following
> > gcc warning when W=1 is set:
> > 
> > drivers/tty/serial/8250/8250_dw.c:640:36: warning: 'dw8250_acpi_match'
> > defined but not used [-Wunused-const-variable=]  
> 
> Don't set W=1 then, this type of "fix" is foolish and is just going to
> make code messier, sorry.

Per my understanding of commit c9c6837d3931 ("kbuild: move
-Wunused-const-variable to W=1 warning level"), "Once we have eliminated
the majority of the warnings for both, we can put them back into the
default list.", so we'll have such warning one day without W=1 in the
future.

And FWICT, other devices drivers which could be used in ACPI and DT also
add the "#ifdef ACPI" to the acpi match table, such as:

drivers/ata/ahci_xgene.c
drivers/dma/dw/platform.c
drivers/i2c/busses/i2c-designware-platdrv.c
drivers/hid/i2c-hid/i2c-hid.c
drivers/usb/dwc3/core.c

Thanks,
Jisheng
