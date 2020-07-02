Return-Path: <SRS0=ZZst=AN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A7C433DF
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A518320874
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 07:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOIvURjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGBHRH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGBHRG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Jul 2020 03:17:06 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D07C08C5C1
        for <linux-serial@vger.kernel.org>; Thu,  2 Jul 2020 00:17:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id e12so20465994qtr.9
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2020 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGNoN9gtKrPMd4VU+QtOqyOlxcTtDvTp63S5slWM6mM=;
        b=uOIvURjIalAjnHSsgHyuCTb8qLuF6jKARWgTAOlSiLQWd6533oNYC2lBSsNtWc5mOi
         P944b9rSSrwLKTlZ7v7ZZ3lGT3eLo/jKaFE9PQl66X5JQDATnqYPVAUsk7/0H8Eu9zoS
         /kJ+UEkhVqr1QtpyXe9Ilh3FxlYuyzDLDEcm19H1Ay4B/IbFc0o45LKThc0ZmUau8V80
         RmXoymIzYsMQ10n9yq4uUwo/RjPmGnTzc/JI4SyBo4KCOG8ENitfQ+bO6B2IR29yimIp
         6IJLJ+EXFV4q6Ozg4VgjzOgk/rPKEmewVBYPxwOjHpDgfqjyprvtQB8f1j3Bb6k6mLxg
         K/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGNoN9gtKrPMd4VU+QtOqyOlxcTtDvTp63S5slWM6mM=;
        b=CThuSQ+3OIIDbqZoni3kRnplNvS3RffnOIwhLKryVp6w0VYvd4+tMYC6L90EpO/0PH
         jMCpVoZw9fu9zTZ7OZ9DQuVqUkaSE91c3MgcdQOyznkanq/UHapr6eo7qoI6WHgC2a0S
         iy0/Y2J0uSEljDuVdh6mgrG1AsUroPAkJcgZWW8PRLCGgcPUKylWSVo6dqzrOTaQXzAD
         mRT5fyYrgC1U01Vxr+aubbLIOg118Ea8XNBFSDyfHFOOcWvvD0l/wEE6BFlJc1CcdDhO
         rsUHF0vZO1mYIYA7l4JyZO9cEXUqNmMMBbUJlS7ep7NSaSq1jaB7JjNZho0JQx2detCb
         WtoA==
X-Gm-Message-State: AOAM533JLMoAZMJL/n6ILXmZku+O+TxineCXPHZcyD8/mpBpku0Vw5P8
        9Py2Gj36bSzcJMwM6m6a77+wVA7U+alB/Y+gC6xg+fAn
X-Google-Smtp-Source: ABdhPJx7+EYYrzfggg1q8gmEqmhYgQYjXmrfHZwNIXfEUIyn79Dny6FStGxiTd1BwrjKnotUnpcmIp22KMtQNNiJEBk=
X-Received: by 2002:ac8:5188:: with SMTP id c8mr30441163qtn.1.1593674225151;
 Thu, 02 Jul 2020 00:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWcZkJ5LMK59UWPP6zsV3ipgVNbk+mH7tVcmRGsp1PJzxBdTA@mail.gmail.com>
 <CAGWcZk+qZaNN1LOWxWjsBiP+JfSKDvD5+atNHe3LeWgWQhC=gw@mail.gmail.com> <20200701132309.GA2362785@kroah.com>
In-Reply-To: <20200701132309.GA2362785@kroah.com>
From:   Egmont Koblinger <egmont@gmail.com>
Date:   Thu, 2 Jul 2020 09:16:28 +0200
Message-ID: <CAGWcZkKChAQwLx16yQ0b6aVx22UrmP_LaK2UjfXBnnZZvLHerQ@mail.gmail.com>
Subject: Re: PROBLEM: tty devices with future timestamps
To:     Greg KH <greg@kroah.com>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

> What is this "problem" causing today?

This is probably only a cosmetic issue, rather than a
strictly-speaking bug.  I mean, the tty line works fine, and the 8
second resolution is a nice prevention against security/privacy
issues.  I'm not aware of any misbehavior in any application (which,
of course, does not guarantee that there isn't any).

That being said, the device regularly having a future timestamp (and
in turn, "ls -l" using a different formatting) is totally unexpected,
and made me (and perhaps will make others) think that there must be
something wrong with the system.

Is this a bug in coreutils's "ls"?  (That was my first suspect.)  ...
Or am I experiencing clock skews?  Due to a hardware flaw?  Due to an
ntp problem?   Is there a chance it'll affect some apps too?  ...  Or
what else could it be?  ...  -- I was wondering.

If the code cares enough to update the timestamp at all -- which I
would be fine without, I personally wouldn't mind if it stayed at the
creation time of that tty line, or was always the Epoch --, and cares
enough to reduce the precision -- which I find a good thing --, then I
guess it should also take care of not setting it to a future
timestamp, in order not to cause unexpected end-user results in "ls
-l" and who knows what other tools.


thanks for your consideration,
egmont
