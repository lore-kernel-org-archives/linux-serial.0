Return-Path: <SRS0=NZaJ=55=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1FFC2BBC7
	for <linux-serial@archiver.kernel.org>; Mon, 13 Apr 2020 09:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6922D2078A
	for <linux-serial@archiver.kernel.org>; Mon, 13 Apr 2020 09:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm7THPT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgDMJXu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbgDMJXu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Apr 2020 05:23:50 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 05:23:50 EDT
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A017CC008617;
        Mon, 13 Apr 2020 02:23:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q16so3061867pje.1;
        Mon, 13 Apr 2020 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgPdHxZlhSC4v+zs/0AEa3wK9zKFB/PRFiLsEr99XBA=;
        b=qm7THPT1ebhpY0cu+H+IZfi8W0+nhCKo3W1RJY2zgd2FkXZd8v+BUqMZ8UGgG1wXZD
         TOk0XAG9IcwzpyneHCH7cIZSLewQsmgN4hTvX96TJnGDrACrYtvhM8YS6cn0cNP+paBc
         rAvU+Li8dzTLEBewh9L0HYVYte1l1g1G33mW977AyZlDvHL4aTuBHBAOBihSo8zSBGQx
         gZNbgnDW3bwke9d8k96T4XZXpeeCVS+zbQAPFSiIpryo3EeOZZi7P5B4TfFpYkwUzJFR
         AaOmRFTy/5JvZwPehJlN9Mw7ckiuTLc501sCk84fZOEz68JUi8f21dolYx/gnLgtuQdC
         bv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgPdHxZlhSC4v+zs/0AEa3wK9zKFB/PRFiLsEr99XBA=;
        b=ST9MBvKQ6QA9t4pmeSdWKNQcDsRt3SidaN/nixo3igfle240Wqa1nf9rIQjMzrRYmc
         RhMEFB3bV9NkRbmJdLDudZv0P9f+FjpKbbsBzU1l+PWz4X3MNG4O6Y1NnUBK8OBrVGh+
         6SAI59w8dWraJJP07aP733yfd7UjDHsQvRpv4Afx4MOGWfs2elSJlzTflxcCZ1PR7SMA
         qNKIxb5IkBiWM2Z1mQfAgyEd8A9y6GmoyqHiMTL5wWpabfcgQZF2j6ABSz8Ucw+gBzDd
         EozrXrne8+bqcNOnLkAroEv/Y3V6uN4LAv9jafzerktII4UuY11yk3YVtEPN+Fl8IRCA
         gUDQ==
X-Gm-Message-State: AGi0PubWtCXtKWgx271E3OCVnwjqxkU9qrdOari2hr3tE+JnzCbU0U91
        i0kmnIbfYME4/9BpPqzt4tHXfQTVBtZirHqKYwI=
X-Google-Smtp-Source: APiQypLL/Wfg4Lp/+ohZlO4zV3KFFCVU24f2uryhyiPohL3pUIEuiUaUmKAr6opmbdZ8UEzmiQy3c2aNzlj8pcl0vZE=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr21162774pjy.1.1586769827768;
 Mon, 13 Apr 2020 02:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <1581789069-5232-1-git-send-email-gupt21@gmail.com>
 <1581789069-5232-2-git-send-email-gupt21@gmail.com> <CALUj-gvM+mupR6qhh=ruyFzY7VL8zGHpcJ9N0oLk4mT-UG_r6A@mail.gmail.com>
In-Reply-To: <CALUj-gvM+mupR6qhh=ruyFzY7VL8zGHpcJ9N0oLk4mT-UG_r6A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Apr 2020 12:23:36 +0300
Message-ID: <CAHp75VdDnUTbPJOjF7btQeaog+_Ni7Zon-bbBB0hNuQRZ8Vt2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tty/serial: ttvys: add null modem driver for emulation
To:     rishi gupta <gupt21@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 8, 2020 at 10:23 PM rishi gupta <gupt21@gmail.com> wrote:
>
> Humble ping for feedback please!

No top-posting, please.

Rebase your series on top of v5.7-rc1 and resend as v3.

-- 
With Best Regards,
Andy Shevchenko
