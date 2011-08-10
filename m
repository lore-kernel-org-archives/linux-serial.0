From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2] serial: samsung: Add unified interrupt handler for
 s3c64xx and later SoC's
Date: Wed, 10 Aug 2011 12:55:31 +0100
Message-ID: <20110810125531.38226d7a@bob.linux.org.uk>
References: <1312971680-3898-1-git-send-email-thomas.abraham@linaro.org>
	<1312971680-3898-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1312971680-3898-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, grant.likely@secretlab.ca, ben-linux@fluff.org
List-Id: linux-serial@vger.kernel.org

On Wed, 10 Aug 2011 15:51:19 +0530
Thomas Abraham <thomas.abraham@linaro.org> wrote:

> s3c64xx and later SoC's include the interrupt mask and pending
> registers in the uart controller, unlike the s3c24xx SoC's which have
> these registers in the interrupt controller. When the mask and
> pending registers are part of the uart controller, a unified
> interrupt handler can handle the tx/rx interrupt. With this, the
> static reservation of interrupt numbers for the uart tx/rx/err
> interrupts in the linux irq space is not required and simplifies
> adding device tree support.

Really only hardware changes so for the tty touching aspect of it

Acked-by: Alan Cox <alan@linux.intel.com>
