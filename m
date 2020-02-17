Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A042C34024
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF9C20725
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581955225;
	bh=+1rWFt0BhZpC3SqXwAi480o2XZY5N6loZqRsLUur/2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lfrppbJC/lW78Iwvfly+HnevjmAKcG7kMl6m60BDV1AyvOfWpJMjYdc7Nb/ujoE96
	 CwfrVCzYeHX9qSkjMKNaHuQkByw4oRbfDV2NeVYoxAYdwLWNJGl1gYUTdYK9O94f8B
	 3JE8h3mzF69saYG6kDf8RUmO1YmeIy6QSSMbS9QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgBQQAY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgBQQAX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 11:00:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AD4206F4;
        Mon, 17 Feb 2020 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581955223;
        bh=+1rWFt0BhZpC3SqXwAi480o2XZY5N6loZqRsLUur/2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIvncg8510kdf/ZqImAIxa0tFU+rfCmL5UIF7dAymDeFQigHY0/phCF+Qyxk/flPd
         Ul52S3a5DBsdrBqoRd0aHHiAJGHJ57BR6jWHYg/47PH2ZTrCMRK2O1kopxl/r0p7s4
         0ouE1j3OFyX2Blg5hH1SOJNyVjx+98GRo8on33ts=
Date:   Mon, 17 Feb 2020 17:00:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, wsa@the-dreams.de,
        broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH 2/6] tty: serial: qcom_geni_serial: Add interconnect
 support
Message-ID: <20200217160021.GA1484698@kroah.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-3-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581946205-27189-3-git-send-email-akashast@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 17, 2020 at 07:00:01PM +0530, Akash Asthana wrote:
> Get the interconnect paths for Uart based Serial Engine device
> and vote according to the baud rate requirement of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 84 ++++++++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 10 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
