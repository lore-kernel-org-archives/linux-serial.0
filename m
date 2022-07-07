Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E682C433EF
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jul 2022 15:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiGGPH7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGGPH7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jul 2022 11:07:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670D3138B
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 08:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89996B82243
        for <linux-serial@vger.kernel.org>; Thu,  7 Jul 2022 15:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95A7C3411E;
        Thu,  7 Jul 2022 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657206476;
        bh=Em5Ma3ccwwMu7imRQHOorRWoJER4jwpjREcetYvefF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmLZsfN+qkcqCp27CAJL2v5L5xyFvchCrE4eX+Zjq5IoedphYh0XAb/8vsizwGctT
         RSs/QXB4ohkybr34jI8Y9lnewqYAMW5Zljz/ZYLHh5FQeLgRVv+NC/8eqaX/CDF/pF
         t7X7JQhysv0lBymB7GsSdPIy/gZXg+MfMkSdpfGc=
Date:   Thu, 7 Jul 2022 17:07:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-serial@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 1/7] USB: serial: ftdi_sio: Fix divisor overflow
Message-ID: <Ysb2ybllKsZ4/81Y@kroah.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-2-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707145354.29705-2-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 07, 2022 at 04:53:48PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Divisor in the register is a 17-bit wide number.
> Therefore we need to clamp it on overflow.

Why, what is wrong with it overflowing, what will happen if it does?


> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Tested-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/usb/serial/ftdi_sio.c | 6 ++++++
>  1 file changed, 6 insertions(+)

What commit does this fix?  Is it a bugfix?  Can this ever happen in a
device?  Should it be backported?.

thanks,

greg k-h
