Return-Path: <SRS0=puAX=AW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72982C433DF
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 06:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42989207BC
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 06:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594449611;
	bh=gI75qSUt5Lfb8eztx2LA6onxkmBfiF0BaPrJgvW2TTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BhHI0QSuWopDg2bZKKwtQMtZVz2w8BdfhtXfpYfde3WcRTCkiZ6peVoVWnvMcvYsG
	 Fl24G4KUSpp0A4IpjbdPMDeqPp1Lh30hTmW6OgO8LliC8GajQi04nmxtvf9hvlykqz
	 hmHQWoA/vM6B1J9g9Zb7MhsmtVYgmUiV63FEXXrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGKGkK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgGKGkK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jul 2020 02:40:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70297206E2;
        Sat, 11 Jul 2020 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594449610;
        bh=gI75qSUt5Lfb8eztx2LA6onxkmBfiF0BaPrJgvW2TTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXAMB3JknGYYZFR3gXxFNnboZs3zv/7h+EWcJJtHBPXGac+bwsM3jyC4Apl3r+k8u
         r3iRIEgJ41LOv5l/rdk9iAtcF2Pb1d5HEcgwz7G3M31GjVLL9MX3Gl8TQQZcFSf1hv
         8LN5JzhnWcDW9NoEXC07rBRRIPvlarY17qbcxL34=
Date:   Sat, 11 Jul 2020 08:40:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <mrhowel@g.clemson.edu>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com
Subject: Re: [PATCH v2] serial: exar: Fix GPIO configuration for Sealevel
 cards based on XR17V35X
Message-ID: <20200711064014.GA2786431@kroah.com>
References: <156b27a1-82c5-090e-0ae8-86944b849d6d@g.clemson.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156b27a1-82c5-090e-0ae8-86944b849d6d@g.clemson.edu>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 10, 2020 at 04:33:00PM -0400, Matthew Howell wrote:
> 
> From: Matthew Howell <mrhowel@g.clemson.edu>
> 
> Sealevel XR17V35X based devices are inoperable on kernel versions
> 4.11 and above due to a change in the GPIO preconfiguration introduced in commit
> 7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
> cards to the value (0x00) used prior to commit 7dea8165f1d
> 
> Fixes: 7dea8165f1d ("serial: exar: Preconfigure xr17v35x MPIOs as output")
> Signed-off-by: Matthew Howell <mrhowel@g.clemson.edu>
> ---
> 
> This is a revised patch submission based on comments received on
> the previous submission.
> See https://www.spinics.net/lists/linux-serial/msg39348.html
> 
> I am using a different email address to address the email footer issue,
> and I have attempted to fix the formatting issues.

The footer issues are fixed, but you should probably change the from:
and signed-off-by to your company address, right?

> 
> Summary/justification of the patch is below.
> 
> With GPIOs preconfigured as per commit 7dea8165f1d all ports on Sealevel
> XR17V35X based devices become stuck in high impedance mode, regardless of
> dip-switch or software configuration. This causes the device to become
> effectively unusable. This patch (in various forms) has been distributed
> to our customers and no issues related to it have been reported.

Why not put that paragraph in the changelog as well?

> 
> Let me know if any changes need to be made.
> 
> --- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
> +++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-09 11:05:25.275891627 -0400
> @@ -326,7 +326,7 @@ static void setup_gpio(struct pci_dev *p
>       * devices will export them as GPIOs, so we pre-configure them safely
>       * as inputs.
>       */
> -    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
> +    u8 dir = (pcidev->vendor == PCI_VENDOR_ID_EXAR && pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL) ? 0xff : 0x00;

That's a horrible line to try to read now, right?

Why not turn it into a real if statement so we can make more sense of it
over time:

	u8 dir = 0x00;

	if ((pcidev->vendor == PCI_VENDOR_ID_EXAR) &&
	    (pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL))
		dir = 0xff;

Looks better, right?

thanks,

greg k-h
