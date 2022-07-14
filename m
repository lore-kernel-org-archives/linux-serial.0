Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF63C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 14:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiGNOcN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiGNOcN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 10:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5B563920
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 07:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37D0C6179E
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 14:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48766C34115;
        Thu, 14 Jul 2022 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657809131;
        bh=wLRI0dplBauNaHTyKZRlomMwAiu7VwQ8uPIYm1v3wpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKQS35V4vreuAKf21k9/c234Rlhnnx/SzgzZ4kgRxG6vNwxMarNaYpJIPuCmqJRvf
         YI5+WL8BD5b/ksYrNLCVjMs5SJS2AyeO20OFPuoYxPqyw5XaEnbBjkD4sEZFqo788X
         HkidryrVQypR2xuleAONM7vMs01jdykjKoPbaSnw=
Date:   Thu, 14 Jul 2022 16:32:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shenwei.wang@nxp.com
Cc:     linux-serial@vger.kernel.org
Subject: Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit in CS7
 mode
Message-ID: <YtAo6LNRnErheW2a@kroah.com>
References: <20220708195800.325933-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708195800.325933-1-shenwei.wang@nxp.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jul 08, 2022 at 02:58:00PM -0500, shenwei.wang@nxp.com wrote:
> The LPUART hardware doesn't zero out the parity bit on the received
> characters. This behavior won't impact the use cases of CS8 because
> the parity bit is the 9th bit which is not currently used by software.
> But the parity bit for CS7 must be zeroed out by software in order to
> get the correct raw data.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

Also, please fix your email client so that your name shows up in the
 From: line.

thanks,

greg k-h
