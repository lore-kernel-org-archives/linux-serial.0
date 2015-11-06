From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg
 access
Date: Thu, 5 Nov 2015 21:44:25 -0500
Message-ID: <563C1409.4070804@hurleysoftware.com>
References: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
 <563C07C8.9060506@hurleysoftware.com> <563C09BB.9030706@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <563C09BB.9030706@codeaurora.org>
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
Cc: andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, rmk+kernel@arm.linux.org.uk, jun.nie@linaro.or, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 11/05/2015 09:00 PM, Timur Tabi wrote:
> Peter Hurley wrote:
>> Perhaps I wasn't clear enough in my previous comments regarding this
>> approach; I see no benefit to re-using the pl011 earlycon definition.
>> Just define a completely new earlycon for sbsa32 (and zte):
>>
>> EARLYCON_DECLARE(sbsa32, sbsa32_early_console_setup);
>>
>> Example:
>>     earlycon=sbsa32,0x3ced1000
> 
> Sounds like six of one, half-dozen of another.  But I'm happy to modify my patch accordingly.  It will avoid the strcmp, but I'm not sure it will reduce the actual number of lines of code.

Or better yet, for sbsa32 earlycon, just use the existing port type constructs.
So,

	earlycon=pl011,mmio32,0x3ced1000

which will set port->iotype to UPIO_MEM32, which in turn can be used to select
the correct i/o width in pl011_putc().

Regards,
Peter Hurley
