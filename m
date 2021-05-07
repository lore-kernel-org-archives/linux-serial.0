Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B9DC433ED
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 19:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63D4610D2
	for <linux-serial@archiver.kernel.org>; Fri,  7 May 2021 19:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhEGTUl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 May 2021 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhEGTUl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 May 2021 15:20:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E9C061574;
        Fri,  7 May 2021 12:19:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f24so15178759ejc.6;
        Fri, 07 May 2021 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9m7MMdVqLKAy3chOmd9o8x3GgGbbXRzbchSC4T+XsRI=;
        b=KY0d3e3IEUTZBH5JzSrg6Mj1XkZNF99NKMXm5l9scfi0MdX99qxpoH73iqkKF17s1y
         Wo3k5EBCgudNoNYx1dv0hs2+laRhHFBEr2Zw7hw9LoweZ5BfPZh1+apa1PgY5ZOUpUn/
         EXKgQYM1kEN5ahCcpXWwn773uEaGBlACE91XZQJKou8wkylt5n6EypjyH9MBUf9dVZUH
         7AD5n+pEDM7i7rUclwSZ4U2rVTZmHi18lTTXehB/ycLkceSu5RUg5KsMJGVk2thku4pf
         vbpoOYMu8TQLC+rPuv1eDyk1n5tAMrNJzuZFwWHcAAWaTkmZaWFU17GIwVm8UiUNLtHl
         tQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9m7MMdVqLKAy3chOmd9o8x3GgGbbXRzbchSC4T+XsRI=;
        b=dWhe+W6sNkJ7l+WAhDswWycqjaQqy1X24JklobiITtdrkoKq/5DRueo4+agONiNOQt
         DaqO7SU5CMi6KuehMSCNNdV0fHugAPM8EBYTTW1Fi4RNmYgPSfa84+rwdTN99/FOt8a+
         B5TQ9xaSjym3EHbKq4z+FsYYl+nkqHcdDIuYZxZo3y8EsbPnU/mVaqu2fXiKRXjwePqY
         PNwHJGhs5JWdGUxamY05GQKBRBwSHOUlNoGncOPdJ8sNcpl7z6PWTcjGpfOQmwzigZIP
         UWYoUoxQEO984dMZrSOkDZDicf1uldJ0hDtTm5L9T0NlKCs62X8j3r1BTLRf2+x50jsQ
         O1RQ==
X-Gm-Message-State: AOAM532dxaVvlPdX+fLb57U7Tbr0uPHkK5Y+Kx9bulKUGlvoO5bF9qRJ
        K6lbiQQAkcLfUa0KHiLtlNSgnwP3vQTgkwFq
X-Google-Smtp-Source: ABdhPJwkTnOB6rNhcQ5WxYos6n/lFZIFyXKgvJlPwbIBrWwIb4iPbrKJdgX+hWtz+LAfaJ4++1FbEg==
X-Received: by 2002:a17:906:f6d0:: with SMTP id jo16mr11645678ejb.461.1620415178115;
        Fri, 07 May 2021 12:19:38 -0700 (PDT)
Received: from r00t ([212.15.178.107])
        by smtp.gmail.com with ESMTPSA id rs28sm3965783ejb.35.2021.05.07.12.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 12:19:37 -0700 (PDT)
Date:   Fri, 7 May 2021 22:18:13 +0200
From:   Ivan Bakula <wamreu@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh@kernel.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TTY: serdev: Replace depricated macros
Message-ID: <YJWghQC8hJ3UO6lG@r00t>
References: <20210506183228.33981-1-wamreu@gmail.com>
 <YJQp4W2X/tuvLfVA@kroah.com>
 <YJUhZP1FwMlUfWrw@r00t>
 <YJUbv3t05ai+g2k0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJUbv3t05ai+g2k0@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Ok, got it.

Thank you for your time,

I.B.
