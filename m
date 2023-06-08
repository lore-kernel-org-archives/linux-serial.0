Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD650C7EE23
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 11:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjFHLwR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFHLwQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 07:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE2FE50
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 04:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7124764CA8
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 11:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864CFC433EF;
        Thu,  8 Jun 2023 11:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686225134;
        bh=OEhDGVhpQC0gZVXCvMuGDXNf8DruYlXOsTcmJpeZFUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOLTdOW68oc5TN2o6GFg0+BU+Bu3SyODvqJDAIH8CcRmh2yHexmiOwhEGofy1RZbm
         rLMJ2vbruqeU5s0nKjr/etLVRIPzRczaDRL+tgxuxZvjodxcSOBXn4Uzs9jItXYhis
         vJ/Y+Wzj//DH510Ek1isoUNxO5dc4dPxm3K0i5JU=
Date:   Thu, 8 Jun 2023 13:52:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Robert Hodaszi <robert.hodaszi@digi.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        sherry.sun@nxp.com
Subject: Re: [PATCH] tty: serial: fsl_lpuart: reduce RX watermark to 0 on
 LS1028A
Message-ID: <2023060858-groove-riddance-0c09@gregkh>
References: <20230608111927.1808525-1-robert.hodaszi@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608111927.1808525-1-robert.hodaszi@digi.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 08, 2023 at 01:19:27PM +0200, Robert Hodaszi wrote:
> LS1028A is using DMA with LPUART. Having RX watermark set to 1, means
> DMA transactions are started only after receiving the second character.
> 
> On other platforms with newer LPUART IP, Receiver Idle Empty function
> initiates the DMA request after the receiver is idling for 4 characters.
> But this feature is missing on LS1028A, which is causing a 1-character
> delay in the RX direction on this platform.
> 
> Set RX watermark to 0 to initiate RX DMA after each character.
> 
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>

What commit id does this fix?  Should it go to stable releases?

thanks,

greg k-h
