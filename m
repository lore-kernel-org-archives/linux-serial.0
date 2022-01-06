Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E840EC433F5
	for <linux-serial@archiver.kernel.org>; Thu,  6 Jan 2022 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbiAFPj1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Jan 2022 10:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbiAFPj0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Jan 2022 10:39:26 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126FC061245
        for <linux-serial@vger.kernel.org>; Thu,  6 Jan 2022 07:39:26 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x6so5778938lfa.5
        for <linux-serial@vger.kernel.org>; Thu, 06 Jan 2022 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6sfkzUbiLnyJ9hqy3bUk8Fi6OGWLE1bDj7vLrDNoEoA=;
        b=YqznuQ0b+u/t/z2z386vGFCmqo06dpkSX9MXsbvuPiCE8gKvvuEv0s22QIE95hQ1AI
         a1lBTNhzIMwJo/qeVEZ1SUwRQtSLq6KXYyN30LBfePH4jhJdkY+4WAReztePdAnFR8zK
         IOazvQK34DCj9+kCoxKBfFoecWF1jqg2DvOyA5ofm7L+MosjJQ2JKayWrwmG4EVot06v
         iSp5zrxfiPhjxGCYiZGCvvLrlh9A/FI9ItgHBfs7M8WpwMqQmjYqf0cbLCa6jlwFh0o3
         y0OblBtts4TACrkKmrrEZjOxgykEk021Oh4eSn3H01AtgM6dCUEMljLjBKx8Z3M5ifBD
         oSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=6sfkzUbiLnyJ9hqy3bUk8Fi6OGWLE1bDj7vLrDNoEoA=;
        b=BK3cu5ci9o47nHcu48mWjZDunQAnzacZSzjKHTwRkbXubv3BMrfB52f6PZLhiCabuL
         LoDi9ZsI+Pf2mUsNhxVGTz+zYZAjf9LouUrjUyFaAPQxxt+spvlPr9EFLhdHEPSiG92t
         eGrh/rYG846j3Zts7NdbmtmpCppY/FaCY3QsWveSTPthz2Z0od+sAhJUoy0ixv6qfBV+
         vVkQ2+FtMOUSACWs3dkf0BkynoLR6Y0NdNjrgWd+dkIInCCCHq3+E2ZkzDtmTVwbWJwG
         B5BDFDcmuT2GwpYftRS0YFVSjI+0yLcWfgIwrwYNv/S+sN2g7/jwHQV8FqSOn6jLRJ2q
         keEg==
X-Gm-Message-State: AOAM532nULMuBoH5zq9ke7HauksZuEOTCxUFINiow3/PK8kGE6In+d6b
        t+TJX3BWa7oHijGIsRXnMoA=
X-Google-Smtp-Source: ABdhPJzumIy5uf1JIodzUT0y9SllvVng/BcDqRlFAZeiV+Mlv0Jto0CYieyeDUFQ+jZ9vrLKz2X9xQ==
X-Received: by 2002:a05:6512:25a:: with SMTP id b26mr51093384lfo.296.1641483564576;
        Thu, 06 Jan 2022 07:39:24 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f19sm202668lfv.100.2022.01.06.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 07:39:23 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomasz =?utf-8?Q?Mo?= =?utf-8?Q?=C5=84?= 
        <tomasz.mon@camlingroup.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        k.drobinski@camlintechnologies.com
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
        <YdQndwYc9xaauvpS@kroah.com>
        <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
        <YdQxmQ+OMCrabg2u@kroah.com>
        <20220104224900.u3omfbilejx2jawr@pengutronix.de>
        <4c48200b-cc2e-0766-a002-831a789d4879@camlingroup.com>
        <YdV00WYGGd49WYt9@kroah.com>
        <20220105105702.vrz7u3nam27izwah@pengutronix.de>
Date:   Thu, 06 Jan 2022 18:39:23 +0300
In-Reply-To: <20220105105702.vrz7u3nam27izwah@pengutronix.de> (Marc
        Kleine-Budde's message of "Wed, 5 Jan 2022 11:57:02 +0100")
Message-ID: <87tuegho0k.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 05.01.2022 11:37:05, Greg Kroah-Hartman wrote:
>> On Wed, Jan 05, 2022 at 08:59:09AM +0100, Tomasz Moń wrote:
>> > On 04.01.2022 23:49, Uwe Kleine-König wrote:
>> > > On Tue, Jan 04, 2022 at 12:38:01PM +0100, Greg Kroah-Hartman wrote:
>> > >> On Tue, Jan 04, 2022 at 12:13:06PM +0100, Tomasz Moń wrote:
>> > >>> On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
>> > >>>> Why can't you do this dynamically based on the baud rate so
>> > >>>> as to always
>> > >>>> work properly for all speeds without increased delays for slower ones?
>> > >>>
>> > >>> Could you please advise on which baud rates to consider as
>> > >>> slow? Does it
>> > >>> sound good to have the old trigger level for rates up to and including
>> > >>> 115200 and the new one for faster ones?
>> > >>
>> > >> You tell me, you are the one seeing this issue and are seeing delays on
>> > >> slower values with your change.  Do some testing to see where the curve
>> > >> is.
>> > 
>> > While the increased latency due to this change is undeniable, it is
>> > important to note that latency is not everything. There are applications
>> > where the latency is crucial, however using Linux for such applications
>> > is questionable. Linux is not a Real Time Operating System after all.
>> 
>> Yes, Linux can be used in real time situtations just fine, look at the
>> RT patchset for proof of that.

Do you mean CONFIG_PREEMPT_RT patches? If so, you probably miss the
point. These patches, among other things, convert interrupt handlers
into preemptible kernel threads, that in turn may even result in
increase of latency of getting characters from RS232 as seen by user
applications.

These patches rather allow to write specific kernel IRQ handlers that
will have low latencies, too meet RT requirements.

Anyway, we are discussing this in the context of plain mainstream
kernel, and when latency vs throughput compromise is to be considered,
I'd expect throughput to win, not latency.

>> 
>> So let's not make things any worse for no good reason if at all
>> possible.
>
> +1
>
> We have a $CUSTOMER, where serial latency is crucial. And we have a task
> to cut down latencies and jitter even more.

Provided plain Linux kernel is far from being RT, it seems that to meet
the requirements you'd need to patch the kernel anyway. Like, say, apply
RT-patches and then turn this particular ISR back from threads to kernel
level. In which case adding one more tweak of setting the water mark
back to 1 is not a big deal, right?

Thanks,
-- Sergey Organov
