From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH resend 2] Add sc16is7x2 driver
Date: Fri, 7 Jan 2011 09:05:19 -0800
Message-ID: <20110107090519.dc31d72b.rdunlap@xenotime.net>
References: <4D272DDA.6010007@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D272DDA.6010007@iis.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Weber <weber@corscience.de>, Johannes Reif <reif@corscience.de>, changgx <changgx@163.com>, miguelangel@nbee.es
List-Id: linux-serial@vger.kernel.org

On Fri, 07 Jan 2011 16:14:34 +0100 Manuel Stahl wrote:

> IRQ is now implemented with work queue (like max3100).
> The problem is, that the sc16is7x2 has a low active irq. But with active 
> low threaded_irqs, shared irqs are not allowed.
> 
> Please try this one and report errors.
> 
> Regards,
> Manuel Stahl
> 
> PS: sorry that the patch is not inline, not sure how to configure 
> thunderbird correctly

Please check to see if Documentation/email-clients.txt can help you,
although it may be a bit outdated.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
