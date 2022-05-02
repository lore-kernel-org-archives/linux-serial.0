Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD96C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  2 May 2022 12:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384899AbiEBMLc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 May 2022 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384909AbiEBML0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 May 2022 08:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E45140FB;
        Mon,  2 May 2022 05:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60621612C9;
        Mon,  2 May 2022 12:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B240AC385AC;
        Mon,  2 May 2022 12:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651493276;
        bh=zH2JcPp93hhXKO2FfuIW5JhzudLikwLODK+XcpVnpr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIGvj5ylzXIGwnN46d+L669DA/lp2myUd5Uzhms1Zbpap/5w97HFOrldCZSGfhHhB
         KGvjkU5WjjtEfzhx44dYS1Rbe6tzoQOfbCz8hs7oBnnDh7YtpFUj+2eqjE5kees9c4
         CetMKXTHgyFa/+CWsFtSni8aRTisvW2ZlAY7XV38=
Date:   Mon, 2 May 2022 14:07:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        jirislaby@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH 2/2] tty: serial: qcom_geni_serial: Disable MMIO tracing
Message-ID: <Ym/Jm0MSRCQEt77B@kroah.com>
References: <1651488314-19382-1-git-send-email-quic_vnivarth@quicinc.com>
 <1651488314-19382-3-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651488314-19382-3-git-send-email-quic_vnivarth@quicinc.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 02, 2022 at 04:15:14PM +0530, Vijaya Krishna Nivarthi wrote:
> Register read/write tracing is causing excessive
> logging and filling the rtb buffer and effecting
> performance.
> 
> Disabled MMIO tracing to disable register
> read/write tracing.
> 
> Signed-off-by: Visweswara Tanuku <quic_vtanuku@quicinc.com>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index f496102..aa8facb 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1,5 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> +/*
> + * Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.

As stated before, this change is not proper.

thanks,

greg k-h
