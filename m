Return-Path: <SRS0=uJPQ=3M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B3AC2D0DB
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 13:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC452467F
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579787083;
	bh=9DIdOrCNk422XAEqzrSHhadTNLm5nYKHPPJS3Xs+wSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSSR6onTTeFX9SsHVRLDS0mMownuTuRCI2I3IWTCBbnbQCndbNj5qhQVw4qgR5bXV
	 Qqb03WjW+ugTXrVvAEO+PmNr5AYxN4TdegsC/hvLn3c7hWH6gaCdB/iney0mbMj1AE
	 FI0g9XLaKVFNDjUxYxRXqPPY+GcgGc/Jx8awEonc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgAWNom (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgAWNom (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jan 2020 08:44:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5AC20661;
        Thu, 23 Jan 2020 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579787082;
        bh=9DIdOrCNk422XAEqzrSHhadTNLm5nYKHPPJS3Xs+wSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEDVkmnMhbNbTeWmvaUqtHFMx/KOYeIPXXMOQV5gis678BQFtBb9C4fNOqMOFbt5H
         NPPxPb8utZghY2YX5WIhe0b83m/1mmpBsT8mqb2NlefqLVvGQq+nf5+g0oapwxnfLY
         nrTKdsBVl/xBG6Re/Xsf3Sh6Ck72aXrlR5EBXBfw=
Date:   Thu, 23 Jan 2020 14:44:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        mgautam@codeaurora.org, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tty: serial: qcom_geni_serial: Configure
 UART_IO_MACRO_CTRL register
Message-ID: <20200123134440.GA1484051@kroah.com>
References: <20200123124802.24862-1-rojay@codeaurora.org>
 <20200123124802.24862-2-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123124802.24862-2-rojay@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 23, 2020 at 06:18:02PM +0530, Roja Rani Yarubandi wrote:
> Configure UART_IO_MACRO_CTRL register if UART lines are swapped.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 6 ++++++
>  1 file changed, 6 insertions(+)

What changed from v1?  Always put that below the --- line.

And no need for a 0/1 email for a single patch, just put everything in
the patch changelog itself as it is standalone.

thanks,

greg k-h
