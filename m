From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 10/12] tty: amba-pl011: add support for 32-bit register
 access
Date: Mon, 16 Nov 2015 16:18:19 -0500
Message-ID: <564A481B.6050304@hurleysoftware.com>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNls-0003kA-Fe@rmk-PC.arm.linux.org.uk> <564A1628.9010900@codeaurora.org>
 <20151116175217.GT8644@n2100.arm.linux.org.uk>
 <564A1FA9.8010109@codeaurora.org>
 <20151116183006.GZ8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151116183006.GZ8644@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Timur Tabi <timur@codeaurora.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 11/16/2015 01:30 PM, Russell King - ARM Linux wrote:
> On Mon, Nov 16, 2015 at 12:25:45PM -0600, Timur Tabi wrote:
>> How is it touching core files?  Granted, we might still need access_32b in
>> vendor_data, but not for SBSA, since SBSA already has a mechanism to
>> determine what 32-bit is needed or not.
>>
>> Then in pl011_probe(), just have:
>>
>> 	uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : 0;
> 
> That fails my sanity filters, sorry.  iotype takes these values, and
> these values only:
> 
> #define UPIO_PORT               (SERIAL_IO_PORT)        /* 8b I/O port access */#define UPIO_HUB6               (SERIAL_IO_HUB6)        /* Hub6 ISA card */
> #define UPIO_MEM                (SERIAL_IO_MEM)         /* 8b MMIO access */
> #define UPIO_MEM32              (SERIAL_IO_MEM32)       /* 32b little endian */
> #define UPIO_AU                 (SERIAL_IO_AU)          /* Au1x00 and RT288x type IO */
> #define UPIO_TSI                (SERIAL_IO_TSI)         /* Tsi108/109 type IO */#define UPIO_MEM32BE            (SERIAL_IO_MEM32BE)     /* 32b big endian */
> 
> These are exposed to userspace, and they have meaning.
> 
> We _could_ augment include/uapi/linux/serial.h and
> include/linux/serial_core.h to add a 16-bit LE MMIO accessor identifier,
> but hacking it by deciding to re-use SERIAL_IO_PORT for something it
> isn't is abhorrent to me.


The UPIO_* comments were added recently.

The proliferation of different bitness and endianness implied that
UPIO_MEM was strictly 8-bit, but that's not true and I'll remove the
UPIO_MEM bitness notation from the header.

The uapi header has no such notation and I think the original value and
meaning of UPIO_MEM used by the pl011 driver should remain.

I see no real issue with using different iotype values to describe
the register access method required when other than what the driver
originally used.

Regards,
Peter Hurley
