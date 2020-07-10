Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ECBC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 12:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BD320772
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594384861;
	bh=dWcNNv9dVfjzY15yn8z3Zonr+/Ih3RJ90i2I6yogmpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g+EQIusTKrDeeUrGzs8XpXTfz/7TSYG7HgXUpOljacg1a9qRyq2kzj9vJxDJI8fjM
	 04sfNPTyk2sj9B6Tw9sH7IgIFifM8Q2sw5VrTiSZnhsRaCkPOBavXfmv/va9FZu9kK
	 5xDN0UdJF3T+u/FKHR1nFMOafrX7GByNEL/o16zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGJMlA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJMk7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 08:40:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8871620772;
        Fri, 10 Jul 2020 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594384859;
        bh=dWcNNv9dVfjzY15yn8z3Zonr+/Ih3RJ90i2I6yogmpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a58fK3v+hkHw/xgV2JPPrtYKyUkWS4XChYD45kDsLn68MK88JbSSgqMHR941fuC8w
         Ya6HA607NNAiJjPDh5GA9GDT+oIV4eMpFw1WSL+u291wc6VrFw/7rFoiL8VHX1q3y4
         5BoKgUZbtCN3lFylYoCPd81cNvPCgeHeSLXqg3Ds=
Date:   Fri, 10 Jul 2020 14:41:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com
Subject: Re: [PATCH] serial: exar: Fix GPIO configuration for Sealevel cards
 based on XR17V35X
Message-ID: <20200710124103.GB1567243@kroah.com>
References: <473cc7ae-c870-ff0f-0c68-bdcfed19efde@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473cc7ae-c870-ff0f-0c68-bdcfed19efde@sealevel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 09, 2020 at 03:23:37PM -0400, Matthew Howell wrote:
> 
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> FIXES: 7dea8165f1d("serial: exar: Preconfigure xr17v35x MPIOs as output")
> 
> Sealevel XR17V35X based devices became inoperable on kernel versions above
> 4.11 due to the GPIO preconfiguration change introduced in commit
> 7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
> cards to the value (0x00) used prior to commit 7dea8165f1d
> 
> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> ---
> 
> With GPIOs preconfigured as per commit 7dea8165f1d all ports on Sealevel
> XR17V35X based devices become stuck in high impedance mode, regardless of
> dip-switch or software configuration. This causes the device to become
> effectively unusable. This patch (in various forms) has been distributed
> to our customers and no issues related to it have been reported.
> 
> This is the first patch I have submitted so please let me know if anything
> is incorrect, unclear, or if any changes to the patch are needed and I will
> be happy to fix it.
> 
> --- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
> +++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-09 11:05:25.275891627 -0400
> @@ -326,7 +326,7 @@ static void setup_gpio(struct pci_dev *p
>       * devices will export them as GPIOs, so we pre-configure them safely
>       * as inputs.
>       */
> -    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
> +    u8 dir = (pcidev->vendor == PCI_VENDOR_ID_EXAR && pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL) ? 0xff : 0x00;
> 
>      writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
>      writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> 
> Confidentiality Notice This message is intended exclusively for the individual or entity to which it is addressed. This communication may contain information that is PROPRIETARY, TRADE SECRET, PRIVILEGED, CONFIDENTIAL or otherwise legally exempt from disclosure. If you are not the named addressee, you are not authorized to read, print, retain, copy or disseminate this message or any part of it. If you have received this message in error, please notify the sender immediately either by phone (864.843.4343) or reply to this e-mail and delete all copies of this message.


Oops, nope, can't take patches with that info in it, sorry, now
deleted...
