Return-Path: <SRS0=VfF8=BB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBCC433E2
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334A420717
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jul 2020 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595403444;
	bh=E3BDv9EXS45tdmSzR1XilX0feunp4kFN3hS+6Te80cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XY2zWGNAURS396oH4PcQBhpTFZ+cxWsNuFATlPgkuwdcq1e2CdIKyjO1dQB+Q628x
	 9s5Cp9HnUp5m/y+ogsYSV9XGlrMI/XEsbKVRnQVJIr2H2UDQ8QKE4VMRdOeJMbFh0O
	 1gWxnIBVQ279O6RmasiKkwkM67E+pDBpeidzGLJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgGVHhX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgGVHhX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jul 2020 03:37:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7876920709;
        Wed, 22 Jul 2020 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595403443;
        bh=E3BDv9EXS45tdmSzR1XilX0feunp4kFN3hS+6Te80cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKqtWxxZD6V3t+pJD+W8pZDMv82yCXhKT56RUuw2sM06eBvTlEuZTBaVky8JpzSh1
         ptRplOIIyJT6PM4cfwVCHd+LbuQFzXpJauihc4issXW4XrfIewEclW2BO+VFjYX4Lw
         h8T80T5lyXS6Wgg+ccCWAVbtwidrETJTOQ2xEHL0=
Date:   Wed, 22 Jul 2020 09:37:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <mrhowel@g.clemson.edu>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com
Subject: Re: [PATCH v3] serial: exar: Fix GPIO configuration for Sealevel
 cards based on XR17V35X
Message-ID: <20200722073729.GA2787816@kroah.com>
References: <9318fef6-f2d4-dc77-2a25-6033d63aab9b@g.clemson.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9318fef6-f2d4-dc77-2a25-6033d63aab9b@g.clemson.edu>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 21, 2020 at 04:08:17PM -0400, Matthew Howell wrote:
> 
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Sealevel XR17V35X based devices are inoperable on kernel versions
> 4.11 and above due to a change in the GPIO preconfiguration introduced in commit
> 7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
> cards to the value (0x00) used prior to commit 7dea8165f1d
> 
> With GPIOs preconfigured as per commit 7dea8165f1d all ports on
> Sealevel XR17V35X based devices become stuck in high impedance
> mode, regardless of dip-switch or software configuration. This
> causes the device to become effectively unusable. This patch (in
> various forms) has been distributed to our customers and no issues
> related to it have been reported.
> 
> Fixes: 7dea8165f1d ("serial: exar: Preconfigure xr17v35x MPIOs as output")
> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> 
> Patch resubmitted as per comments received on
> https://www.spinics.net/lists/linux-serial/msg39371.html
> 
> Moved problem description and justification above the signed-off-by
> line.
> 
> checkpatch.pl reports no styling issues with the diff below.
> 
> Let me know if I need to make any other changes.

You should put a --- line after the signed-off-by line, so these
comments do not show up in the changelog.

> 
> --- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
> +++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-13 11:54:44.386718167 -0400
> @@ -326,7 +326,20 @@ static void setup_gpio(struct pci_dev *p
>       * devices will export them as GPIOs, so we pre-configure them safely
>       * as inputs.
>       */
> -    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
> +
> +    u8 dir = 0x00;
> +
> +    if  ((pcidev->vendor == PCI_VENDOR_ID_EXAR) &&
> +        (pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL))
> +    {
> +       // Configure GPIO as inputs for Commtech adapters
> +       dir = 0xff;
> +    }
> +    else
> +    {
> +       // Configure GPIO as outputs for SeaLevel adapters
> +       dir = 0x00;
> +    }
> 
>      writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
>      writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> 

Your patch has all tabs turned to spaces, making this impossible to
apply.

Also, always run your patch through scripts/checkpatch.pl to fix the
obvious coding style issues in it before sending it out.

v4?  :)

thanks,

greg k-h
