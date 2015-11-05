From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 10/11] tty: amba-pl011: add support for 32-bit register
 access
Date: Wed, 4 Nov 2015 23:46:25 -0500
Message-ID: <563ADF21.8000405@hurleysoftware.com>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcw4-0007Ct-PP@rmk-PC.arm.linux.org.uk> <5638CB41.1000807@codeaurora.org>
 <20151103161939.GB8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103161939.GB8644@n2100.arm.linux.org.uk>
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

On 11/03/2015 11:19 AM, Russell King - ARM Linux wrote:
> On Tue, Nov 03, 2015 at 08:57:05AM -0600, Timur Tabi wrote:
>> Russell King wrote:
>>> -	return readw(uap->port.membase + pl011_reg_to_offset(uap, reg));
>>> +	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
>>> +
>>> +	return uap->access_32b ? readl(addr) : readw(addr);
>>
>> Ok, ignore my previous email.  I just noticed this.
>>
>> This version is fine, except that it now performs a runtime check for every
>> I/O access.  Isn't that too much overhead?  access_32b will always be either
>> True or False for the life of the entire SOC.
> 
> It's a balance between a few more branches and killing six registers
> (r0 - r3, ip, lr) on every register access due to a function call.
> If GCC was a reasonable compiler, it could be done without incuring
> any branches, merely by using conditional instructions, but GCC on
> ARM really sucks - it wants to reload the base address, offset and
> access_32b flag on every device access despite the struct being
> marked const.

The compiler reloads are probably due to the barriers in readw()/writew();
I think the relaxed i/o accessor variants avoid the reloads.

Regards,
Peter Hurley
