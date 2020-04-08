Return-Path: <SRS0=0Mhk=5Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F3C2D0EA
	for <linux-serial@archiver.kernel.org>; Wed,  8 Apr 2020 07:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9DF2074F
	for <linux-serial@archiver.kernel.org>; Wed,  8 Apr 2020 07:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYpEyhHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDHHOE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:14:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41623 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHHOE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Apr 2020 03:14:04 -0400
Received: by mail-io1-f66.google.com with SMTP id b12so6070451ion.8;
        Wed, 08 Apr 2020 00:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3pOLajiHp9QNgBFOxW5iWABG0gRZUq3fep3oI+pRP8=;
        b=NYpEyhHH8YEEcu1QsXmXLw3y8kOTad+w3HVZnR+Y3hyVn62prunYKNT8T4GqQbQpBj
         l/At2kUjKL8Th079SXupYhtk21aNK7hDaCSwh9agFmmKlcK1CdHlWB2UW04XWDI3jA3m
         TuoQuBtCLW/G+i1HIPoZo0LfWs2GyJlsNd2SQuwD8vFG2NISI8HYiruCgp71XTTZj9A3
         rNRMGli6GXwytqzWW+cq3bspNSs7051L9l1d7ACWQYfr6eoBzNYQ//d4wEEumxvFSkdo
         gxYOGCqvk9aExhalhwO/oAaZIiEdBj0eswBvUf8O0FZrHL5YUJV6MatginpalN+p7TE4
         h36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3pOLajiHp9QNgBFOxW5iWABG0gRZUq3fep3oI+pRP8=;
        b=MxjCUM5Kh/qViTQqnaR9dOI9lhLvFwjlZ9Bi1B4nfvVuFxvFm0tRd4IxjiGCPE8UjT
         slNS5u1EUbGu9h4Yk6cSXnAzhREfrIAi3cUb3oi1k+aBPOP7ZsQIoaqgnLBbczP3kEB7
         T4UZyVwAS82fQgN3HYLT0KGT9Yc4bYvLFiTC6Fkryt5nZ5MZ6RLAN0kAtLlEjgF/sY4I
         UICyf7c7VEyia8uA0UrqMAhq5bjM6DChj7G0256SGoYTZYD/8McBAYa7yKb0f/OQJ5al
         5x6X3KrPj9qEeDQImUEggMYPdqOpHZQvRkAxGTOgzQaMTwaiZgVXhRbeVLd0o93YHaRw
         /KsQ==
X-Gm-Message-State: AGi0PuZGG33cEexS+iYq6PilpH7alF8ERhpLfeijxUM++I0Ej86l3N91
        JVET52dYZ70OYYL37hUtUknRI/ccuql6EHIa3F2YcQ==
X-Google-Smtp-Source: APiQypLby6SoQX8sZccd/LcU0stSsoPaVtQSyNW6q8SgeNId9cCkGs4yVDFZWwGwe5zLBkGQZQA/9vedTzGxJz3dR7I=
X-Received: by 2002:a5d:948e:: with SMTP id v14mr5715979ioj.112.1586330043053;
 Wed, 08 Apr 2020 00:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <1586278391-9061-1-git-send-email-raviteja.narayanam@xilinx.com>
In-Reply-To: <1586278391-9061-1-git-send-email-raviteja.narayanam@xilinx.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Wed, 8 Apr 2020 12:43:51 +0530
Message-ID: <CAKfKVtENc6R2c_h1Vr9AUywXJNGahctAaBz_05_kTY8vNNXeWg@mail.gmail.com>
Subject: Re: [PATCH] serial: uartps: Wait for tx_empty in console setup
To:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi ,
On Tue, Apr 7, 2020 at 10:25 PM Raviteja Narayanam
<raviteja.narayanam@xilinx.com> wrote:
>
> On some platforms, the log is corrupted while console is being
> registered. It is observed that when set_termios is called, there
> are still some bytes in the FIFO to be transmitted.
>
> So, wait for tx_empty inside cdns_uart_console_setup before
> calling set_termios.
>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
