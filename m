From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] ARM: S3C24XX: Add missing clkdev entries for s3c2440 UART
Date: Mon, 22 Jul 2013 19:14:53 +0200
Message-ID: <1877003.j5SlNHUNT8@amdc1227>
References: <1374435765-6747-1-git-send-email-sylvester.nawrocki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:41812 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab3GVRO6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Jul 2013 13:14:58 -0400
In-reply-to: <1374435765-6747-1-git-send-email-sylvester.nawrocki@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, oselas@community.pengutronix.de, Chander Kashyap <chander.kashyap@linaro.org>

On Sunday 21 of July 2013 21:42:45 Sylwester Nawrocki wrote:
> This patch restores serial port operation which has been broken since
> commit 60e93575476f90a72146b51283f514da655410a7
> serial: samsung: enable clock before clearing pending interrupts during
> init
> 
> That commit only uncovered the real issue which was missing clkdev
> entries for the "uart" clocks on S3C2440. It went unnoticed so far
> because return value of clk API calls were not being checked at all
> in the samsung serial port driver.
> 
> This patch should be backported to at least 3.10 stable kernel, since
> the serial port has not been working on s3c2440 since 3.10-rc5.
> 
> Cc: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> [on S3C2440 SoC based Mini2440 board]
> Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> ---
> 
> There seems to be something wrong with the process, as things are
> getting broken late in the -rc cycle.  It seems author of the above
> mentioned commit didn't test all 6 SoC series that the samsung
> serial driver handles.  While I can understand they might not have
> all required hardware it's a bit irritating that the patch that
> in practice caused regression appeared only on linux-serial mailing
> list. And it's not evident it was even tried to test it on all
> potentially affected platforms. It not clear on what platforms
> the patch has been tested.
> 
> My humble suggestion is, _please_ do send patches that affect multiple
> Samsung SoCs to linux-samsung@vger.kernel.org.  So there is better
> review and test exposure.  And we can reduce mess like this happening
> in the future.
> 
> Thanks!
> Sylwester
> ---
>  arch/arm/mach-s3c24xx/clock-s3c2410.c      |  161
> +++++++++++++++++----------- arch/arm/mach-s3c24xx/clock-s3c2440.c     
> |    3 +
>  arch/arm/plat-samsung/include/plat/clock.h |    5 +
>  3 files changed, 106 insertions(+), 63 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

