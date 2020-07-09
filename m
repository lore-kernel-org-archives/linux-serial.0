Return-Path: <SRS0=9J3d=AU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71477C433DF
	for <linux-serial@archiver.kernel.org>; Thu,  9 Jul 2020 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A13207D0
	for <linux-serial@archiver.kernel.org>; Thu,  9 Jul 2020 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lqOZ9Vno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGIP0y (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgGIP0x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Jul 2020 11:26:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F0C08C5DD
        for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2020 08:26:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so970110plo.7
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2020 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Io/mcFrQGmKFI/J7y8Kvbnw7Sd2yzklarBYDCcZ/mU4=;
        b=lqOZ9VnoNFqFqWU6dnrvF3ytzvguHdIiMzhTNUwohP1JTvBJUE0fGANEr1kEpsRYaU
         T88hkxoG+egozI5GuJ1u03E5Az1rZYBu4pj8imOnW6/WuJyf4ZhIA83lN49SaML6koNh
         7Jnu5FDNs7JJ/V5DZgH5wY6L3f9qS+8Td+YRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Io/mcFrQGmKFI/J7y8Kvbnw7Sd2yzklarBYDCcZ/mU4=;
        b=XKp1eLZAVnhz57JxRXMebAIA424AgWZrm80oQvZFWRgV5QI+wdqprOoT5qkbodrEW2
         HhVa12YqsZkMIjt/VuHyvZbO+BASzrvG28EioXBTk/9BOlxXDZFxcFTBeO8NvTssoPsd
         +bCe6eGqwmF6rHZ5JyqFAGKMrAansxCBxkaVT6V2Ho9edxbxNWeGTNoOADkynSolQgV1
         TmcnqM7hXVBmVFIgfkQi3a3SckAaAbtNWc4gDrKIjeU9wFE6k4CcCDCjF3Yvqy7tTl1p
         u5FI/pzAbkf52Ieu2ZVJ5uf2v09F27Ikd6V42jdC/0+drvi2k97AkMNy29spR9+tFQr1
         YfSw==
X-Gm-Message-State: AOAM531h/0FN96a2v0j1LS6O9dkRneyCfu59HYG/IhxKb20duFS4Z0l5
        2r2QLrTepeS+ndPLlWY2GNRgNA==
X-Google-Smtp-Source: ABdhPJzMPBypSd95etgDvAlbeBxpHEC0IUibuotoWf73dYLHTKbmK48l2Xgg3Nw9fv2P+eMKHigIsQ==
X-Received: by 2002:a17:902:b687:: with SMTP id c7mr54618732pls.102.1594308413042;
        Thu, 09 Jul 2020 08:26:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id g18sm3261173pfk.40.2020.07.09.08.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:26:52 -0700 (PDT)
Date:   Thu, 9 Jul 2020 08:26:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        gregkh@linuxfoundation.org, georgi.djakov@linaro.org,
        akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Drop the icc bw votes in
 suspend for console
Message-ID: <20200709152650.GI3191083@google.com>
References: <1594287420-24141-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1594287420-24141-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 09, 2020 at 03:07:00PM +0530, Rajendra Nayak wrote:
> When using the geni-serial as console, its important to be
> able to hit the lowest possible power state in suspend,
> even with no_console_suspend.
> The only thing that prevents it today on platforms like the sc7180
> is the interconnect BW votes, which we certainly don't need when
> the system is in suspend. So in the suspend handler mark them as
> ACTIVE_ONLY (0x3) and on resume switch them back to the ALWAYS tag (0x7)
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Tested-by: Matthias Kaehlcke <mka@chromium.org>
