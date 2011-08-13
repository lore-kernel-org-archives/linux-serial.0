From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 0/2] Update uart irq handling for s3c64xx and later SoC's
Date: Sat, 13 Aug 2011 13:26:17 +0200
Message-ID: <2617144.DJZiU5lFpE@flatron>
References: <1312971680-3898-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1312971680-3898-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-serial@vger.kernel.org, kgene.kim@samsung.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

Hi Thomas,

On Wednesday 10 of August 2011 at 15:51:18, Thomas Abraham wrote:
> s3c64xx and later SoC's include the uart interrupt mask and pending 
registers
> in the uart controller, unlike their s3c24xx predecessor. This allows the
> uart irq handling to be moved from the platform code to the driver. This
> patchset does this change and removes all the macros that will not be
> required with this update.
> 

Your patches should solve the issue of system hanging on wake up because of 
unacked (and unackable due to disabled UART bus clock) UART interrupts. So one 
more reason to merge them.

My earlier description of the issue:

> I am experiencing a strange issue with UART ports on a Tiny6410 board, based
> on the S3C6410 SoC (hardware wise same as the Mini6410 supported by Linux),
> after enabling CONFIG_PM and suspending the SoC.
> 
> After triggering a wakeup event, it resumes till arch_suspend_enable_irqs()
> called by suspend_enter() and starts to get hammered by infinite amounts of
> UART interrupts.
> 
> I have tracked this down to disabling UART PCLK clock on suspend and the
> bootloader/reset/power down/whatever leaving the UART in an undefined state
> with interrupt bits set (specifically Tx interrupt), with the masked clock
> making it impossible to ack them by plat-samsung/irq-uart.c. 

Best regards,
Tom
