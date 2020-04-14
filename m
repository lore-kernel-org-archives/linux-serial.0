Return-Path: <SRS0=CAPS=56=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C206CC2BA19
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 12:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8DF20732
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfpUcmaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgDNMOH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgDNMOD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Apr 2020 08:14:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE81C061A0C
        for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2020 05:14:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l14so5208809ljj.5
        for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2020 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bAOD7nPch+UQ4HqnatKVPbQcT2jcMXIOCzEsyN32ctk=;
        b=CfpUcmaJPpyop6Z6pNbBOB2EP7MqBRSEikWBbGyba0UDdT7YCARCwbMP4et20a2kwj
         in005y/76woLfeCh5c2L2dCE+AANKd3bL9WsSYXd1rDtAjAdvN1dBQ+p0oyT+rFTu0v0
         OdWnNf4yLrPtGLnsrjc/aj/t0RT2WXm4eCERF/piY6R9z9/FwEjIYqx8typ8gMiDwrDd
         CKI8vXo1uzS+D2a5Sz1jeky3SqpdQfvrc7gQ5Y6rtaMcLhucpdLBYM++whfbMX35AJGQ
         l/rFyxxce8MojY2uC7AQ7SNPUga80+mhqcd+ALx3B4auCvEmuPEPNJsnknJm2XyX0yQY
         Zj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bAOD7nPch+UQ4HqnatKVPbQcT2jcMXIOCzEsyN32ctk=;
        b=J6N8SXQvY+sYY19WZs6BelUvUGzMDRAgmJZvdaU9M9NIAf3KA4YjoNgz9Q1nhlTRPG
         DKbpCj6xcbSRu4jpE9i72UyfnYdim1CLFDkcP2P6WOq3NbAjkkcky7z79vZTRkJ1Qw1N
         FQXrBiCrPLXPFWPz39jRNVzeQs3m3RxEvltjpk4VcusJtiiTcGHycvES0kKP4DANztax
         eS83+MfYEyBYY+M1sd2wzYfvwQfIzUW1fqjIS5+ut/UuULK9qJm1y/RkVCTJrc6t4zo/
         RiuaW2M8YklIM1hI8MUUhSuH8+DKMKJZ9T4Uywi62qq0Xt5wTm+VTQtnSviHH3grzmC5
         aNBQ==
X-Gm-Message-State: AGi0PuYBSpYq49tZGEJLWJVfy/h/ALctsvLeJu9746fodcR0ejfA5mLd
        r/voYb3Zc2m0SGfO71uSS8o=
X-Google-Smtp-Source: APiQypJ3Kd7MEXCvSm1k0YkMuP5LL6+QRtxlXbvh4C4nuqbo2vnduPHQEYz7ojFxgzuujvPl9S6O9Q==
X-Received: by 2002:a2e:9ed8:: with SMTP id h24mr13607535ljk.221.1586866441919;
        Tue, 14 Apr 2020 05:14:01 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 6sm1682808ljq.36.2020.04.14.05.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 05:14:00 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Serial console and interrupts latency.
References: <87lfnq15vi.fsf@osv.gnss.ru>
        <aa0174f8-7cef-46c9-4164-605191393abd@suse.cz>
        <87ftdtzypi.fsf@osv.gnss.ru>
        <20200327232428.GT25745@shell.armlinux.org.uk>
        <CANp_pu1caHaGJbBR8sEoOER2SfMDO3eJKOVQz3K8jKKZACh7=w@mail.gmail.com>
        <20200414095644.GU25745@shell.armlinux.org.uk>
Date:   Tue, 14 Apr 2020 15:14:00 +0300
In-Reply-To: <20200414095644.GU25745@shell.armlinux.org.uk> (Russell King's
        message of "Tue, 14 Apr 2020 10:56:44 +0100")
Message-ID: <87h7xmuuwn.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:

> On Tue, Apr 14, 2020 at 12:50:49PM +0300, Sergey Organov wrote:
>> Russell King - ARM Linux admin <linux@armlinux.org.uk>:
>> > Correct, and what I said back then still applies - and more.
>> 
>> What bothers me is "we have no real option..." part of this, as it's rarely
>> happens to be the case.
>
> I don't see you coming forward with a solution beyond "let's revert
> the commit" or "let's comment out the lock" - neither of which are
> an option for mainline kernels.

I didn't suggest to revert the commit, as it obviously solves real
problem. I asked if and why the lock is needed on non-SMP targets, but
either I didn't get a reply or missed it, sorry.

I mean everything I said was to get some help rather than to spread
useless critics or even insults.

>
> Until *you* do, since you obviously have better ideas, "we have no
> real option".

I'm in the process of making myself familiar with the internals of
printk machinery to find generic solution, but if nobody else actually
cares, I'll stop bothering you guys with my questions.

Do I get it right that you still think there are no sensible options but
to disable interrupts for ages? If so, it would greatly reduce my drive
to find one... or maybe the other way round, but it'd be nice to know
either way.

> But, as I've said, one of the *important* characteristics of serial
> console is that it is synchronous with the kernel, so it can be
> relied upon to get complete messages out if the kernel crashes after
> a printk() has been executed, and that must not be lost.

Do I get it right that it's covered by the 'oops' case, or are there
hidden pitfalls as well?

Thanks,
-- Sergey
