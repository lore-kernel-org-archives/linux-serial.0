From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 01/11] tty: amba-pl011: add register accessor functions
Date: Tue, 3 Nov 2015 08:53:49 -0600
Message-ID: <5638CA7D.8000404@codeaurora.org>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1ZtcvK-0007Bt-91@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1ZtcvK-0007Bt-91@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

Russell King wrote:
> +static unsigned int pl011_read(void __iomem *base, unsigned int reg)
> +{
> +	return readw(base + reg);
> +}
> +
> +static void pl011_write(unsigned int val, void __iomem *base, unsigned int reg)
> +{
> +	writew(val, base + reg);
> +}

This has the same problem as the original, in that it doesn't support 
the SBSA subtype 13.

I'll post my version soon that addresses this.  Maybe you can consider 
it as a replacement for your patch 1/11.


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
