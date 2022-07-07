Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A7CCA479
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiGGQuP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiGGQuP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 12:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B78526138
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 09:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE0EAB81EF7
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 16:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC26C341C0;
        Thu,  7 Jul 2022 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657212611;
        bh=BHuLn5/1wLq5cbTmKmmDq7mHTRQm0tchFho8YofcD60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8iNddZLNK/VUpEK0345UsNonIG0TC6OxPeNDNWJEgVImb30Q0ftwMIATEB8reWbG
         l8GZ0l9rgE0kRIyrzDYwJ90Y4pNPEYzmLdex0yDp45aQtxeSNqDdxmqdy5qJqQtNfi
         T7ex47wdvhTIztIJWZNdDuzXu/bpJvqphtauOkxo=
Date:   Thu, 7 Jul 2022 18:50:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 2/7] USB: serial: ftdi_sio: Add missing baudrate
 validation
Message-ID: <YscOwVPsWBpNt8t/@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-3-kabel@kernel.org>
 <Ysb284QtPTvUge+F@kroah.com>
 <20220707182201.145b84a7@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707182201.145b84a7@dellmb>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 06:22:01PM +0200, Marek Behún wrote:
> On Thu, 7 Jul 2022 17:08:35 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 07, 2022 at 04:53:49PM +0200, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > More FTDI variants limit the minimal baudrate value. Add lower bound
> > > checks.  
> > 
> > Which variants limit it?  Did you just break existing devices and keep
> > them from running at really low baud rates?
> 
> The variants for which the patch adds the checks. Does this need
> to be listed it in commit message?

Why wouldn't you want to see that in a changelog text?
