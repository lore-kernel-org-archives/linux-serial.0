Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9FC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0216D610CF
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 08:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJ1Irg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhJ1Irf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Oct 2021 04:47:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D56C9610C7;
        Thu, 28 Oct 2021 08:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635410707;
        bh=6FnoWItqhX4i2tVirmjmWtZScoYaiHnnimIFWjGaDxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZ3P9zZZtFG40mdnjQbz+sZr67CPVdGcvrOk7fnrpulWEKbcv3w4BCbRH1ylyPqjy
         1zS0ChoaLbv2NPEHVX78T1IES9RCzWng4NtEqzO4hP8n1+KxbGwjviChxLTXbaOLWO
         rPbeTOD1pLzXD2lubeLicEkzN49R5IKNK/rlROTQGPozCYS0nQYTZcQP+3XIbdpT+/
         E26aIiX1sukCpksG4h09lC72f39grkktecPfolr7Z+vzJhTMgP6yHRnDmAJ5pzozJm
         e332bVC0WuIh7JzcmbcxeN3ccWTBxxMEM3jSZC/lV+VGxQPgOvOgZ9ErVqJEql2Pgu
         2eINs7j9LvM3A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mg121-0006wF-7T; Thu, 28 Oct 2021 10:45:05 +0200
Date:   Thu, 28 Oct 2021 10:45:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: Fix extra "not" in TTY_DRIVER_REAL_RAW description
Message-ID: <YXpjEeeajd706Nak@hovoldconsulting.com>
References: <20211027102124.3049414-1-anssi.hannula@bitwise.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027102124.3049414-1-anssi.hannula@bitwise.fi>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 27, 2021 at 01:21:24PM +0300, Anssi Hannula wrote:
> TTY_DRIVER_REAL_RAW flag (which is always set for e.g. serial ports)
> documentation says that driver must always set special character
> handling flags in certain conditions.
> 
> However, as the following sentence makes clear, what is actually
> intended is the opposite.
> 
> Fix that by removing the unintended double negation.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> ---

Acked-by: Johan Hovold <johan@kernel.org>

> This one seems to have been there since 1994.
> 
>  include/linux/tty_driver.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
> index c20431d8def8..5bec04481c60 100644
> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -360,7 +360,7 @@ static inline void tty_set_operations(struct tty_driver *driver,
>   * 	Used for PTY's, in particular.
>   * 
>   * TTY_DRIVER_REAL_RAW --- if set, indicates that the driver will
> - * 	guarantee never not to set any special character handling
> + * 	guarantee never to set any special character handling
>   * 	flags if ((IGNBRK || (!BRKINT && !PARMRK)) && (IGNPAR ||
>   * 	!INPCK)).  That is, if there is no reason for the driver to
>   * 	send notifications of parity and break characters up to the
