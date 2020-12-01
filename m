Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8399FC64E7B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 07:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C78216C4
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 07:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h77mcHDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgLAHKc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgLAHKc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 02:10:32 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086DC0613CF;
        Mon, 30 Nov 2020 23:09:52 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id k17so373471vsp.13;
        Mon, 30 Nov 2020 23:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gfdRiKeQS5ZmNSxKk+0c7aA/0vSf+2CP1Q0dHquDj5U=;
        b=h77mcHDPePcZ7/fOj9ZY+/W/6wxnCxYQp4autpWzE+mKDxV3WaJ2aabwVGga8bLfAT
         Eoah2exgYeba1xw9AAAv6IIMT47up8wmpxqGib9BZiF/2mxj0z7aZkRBRqF73ILNEmvC
         da/a+YwGDz+4zimY68gVEyOsyMwqMo3qZf0Ckts2d/xL7EZRMD1xmhFVjTsn1e98gffe
         7I/SUZPPOp8VgA2WbC4y2XJ72bH6ivW+ij/wMsgwOWIzO4bmcf04r7mtkWqlnsmy+rkw
         B0nw/Pway54GA+UzZ8kSVSY9I9i81VBswTEo0/kq2p8TCOMN3tlGqEsQ90MMAohyYjkD
         a7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gfdRiKeQS5ZmNSxKk+0c7aA/0vSf+2CP1Q0dHquDj5U=;
        b=C+ih5PzVqLZ1wr1HKqYJ6DMHDXshISUyHRP9SQ49mABwRJvLgWbuVlKEhDdH06IfO+
         TQ2NAUORNavwq9SWJlNbMhuyrNOjoykcT/LvXCHh8XRiAbY+Ynk6fS2I++EDOCCXfpNb
         tdDeOMnqfgEAkvlW/h99EzkIFNbEAY0yzE5pOzOZ7GzcLINzWTTvP/1HukL1QdsArJ3x
         027ZzT2kNWaNBXTqX36YBiEN1AHuaR9q1GG17g2OgEOoQYSsXxpyN7rJbm+d4eSWMD57
         c+ck8zvicTBFrYaEYZSY9wZxNdo37pGeQiW/NB5uJIbHhkTWZKczhaXkOb58lxn1l3UO
         6QAg==
X-Gm-Message-State: AOAM533Vz42fEbTl4/KtIY3HvuYTAfXekVR3/SqHxDQDauK/iQEk48fc
        VgLOTf4az+nfeKEBT/ds4bqlL7wfJ1G4UMzST26QoBvvIhrHgw==
X-Google-Smtp-Source: ABdhPJxWXgqOlhdu+xUTSc5snGEx/DQ7+VLorBci2PpS0Kb2zdFbkOnqyarP/7iBDakHtrxOWu0rqoEHSUqo+M22nRI=
X-Received: by 2002:a67:87cd:: with SMTP id j196mr1352624vsd.43.1606806591417;
 Mon, 30 Nov 2020 23:09:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:6ecb:0:0:0:0:0 with HTTP; Mon, 30 Nov 2020 23:09:50
 -0800 (PST)
In-Reply-To: <ffec9dbe-a238-4411-acdb-41bd33719288@kernel.org>
References: <20201130153742.9163-1-johan@kernel.org> <20201130153742.9163-2-johan@kernel.org>
 <ffec9dbe-a238-4411-acdb-41bd33719288@kernel.org>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Mon, 30 Nov 2020 23:09:50 -0800
Message-ID: <CA+uuBqa-k0Ztt18cetCdYs=6tBk8xTHufaFAcbpA3wert8nFAA@mail.gmail.com>
Subject: Re: [PATCH 1/5] tty: add port flag to suppress ready signalling on open
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/30/20, Jiri Slaby <jirislaby@kernel.org> wrote:
> port can be const here.
> [...]
> We have assign_bit() for these cases these days.

Johan's patch adding test and set accessor inline functions for the
new flag follows the style of the existing accessor inline functions
for previously existing flags, for the sake of consistency. If we are
going to use the new style (const for test functions, assign_bit() for
set functions) for the new flag, then we should also change all
existing ones for consistency. In terms of patch splitting, would it
be most kosher to have one patch that updates the style of existing
accessor inline functions, and then the interesting patch that adds
the new flag?

M~
