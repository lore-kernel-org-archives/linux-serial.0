Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9936C4338F
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDDD60F41
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 12:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhHQM7v (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Aug 2021 08:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhHQM7t (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Aug 2021 08:59:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D98860EBD;
        Tue, 17 Aug 2021 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629205155;
        bh=nLqij11ZwTdXwOC5iKH5vBOKi+8GTdVjmeB6OF4J7Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIxB0yQG6aVN5x9v3HwI6A3Y1gM2ik7KIStMDm/c93Dm5mQLeNxbOJPNovbnW0JqN
         PHFkLd7qI0Gckykc5bd5gwZ23iWY1/ck6KPVoLnJb/Hs3UQfuXwQPAWobYXISPJMGG
         6UKSMIiOiAJXsSwW77L7yOurb6VbfGfW/HYSDgSQ=
Date:   Tue, 17 Aug 2021 14:59:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] serial: 8250_mid: Use pci_irq_vector() to get IRQ
Message-ID: <YRuyoWujcSB6zKl5@kroah.com>
References: <20210817081401.3440-1-utkarshverma294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817081401.3440-1-utkarshverma294@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 17, 2021 at 01:44:01PM +0530, Utkarsh Verma wrote:
> Instead of a direct assignment, use pci_irq_vector() to get the
> Linux IRQ number.

Why is this needed?

> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_mid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
> index efa0515139f8..3a279ce0e904 100644
> --- a/drivers/tty/serial/8250/8250_mid.c
> +++ b/drivers/tty/serial/8250/8250_mid.c
> @@ -299,7 +299,7 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	memset(&uart, 0, sizeof(struct uart_8250_port));
>  
>  	uart.port.dev = &pdev->dev;
> -	uart.port.irq = pdev->irq;
> +	uart.port.irq = pci_irq_vector(pdev, 0);

What problem does this solve?

Do not describe what you are doing, but rather, _why_ you are doing it.

thanks,

greg k-h
