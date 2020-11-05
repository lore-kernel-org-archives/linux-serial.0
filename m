Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1133CC4741F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 16:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A04B2080D
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 16:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOJgFMFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKEQJ6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 11:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEQJ6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 11:09:58 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D6C0613CF;
        Thu,  5 Nov 2020 08:09:57 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id u19so2337936ion.3;
        Thu, 05 Nov 2020 08:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLDJlkfpjU9lqWYdXgPxbTY25CjR40spE2GrrTHC2WY=;
        b=EOJgFMFm6KWKrv88sMQgUbUc7iRugwEuz4Lg2hsOXg/WxZtkYwhZSox7ECYBCLVzcw
         y7gK2KzRRcKsJPka7M0/7ZOdGLG7HgQ7+wIuxUA3WsUyjQB0HyqxODatNBhHtPcT8GgA
         WspuENYXmeq/HMV7vQAiccRC1+19VN1wU4aStq6RMZpyYa88wPnkPMVnerfj7RgWhP+w
         RkUkxBh8eCrZS5trlL3Vs8ITDBVt159B38iuIjnuN+qGHeVm2BJBl5K3nUOM9SplGaBM
         aAlzeIfSxAoYyU0zo7y351vSH+3/NDDf7XsJNikxAfexzEbfy5cR3c034CdUsF7dqDke
         khAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLDJlkfpjU9lqWYdXgPxbTY25CjR40spE2GrrTHC2WY=;
        b=TaFPTn1K1yJItqHHodlabDD6928KRiV7Mofp6J1sVs/YT7WrlCa6v3BXXYncxGbnFO
         r6wnl0srv/cHeIBfkZD7kYS9Yf733zVeuacPHFX7Md1t026U1Bamr5QiGxMSFN9hQWCJ
         jv0UcpxXeqWHDVF8eTfjRR+7uZD2tEn90ZsKG4JX/PtwsE8fM1A+CUQSkLsCnzVaMA+s
         gmZwIaSPiAQna/BRDKHaDPQlhVLWgWT9I0bBPpEJ6y+G1ipPD+aQIAkXmyH8aNADN590
         i6jw/3OpLmX56bX0dCtW8F1XFtfsT8+cqE7k2LdLYZ3CSh4cISDAQH9SPnPMBE2tg1ph
         cxyA==
X-Gm-Message-State: AOAM533vR6eHiJ2fCiQWvk5VwOKz7JkOHyLYz6eE6jbmBLABRIf0Bnq8
        xRf3WeRTB1XJxso6rGthuV5K5eAer2+oa5y+V2o=
X-Google-Smtp-Source: ABdhPJx26OgEROU6LQe0Ck+ix34tLzuKcKCm0b7TN7vHCbweOLjuCFRV3NWFJo7F5L8rxNzfGotxBVbpdVN9GS0Hyn0=
X-Received: by 2002:a05:6638:419:: with SMTP id q25mr2640945jap.48.1604592597346;
 Thu, 05 Nov 2020 08:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20201104235134.17793-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20201104235134.17793-1-rikard.falkeborn@gmail.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Thu, 5 Nov 2020 09:09:46 -0700
Message-ID: <CAOCk7Nru+6--WdVaMQnwdGzS-KfHOR1teQnh+HEUKuWu5SnpwA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: msm_serial: Constify msm_uart_pops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 4, 2020 at 4:54 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> The only usage of msm_uart_pops is to assign its address to the ops
> field in the uart_port struct, which is a pointer to const. Make it
> const to allow the compiler to put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
