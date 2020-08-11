Return-Path: <SRS0=7S4r=BV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E43C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2D8206C3
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597134202;
	bh=05X/U1X1FmvLRP9StXB50QFn4807rniaSe6uYcy49QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nHA0dJ0pIoS7kMTnreDTo8x5crM8krVr3+525baZI3ynQh+Rzx7jmAiCmVvaPibzi
	 t34m1A4EXDohcVc2hvwHg02qZvCQ9NVgOx+ydvpNMd/qjDSwUkGevA+bIV9Y4rU28f
	 juDUpjBemwhbhfWEC8Ye9Mx/fDxihIUa5zlpzLN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHKIXV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgHKIXV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Aug 2020 04:23:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76CA920678;
        Tue, 11 Aug 2020 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597134201;
        bh=05X/U1X1FmvLRP9StXB50QFn4807rniaSe6uYcy49QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1HE1+q140jJ+fPqVO9eDe4qgKMVRPd/jV8j4P++0m1IjqbkmmHzA93KGTMDdPmr1
         Q3FaWbW5iL+MT3uvjxKL7WiP832KT+sfI7FMbfuBnJheaZZcDciZ+1xSHhKSWqTc+b
         vpKT/hYrw2AxJZ0TD094EUtF3+4T/YQ1yGqM10Qo=
Date:   Tue, 11 Aug 2020 10:23:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paras Sharma <parashar@codeaurora.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] serial: qcom_geni_serial: To correct QUP Version
 detection logic
Message-ID: <20200811082330.GC113774@kroah.com>
References: <1597131794-1076-1-git-send-email-parashar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597131794-1076-1-git-send-email-parashar@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 11, 2020 at 01:13:14PM +0530, Paras Sharma wrote:
> The current implementation reduces the sampling rate by half
> if qup HW version greater is than 2.5 by checking if the geni
> SE major version is greater than 2 and geni SE minor version
> is greater than 5.
> 
> This implementation fails when the version is 3 or greater.
> 
> Hence by adding the another check for geni SE major version,
> this problem can be solved.
> 
> Signed-off-by: Paras Sharma <parashar@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Should this go to stable kernels?  If so, how far back?  What git commit
id is this patch fixing?  And if so, why not put a Fixes: tag on this as
well?

thanks,

greg k-h
