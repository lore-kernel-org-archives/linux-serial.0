Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A2DC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 10:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEB064EAE
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 10:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCOKHf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCOKHb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 06:07:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F0C061574;
        Mon, 15 Mar 2021 03:07:30 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id p10so8775936ils.9;
        Mon, 15 Mar 2021 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0yTkeRLYBbu9xWJ6lRGwyCy/WfW0M4jYX9LPXiwOrA=;
        b=bJIX6IIOLOdCt836ruiJa6x/x6sR90zqyJC670tjI6WIJ2etWPjUfpX62prEI5IcVn
         qW0d8+ktEiIaC0bnNLiBkwhMxQNvwulC3y27LtP81i2fpkbi5O5kB9SYIIQpnC6m6EhE
         xgsx31C4UWBTD9dyQLKCklE1xC22qiJyQ/ONUVZymb1siswFsWB++FszBxJZy4bjWhdc
         2Dt7vnIWIZ79g7TGp318kHCi0vFNgylMbi9fLAiWIyKLmw/u4SWNnkS/xGUQoGZP5yJO
         Z6S0Aesj9PQhyYrmQxWShbxWxB33tDz9qjyX5/yU/+nhX0EFm6aOjL4cQ9hHDhD1lxla
         R6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0yTkeRLYBbu9xWJ6lRGwyCy/WfW0M4jYX9LPXiwOrA=;
        b=fy1EXoZFurToB4YvcqLFGeQHC4wJpPfzJuAX6mRsUqoOmJmSDPgjgwNltblaqoY5uE
         QGvIQOrFqvNJ9qCt8xyxe5BOJ/jUjXgsvSRDShG/rBVsbW5klvI1DAmXY0g6OEIBzy4Y
         VPPPZtjz2xb8f4RQVdLflbJG3ahdJhKxv5nPd7lH/3DoxG9Njxr2Gh2K2tpwGq3yb2Yn
         k1LDyh43rVg/F7sTBeoF1ira1tRdXAECxHguhyQ+0w/KF84RSCUOZva9B7BNj1XeJEt+
         LpZDhRkJuPNO5IQofy3M7MuqD1TAbogzTbfwYwzie2CEfQ/NE7Fl1vfLjBCCZpmURt/+
         sMYA==
X-Gm-Message-State: AOAM530Bg4Luv4/X7i+cZ5UXK83DKhfRQE24T2aDrN7FU5vY1aBN/M0K
        5uzr3XqvpJmSVGpPypON/Xx9dITcDqI3kNa/T9gt/gqGT/AI2A==
X-Google-Smtp-Source: ABdhPJy4dGzh2OSJWBIcX8iOWXn3InuSM5KT9ZOxj3AW5XqRxtL1C0ke6FUweZEot1PvneJqxjx3Wj0vAN4hrdP2zjo=
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr10064959ils.39.1615802849575;
 Mon, 15 Mar 2021 03:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <YDUysZY90FfVhrHK@hovoldconsulting.com> <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com> <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
 <YEH7okblCx8+Odxn@hovoldconsulting.com> <ddc0e424-21c2-b8f4-1b00-f589267d2b51@IEEE.org>
 <YEpAaL9QtVMduEpi@hovoldconsulting.com> <9d02257d-cca1-116e-634a-6ac952362c5d@IEEE.org>
 <YEtwNzhCmvyKhRto@hovoldconsulting.com> <a475110e-2f44-eeca-3cd2-dd946e5abfe7@IEEE.org>
 <YE8j1XdfQNDGLzZR@hovoldconsulting.com>
In-Reply-To: <YE8j1XdfQNDGLzZR@hovoldconsulting.com>
From:   Charles Yeh <charlesyeh522@gmail.com>
Date:   Mon, 15 Mar 2021 18:07:18 +0800
Message-ID: <CAAZvQQ6NCocMXQXVcKGEi7ivbysyU8EJeeRUK5RPqAmEyqSXcA@mail.gmail.com>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
To:     Johan Hovold <johan@kernel.org>
Cc:     "Michael G. Katzmann" <michaelk@ieee.org>,
        =?UTF-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Charles, could you help us out here? Which other device types use the
> alternate encoding (e.g. HX(A) or TB) if any?

TA and TB are the same hardware design: no need to design a new type

Charles.
