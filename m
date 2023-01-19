Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1323C00A5A
	for <linux-serial@archiver.kernel.org>; Thu, 19 Jan 2023 14:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjASO5c (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjASO5b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Jan 2023 09:57:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4EF78577
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 06:57:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B64961994
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 14:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA99C433F0;
        Thu, 19 Jan 2023 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674140247;
        bh=dJHg8+MGW1i+Jh0DbRVkZDhtaueG6Mu68dQWP14THmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1n328/x0w9t3o7Xxm9Vy/kguCiLoHvbJrO+1/ayPhCsMwFvXab0glGsU0IKwuddv/
         tDJNm67M2bg9i1ZlvLzY1M8kBaJPhBGxwXUrBHIkIn5mj2Z8I4+LYB+18LK0U16cKD
         m4boJ9N13ow2TEiw6hxayCczn5nlAwzM62ZShftA=
Date:   Thu, 19 Jan 2023 15:57:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <mrhowel@g.clemson.edu>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com, matthew.howell@sealevel.com,
        darren.beeson@sealevel.com
Subject: Re: [PATCH] serial: exar: Add support for Sealevel 7xxxC serial cards
Message-ID: <Y8laVD+RSwS/eM7C@kroah.com>
References: <alpine.DEB.2.21.2301161242150.19090@tstest-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2301161242150.19090@tstest-VirtualBox>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 16, 2023 at 03:49:08PM -0500, Matthew Howell wrote:
> Add support for Sealevel 7xxxC serial cards.
> 
> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
> 
> This patch:
> * Adds IDs to recognize 7xxxC cards from Sealevel Systems.
> * Updates exar_pci_probe() to set nr_ports to last two bytes of primary
> dev ID for these cards.

This information needs to be above the signed-off-by line in the
changelog text.

Can you resend this as a v2 patch?

thanks,

greg k-h
