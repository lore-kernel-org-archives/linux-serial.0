From: Linus Walleij <linus.walleij@linaro.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_amba=2Dpl011=E2=80=8B=2Fdma=3A_Add_check_for_the_res?=
	=?UTF-8?Q?idue_in_DMA_callback?=
Date: Mon, 20 Feb 2012 09:31:21 +0100
Message-ID: <CACRpkdZ4fJEBa4uDQ6P3UC50wyWarD-owC3tjC=FRMno-UOk5Q@mail.gmail.com>
References: <CAOAMb1BoEJWjU9he=xr2irCyDVwDUPmhihQyPc_n3t8HbegLDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43667 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2BTIbW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Feb 2012 03:31:22 -0500
In-Reply-To: <CAOAMb1BoEJWjU9he=xr2irCyDVwDUPmhihQyPc_n3t8HbegLDw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chanho Min <chanho0207@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Per Forlin <per.friden@stericsson.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rabin VINCENT <rabin.vincent@stericsson.com>

On Mon, Feb 20, 2012 at 2:24 AM, Chanho Min <chanho0207@gmail.com> wrote:

> In DMA-operated uart, I found that rx data can be taken by the UART
> interrupts during the DMA irq handler. pl011_int is occurred just
> before it goes inside spin_lock_irq. When it returns to the callback,
> DMA buffer already has been flushed. Then, pl011_dma_rx_chars gets
> invalid data. So I add check for the residue as the patch bellow.
>
> Signed-off-by: Chanho Min <chanho.min@lge.com>

Looks correct!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
