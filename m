Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BCCC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD0560F6E
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 07:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJUH6X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhJUH6W (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Oct 2021 03:58:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C92EF611CB;
        Thu, 21 Oct 2021 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634802967;
        bh=j4UMg4TYoodF8etGC3h6w2j7bcT4DagTggKNft2sEN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TycN5f8YdzaOyQycrIg3HNZB3PrASMT0Y3RVd97f1ihxf/DvlXSzUO8awhgHZkJBR
         RMolkBG3wnsNcWnvVq3S/dsi0gU5A397v5tPUzah7V9IHE2vIht4iJhkcxL4XyLoKz
         pqd7DkpSaufr4BTYjkW1Z1ctG1WhVYlBybAHLVGk=
Date:   Thu, 21 Oct 2021 09:56:04 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: Possible issue with RS485 IOCTLs on 16C950 UARTs?
Message-ID: <YXEdFPyvpnBCeoxt@kroah.com>
References: <BY5PR05MB7092A78C7C3441240685522DF9BE9@BY5PR05MB7092.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR05MB7092A78C7C3441240685522DF9BE9@BY5PR05MB7092.namprd05.prod.outlook.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 20, 2021 at 08:44:54PM +0000, Matthew Howell wrote:
> Confidentiality Notice This message is intended exclusively for the individual or entity to which it is addressed. This communication may contain information that is PROPRIETARY, TRADE SECRET, PRIVILEGED, CONFIDENTIAL or otherwise legally exempt from disclosure. If you are not the named addressee, you are not authorized to read, print, retain, copy or disseminate this message or any part of it. If you have received this message in error, please notify the sender immediately either by phone (864.843.4343) or reply to this e-mail and delete all copies of this message.

Now deleted.
