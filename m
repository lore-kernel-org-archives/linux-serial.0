From: Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [PATCH] tty: amba-pl011: add support for 32-bit register access
 for earlycon
Date: Sat, 12 Dec 2015 22:06:43 -0800
Message-ID: <20151213060643.GA30667@kroah.com>
References: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
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
Cc: peter@hurleysoftware.com, andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, jslaby@suse.com, rmk+kernel@arm.linux.org.uk, jun.nie@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 06, 2015 at 06:18:23PM -0600, Timur Tabi wrote:
> Add support the "mmio32" earlycon option for the pl011 device.  If
> specified in the earlycon parameter, all reads/writes to pl011 registers
> during early console will use 32-bit accessors.  Normally the function
> uses 8-bit writes.
> 
> Normal console uses the "access_32b" field of the vendor data structure
> to determine whether the registers needs 32-bit accessors.  Early console
> is used before the vendor data is available, so we need a different
> mechanism to choose the accessor.
> 
> Example:
> 
> 	earlycon=pl011,mmio32,0x3ced1000
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
> 
> This patch applies on top of Russell's 12-part amba-pl011.c patchset.

Which I didn't apply, so can you resend this after he resends his?

thanks,

greg k-h
