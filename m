Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A1C8301A
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 18:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C2122201
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 18:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbgLBSJc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389249AbgLBSJa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 13:09:30 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0680C061A54;
        Wed,  2 Dec 2020 10:07:59 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id 128so1417149vsw.10;
        Wed, 02 Dec 2020 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pK0yJ+C90ne66IyKxcSzqFDurNlO0mJMG/RO4XxWw0Y=;
        b=TvNT14OrcPuwvmdbS+bnJGjR5W9zvIXsCVpkLUDLf/cWk0FnXOPEKdJ3u0A8t2DRdr
         KkqHjznZPolIsYGgxGDhnJHLtfD06pDxH9vcvhZxdhJOFkvi6VyuNiog3W/DAlBV9gXk
         uOJF7wa7EMFVsKw/TCr4dGc+MYDwCSGq8wQ1fhif4O8QPcb39GriVbv/LRfIEHO8J/Em
         ptMCrPkvHp4mycvLrt1z0GW8gTRA7Kk+2JazzVBpF0mEciVXemRXb1A0Aw69YSRyoIxs
         LstQh99YiutzySnVdQLdEw/iheqk//sI2CMmQCcIPRvCtE1frdBTpEKKLxXVh5yCp7SY
         s5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pK0yJ+C90ne66IyKxcSzqFDurNlO0mJMG/RO4XxWw0Y=;
        b=EzEjX+EecgOFMeGBxQQc+9/9J4tdRyY2mrFtLlCzwUG3OwwhRov5u1bY7YV+8oRuOG
         MHZIC/wqvLck0d/bbSzZpKiwKsuqhJly4WQoIVkOLBUUjVBznmfxj8U8DvqndZY0GY+D
         cdnkUBrzWMhwaM8nbK0eVhERxcsnpZYXY18wnNabR8EzZ8wszRyaZ+ECAR/EQNhvYGj2
         JxuazFVtNTDyBVCNaP95O+nxEVluKCClX2MC6inTlvWGd/Qpj0wX5gn+JXjfkdbyvkVh
         UEMlv43LrZzfHeQjWQhz4JdYL1Mu7VYVC7SDg5gsjwH1j3k/LA3p8PSsu2zYGVR3nKnq
         CPqg==
X-Gm-Message-State: AOAM532f6O4uwWDo012Zka36An43JJ5jswNJ0z0wJDAE+LxFazFw6at2
        6NiZbGvYK77ADDTMJYJI6eef7eOTjaNObnEr+Y8=
X-Google-Smtp-Source: ABdhPJyWQYHuGNBUG9LA2eJTjQu2rFFwTk0chIB6hIBOXvu31uqgmQRvsh4rt8v6Ym+FX4X9dLLRJ0j5AdTWtifRcZQ=
X-Received: by 2002:a67:f601:: with SMTP id k1mr2764150vso.46.1606932479046;
 Wed, 02 Dec 2020 10:07:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6ecb:0:0:0:0:0 with HTTP; Wed, 2 Dec 2020 10:07:58 -0800 (PST)
In-Reply-To: <20201202113942.27024-1-johan@kernel.org>
References: <20201202113942.27024-1-johan@kernel.org>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Wed, 2 Dec 2020 10:07:58 -0800
Message-ID: <CA+uuBqZ-EnsOU-UiufXo+oxmrgM3=2eu9C_50tpBHLKjcfxdgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/2/20, Johan Hovold <johan@kernel.org> wrote:
> Also let me know if you prefer to hold this off for 5.12. The change is
> minimal, self-contained and low-risk, but it is a new interface and late
> in the release cycle as Andy pointed out.

Hold off for 5.12? Did you perhaps mean 5.11? I understand how this
change may be too late for 5.10, but surely it can go into 5.11 merge
window, why hold off for 5.12?

M~
