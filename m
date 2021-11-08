Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3A6C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 14:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF4A61076
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 14:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbhKHOb3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 09:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbhKHOb2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 09:31:28 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED8C061570;
        Mon,  8 Nov 2021 06:28:43 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so25762569otf.2;
        Mon, 08 Nov 2021 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zddqLgqGTr+VISPPPEfVDEa95nv8B5wIf1fGQsuOVx8=;
        b=GC+UtHWket+w6TWXUa5PdiX9Pb30dK4kmfMuCfGTetawhHAv5r1Nbgpp+9Q41qhWup
         +NOHRCk8b3/Cl8U0QRi67lqE7HTPwfYDFkg/jdo2x0yWjcW5mUJ7M0Kgpp7pwrr02zOb
         XHqsIaEKPoP/xu0BGHLQLRidFJbpO7GVETW9tOcvOkohDJiumMaZO6gDTRPWWgD4SdU0
         Gk6i8JykmXiP60934Lu8LyCYITRGYObpbz0jHz1suN2/mTwqQJ5wEcA447D4qNmAcCfl
         V6vZMeK6sRi/loHOJfJ3RlyLAVyBHA3/GoppeKBU1UIBW8+yl7lMAHO6/lnocg89KM/k
         f5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zddqLgqGTr+VISPPPEfVDEa95nv8B5wIf1fGQsuOVx8=;
        b=axfBk+bENKUk7b5/hOfbFXpcLrwqXL7YAZfTnmSScnIqvuWgXCOUDBw+eJHDKBOcAb
         XG5FAYYY2T1WSh4+EKY8nBWVW9i0aD3SKmhtFMysLXFHgao4Anuz5euger1WbiNQJzvU
         aOvdtOBSGCx1EXFxvppGyjhFbD/FuEBRRnsF47ptv7xNMH2eSMPveG9YBDUYfObFXMIV
         szE26sEA7tUbaOtLJWqko0Xbd0xGyQtO688zgbf3HMMuM78AQwsc1I9lip+aXphQMK8Z
         AP+dEO472y4mspt+1TWpax5xXSVueiXPnW1h+2OclxfkI1N1wKhhEKciADq4GkVpSVDh
         ifMA==
X-Gm-Message-State: AOAM530Vord/9MEjEhZ0jOZSy17B+GGCzbSzrifuVs3pJ2dA4Zzy9Gv8
        DaU3FPfN2qossmdbu2CKipDCPT4zCEGR48dBGT4=
X-Google-Smtp-Source: ABdhPJxeViaX4NG9EdYM+G5nBy4wKZQWa0Jvkli7h35XTucwVncG8DVWP9a98vMrFs/BJpQ3gVoiAXXoJ6cgHySRfEQ=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr116986otq.173.1636381723402;
 Mon, 08 Nov 2021 06:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20211108134901.7449-1-ajaygargnsit@gmail.com> <YYkroa2v1ruwPRBN@kroah.com>
 <CAHP4M8WLaWa769hDJBWVwL7P7hadoTk+CE1sVba3tRVxpMRVtw@mail.gmail.com> <YYkv7ekV9ezpPOWx@kroah.com>
In-Reply-To: <YYkv7ekV9ezpPOWx@kroah.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 19:58:31 +0530
Message-ID: <CAHP4M8XxbqCBU9gnoT4vbCMbQCEuV=Nm8SpJRMtksorr7F1z9g@mail.gmail.com>
Subject: Re: [PATCH v5] vt: keyboard: suppress warnings in vt_do_kdgkb_ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        kernel@esmil.dk, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, paskripkin@gmail.com,
        johan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

>
> You are listing two different things being done in this single commit.
>
> It should be 2 different patches.
>
> I would recommend getting more comfortable with Linux kernel development
> by working in the drivers/staging/ portion of the kernel first.  And not
> in the "core" kernel like tty/serial or other well-entrenched
> subsystems.  That way you can learn the proper processes and workflows
> better in an area of the kernel that is specifically designed just for
> that, and not end up bothering the time of other kernel developers for
> basic process issues like your recent patches have shown.
>

Ok, thanks Greg for the suggestion. Now looking to work with someone
on an active component in drivers/staging, to come up to terms :)
Thanks everyone for their time.


Thanks and Regards,
Ajay
