From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] tty: amba-pl011: add support for 32-bit register access
 for earlycon
Date: Sun, 13 Dec 2015 09:34:20 -0600
Message-ID: <566D8FFC.7080704@codeaurora.org>
References: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
 <20151213060643.GA30667@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151213060643.GA30667@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: peter@hurleysoftware.com, andre.przywara@arm.com, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, linux-serial@vger.kernel.org, jslaby@suse.com, rmk+kernel@arm.linux.org.uk, jun.nie@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Greg Kroah-Hartman wrote:
>> >
>> >Example:
>> >
>> >	earlycon=pl011,mmio32,0x3ced1000
>> >
>> >Signed-off-by: Timur Tabi<timur@codeaurora.org>
>> >---
>> >
>> >This patch applies on top of Russell's 12-part amba-pl011.c patchset.
> Which I didn't apply, so can you resend this after he resends his?

Yes, I will resend all of my pl011-releated patches after Russell's 
patches are reworked and accepted.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
