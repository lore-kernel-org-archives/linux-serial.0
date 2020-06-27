Return-Path: <SRS0=J/Eu=AI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB1BC433E0
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 08:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315BA20656
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 08:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP6TgETl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgF0IeP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgF0IeP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Jun 2020 04:34:15 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1DFC03E979
        for <linux-serial@vger.kernel.org>; Sat, 27 Jun 2020 01:34:15 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id o38so9292731qtf.6
        for <linux-serial@vger.kernel.org>; Sat, 27 Jun 2020 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=N49Tf7zlXb0OcGaRN3R9cUXlNR/7bneITQyS0XCftTY=;
        b=UP6TgETliZgbkxT9VT3opBcjTM1Ggbxv37PrkAxevpGjEsdwz3Zibb7NRq3+bO/D56
         El2zbuQfrJ8ITbJEeD2L6bjjrU6gpEgPX7PymxbID/oshLrewirJM7iJY0uEYfYYvMbk
         8K6X2NXlLiXmziCIp8zNLju1QjiVGU9ib9riJeRjspu9LqcMeYCq0DSeR54rrfjq3AaV
         gH8BSm6qhG1jIeGSQYgA73lnL5Pn1ApEpi9DSv0LpIAf45TbHv8E5qYLaf6HB9iwpsd+
         usOFBmZFkTjGZ4+8Yo+HuJ+VUci72k8lfcZOS5ryBMxlgJKrBHVCmRkabbtOJrkFuTJM
         4VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=N49Tf7zlXb0OcGaRN3R9cUXlNR/7bneITQyS0XCftTY=;
        b=E0S6pTPU7BbncDnQ9j1PlJGPyCR+H/Rbs+AxcZgtmprf0S2U+FhWDYPQPG+YnWSpdq
         MZK8b3s6froJxfG2pQHy+d3SxNBJPPRY+CY32GQz/jC+rOav4ND67++HR2YAT7JsEH2O
         HzyklbExGs3md+u/nWqibTiu3+lK78LyFrUkOdSzmo5pOPa2agH7sT54fIZzTZmpZpht
         woJBp5ITBoh4ysFiYGr+LLQ4SjaXRS8/nn3bIO9Wp0XrG7KBh1sgM9TLjIOKQAbx0FP/
         rsllpNJCb/PnkepbR/bzQq7p/8c7z3S2XmpWlTaQ9G8HqJmuV12uRUt9nZGdPhEwJiyW
         1T9g==
X-Gm-Message-State: AOAM531XtsqZe29mFMKA8ijMUyDNDWLAnb06e4VuCZ3kjRwolblnqBpD
        V18Ry6gdJXcUeINyaI0WH8b08s7wuaxa6BHuEmrbSpjE
X-Google-Smtp-Source: ABdhPJygPMly68YVOIHVzXbOqxUxSwXc26wLkilJVED8WLT5nEiWfjFU2ivec5avXXtEeKIN0sbAZpsbxsTJAIrwIYA=
X-Received: by 2002:ac8:60c8:: with SMTP id i8mr6749348qtm.271.1593246854050;
 Sat, 27 Jun 2020 01:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWcZkJ5LMK59UWPP6zsV3ipgVNbk+mH7tVcmRGsp1PJzxBdTA@mail.gmail.com>
In-Reply-To: <CAGWcZkJ5LMK59UWPP6zsV3ipgVNbk+mH7tVcmRGsp1PJzxBdTA@mail.gmail.com>
From:   Egmont Koblinger <egmont@gmail.com>
Date:   Sat, 27 Jun 2020 10:33:38 +0200
Message-ID: <CAGWcZk+qZaNN1LOWxWjsBiP+JfSKDvD5+atNHe3LeWgWQhC=gw@mail.gmail.com>
Subject: PROBLEM: tty devices with future timestamps
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

An active terminal line (/dev/pts/N), in about 6% of the cases, has a
future timestamp.

I noticed that the command
  ls -l $(tty)
occasionally prints the timestamp in "month day year" format, rather
than "month day hour:minute". This is what coreutils's "ls" does when
the timestamp is either 6+ months back in the past, or is in the
future. Let's test the "in the future" hypothesis:

  ls -l --full-time $(tty); date +%H:%M:%S.%N
occasionally produces something like
  crw--w---- 1 egmont tty 136, 8 2020-06-27 09:57:28.686473296 +0200 /dev/p=
ts/8
  09:57:28.170717548
Yep, the timestamp of the tty line is a slightly higher value than the
system date at a later point.

Running
  ls -l --full-time $(tty)
in an endless loop causes the seconds to increment in steps of 8, but
the subseconds part remains unchanged, like:
crw--w---- 1 egmont tty 136, 8 2020-06-27 10:07:12.686473296 +0200 /dev/pts=
/8
crw--w---- 1 egmont tty 136, 8 2020-06-27 10:07:12.686473296 +0200 /dev/pts=
/8
crw--w---- 1 egmont tty 136, 8 2020-06-27 10:07:20.686473296 +0200 /dev/pts=
/8
crw--w---- 1 egmont tty 136, 8 2020-06-27 10:07:20.686473296 +0200 /dev/pts=
/8

drivers/tty/tty_io.c : tty_update_time() seems to be responsible for
this jump in 8 seconds, leaving the milliseconds intact.

I think zeroing out the milliseconds in this method would solve the
problem =E2=80=93 although then it's maybe inconsistent that at creation ti=
me
the device would have subsecond precision which would be gone soon
afterwards. Maybe it's better to create the device with no subseconds
right away? I'll leave it to you guys to decide.

I'm experiencing this on two different machines with Ubuntu 20.04,
using their 5.4.0 kernel. The method setting the seconds but not the
nanoseconds is still present in latest kernel git.

Thanks a lot,
egmont
