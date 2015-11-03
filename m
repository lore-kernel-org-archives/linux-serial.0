From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 10/11] tty: amba-pl011: add support for 32-bit register
 access
Date: Tue, 3 Nov 2015 08:57:05 -0600
Message-ID: <5638CB41.1000807@codeaurora.org>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcw4-0007Ct-PP@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1Ztcw4-0007Ct-PP@rmk-PC.arm.linux.org.uk>
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
> -	return readw(uap->port.membase + pl011_reg_to_offset(uap, reg));
> +	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
> +
> +	return uap->access_32b ? readl(addr) : readw(addr);

Ok, ignore my previous email.  I just noticed this.

This version is fine, except that it now performs a runtime check for 
every I/O access.  Isn't that too much overhead?  access_32b will always 
be either True or False for the life of the entire SOC.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
