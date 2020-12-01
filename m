Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587C8C64E8A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 07:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE9D2085B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 07:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auWJKdwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgLAHTZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgLAHTZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 02:19:25 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA7C0613CF;
        Mon, 30 Nov 2020 23:18:44 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id x4so390385vsp.7;
        Mon, 30 Nov 2020 23:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3/mAGTVPuz8+dqCn7++T3X3NmDsHTQaAJoz4dS/tN7E=;
        b=auWJKdwFapW8VX4/y3BkFf+mmYV3watyYsEC+9pDL8BldKvxH+MBSS0hI5zL4sJM8T
         FFW26mgohEHlZc6SdDK7vDTVBerbDzGoVuyrXDfrDgdbphybQUwW7uGnepyiXYWjCXIO
         xL/GCIOyE3znX6rKE38rYNNdka5jIjlWF0qi9FR7w/94GSvLDWy877K3VTaA23TPzO3D
         eztMMwLhlaLc9mBNJhCnVWWWcAgo9QWqTxZAi85tGJu26yVsiQMRPZnagIf1b+qdSgOB
         JUBBpBshDJvnCRm78xyMLk7SnryKBUrXnJf8qZO4m7B1mQBDuyy3fIJ0dZkcolnoLxbW
         SERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3/mAGTVPuz8+dqCn7++T3X3NmDsHTQaAJoz4dS/tN7E=;
        b=NO3hcW7wr5xalLuYmTr07xUPVe7CvhemoNDfkaT/ddk6ejquDDvWvjg5UX5Ta0aAjY
         GiwJDXgR7dD4ORhxCjLsbzXKYf+B0K6TRuGosNJp99cgen0NsB0fBn0l7upx9Qi20MRE
         NjAvZfnyan7iOYFsYNlZKK1G74S2OPEKIYHBEUh/wEWX+RUKBfNQt/KEzFPAVgPPCxxt
         nJabc8KnR3eYGXTLIHSSAM7cxkJYOzes2IZ9r5G5LoVgMGteSyBBJgnqlFpaRNvcYjDc
         g5PwmlQT9GVI+OtKQtlYAH9h1gPBnWtksmQOWAUNhVs6QYk0szJkpgUpy3YW+IvDyZV/
         nifw==
X-Gm-Message-State: AOAM5300zXl/XGjwNveTmS36AZ+MaRa3LOzVy4OJ/52skwHYG6SjTWfI
        zMv4h74mk/xLEHTlxkF7rTCE3SBNJvm+yQh7A80=
X-Google-Smtp-Source: ABdhPJyjvidK04O1BfV3cDIPsEDz0HyKyeoagTApTwHI33ONN3DsYSGdCZaUEmvWwqbWHNf0VfTjIxnayU17GqYJyAs=
X-Received: by 2002:a05:6102:d1:: with SMTP id u17mr1333362vsp.8.1606807124142;
 Mon, 30 Nov 2020 23:18:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6ecb:0:0:0:0:0 with HTTP; Mon, 30 Nov 2020 23:18:43
 -0800 (PST)
In-Reply-To: <c8f3e485-54c6-99c7-4888-6eef2e174bf6@kernel.org>
References: <20201130153742.9163-1-johan@kernel.org> <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
 <c8f3e485-54c6-99c7-4888-6eef2e174bf6@kernel.org>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Mon, 30 Nov 2020 23:18:43 -0800
Message-ID: <CA+uuBqZtUvdGq9ct1Ltt9dLyc4WvV0x7_KzP487bR45JOh9qfw@mail.gmail.com>
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/30/20, Jiri Slaby <jirislaby@kernel.org> wrote:
> The difference to other control flags is that open raises DTR/RTS in any
> case (i.e. including O_NONBLOCK)

Yes, this is the exact root-cause problem I am trying to fix, with Johan's help.

> -- provided baud rate is set (and it is
> for casual serials). That means you cannot open a port to configure it
> (using e.g. setserial) without actually raising the DTR/RTS.

Exactly.

M~
