From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 10/12] tty: amba-pl011: add support for 32-bit register
 access
Date: Mon, 16 Nov 2015 18:30:06 +0000
Message-ID: <20151116183006.GZ8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNls-0003kA-Fe@rmk-PC.arm.linux.org.uk>
 <564A1628.9010900@codeaurora.org>
 <20151116175217.GT8644@n2100.arm.linux.org.uk>
 <564A1FA9.8010109@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <564A1FA9.8010109@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 16, 2015 at 12:25:45PM -0600, Timur Tabi wrote:
> How is it touching core files?  Granted, we might still need access_32b in
> vendor_data, but not for SBSA, since SBSA already has a mechanism to
> determine what 32-bit is needed or not.
> 
> Then in pl011_probe(), just have:
> 
> 	uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : 0;

That fails my sanity filters, sorry.  iotype takes these values, and
these values only:

#define UPIO_PORT               (SERIAL_IO_PORT)        /* 8b I/O port access */#define UPIO_HUB6               (SERIAL_IO_HUB6)        /* Hub6 ISA card */
#define UPIO_MEM                (SERIAL_IO_MEM)         /* 8b MMIO access */
#define UPIO_MEM32              (SERIAL_IO_MEM32)       /* 32b little endian */
#define UPIO_AU                 (SERIAL_IO_AU)          /* Au1x00 and RT288x type IO */
#define UPIO_TSI                (SERIAL_IO_TSI)         /* Tsi108/109 type IO */#define UPIO_MEM32BE            (SERIAL_IO_MEM32BE)     /* 32b big endian */

These are exposed to userspace, and they have meaning.

We _could_ augment include/uapi/linux/serial.h and
include/linux/serial_core.h to add a 16-bit LE MMIO accessor identifier,
but hacking it by deciding to re-use SERIAL_IO_PORT for something it
isn't is abhorrent to me.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
