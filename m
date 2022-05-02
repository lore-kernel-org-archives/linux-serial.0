Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDDFC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  2 May 2022 12:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiEBMKb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 May 2022 08:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiEBMK2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 May 2022 08:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6632B10FE0;
        Mon,  2 May 2022 05:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025A660C0B;
        Mon,  2 May 2022 12:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEEFC385AC;
        Mon,  2 May 2022 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651493219;
        bh=qetEOcAf7xVqMAk2Ja1t6zfPHpXbHu/1KECgNdTnRvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntf9qGJykfKce1zRoZPx84E7tVWUcZvpAQ2p+B2xg4H49YByUJo5JIU+ogHTpUWT+
         yWqL+ehCVu1fFYen2qQBm6AX8AlcZ1m6ALFE7RuiEuiZq3qAuR2XCKcsa2EKf2YAgc
         j68iucwG09eqMbuDD6NblfO5aeiUq/kf9gtwt7o0=
Date:   Mon, 2 May 2022 14:06:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        jirislaby@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH 0/2] Disable MMIO tracing from QUP wrapper and serial
 driver
Message-ID: <Ym/JYr3ltaKWqHQn@kroah.com>
References: <1651488314-19382-1-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651488314-19382-1-git-send-email-quic_vnivarth@quicinc.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 02, 2022 at 04:15:12PM +0530, Vijaya Krishna Nivarthi wrote:
> Register read/write tracing is causing excessive
> logging and filling the rtb buffer and effecting
> performance.
> 
> Disabled MMIO tracing from QUP wrapper and serial
> driver to disable register read/write tracing.
> 
> Vijaya Krishna Nivarthi (2):
>   soc: qcom: geni: Disable MMIO tracing
>   tty: serial: qcom_geni_serial: Disable MMIO tracing
> 
>  drivers/soc/qcom/qcom-geni-se.c       | 8 +++++++-
>  drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> -- 
> 

Doesn't this series depend on the MMIO tracing series?  Why not just
make it part of that one?

confused,

greg k-h
