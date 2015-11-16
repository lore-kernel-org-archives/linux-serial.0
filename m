From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 10/12] tty: amba-pl011: add support for 32-bit register
 access
Date: Mon, 16 Nov 2015 14:52:00 -0600
Message-ID: <564A41F0.3030105@codeaurora.org>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNls-0003kA-Fe@rmk-PC.arm.linux.org.uk> <564A1628.9010900@codeaurora.org>
 <20151116175217.GT8644@n2100.arm.linux.org.uk>
 <564A1FA9.8010109@codeaurora.org>
 <20151116183006.GZ8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 11/16/2015 12:30 PM, Russell King - ARM Linux wrote:
> We_could_  augment include/uapi/linux/serial.h and
> include/linux/serial_core.h to add a 16-bit LE MMIO accessor identifier,
> but hacking it by deciding to re-use SERIAL_IO_PORT for something it
> isn't is abhorrent to me.

I don't want to belabor this, because there's nothing wrong with your 
patch.  I can understand that we shouldn't be mis-using a variable, but 
I don't understand how this is a misuse of SERIAL_IO_PORT.

We could do something like:

#define UPIO_PORT               (SERIAL_IO_PORT)
#define UPIO_HUB6               (SERIAL_IO_HUB6)
#define UPIO_MEM                (SERIAL_IO_MEM)		// 8-bit
#define UPIO_MEM32              (SERIAL_IO_MEM32)   	// 32-bit
#define UPIO_AU                 (SERIAL_IO_AU)
#define UPIO_TSI                (SERIAL_IO_TSI)
#define UPIO_MEM32BE            (SERIAL_IO_MEM32BE)
#define UPIO_MEMx		(SERIAL_IO_MEMx)	// any bit

uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : UPIO_MEMx;

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
