Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C1C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 12:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EB660EE9
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 12:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhJYMrA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhJYMrA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 08:47:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F118DC061745;
        Mon, 25 Oct 2021 05:44:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l13so22097628edi.8;
        Mon, 25 Oct 2021 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/7+UMC0uPidkpB1Rz9mAPwHLWUWuTue4UkDjFgG3Lo=;
        b=bJb1Jyi0T0wjvDpd65y8dwwnDae17bP7cNflVnZVPQ/4qNQheuKat9S9n2dRRLURVY
         WqA6jAbyQzSzXopof9gONLjHU3Qd5neZlivistctGsYdzXRdygL8SZfXU4cJW810MkjX
         zCYgadUCJM0SeGyLb/x3qYr+BGqiW1iu+f2v+PmXtx3739ZbzdbzxZ1UxcImlOKGtWF1
         p1/sjtYrlcYl2GoBpqRt6bimmjvX2cy85ia6h5FS55jJFT3VO5vKbdKDMyOVWL/VKmmm
         MPAFWSfpsmJsiAjz2DU3VA5QzB5IXy+SrvSOnVhLB+M5VyyVFdDjGrRuU98JtJBKdsZq
         7g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/7+UMC0uPidkpB1Rz9mAPwHLWUWuTue4UkDjFgG3Lo=;
        b=LPmRvEmki2MB0qkWNQwSLtd25ebDa9qFViKGkmzFvStZsBt2+1O85BPK180E8EqdAA
         PT+U/Q1hTioGeQGQP4UGlo7vt4fJ9n+x/UnF2CrV00Qg/a0sAGfCm/n4nCGHA8hYBSTv
         7ucc/Pakkl7Em7fgF+hxKkV3W7vRFvv00V/dOE/HxMSv8VI0f8BlfekUL4psm7wwx9Am
         hjZRDPmJScoVnjUwwE/TbZqc10fmLcg/SxLKNDgnZY6mxyPlI4XZk/R1I+rx77m70le0
         qqSjwovRlfpq54h6vQjUmeytjBQzHPrzdnFPxUXoERjkkrruvPeCblq9zHCrWaBt02PE
         v0Ng==
X-Gm-Message-State: AOAM5321v9W8WDKX3epTP3Av1Wz5MTobbpOrJgeXPLHDJ8yQxZI+ID2b
        VhWR+3ZtqyRDsQmhOXdAbJW6M9LkfuSazLbmQtN7oAMZV9JgBQ==
X-Google-Smtp-Source: ABdhPJx1rhs2euDrGKnk//2yuXw4zzZKh9f1MmOxRLeH+mhD6Oh9J6BxpPsZFhFqbLrcLlkO18kmq6zINXn5sNfVGPw=
X-Received: by 2002:a17:906:a158:: with SMTP id bu24mr20368809ejb.356.1635165850603;
 Mon, 25 Oct 2021 05:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211025124142.18041-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211025124142.18041-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Oct 2021 15:43:16 +0300
Message-ID: <CAHp75Vfkqds+Nq9Dv51zmVtK2Eb0dHpQbLU3EyknQ9Ygo=+gGg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] serial: 8250_pci: Remove empty stub pci_quatech_exit()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 25, 2021 at 3:42 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The ->exit() callback is checked for presence anyway,
> no need to have an empty stub.

Sorry, wrong set, please ignore both patches.

-- 
With Best Regards,
Andy Shevchenko
