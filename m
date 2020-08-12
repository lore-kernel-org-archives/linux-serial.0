Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1916C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 19:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BA920781
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 19:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7QT7Mhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHLTOe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgHLTOd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 15:14:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D19C061383
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 12:14:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k13so1764658lfo.0
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FeWQAEAXQyh9OcTcZqkBShgazLRu02qsmYbCBeVEhZY=;
        b=k7QT7MhfKa34FGuqMSbQKpCiRXwHGP2OCXHf40eVqa/NsouCw2acZY/yVKXt6aOSf+
         Myovf3SSN5FLQxiG++AoLxmvSE3skVSHBP+mlEmNdS69/6V0QB5qbPvXrdFNCxWT9aCv
         i17toqyQLIiNWK7D/7QKJe8klOBMyTlZbYau+U/zmmptNOkOHpu6I4SqIxolybRD9Rvc
         z7Bk4VS+2RvM2ax+nuFLdgM2CJ1d0pXkCwaO6bZTKyWqMj5i+w7vld1vfE+6kl+MGGgp
         mouGi+Hb7j+QWtOaNXTvJIl4LcE4H991qtAX8E4XJr/wlfHC9O7s3xtxs4uGwhnvN4TJ
         jrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FeWQAEAXQyh9OcTcZqkBShgazLRu02qsmYbCBeVEhZY=;
        b=Ld1Up/xsMCXIjw3dqgCW8WXC6WqBxO6QNjoGuM0ZUk+/sZ7xU9WK2uFh7rIprXJ4hH
         QjcI7NDcSJD8v6vlBEAAAD7W0VPv7FzLiT0mVFiWs/jWBzLmrEeqrvkDO7K8rPDaQUTo
         kLvRFbecHKfOn6sZsi5uiL2UIRk0E95GPYMHFRe4xN2NYEYes2KqguBA34MV6sPuLl4I
         nKmcbumaC0Ty9nAy1zsUOz0aOU1519FASkAwA7J+DqC2uL7aKTJGsxS1HGDS2vRQWXTO
         3R5hfl6XrGjwc4eCcMFzD4QEnEVFc8QnfqB3M6E4KiHmKnnxWKQ8/5CkBotmNXSZpBHJ
         eV6g==
X-Gm-Message-State: AOAM531UpR7T1ANCcgpHWXUemp/eowGvNVAkQyOJs6TnDHO2gTWJLp98
        KQMqejelwPMaIgyIigE2pUI6ik83
X-Google-Smtp-Source: ABdhPJxxObJABPminYI+ciUC8i/L5o1aVvf1rBpbMqQJ+StY2Faj9TxNRvSMgsEnRnSlioAXjeoobA==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr432921lfl.176.1597259668039;
        Wed, 12 Aug 2020 12:14:28 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b16sm617144ljk.24.2020.08.12.12.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:14:27 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Petr Slansky <slansky@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Serial raw mode. Bug in serial driver in Linux kernel? Is
 documentation correct?
References: <CA+ww9hwAzFHCYhkQUev2_VBN=8gMsxBcnExG53_gCkC6++-ScA@mail.gmail.com>
Date:   Wed, 12 Aug 2020 22:14:26 +0300
In-Reply-To: <CA+ww9hwAzFHCYhkQUev2_VBN=8gMsxBcnExG53_gCkC6++-ScA@mail.gmail.com>
        (Petr Slansky's message of "Wed, 12 Aug 2020 18:51:39 +0200")
Message-ID: <87v9hn7k31.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Petr Slansky <slansky@gmail.com> writes:

> Hi Linux-Serial,
>
> I was fixing "pirate-loader" for BusPirate device, firmware loader utility.
> The design followed documentation for serial communication for "row"
> serial mode but it was not working. I modified flags and utility works
> now but my modification doesn't match documentation. That is strange
> from my point of view. Have I discovered a bug in the kernel? Could
> you check??
>
> Details are here, second comment, the long one:
> https://github.com/BusPirate/Bus_Pirate/issues/140
>
> This is the core of my fix, I changed CSIZE flag:
>
>         cfmakeraw(&g_new_tio);
>
> -       g_new_tio.c_cflag |=  (CS8 | CLOCAL | CREAD);
> -       g_new_tio.c_cflag &= ~(PARENB | CSTOPB | CSIZE);

You got a bug right here. Just swap these 2 lines. You should first
clear CSIZE bits, then set CS8 size.

-- Sergey Organov
