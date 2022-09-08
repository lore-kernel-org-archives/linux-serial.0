Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1807C38145
	for <linux-serial@archiver.kernel.org>; Thu,  8 Sep 2022 00:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIHAnk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiIHAnj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Sep 2022 20:43:39 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E0B81F0
        for <linux-serial@vger.kernel.org>; Wed,  7 Sep 2022 17:43:37 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1278a61bd57so21763022fac.7
        for <linux-serial@vger.kernel.org>; Wed, 07 Sep 2022 17:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date;
        bh=0NDOpRRZXKSoT0ag7W3GTB/utuZq1B1nc2pEFCLA+SM=;
        b=hljcWqxcGFzN8FxmRrg+VJublQkjR+8ByfCr5igMQXtQycm1WkYNnMcUWj781qo0EY
         93TpacIccciqXXTc4QWx9paA5MA5TLas5OhhQ05r5Top/X3/MbuiToSgU/W0z1TxO7ez
         IbG63SykKaqLNvV3z+iTBb6XMhRo/AXzo/WKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0NDOpRRZXKSoT0ag7W3GTB/utuZq1B1nc2pEFCLA+SM=;
        b=JC9WNIHy8mDyUyncypxrDx7VXL1UvaUR3dTHPS35b+0eqaQEhTEono/aJqGCFjVsDi
         ps1WtG1jYouYjJlywvWe3Th2i6KpYm1yxM5viQ6ARD5QM9dRYW7kQQt0iK+Qf1KMibvY
         0fwelAop4RpgO2VcqeGuwYPXva3hWKRWn0+f9U5QY07yjIr5kzkr8p6C6RmOSrX76tOM
         6h3KCzkNyg3v+dGJ7g0sPsz8bsegvQGTMTQg8+mmQYqsws+YI+NDuhyVibNK43fYSX0+
         F+RkMlXx65B64h9ixMavKq1fXY7MjZ4XH842Aj4n5Ny8hmAjZOeL38UE9SOvxvlPk5+U
         iexw==
X-Gm-Message-State: ACgBeo25edQdrp+Ttq0yAbv2HiaoatEgk4vk6NAHLUk6Jo5muncza4b9
        Gqq3ZJYgoWe+AbxVwnd2TMJWOsutw8vmPrulzHcqdw==
X-Google-Smtp-Source: AA6agR7BSPSs98vSFaJfDu5M4EnQqDgWgsMOH8L9mxK0EGPdtbJUMA3iEP1v0WNDQ7RL/nqHOQkbX6Dg29/ju6EDcKE=
X-Received: by 2002:a05:6808:bca:b0:344:ef42:930f with SMTP id
 o10-20020a0568080bca00b00344ef42930fmr436019oik.0.1662597817334; Wed, 07 Sep
 2022 17:43:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Sep 2022 19:43:36 -0500
MIME-Version: 1.0
In-Reply-To: <1662564702-7253-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1662564702-7253-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 7 Sep 2022 19:43:36 -0500
Message-ID: <CAE-0n52q3419nOSh3WOfyqhnDdFUSS4Oq4h-0CPQOZkQ54_UNQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Replace hardcoded icc
 flags with macros.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Vijaya Krishna Nivarthi (2022-09-07 08:31:42)
> In suspend/resume routines, icc flags are hardcoded.
>
> Replace the hardcodes with macros available from header.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
