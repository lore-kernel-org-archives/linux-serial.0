Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BDEB64DD
	for <linux-serial@archiver.kernel.org>; Wed, 12 Jul 2023 15:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjGLPUL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGLPUE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jul 2023 11:20:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06591BE4
        for <linux-serial@vger.kernel.org>; Wed, 12 Jul 2023 08:19:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31297125334so603492f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 12 Jul 2023 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689175174; x=1691767174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2jUmgPJMl8rNeDpH2GLcq5ImDgq36YmUU+/0NveM+c=;
        b=UCdooMkEYlmcH+/GKIRSljMulWWBGH63TzM/BqZq9bgBjr1sGdLtosqgSUbGCEEzjo
         m7W1rk+X2V7pObvBjCST9USZDZ5VZF/1RBl6O41iXhaR275YmFfzJ7OtCj9+nRp6HPpB
         lQKhDg1TWTYDRWOHVa4pcjQipoboO9GFErVfWepMof3s3AdkSb4H2ijilhUpquOCL/j8
         MaAri8u5ZsVQ/TDcX2sBvarXUp79ENwuv8db663JxWVAKpMFUmOSzeTPvTMknpoePoN8
         dDBfTTtozC5DV89B74cZ4PLVjzfWWLaW2gHahea6422LmC6nGJCjgvwjuqRrEtJ/ghj5
         kDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689175174; x=1691767174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2jUmgPJMl8rNeDpH2GLcq5ImDgq36YmUU+/0NveM+c=;
        b=Xp6BnhTmaJsnxv/5MTp3i2pAsGAxTWjZmrwpvos6LEsyc91YWyBqEexxI63WW2hXSj
         UvUZ29ryOLcpmFoErmJ8+zRUSOasWrMKaaqpPa46aKJBtDVzsfmvE6yOgXwvQ9ag/QjX
         D5hjUh4IrbFidowkmfLyt9C/MXUVy5Wt70I/Op+BhZJZ8E1IIFqTQiI1ZkpNFqITf3Zs
         WngTmKu6FnFUvGiotfSV6mCEwyLsEepmifhjl3XxULivT9k94zho8Ma3dymabsOsHE9C
         AiM2/N0JF9q6ZztW+AMcwZx6aO3vbodMOrjrvlpEKnSAY05Ph6qILzlqcTQnQWufjLDH
         BPgA==
X-Gm-Message-State: ABy/qLbc3aQ6EABXT9R5VtUzr/444svlnoQRU0gPyao3iScF/RnnLNjA
        Rd//vh5pfBcVVvp6enwdsNX7Rg==
X-Google-Smtp-Source: APBJJlHdwL2zKIVCmmL3/riZO45YQ7rzeJE80NsRv8hjeV/nAECA/Gt5BHfQ4Nv94ah2m4kod3Me7A==
X-Received: by 2002:a05:6000:4c3:b0:314:1d6:8aa7 with SMTP id h3-20020a05600004c300b0031401d68aa7mr1972887wri.29.1689175174315;
        Wed, 12 Jul 2023 08:19:34 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm5349531wrx.48.2023.07.12.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:19:33 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:19:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 02/10] tty: sysrq: switch sysrq handlers from int to u8
Message-ID: <20230712151931.GA458038@aspen.lan>
References: <20230712081811.29004-1-jirislaby@kernel.org>
 <20230712081811.29004-3-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712081811.29004-3-jirislaby@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 12, 2023 at 10:18:03AM +0200, Jiri Slaby (SUSE) wrote:
> The passed parameter to sysrq handlers is a key (a character). So change
> the type from 'int' to 'u8'. Let it specifically be 'u8' for two
> reasons:
> * unsigned: unsigned values come from the upper layers (devices) and the
>   tty layer assumes unsigned on most places, and
> * 8-bit: as that what's supposed to be one day in all the layers built
>   on the top of tty. (Currently, we use mostly 'unsigned char' and
>   somewhere still only 'char'. (But that also translates to the former
>   thanks to -funsigned-char.))
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> <snip>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>

For kgdb:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
