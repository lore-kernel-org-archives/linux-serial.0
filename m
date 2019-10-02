Return-Path: <SRS0=7mFb=X3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6365C10F14
	for <linux-serial@archiver.kernel.org>; Wed,  2 Oct 2019 19:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2271218DE
	for <linux-serial@archiver.kernel.org>; Wed,  2 Oct 2019 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rm5248.com header.i=@rm5248.com header.b="RHGHABGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJBTEB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:04:01 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:48305
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfJBTEB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Oct 2019 15:04:01 -0400
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3DD7E8C0A28
        for <linux-serial@vger.kernel.org>; Wed,  2 Oct 2019 19:03:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a58.g.dreamhost.com (100-96-91-70.trex.outbound.svc.cluster.local [100.96.91.70])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 905B28C05D8
        for <linux-serial@vger.kernel.org>; Wed,  2 Oct 2019 19:03:58 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|robert.middleton@rm5248.com
Received: from pdx1-sub0-mail-a58.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.5);
        Wed, 02 Oct 2019 19:03:59 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|robert.middleton@rm5248.com
X-MailChannels-Auth-Id: dreamhost
X-Tank-Tangy: 519cd0c95757dded_1570043039023_3482591509
X-MC-Loop-Signature: 1570043039023:1095877291
X-MC-Ingress-Time: 1570043039023
Received: from pdx1-sub0-mail-a58.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a58.g.dreamhost.com (Postfix) with ESMTP id 3303E80670
        for <linux-serial@vger.kernel.org>; Wed,  2 Oct 2019 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=rm5248.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=rm5248.com; bh=3qObEB6Y0Iqj5zMiD5X6cXyBj4g=; b=
        RHGHABGZOv/FLi09i0/7Movsf3PlBj/O1bWPV0z5xsGHTYtPD4730v26jKycgSpp
        3PIb1tt0BUKweqSN2tWI8gCm1RXgjytnUtY1yfiak2uJOgmmZ3iopLCAkctqusO+
        zo2Aso24yUSQZBJ55/3O5v6ei4kC1LKsqWRYUQIQjkA=
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robert.middleton@rm5248.com)
        by pdx1-sub0-mail-a58.g.dreamhost.com (Postfix) with ESMTPSA id 04D3B8066F
        for <linux-serial@vger.kernel.org>; Wed,  2 Oct 2019 12:03:55 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id h144so59396368iof.7
        for <linux-serial@vger.kernel.org>; Wed, 02 Oct 2019 12:03:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXlNvozHMtp3pxta+J5QuikI2AbOernjh4QQhIdwVCWAZ9EjMLZ
        9MSEQLo5+Q3asKoRD4o0z8MrC5iCDi/f14uRSEI=
X-Google-Smtp-Source: APXvYqx9BKzccx7fKL2nj60U1O4zGVz6ssKKb7yntMm0ibjPO56ywX3mJ7CZ4Cq9ctbVNSsOFSFeWkOMi3+8xFDVZ8k=
X-Received: by 2002:a92:d0c6:: with SMTP id y6mr5359801ila.307.1570043035253;
 Wed, 02 Oct 2019 12:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com> <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com> <20190806153110.GG30120@smile.fi.intel.com>
 <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
 <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
 <20190807150425.GC30120@smile.fi.intel.com> <CAKpcJVYmTK-kw5eZJtcMWBSMmOk4ijqu-1oh9cEswi4q98QHAg@mail.gmail.com>
 <20190808121148.GT30120@smile.fi.intel.com> <d4ec5a0a-08e3-4da9-bf43-fb1269d0b996@codethink.co.uk>
 <d64d54fd-5d21-f0a5-8804-b4a0ce486c59@codethink.co.uk> <CAKpcJVaNyv-D3eehF4rcE7ZvihRcsdHm+dOWAea0+6CETY6L=Q@mail.gmail.com>
 <29ab74c4-490b-ef4a-011a-ba75fc4321cb@codethink.co.uk>
In-Reply-To: <29ab74c4-490b-ef4a-011a-ba75fc4321cb@codethink.co.uk>
X-DH-BACKEND: pdx1-sub0-mail-a58
From:   Robert Middleton <robert.middleton@rm5248.com>
Date:   Wed, 2 Oct 2019 15:03:43 -0400
X-Gmail-Original-Message-ID: <CAKpcJVbVRw3AdmQgmU-UovUWQ0aU6mz16DnuTwk4H+tBB9RRdA@mail.gmail.com>
Message-ID: <CAKpcJVbVRw3AdmQgmU-UovUWQ0aU6mz16DnuTwk4H+tBB9RRdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeeigddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqnecukfhppedvtdelrdekhedrudeiiedrheefnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqihhouddqfhehfedrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrdduieeirdehfedprhgvthhurhhnqdhprghthheptfhosggvrhhtucfoihguughlvghtohhnuceorhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomheqpdhmrghilhhfrhhomheprhhosggvrhhtrdhmihguughlvghtohhnsehrmhehvdegkedrtghomhdpnhhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Sep 29, 2019 at 5:43 PM Sudip Mukherjee
<sudip.mukherjee@codethink.co.uk> wrote:
>
>
>
> On 29/09/2019 22:30, Robert Middleton wrote:
> > On Sun, Sep 29, 2019 at 2:15 PM Sudip Mukherjee
> > <sudip.mukherjee@codethink.co.uk> wrote:
> >>
> >> Hi Robert,
> >>
> >> Sorry for the delay. I managed to test it today. My test file contained
> >> 70 lines of "The quick brown fox jumps over the lazy dog". I used upto
> >> 1200 Baudrate to send the text from the desktop using the Exar serial I
> >> have and I did not notice any message loss on the receiving laptop.
> >> Please let me know if you want me to test further.
> >>
> >
> > Two questions:
> > 1. What kernel version?  If you didn't have a problem, I can try with
> > the exact version that you have as well and see if I can reproduce on
> > my side.
>
> v5.3.1
>
> > 2. Did you test this via 'cat text-file.txt > /dev/ttySX' ?  I'm
> > assuming that you are, but just want to make sure.
>
> Yes. On the desktop which has the Exar hardware "cat fox.txt >
> /dev/ttyS4" and on the laptop which is the receiver a terminal to read
> from /dev/ttyUSB0.

Thanks for checking; I still have the issue on my side, it is very
weird.  Would you mind if I send you a video off-list that shows what
is happening on my end?  I'm pretty much at a loss at this point.

-Robert Middleton
