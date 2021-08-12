Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E794C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 08:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE060EB9
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 08:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhHLIK4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 04:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbhHLIKz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 04:10:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B067C061765;
        Thu, 12 Aug 2021 01:10:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a8so8089744pjk.4;
        Thu, 12 Aug 2021 01:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=wA2EylzKX5tfpad+tzO/G4l9L4yhGUfFiyAU73+HP3E=;
        b=jytMxyA9OfnNO3v+z5cr6c2MoZg3Us6gVzi4atAwoYGQjBZAE8OQ+6MD3uiQlj8qhH
         +PaRT7FBHiEKPLEZMdofIl2LbzfhsnzpJReir6L5CKXevb8Y+ifvhAMoM6Wf+jrmZOVZ
         aB4J/yxlb53Pr+dnpVaf7hB9L7ujkrz1UILrrSmHPmz3CZ6CCvp6kde64oniPzaRsJNN
         1rS8j/ZGoUhw9t7GMpsRmX8pUA+s0MNkHE0tfIH+G8CPdC1vVjsIt7in3beoY7f73cZR
         0DCLQDGuqPuOt7KA6kkdjo0NN9SLQKGtX8YVuiqap/o2YnSzIa35SRuKrj0Bvds+vFJy
         MrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=wA2EylzKX5tfpad+tzO/G4l9L4yhGUfFiyAU73+HP3E=;
        b=sUGfE0nhB3F7GW2H6G3vXehgtw7//oGTjhX0S4vy/HH24irU0eJFn7s8Im6yi1pu1q
         iYDXtNZsVkT9cLOpmbuyISVDilY8l4NM0mFCEdUZ5p0LBH6Q/L1zlRNqM7f6mdklkeOA
         p1iz6lRdJvefwWve4aJFUOWewXhADsryU3kAMT9g4PyXkA4rcbTsjHYVHhOwb5X6WGje
         +AmyVZBvHMeo5DDlRQux5qKSKIvW0WXoM9Gvo8uzDZ7G0rhbrFYB1YZbHb9DJ6ivdBIu
         SBNZVY2MRgWXyiOUWlAUKXywQD0A5YBqROw76LghTFNyPIbIDf3fWjCEFi3aQHjxfFFX
         cxKA==
X-Gm-Message-State: AOAM533aG5RhEq1gY2k/3uovFsovQqYJHJa6gfm7naJiZIimM0YatJ9p
        3nTP2SPaFkzpHZCyllwddHY=
X-Google-Smtp-Source: ABdhPJyWVRQ71v8WMSr+n3GTebTul9FD7s7NiNuCOmKl8aFK9g24hVHxgaxR4eTjUtZtNBKkLQNUwA==
X-Received: by 2002:a63:e708:: with SMTP id b8mr2855779pgi.192.1628755830216;
        Thu, 12 Aug 2021 01:10:30 -0700 (PDT)
Received: from [10.157.0.42] ([85.203.23.10])
        by smtp.gmail.com with ESMTPSA id k4sm2632680pgh.9.2021.08.12.01.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 01:10:29 -0700 (PDT)
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
From:   Tuo Li <islituo@gmail.com>
Subject: serial: sh-sci: Is there a potential buffer underflow in
 sci_dma_rx_complete()?
Message-ID: <0778c492-984e-b09e-cb1c-750c8256c346@gmail.com>
Date:   Thu, 12 Aug 2021 16:10:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Our static analysis tool reports a possible buffer underflow in sh-sci.c 
in Linux 5.14.0-rc3:

The variable active is checked in:
1304:    if (active >= 0)

This indicates that it can be negative.
If so, a possible buffer underflow will occur:
1312:    desc = dmaengine_prep_slave_sg(s->chan_rx, &s->sg_rx[active], 
1, ....);

However, I am not sure whether &s->sg_rx[active] will be used in 
dmaengine_prep_slave_sg() if the
function sci_dma_rx_find_active() called at Line 1303 returns a negative 
value (-1).

Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
