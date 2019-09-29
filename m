Return-Path: <SRS0=vVzV=XY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDD0C4360C
	for <linux-serial@archiver.kernel.org>; Sun, 29 Sep 2019 21:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F19217F5
	for <linux-serial@archiver.kernel.org>; Sun, 29 Sep 2019 21:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rm5248.com header.i=@rm5248.com header.b="P3acGZNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfI2VaZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 29 Sep 2019 17:30:25 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:4274 "EHLO
        egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbfI2VaZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 29 Sep 2019 17:30:25 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4ED00501F81
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2019 21:30:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a14.g.dreamhost.com (100-96-145-245.trex.outbound.svc.cluster.local [100.96.145.245])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A0C35501C92
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2019 21:30:22 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a14.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.1);
        Sun, 29 Sep 2019 21:30:23 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Society-Bubble: 2495d2a120d02323_1569792623077_2736283823
X-MC-Loop-Signature: 1569792623077:1613260506
X-MC-Ingress-Time: 1569792623077
Received: from pdx1-sub0-mail-a14.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a14.g.dreamhost.com (Postfix) with ESMTP id 276D285922
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2019 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=w6WbzYG3rTsISBD25F0rz1w64bs=; b=
        P3acGZNW+VDVkg+2Vn5OkUbuckTNbgME9RhXdS6Oco9/dXtVagSyK0hYdTjdGt1n
        YkwpE/wiAkDk1ig6p4NJ3HH1bvjgEE1FmS9+1q4Il2d/qY8Ic3GQr+FzGBBDmOX5
        YKbb6e4DLG2E/XYh5uaGGehR+9RKXlppZMnyoK8o3Ik=
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a14.g.dreamhost.com (Postfix) with ESMTPSA id 8B73385921
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2019 14:30:16 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id u8so32769961iom.5
        for <linux-serial@vger.kernel.org>; Sun, 29 Sep 2019 14:30:15 -0700 (PDT)
X-Gm-Message-State: APjAAAU+6kHNv0HqPYIEz5pFdahchVLYSXdWs9QD0ds4KTQQdo4c+3XE
        rZkJS5z772INgnv4wLEpaUZDwnW9pe5e2jH6NIY=
X-Google-Smtp-Source: APXvYqwSnYVhfFA/6R+KwB71BK92FR6aQdWPFgg5KIn8x+sSbyDYwYns4ZK6mQhbMiVKnjOmHUueFRZRZM4IhZgAOeU=
X-Received: by 2002:a6b:f90a:: with SMTP id j10mr10994202iog.77.1569792615457;
 Sun, 29 Sep 2019 14:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com> <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com> <20190806153110.GG30120@smile.fi.intel.com>
 <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
 <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
 <20190807150425.GC30120@smile.fi.intel.com> <CAKpcJVYmTK-kw5eZJtcMWBSMmOk4ijqu-1oh9cEswi4q98QHAg@mail.gmail.com>
 <20190808121148.GT30120@smile.fi.intel.com> <d4ec5a0a-08e3-4da9-bf43-fb1269d0b996@codethink.co.uk>
 <d64d54fd-5d21-f0a5-8804-b4a0ce486c59@codethink.co.uk>
In-Reply-To: <d64d54fd-5d21-f0a5-8804-b4a0ce486c59@codethink.co.uk>
X-DH-BACKEND: pdx1-sub0-mail-a14
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Sun, 29 Sep 2019 17:30:04 -0400
X-Gmail-Original-Message-ID: <CAKpcJVaNyv-D3eehF4rcE7ZvihRcsdHm+dOWAea0+6CETY6L=Q@mail.gmail.com>
Message-ID: <CAKpcJVaNyv-D3eehF4rcE7ZvihRcsdHm+dOWAea0+6CETY6L=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedtgdduieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrudeiiedrgedunecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqihhouddqfheguddrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrdduieeirdeguddprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Sep 29, 2019 at 2:15 PM Sudip Mukherjee
<sudip.mukherjee@codethink.co.uk> wrote:
>
> Hi Robert,
>
> Sorry for the delay. I managed to test it today. My test file contained
> 70 lines of "The quick brown fox jumps over the lazy dog". I used upto
> 1200 Baudrate to send the text from the desktop using the Exar serial I
> have and I did not notice any message loss on the receiving laptop.
> Please let me know if you want me to test further.
>

Two questions:
1. What kernel version?  If you didn't have a problem, I can try with
the exact version that you have as well and see if I can reproduce on
my side.
2. Did you test this via 'cat text-file.txt > /dev/ttySX' ?  I'm
assuming that you are, but just want to make sure.

-Robert Middleton
