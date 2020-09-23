Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E709FC2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 20:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F03D20936
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 20:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APeCM/GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWUe1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUe1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 16:34:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54038C0613CE;
        Wed, 23 Sep 2020 13:34:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so1400290ejo.9;
        Wed, 23 Sep 2020 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hCuPGOvEPIi3OUbPvuztvSG1QWxg6f0QbVeuNx1CtoA=;
        b=APeCM/GBH0rKfS/yOgJv1WAKgLajrKgzpwMH6usO9/cOXg+gY75M5IBBHFWPGfWxbT
         xO/McpjlHf0+fppAWB3algVENWG0bI1AVqPEGobeC+CVh6ReT5gMIuo4k+LwWAqnNwUR
         tfH1f3z37jYQOheDcBqyHZ2Ua3hrcWM21WWcF3nSZNNMaFa9u4KiZbeyvfWnAR6fPQAW
         kRZ+6AFYVmFv6wNA7QP6QpPXXML5+ZBF+qDHeLfejNrBbod8yaage1X3jc6P9Td/t1Yi
         VNQfNcCUAWUNzhDPX6Mi0lN8WmRfXu4+sBM0gGV9P0mpQKzKpxnG+mpEIN2kH2z3pePV
         iDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCuPGOvEPIi3OUbPvuztvSG1QWxg6f0QbVeuNx1CtoA=;
        b=MeIDFkbfbLd/67Fgj7CB3+Qo/myFdU4ksaTxG+kiylFgIIUU4wYFFXY9/Mb15Z1X2g
         lqp4jEhcVwm1xVmsRgH6cw8U5/E+UZMiMMyZdclqGd+XlaXM5SND6WzusAkzAwQ7RezN
         cRkgzQeldsx6XjL8Ce8oQ/wFtUUUuVG5rnfqJOruuUeqBBMespzV3MFeWdUsGYByWH5M
         0gbSW/tF/fMZAkLihjiSqEyoMqpZoSxQFpO9cw4/c/sKhEa2ygmpgmUs3V8jlNI6UvXX
         Ru4xmMyG9DjfKCddqCdS6qsEN3qSM12u/E6yUZxGcWA1yjCzae/IXzFh5JABY3ITe39E
         RBxA==
X-Gm-Message-State: AOAM530gKxqpO3Y0uwlaE55PcSXwZWieWgwF+4mM258tV1sWnhEhLVGQ
        oZnA8SdgrQVPlTY7Dy7hDW8=
X-Google-Smtp-Source: ABdhPJwgL/b8GE+tn+uDF9/HcXKrlqsotpwo3IwJ1fqeOle/05aOfhHGtUVo87dAOJo4fQ1N1HDQuQ==
X-Received: by 2002:a17:906:4d57:: with SMTP id b23mr1398136ejv.496.1600893265877;
        Wed, 23 Sep 2020 13:34:25 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id i17sm716059ejy.79.2020.09.23.13.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 13:34:25 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] misc: Add Surface Aggregator subsystem
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-2-luzmaximilian@gmail.com>
 <20200923165745.GA3732240@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <de24d687-62c2-1f34-cac2-d32246c68a09@gmail.com>
Date:   Wed, 23 Sep 2020 22:34:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923165745.GA3732240@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 9/23/20 6:57 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 23, 2020 at 05:15:03PM +0200, Maximilian Luz wrote:
>> +/* -- Safe counters. -------------------------------------------------------- */
>> +
>> +/**
>> + * ssh_seq_reset() - Reset/initialize sequence ID counter.
>> + * @c: The counter to reset.
>> + */
>> +static void ssh_seq_reset(struct ssh_seq_counter *c)
>> +{
>> +	WRITE_ONCE(c->value, 0);
>> +}
> 
> These "counters" are odd, what exactly are they?

The SEQ counter is a sequence counter for transport packets with
roll-over at U8_MAX. As far as I can tell from testing, it doesn't
specifically have to be in sequence, but that's what I've called it
after initially reverse-engineering the protocol (the Windows driver
does keep it in sequence).

This counter is basically used to ensure that data packets can be
matched up with the corresponding ACK (acknowledge) control-packet. The
main reason for it being sequential, or rather where the sequentiality
can help, is packet retransmission detection:

Imagine the EC sends us a data packet, we ACK it but the ACK is somehow
dropped in communication. After the retransmission timeout the EC sends
us the data packet again. We can now assume (since the counter is
sequential) that there is a significant amount of time needed until we
can see the same SEQ number again. So we can write it to a fixed-size
rotating list after we've first received it, ACK the packet and
ignore-and-ACK any packet with the same ID after that until we've
received, let's say 16 packets with different IDs.

I assume that a similar mechanism is implemented on the EC side,
although I'm not sure how it's implemented specifically.

The RQID counter is pretty much the same, except for requests, roll-over
at U16_MAX, and some reserved IDs at the beginning (specifically 1 to
SSH_NUM_EVENTS, both inclusive) to differentiate events from responses
to requests.

> They seem like a simple atomic counter, but not quite, so you have
> rolled your own pseudo-atomic variable.  Are you sure that it works
> properly?  If so, how?

I'm fairly sure they work as designed, at least in terms of being safe
for concurrent execution (please do point it out if they're not). The
reset function is only called on init when no other thread should have
access to it, the counter get-and-increment is handled via cmpxchg to
guarantee that the same (old) value is only returned once per roll-over
and the correct new one gets assigned to the current counter value.

There can be a problem when a new packet/request is being put on hold by
the submitter (before actually being submitted) for an overly long time
and the counter rolls over at least once, causing the exact same packet
(or request) ID to be sent in sequence, and that in turn the EC to drop
the packet and result in a request timeout.

Note that everything else should (with the current implementation) work
fine. I.e. matching a request with its response will work (on the
driver-side) even with two requests with the same request ID in
sequence, as the pending "set" is actually a list that's traversed in
order, so matching the first submitted to the first received and the
second submitted to the second received.

I think that in practice, holding a packet/request this long should not
happen. My current implementation just ignores that issue. Maybe not the
best strategy, really...

> What about just using an ida/idr structure instead?  Or just a simple
> atomic counter that avoids the values you can't touch, or better yet, a
> simple number with a correct lock protecting it :)

As mentioned above, I belive that concurrent execution doesn't cause any
issues due to the cmpxchg, so no need to use a lock here. AFAIK atomic
counters don't roll over, so there shouldn't be any difference in
implementing this with atomic_int apart from then using atomic_cmpxchg
(semantically, they are the same, right?).

As far as I can tell, a fairly easy way to fix the duplicate-value
problem itself would be using IDAs for both, however, they would need to
be kept allocated for some time after the packet/request has been
completed to avoid re-using the same ID sequentially and accidentally
triggering retransmission-detection on the EC. I don't have a clue how
that's implemented... just that it works with roll-over counters in the
Windows driver, and that the EC itself uses a roll-over counter for its
SEQ values (SEQs sent by the EC and SEQs sent by the driver are
completely independent). I also don't know how that works on the Windows
driver for that matter.

_Theoretically_, the protocol should be able to support multiple packets
waiting for an ACK, but in testing that caused problems with
retransmission after error-detection on my Surface Book 2, so that's the
reason why it's currently limited to one due to this. I'm not sure if MS
considers changing that/has changed that on newer devices, which could
influence how retransmission-detection behaves, so that's another reason
why I'd like to keep it similar to what we observe on Windows.

We could add an "in-use" range to block allocation of new IDs. This
would be fairly cheap, still sequential, and guarantee that no ID is
used twice at the same time. On the other hand, that would also
completely block communication if just one packet is held back before
submission (something that could be avoided with IDAs).

And the last alternative: Keep it as it is. As said, this can result in
a dropped packet/request, upon which the caller is encouraged to
resubmit. In that case, I should probably also document this
somewhere... This will likely bite us though if the request throughput
gets large (and thus time-to-roll-over small) so I think this should be
addressed properly.

In short: Concurrent execution of the counter functions works, as far as
I can tell at least, and, as you see by the long answer, I have to spend
some time and think about the duplicate-value problem (again). If you've
managed to read through this wall of text (sorry about that) and you
have any ideas/preferences, please let me know.

Thanks,
Max

