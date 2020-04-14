Return-Path: <SRS0=CAPS=56=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294BC2BA19
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 09:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C721E2064A
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tEqsTplx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438038AbgDNJ44 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:56:56 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38846 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437925AbgDNJ4z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Apr 2020 05:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MFDKQod1ulWQsmUhrBi6caTSYw9k5n9WOUJXNnAw418=; b=tEqsTplxGA9kKYxzAAvY0u8Hp
        Tqqs3i+D3QDwd/qy/IELdE65zUz6p6RCDGbTemRf1hGmd+V+7UBx2VxP3sa1i4dSYCJNrmBqgkfiB
        vYbiajLZaDRY37lu2pObRfLM5rNmRad9BtuuY0WXKiCtw7iWpDvHaDreGfOfh4plY4K5A11M9g2up
        L+RrfIbLX2D320dt/uwiojhZFflNQ6vsi+o+/rTVp0Zh1NCIaNf1Oxc+EU80iQgMolTDk2DXwerR/
        8UQ4U6L2LzI8SC1soWDlQnm7iADCwfhBlWR82opdT2l8F6ZRJ+BnD2RjaRDm+fhwtBc0LzVav2R2t
        7MQ4UPQ8Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49896)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jOIJB-0007ES-OU; Tue, 14 Apr 2020 10:56:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jOIJA-0007rs-6J; Tue, 14 Apr 2020 10:56:44 +0100
Date:   Tue, 14 Apr 2020 10:56:44 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Serial console and interrupts latency.
Message-ID: <20200414095644.GU25745@shell.armlinux.org.uk>
References: <87lfnq15vi.fsf@osv.gnss.ru>
 <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz>
 <87ftdtzypi.fsf@osv.gnss.ru>
 <20200327232428.GT25745@shell.armlinux.org.uk>
 <CANp_pu1caHaGJbBR8sEoOER2SfMDO3eJKOVQz3K8jKKZACh7=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp_pu1caHaGJbBR8sEoOER2SfMDO3eJKOVQz3K8jKKZACh7=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 14, 2020 at 12:50:49PM +0300, Sergey Organov wrote:
> Russell King - ARM Linux admin <linux@armlinux.org.uk>:
> > Correct, and what I said back then still applies - and more.
> 
> What bothers me is "we have no real option..." part of this, as it's rarely
> happens to be the case.

I don't see you coming forward with a solution beyond "let's revert
the commit" or "let's comment out the lock" - neither of which are
an option for mainline kernels.

Until *you* do, since you obviously have better ideas, "we have no
real option".

But, as I've said, one of the *important* characteristics of serial
console is that it is synchronous with the kernel, so it can be
relied upon to get complete messages out if the kernel crashes after
a printk() has been executed, and that must not be lost.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
