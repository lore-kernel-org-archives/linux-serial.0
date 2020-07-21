Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE60C433EB
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB622068F
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595352828;
	bh=4NcPcN8rD2FoQUOIdZkD4QjVcEtKOHW0B/nnoztGEQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OnHSybUBAG0Eplywu/ZV9mHBoMpfLmk2LmwMri594WNqbY6B9PBfh1CtrKAFFFPeo
	 PPOX/oahYnBTZ/Jvr3PDYUuadkaQ3RPY3LOBj9MIBLQHEkJ/sXFDIBs1nP+NK8i2oL
	 UFTsNULCedoi5qE1CBwoMdYJ8+3FDiOsV5Efc4QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgGURdr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgGURdr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 13:33:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E4920717;
        Tue, 21 Jul 2020 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595352827;
        bh=4NcPcN8rD2FoQUOIdZkD4QjVcEtKOHW0B/nnoztGEQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nao2wzN7EM8zNqJbM5TI1LMgHb6Fpl6nlRLTOZ0jNCU9YBZDerIoBVudR3fCB8oUf
         10QS/abDvmhlHg1ZYH34Ci1iAMz1eFBg0YXL/5jJdZOsxCJOil9Uq0xR0h3xtAvNse
         OGB6R2W3FH+F/Lc3yP9Z/BwlTjU1Xx3ZLJcqORpQ=
Date:   Tue, 21 Jul 2020 19:33:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart.c: fix a parentheses coding
 style issue
Message-ID: <20200721173355.GB2461958@kroah.com>
References: <20200721171412.xfpzswsrjn7savco@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721171412.xfpzswsrjn7savco@pesu.pes.edu>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 21, 2020 at 10:44:12PM +0530, B K Karthik wrote:
> add parentheses to expression to improve
> code readability.
> 
> Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 0cc64279cd2d..3108f5ab57fa 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1167,7 +1167,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  	 * Calculate length of one DMA buffer size to keep latency below
>  	 * 10ms at any baud rate.
>  	 */
> -	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
> +	sport->rx_dma_rng_buf_len = (((DMA_RX_TIMEOUT * baud) / bits) / 1000) * 2;

No, what is there is more readable, don't force people to try to
remember the order of operations.  I totally disagree with checkpatch
here.

thanks,

greg k-h
