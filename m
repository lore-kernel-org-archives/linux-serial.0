Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA929C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 18 Oct 2022 07:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJRHC5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Oct 2022 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJRHC4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Oct 2022 03:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C424B0DA;
        Tue, 18 Oct 2022 00:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A02ACB81CF4;
        Tue, 18 Oct 2022 07:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A833FC433D6;
        Tue, 18 Oct 2022 07:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666076572;
        bh=Wb/Mf9AX+UfFu70C7H6JaBJTJoWk5VaIAcRMDgMSG6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AoBYPGZopKhEBWLIhnUMv5c0yikMYFFyfjg0FpDx12J/QPiwjqrRsrlLo9XxP+MY7
         DErY/v491X76N5uKrpy3zlXctDjioyPOOuc3p00/QUHrwVYGU2SCfi0ZJf/cpEQz46
         7OaNtqiZeJoba4uqm4F531OoH5fsHi6UTmOVteHY=
Date:   Tue, 18 Oct 2022 09:02:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kartik <kkartik@nvidia.com>
Cc:     akhilrajeev@nvidia.com, jirislaby@kernel.org, jonathanh@nvidia.com,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        swarren@nvidia.com, thierry.reding@gmail.com
Subject: Re: [PATCH] serial: tegra: read DMA status before terminating
Message-ID: <Y05Pma6GLVtXVCrg@kroah.com>
References: <Y05J19PplpDuOfR/@kroah.com>
 <1666076116-12962-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666076116-12962-1-git-send-email-kkartik@nvidia.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 18, 2022 at 12:25:16PM +0530, Kartik wrote:
> On Tue, Oct 18, 2022 at 12:08, Greg KH wrote:
> > Why send this twice?
> > 
> > confused,
> 
> Hi Greg,
> 
> I made a mistake in my "git send-email" and the patch got posted twice.

So which one is correct?
