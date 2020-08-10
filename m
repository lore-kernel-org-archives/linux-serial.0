Return-Path: <SRS0=IIB/=BU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A1C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17492073E
	for <linux-serial@archiver.kernel.org>; Mon, 10 Aug 2020 21:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPtviNy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHJV01 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgHJV00 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Aug 2020 17:26:26 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C1BC061787
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2020 14:26:26 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y8so4952784vsq.8
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2020 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXASfmqoUl3o8zN6MXHewh7vS0xl4tHelH9X4EiAPTg=;
        b=iPtviNy9RShsJFpYsrUv4+ItQVmKuSBZAs+NqagKy930sVZjRWUTkUxZacbU9KMJ9x
         CldemxPziILP/Xm4LSWsQAELyezydtv5sifKft2/LSVyc4/58JoPG6k5BIxVVvNHjwp4
         uWlD8l3v+F7WMtJqUFLtCaENMe7W0y16GGvzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXASfmqoUl3o8zN6MXHewh7vS0xl4tHelH9X4EiAPTg=;
        b=UNvie/dHGZoJttoFttYyKhsDN9lAZ8pGyZMLHvc2FfVpbupF3SXHvYSNiOvmRbUV0B
         Xv1k8vcNwUFk9NQ7njHGmlGmuEWqYx9cBKaihF/vOLaKk02DgUoRCGt9e+FyQd62sqlC
         YvqqzU7+NJNFPtfpAWYzc26zEjAGgCMonq5znPOh911BHH87Wj/oGiXjxaWPjeUdBhKJ
         jxhF8jXJfNbNfZ2q1z/SlP6MHLVxojb4wZGHybrl1r8Js2D9WxV5OJt38KWrsiDpcA9o
         V2Tz/OZAaQrJlPF2lTjFsGwLtBE5BGr4eEOLWN/Mu6+0ug8dUqZuqruyZdwlH4jAZfTA
         ck/g==
X-Gm-Message-State: AOAM533Sf8x57qWupfJcwSyKP907tfiAkLyzRJPjvvG421GPMidbh2pv
        9N+xxL63skwqVF1zH7u/xB3dt7nN2Ns=
X-Google-Smtp-Source: ABdhPJxhHD6/5K/o2+MvTufMrIa3StcCgytST+vdhXNCl1DUDstjh4CmWLjdQx+18UOwFtaPkDK0qQ==
X-Received: by 2002:a67:fbd1:: with SMTP id o17mr20715214vsr.19.1597094785154;
        Mon, 10 Aug 2020 14:26:25 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id f16sm5582869vka.7.2020.08.10.14.26.23
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 14:26:24 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id o184so4970345vsc.0
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2020 14:26:23 -0700 (PDT)
X-Received: by 2002:a67:2c4f:: with SMTP id s76mr20074899vss.213.1597094783404;
 Mon, 10 Aug 2020 14:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200806221904.1.I4455ff86f0ef5281c2a0cd0a4712db614548a5ca@changeid>
 <adaef6bf-7887-feea-fedf-d3bc5566bb9d@codeaurora.org>
In-Reply-To: <adaef6bf-7887-feea-fedf-d3bc5566bb9d@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 10 Aug 2020 14:26:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8tNpmkSrEjXgKPKsBOZfjt8aVQe47gzi5FvPqdOQN+A@mail.gmail.com>
Message-ID: <CAD=FV=X8tNpmkSrEjXgKPKsBOZfjt8aVQe47gzi5FvPqdOQN+A@mail.gmail.com>
Subject: Re: [PATCH] serial: qcom_geni_serial: Fix recent kdb hang
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, Aug 10, 2020 at 5:32 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Hi Doug,
>
> On 8/7/2020 10:49 AM, Douglas Anderson wrote:
> > The commit e42d6c3ec0c7 ("serial: qcom_geni_serial: Make kgdb work
> > even if UART isn't console") worked pretty well and I've been doing a
> > lot of debugging with it.  However, recently I typed "dmesg" in kdb
> > and then held the space key down to scroll through the pagination.  My
> > device hung.  This was repeatable and I found that it was introduced
> > with the aforementioned commit.
> >
> > It turns out that there are some strange boundary cases in geni where
> > in some weird situations it will signal RX_LAST but then will put 0 in
> > RX_LAST_BYTE.  This means that the entire last FIFO entry is valid.
>
> IMO that means we received a word in RX_FIFO and it is the last word
> hence RX_LAST bit is set.

What you say would make logical sense, but it's not how I have
observed geni to work.  See below.


> RX_LAST_BYTE is 0 means none of the bytes are valid in the last word.

This would imply that qcom_geni_serial_handle_rx() is also broken
though, wouldn't it?  Specifically imagine that WORD_CNT is 1 and
RX_LAST is set and RX_LAST_BYTE_VALID is true.  Here's the logic from
that function:

  total_bytes = BYTES_PER_FIFO_WORD * (word_cnt - 1);
  if (last_word_partial && last_word_byte_cnt)
    total_bytes += last_word_byte_cnt;
  else
    total_bytes += BYTES_PER_FIFO_WORD;
  port->handle_rx(uport, total_bytes, drop);

As you can see that logic will set "total_bytes" to 4 in the case I'm
talking about.


> In such scenario we should just read RX_FIFO buffer (to empty it),
> discard the word and return NO_POLL_CHAR. Something like below.
>
> ---------------------------------------------------------------------------------------------------------------------------------------------------------
>
>                  else
>                          private_data->poll_cached_bytes_cnt = 4;
>
>                  private_data->poll_cached_bytes =
>                          readl(uport->membase + SE_GENI_RX_FIFOn);
>          }
>
> +        if (!private_data->poll_cached_bytes_cnt)
> +              return NO_POLL_CHAR;
>          private_data->poll_cached_bytes_cnt--;
>          ret = private_data->poll_cached_bytes & 0xff;
> -------------------------------------------------------------------------------------------------------------------------------------------------------------
>
> Please let me know whether above code helps.

Your code will avoid the hang.  Yes.  ...but it will drop bytes.  I
devised a quick-n-dirty test.  Here's a test of your code:

https://crrev.com/c/2346886

...and here's a test of my code:

https://crrev.com/c/2346884

I had to keep a buffer around since it's hard to debug the serial
driver.  In both cases I put "DOUG" into the buffer when I detect this
case.  If my theory about how geni worked was wrong then we should
expect to see some garbage in the buffer right after the DOUG, right?
...but my code gets the alphabet in nice sequence.  Your code drops 4
bytes.


NOTE: while poking around with the above two test patches I found it
was pretty easy to get geni to drop bytes / hit overflow cases and
also to insert bogus 0 bytes in the stream (I believe these are
related).  I was able to reproduce this:
* With ${SUBJECT} patch in place.
* With your proposed patch.
* With the recent "geni" patches reverted (in other words back to 1
byte per FIFO entry).

It's not terribly surprising that we're overflowing since I believe
kgdb isn't too keen to read characters at the same time it's writing.
That doesn't explain the weird 0-bytes that geni seemed to be
inserting, but at least it would explain the overflows.  However, even
after I fixed this I _still_ was getting problems.  Specifically geni
seemed to be hiding bytes from me until it was too late.  I put
logging in and would see this:

1 word in FIFO - wxyz
1 word in FIFO (last set, last FIFO has 1 byte) - \n
Check again, still 0 bytes in FIFO
Suddenly 16 bytes are in FIFO and S_RX_FIFO_WR_ERR_EN is set.

I spent a whole bunch of time poking at this and couldn't find any
sort of workaround.  Presumably geni is taking some time between me
reading the last word out of the FIFO from the "previous" packet and
then transitioning to the new packet.  I found a lot of references to
this process in the hardware register description (see GENI_CFG_REG69,
for instance), but I couldn't manage to make the kick to happen any
faster.  Presumably this isn't a problem for things like Bluetooth
since flow control saves them.  ...and I guess this isn't a problem in
practice because we usually _send_ a lot of data to the host for
console/kgdb and it's only the host => DUT path that has problems.


> I am not sure about what all scenario can leads to this behavior from
> hardware, I will try to get an answer from hardware team.
>
> Any error bit was set for SE_GENI_S_IRQ_STATUS & SE_GENI_M_IRQ_STATUS
> registers?

As per above I can see overflows in my test case and geni seems to be
behaving pretty badly.  If you have ideas on how to fix this I'd love
it.  However, it still seems like my patch is right because (at least
in the cases I tested) it avoids dropping bytes in some cases.  It
also matches how qcom_geni_serial_handle_rx() works and if that was
broken we'd have noticed by now.


> I guess the hang was seen because *poll_cached_bytes_cnt* is unsigned
> int and it's value was 0, when it's decremented by 1 it's value become
> '4294967295' (very large) and dummy RX (0x00) would happen that
>
> many times before reading any actual RX transfers/bytes.

Right.  That would be why it was hanging.


-Doug
