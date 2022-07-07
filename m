Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C44C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiGGPIm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGGPIl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:08:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07A027B01
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6888AB82246
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9312CC3411E;
        Thu,  7 Jul 2022 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657206518;
        bh=ytW8IX6MdkQZ6vqpukQ4kH3isNN1c6HTO7zH06x4nLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UhP2ADvis81xbx4SzX5sHcHmoKOB+bdF6qyEty8RmoYw7rW8pGAclSlK7MEblRe8U
         jjNnxXoMJs5qTQtTeRmhp3KxWqfEv0wLx666Obl3MvBfGQp671iYQo6VIx64EMxIJe
         JIrQPXoyyAIiSvoniXRwxhCONd11ti7PeLr11/+Q=
Date:   Thu, 7 Jul 2022 17:08:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 2/7] USB: serial: ftdi_sio: Add missing baudrate
 validation
Message-ID: <Ysb284QtPTvUge+F@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-3-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707145354.29705-3-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 04:53:49PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> More FTDI variants limit the minimal baudrate value. Add lower bound
> checks.

Which variants limit it?  Did you just break existing devices and keep
them from running at really low baud rates?

thanks,

greg k-h
