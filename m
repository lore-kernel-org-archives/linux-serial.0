From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 00/12] Prepare amba-pl011 for ZTE UART support
Date: Sat, 5 Dec 2015 13:49:59 -0500
Message-ID: <566331D7.7010105@hurleysoftware.com>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Timur Tabi <timur@tabi.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Jun Nie <jun.nie@linaro.org>, Andrew.Jackson@arm.com, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 11/16/2015 12:39 PM, Russell King - ARM Linux wrote:
> This series is a re-posting of the updates to the AMBA PL011 primecell
> serial port.
> 
> ZTE UARTs differ from the ARM version in two ways: the address layout
> of the register set is substantially different, and the register access
> size needs to be 32-bit.
> 
> This series converts the driver to use a lookup table to address the
> first point, and switches to use a flag to indicate the access size.
> We also switch the driver to use relaxed accessors, which is safe as
> none of these are responsible for DMA configuration.

For series,

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

I made some individual notes for stuff that could/should be fixed with
follow-up patches.

Greg,

Just a heads-up: this series has merge conflicts with Timur's
"serial: amba-pl011: use cpu_relax when polling registers"

Regards,
Peter Hurley
