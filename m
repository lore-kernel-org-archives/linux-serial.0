Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E7EC43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiGGPHV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbiGGPHV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:07:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82932EE9
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CE74B82243
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA72C341C6;
        Thu,  7 Jul 2022 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657206437;
        bh=H6ZJgtcV1E/vKaf+0+haPZlxS42ENK/aErLWZXV+fZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCHqciadDBMAGQ62iv6ggtMGB0NqoJ8/til24mNKCevvDmNMFEUnRAbGc62sdVtYj
         HaBF57RIrGohUZH421bSWKt2viLG9yI7OozRa7fqF7jXTxJKLMPs5p/sBAbW2Z4M9m
         EEr6lvn4/oZbsm334/vBbGU+U3OFyLivUdFIf8JA=
Date:   Thu, 7 Jul 2022 17:07:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/7] ftdi_sio driver improvements
Message-ID: <Ysb2ok1pRp09OneY@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707145354.29705-1-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 04:53:47PM +0200, Marek Behún wrote:
> Hello Greg,
> 
> Pali has worked out some improvements for the ftdi_sio USB serial
> driver and I have tested them.

Why me?  Please always use scripts/get_maintainer.pl

Use that for when you fix these up and resend, see my other response as
to why we can't take these as-is.

thanks,

greg k-h
