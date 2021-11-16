Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8292C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 15:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBFA60F38
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 15:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbhKPPfr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbhKPPfc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 10:35:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571A7C0613B9
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2021 07:32:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t5so4058491edd.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2021 07:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10QA8B/LPkfjXNnh97Pzfdw4MjXxCZXNW3jfX9Mmswg=;
        b=fTB8ZjMBE99oiJfyC1dWFJVVNclwsB2Jl10zen5EOIACDD34xetVwhr7jHITMPjuER
         rbKouxcZHC9PanXr3mmix+lZWO0xbpsq/MNmeyVTXIXwVlXzAwU2cG03eC+yWehYgCFn
         +EtsY0lRPl7pnBpMl1ocRmYQnzjHQBiewXH/aPg9fAzO/TY70fqJYeMYFWvDXTMjmM0j
         Xay9tCydaSXBKIAB38T7MnotSPuaHTBUYdkiRe1SfN8KDiD6Xfk/6Z6KEufcmSngxNkt
         Xk9YJ/dEPfY2uFJ3cj1knYoK6fHzcVghH4pgzsR5Q2GFLvO5T01t19TmgjrxAR+Zopit
         paTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10QA8B/LPkfjXNnh97Pzfdw4MjXxCZXNW3jfX9Mmswg=;
        b=Z6FhJHrzuZ55Cgo5lPlw/EkymS//QcVvhIikUmoBKZwATMqIDANvUFt2ruS6czDLMP
         sHpJ3YyjMXM+SzpHtodBdstVbjO0M0cVxqx/SNilFX/QyXymS0By7+E2goNANu4NNSr8
         sZpOKcRMUYDVKheWFduHFQd9XZ9/OTpQXrusJycEmL3afsoWGOejhUDfPXmuxCxSwQzZ
         XZa19Yx8FDWMLgOrhWXrGstXmzUQGco03rKabQLU9cAGjHBREql7EbnYAY7EK/Aa5Uyj
         OOvdzRtPGy8NRwZl1+qjfUxmFyZ+0qW6S1bxBgSSsSnuDNxeiVB0u1gpkBwZ78dx7fGA
         +sig==
X-Gm-Message-State: AOAM533zowdMc2pI6O7KYR4ECKWgWqW+nOmcf1fIxukcu3LVu/wjdVqr
        VTjYnXgeS4QU0PNdXlIVhJzFTcbdl/e+XTN6rRb6f7lLU9g=
X-Google-Smtp-Source: ABdhPJzaq2z5BNinxNhSEWI9JRrjfZytIJQFyBAtq6xDuoJZ6m+4Aq+L5raL9WSrSIP8hIjweithTHJTYJIKX+S0c+I=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr10890170ejb.69.1637076753838;
 Tue, 16 Nov 2021 07:32:33 -0800 (PST)
MIME-Version: 1.0
References: <20211114183908.444923-1-jay.dolan@accesio.com> <20211114183908.444923-3-jay.dolan@accesio.com>
In-Reply-To: <20211114183908.444923-3-jay.dolan@accesio.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 17:31:53 +0200
Message-ID: <CAHp75VeH1zEhGLJPbxXTA_1JkZKTe94jYyRM82UO5eaOp1TOuw@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: 8250_pci: Re-enable higher baud rates on
 Pericom chips
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 14, 2021 at 8:39 PM Jay Dolan <jay.dolan@accesio.com> wrote:
>
> Add UPF_MAGIC_MULTIPLIER to Pericom serial ports since there is now
> range checking in serial8250_get_baud_rate() in 8250_port.c

The patch is good per se, but see the comment against the cover letter.

-- 
With Best Regards,
Andy Shevchenko
