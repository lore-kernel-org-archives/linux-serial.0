Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE48CC4332F
	for <linux-serial@archiver.kernel.org>; Tue, 31 Oct 2023 17:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbjJaRe6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Oct 2023 13:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbjJaRe5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Oct 2023 13:34:57 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336EC8F
        for <linux-serial@vger.kernel.org>; Tue, 31 Oct 2023 10:34:55 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28094a3b760so1318297a91.3
        for <linux-serial@vger.kernel.org>; Tue, 31 Oct 2023 10:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698773692; x=1699378492;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXofEti8JZwCHmgwTE3vRVhbr56U4e+wTA5dWayHUSY=;
        b=aKvJfXtLmxNSoMsakH/5m7Hc5ieGC1xwac0wKzlt9KJtwad/Ahj4ngqTGyy9VcWd8V
         h0/YU35CDro/NLL9tSqhbxQ0VYRXciGhbPjr7I/tNBd6mYYdhl6D1n5uSiM5+fX4TcyV
         Qw6f35/sdG3CT5278kGswPNDexboQ9OpszW6VWHZ0UJXzrMIa9yl+zbxiu2JrwhzxHd+
         7fe84/sKWgm+5/G262Rn7yzIMenWKmOBcgGgCRoVm1hZ4BrB2vn2LcVYnXzm3KkJrptu
         gL7ymqe0kl27cyqgxtrV9kTo2u5TgFL0twAJuQq9ZhiqdbPf1bvYue6oaEWZXKzaer/d
         887A==
X-Gm-Message-State: AOJu0Yx3RvM41dA+weD0d4/i3x+CLttHbhGaY/Wm5tk1nWI5RyF2+Jry
        oYjWgiLLzCuPL6FeTaysKIl9Rg==
X-Google-Smtp-Source: AGHT+IFNQNukXbiGrmnVenNCdhVkQD5ki1y5oU+7Q17KWZUlrk5JuFTubJ6QAp08WQPas03FyJmx0g==
X-Received: by 2002:a17:90a:9a98:b0:27e:3d05:418c with SMTP id e24-20020a17090a9a9800b0027e3d05418cmr9502150pjp.22.1698773692108;
        Tue, 31 Oct 2023 10:34:52 -0700 (PDT)
Received: from localhost (97-126-94-246.tukw.qwest.net. [97.126.94.246])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001b03f208323sm1586749pld.64.2023.10.31.10.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:34:51 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Tony Lindgren <tony@atomide.com>,
        Thomas Richard <thomas.richard@bootlin.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if
 no console suspend
In-Reply-To: <20231031105247.GC57044@atomide.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com> <20231024045109.GT27774@atomide.com>
 <7hjzrbj29t.fsf@baylibre.com> <20231025064131.GZ27774@atomide.com>
 <75b6cda8-c809-409b-8be9-ad8a4db63c14@bootlin.com>
 <20231031105247.GC57044@atomide.com>
Date:   Tue, 31 Oct 2023 10:34:51 -0700
Message-ID: <7h34xqitl0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Thomas Richard <thomas.richard@bootlin.com> [231031 10:15]:
>> Please find below the logs of the test you asked me.
>
> OK great thanks!
>
>> I added the call of pm_runtime_get_usage_count at the end of the suspend
>> function.
>> The console is attached on 2800000.serial, it has usage_count=4.
>> Other serial has usage_count=3.
>
> So as suspected, it seems the power domain gets force suspended
> somewhere despite the usage_count.

I think the only way this could happen (excluding any bugs, of course)
would be for pm_runtime_force_suspend() to be getting called somewhere,
but I thought the earlier patch made that call conditional, so maybe
there is another path where that is getting called?

Kevin


