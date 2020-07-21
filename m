Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2918C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 19:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EA1206E3
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 19:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595358464;
	bh=dtBNVf8eZjlHp1aNJ87R+E6/lv2EZUHKaYHWYXbFpNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rnwk+16N7589SRq8qTPWmY+ZTWE2q8HU9ujdiLi5mARHE4i+oT3yzy6pyKARXHqOn
	 PG1/zo3TLnI4V4yNmo+eWizrvoj01D6ij9o9b6dtHLrnMnb4EDEO6ORnUov2o2tEb6
	 sR4MW9RvmyHPPG1QmI2Ri60SrAw6LNiRTAoY6jU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgGUTHn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbgGUTGy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05060206E3;
        Tue, 21 Jul 2020 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595358410;
        bh=dtBNVf8eZjlHp1aNJ87R+E6/lv2EZUHKaYHWYXbFpNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+/4+8bk1ctCbSIBooNsBAbk7YmB67XYL3TVKw+B66nBMCfidT2RFwsl8ui4hl3FB
         fIrHitMKXae93BGu7UV5LrkOtnc/xK+tmM6pUef/RRSOuwVCJqyj7H7Pte4TOFDZNl
         RHXSYbhfp0MNmbZ4BAsrN2UrjgHsSC3Nt3iC50Yo=
Date:   Tue, 21 Jul 2020 21:06:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <mrhowel@g.clemson.edu>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com
Subject: Re: [PATCH v2] serial: exar: Fix GPIO configuration for Sealevel
 cards based on XR17V35X
Message-ID: <20200721190658.GA2605882@kroah.com>
References: <156b27a1-82c5-090e-0ae8-86944b849d6d@g.clemson.edu>
 <20200711064014.GA2786431@kroah.com>
 <c2c183d1-4a90-199a-23ad-2a736e431b27@g.clemson.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2c183d1-4a90-199a-23ad-2a736e431b27@g.clemson.edu>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 13, 2020 at 12:26:54PM -0400, Matthew Howell wrote:
> 
> On 7/11/20 2:40 AM, Greg KH wrote:
> > On Fri, Jul 10, 2020 at 04:33:00PM -0400, Matthew Howell wrote:
> >>
> >> From: Matthew Howell <mrhowel@g.clemson.edu>
> >>
> >> Sealevel XR17V35X based devices are inoperable on kernel versions
> >> 4.11 and above due to a change in the GPIO preconfiguration introduced in commit
> >> 7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealevel
> >> cards to the value (0x00) used prior to commit 7dea8165f1d
> >>
> >> Fixes: 7dea8165f1d ("serial: exar: Preconfigure xr17v35x MPIOs as output")
> >> Signed-off-by: Matthew Howell <mrhowel@g.clemson.edu>
> >> ---
> >>
> >> This is a revised patch submission based on comments received on
> >> the previous submission.
> >> See https://www.spinics.net/lists/linux-serial/msg39348.html
> >>
> >> I am using a different email address to address the email footer issue,
> >> and I have attempted to fix the formatting issues.
> >
> > The footer issues are fixed, but you should probably change the from:
> > and signed-off-by to your company address, right?
> >
> 
> That would be optimal, yes. However, I don't have direct control over
> the footer as it is enforced by our email server / group policy. Let
> me know if the company email is *required* to be in the from: field
> for this patch to be accepted though I will see if there is any way I
> can get an exemption in this case.

You can use the From: line for your company address and keep the
signed-off-by line from that same address as well and send from your
university account, that's fine and happens more than most companies
know :)

> >> Summary/justification of the patch is below.
> >>
> >> With GPIOs preconfigured as per commit 7dea8165f1d all ports on Sealevel
> >> XR17V35X based devices become stuck in high impedance mode, regardless of
> >> dip-switch or software configuration. This causes the device to become
> >> effectively unusable. This patch (in various forms) has been distributed
> >> to our customers and no issues related to it have been reported.
> >
> > Why not put that paragraph in the changelog as well?
> 
> It is my understanding that the message above signed-off-by is
> included as the commit message and should be as short as possible,
> while additional information and justification is provided below the
> sign-off-by line. Is that not the case? If it is preferable to be
> above signed-off-by line I can move it to there.

Please move it, it helps.

> 
> >
> >>
> >> Let me know if any changes need to be made.
> >>
> >> --- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
> >> +++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-09 11:05:25.275891627 -0400
> >> @@ -326,7 +326,7 @@ static void setup_gpio(struct pci_dev *p
> >>       * devices will export them as GPIOs, so we pre-configure them safely
> >>       * as inputs.
> >>       */
> >> -    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
> >> +    u8 dir = (pcidev->vendor == PCI_VENDOR_ID_EXAR && pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL) ? 0xff : 0x00;
> >
> > That's a horrible line to try to read now, right?
> >
> > Why not turn it into a real if statement so we can make more sense of it
> > over time:
> >
> >     u8 dir = 0x00;
> >
> >     if ((pcidev->vendor == PCI_VENDOR_ID_EXAR) &&
> >         (pcidev->subsystem_vendor != PCI_VENDOR_ID_SEALEVEL))
> >         dir = 0xff;
> >
> > Looks better, right?
> >
> > thanks,
> >
> > greg k-h
> 
> Thanks for that feedback. It must have been unclear since the value of
> dir in your if statement has the wrong value. Revised patch diff with
> added comments is below.

Ah, see, I misread your patch, all the more reason to do this "right".

> 
> --- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:03.920060577 -0400
> +++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-13 11:54:44.386718167 -0400
> @@ -326,7 +326,20 @@ static void setup_gpio(struct pci_dev *p
>       * devices will export them as GPIOs, so we pre-configure them safely
>       * as inputs.
>       */
> -    u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
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

Coding style issues aside, looks good!

Please fix that up and resend, thanks.

greg k-h
