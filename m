Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED612C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 15:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50262068E
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 15:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei0k57VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgEFP2z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbgEFPZx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 11:25:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A54C061A0F;
        Wed,  6 May 2020 08:25:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e6so1032110pjt.4;
        Wed, 06 May 2020 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOcIBwBnUauldiWLndzVmwzZBKURfhS3mRHhqqKZPOs=;
        b=Ei0k57VLk7N4E1tLvvZ/W7MHkb57jABqquZr5M0n8FHzv94us4sIsfRRTTjtwzJC3C
         XZpXtiP/3hYpjwUSQyzP7ItePPVEhLJEFdi942IWT4mUMySrX+xg2Hl5R9txLGwkXqQm
         /r+OvYPRXzuCALy7Rphp6MDbF2lYVmLEmiFiC7aLT2jhENPb2YSyi7A0hpWmZLMVDEBg
         zf2ZdcRPeDbZ8JhtAI2YC8GjaVL9R45v/JCP1frBXL9Yz56FitLq8IqFvQiQ7HvhtubW
         F9FxRsMODSAsct79wjZKuI+Nhp2PyaJLU9aXV8lhXbrBJEt+LVl1v8+QZA7HgV6laDK0
         bYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOcIBwBnUauldiWLndzVmwzZBKURfhS3mRHhqqKZPOs=;
        b=tS8b8qoG8xYBQXDaz/he1CcsuBn+uZE9qz9f8+GvYPothiZm/m0KOpkP2RJ4Bt8ypE
         heEl4oJ4L9NEIVZERAkF3M/G7F2/gkiiK5fWiThGwuoPjQYsnCNMh9xtuf/mN1SS0lig
         n79Y01NSCaZzkp9JkyhSuZFXX3Cb0lapUM81kXGk6ZSwmRGS0q7ezCHFGXlmRV23Xbf0
         rysQr5YgHrJDq8qTyUsCrnly/xjRWGWDFa+7Uq7dztGs3fMZ0Kq1J2VEdQFYIEcqNskk
         +LPy6oz8gBsVX0p25o0XYMJjFZ5/wmVtiQ9iHV9eWg42tPi9DCyZKGitzO4WU9B7ATD+
         tDdA==
X-Gm-Message-State: AGi0PuaXbp99uPURkuHY25NYl4CL+7VlCnvLGOph7y4vAkB2Qh3oTcBC
        y+cPM4SNHLBLo+rtCSYiqMPC/a4jpTQlteAHiro=
X-Google-Smtp-Source: APiQypL6R11GbtDukVgWq3NIFn7VvgbUZ3iiF6XhKRJwUfyY+0Iw+ZOcqDtJEjUYcXU7X5ra+HAqDCooSrMRgUlXWCY=
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr10273546pjb.25.1588778753308;
 Wed, 06 May 2020 08:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200325231422.1502366-1-heiko@sntech.de> <20200325231422.1502366-8-heiko@sntech.de>
In-Reply-To: <20200325231422.1502366-8-heiko@sntech.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 May 2020 18:25:45 +0300
Message-ID: <CAHp75Vef2Gu3Kz97FK6gQRS8dnAhnFFdWK1sqjZuf8tarx3LAw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] serial: 8250_dw: add em485 support
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        christoph.muellner@theobroma-systems.com,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 26, 2020 at 1:17 AM Heiko Stuebner <heiko@sntech.de> wrote:

If it's not covered by either yours or Lukas' series, perhaps worth to
address as well.

.../8250_port.c:1427: warning: Function parameter or member 'p
' not described in 'serial8250_em485_stop_tx'
.../8250_port.c:1427: warning: Excess function parameter 'up'
description in 'serial8250_em485_stop_tx'

-- 
With Best Regards,
Andy Shevchenko
