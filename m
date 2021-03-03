Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C921C433E9
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D05B64EC0
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbhCDAAG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350397AbhCCTmt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Mar 2021 14:42:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF24B64ED0;
        Wed,  3 Mar 2021 19:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614799865;
        bh=h5FCaQLoCU1eLgBpB+1GspxLjjVwOPWrvQkt3lDgAUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEcgKJCSdq6xUFXNdC95YSgTC/uiJvkG0L6ZhxyQLlM/j4QKJH5PJyf053oXS82dR
         ebHF+Cr1XG27xFKZ+8MVrHy5b8t5zi7N+7vB3QzJ0/++vdoMaNBGT+W/z4WikA1PNZ
         +j3arvkQC+NwTQecUli9YcrdLDUear4lgJWqluqU=
Date:   Wed, 3 Mar 2021 20:31:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Erwan Le Ray <erwan.leray@foss.st.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: Re: [PATCH 00/13] stm32 usart various fixes
Message-ID: <YD/j9jhkcVbN3zs0@kroah.com>
References: <20210219174736.1022-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219174736.1022-1-erwan.leray@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 19, 2021 at 06:47:23PM +0100, Erwan Le Ray wrote:
> This series brings various fixes to stm32-usart driver.
> 
> Erwan Le Ray (13):
>   serial: stm32: fix probe and remove order for dma
>   serial: stm32: fix startup by enabling usart for reception
>   serial: stm32: fix incorrect characters on console
>   serial: stm32: fix TX and RX FIFO thresholds
>   serial: stm32: fix a deadlock condition with wakeup event
>   serial: stm32: fix wake-up flag handling
>   serial: stm32: fix a deadlock in set_termios
>   serial: stm32: fix tx dma completion, release channel
>   serial: stm32: call stm32_transmit_chars locked
>   serial: stm32: fix FIFO flush in startup and set_termios
>   serial: stm32: add FIFO flush when port is closed
>   serial: stm32: fix tx_empty condition
>   serial: stm32: add support for "flush_buffer" ops
> 
>  drivers/tty/serial/stm32-usart.c | 198 +++++++++++++++++++++----------
>  drivers/tty/serial/stm32-usart.h |   3 -
>  2 files changed, 135 insertions(+), 66 deletions(-)

This series does not apply cleanly to my tree.  Can you rebase it
against 5.12-rc1 and resend?

thanks,

greg k-h
