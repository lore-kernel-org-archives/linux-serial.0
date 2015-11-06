From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg
 access
Date: Thu, 5 Nov 2015 20:00:27 -0600
Message-ID: <563C09BB.9030706@codeaurora.org>
References: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
 <563C07C8.9060506@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <563C07C8.9060506@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, rmk+kernel@arm.linux.org.uk, jun.nie@linaro.or, linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Peter Hurley wrote:
> Perhaps I wasn't clear enough in my previous comments regarding this
> approach; I see no benefit to re-using the pl011 earlycon definition.
> Just define a completely new earlycon for sbsa32 (and zte):
>
> EARLYCON_DECLARE(sbsa32, sbsa32_early_console_setup);
>
> Example:
> 	earlycon=sbsa32,0x3ced1000

Sounds like six of one, half-dozen of another.  But I'm happy to modify 
my patch accordingly.  It will avoid the strcmp, but I'm not sure it 
will reduce the actual number of lines of code.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
