Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2B3C43334
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiGGPKs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiGGPKs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:10:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A4824F25
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0AB4B82243
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6443AC3411E;
        Thu,  7 Jul 2022 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657206644;
        bh=pJe5Ve877Q5tsn+XBklf10OGzLIwoSPXPKMTfjpIkKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXz7RPSqztZ4f8U1/7i0bPLzBtUEHNuPBl+qqDJapukkvE9D5gSbvAioeMHBpjANu
         0WFKsQbfTfPSBWBQB/g0cpphPppFmixiyc4RBx8Aknp9l2t6+sDKrrghDU7DOfdsT5
         +y+lJMwXjWqlg2xrpH4ru4TWl8pXvWYCGVQ449rc=
Date:   Thu, 7 Jul 2022 17:10:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 4/7] USB: serial: ftdi_sio: Do not reset baudrate to 9600
 on error
Message-ID: <Ysb3cotx1FFyiaES@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-5-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707145354.29705-5-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 04:53:51PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> On failure to set new baudrate, reset baudrate to the previous value
> (as is done by other serial drivers) instead of resetting to 9600.

Where is it mandated that this is correct?  Why not keep the existing
functionality?  Did you just break systems that tried to set invalid
values and ended up with 9600 as a default?

What changed to make this a new requirement?

thanks,

greg k-h
