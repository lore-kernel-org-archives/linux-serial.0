Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF6C7EE2C
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jun 2023 03:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjFEDEn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Jun 2023 23:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjFEDEm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Jun 2023 23:04:42 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2FC4
        for <linux-serial@vger.kernel.org>; Sun,  4 Jun 2023 20:04:40 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-78a03acc52aso595589241.3
        for <linux-serial@vger.kernel.org>; Sun, 04 Jun 2023 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685934280; x=1688526280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GemXbMIq5lp+454RKyClJK8enwTWlxZVZu2OjpvqlY=;
        b=oPX1da39xxxDeDArWOnV6VvW0eqMDZSK7f9Ve9mZ0kzDSYY1VOdxziYIN0/fC6NW1m
         F/prs75MzDyyEYf0I12KVAvkEYP3P2XZcNI5tU3X7t4GTFd4snKp7LpRiaKWrmR/jKQ+
         +HFYU/lo//sCc8NY3bh61JGMniX1nPvtycInI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685934280; x=1688526280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GemXbMIq5lp+454RKyClJK8enwTWlxZVZu2OjpvqlY=;
        b=YAVp3Ba62Lz/hTbh0o1EjhuYeVum2dx5yOz6st6H9B5EQ+StDXzfRzmMcCnK1uaXDU
         d0/JuZPAvrHdreon03RzoMkaWtnkO6f0r3ZYzn+xpU+IVYzsF4aZeovAR0/Ty/zEHRCY
         doBSWCVJt+H/ydmOrTD9ZFwM2HDSaNsfQ1dCAOlPJiVA8QG3WAPg2kDFvcdCWZH30QUO
         TMp1+htL9F9LgG1Tz2VvM4LK2sZ+GKlZ5nCd/QJ0mXTxK9XWY6n5r8XF+h2IoAJQQt1v
         JWgnWf6nyvtdCw4Q8Gg+fvFIf3THnlrZidqCVN8F9r1ulXAWByWXenu4AzbbWAnJ4MLu
         /Yog==
X-Gm-Message-State: AC+VfDxvPPzj9Y7FzhJOh7/lCOv3Rn2EPBNEox+XBSxf2sn8ez9KIANA
        t5Mo8bltczdtAnht2Ohs1YCKLwM95i1u0K4byeoh1Q==
X-Google-Smtp-Source: ACHHUZ6jpGq4+6/+6ClKSVvkgkwQzzirwShAHbQSCjNu7NjQjavUuh0PcSmBXhB3NwTi/oX4WQQPRVTj7U6bPKM8aSE=
X-Received: by 2002:a1f:3d4e:0:b0:45c:e022:d713 with SMTP id
 k75-20020a1f3d4e000000b0045ce022d713mr4342803vka.12.1685934279946; Sun, 04
 Jun 2023 20:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230525113034.46880-1-tony@atomide.com> <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
In-Reply-To: <87a5xii33r.fsf@jogness.linutronix.de>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 5 Jun 2023 11:04:28 +0800
Message-ID: <CAGXv+5Gy=SqKukrDTpx+qVDgNDzMmMcC+Y0wkgfRA9xZCKBA6w@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 2, 2023 at 6:13=E2=80=AFPM John Ogness <john.ogness@linutronix.=
de> wrote:
>
> On 2023-06-02, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > This patch, in linux-next since 20230601, unfortunately breaks
> > MediaTek based Chromebooks. The kernel hangs during the probe of the
> > serial ports, which use the 8250_mtk driver.
>
> Are you sure it is this patch? Have you bisected it?
>
> Unfortunately next-20230601 also brought in a series that added
> spinlocking to the 8250 driver. That may be the issue here instead.
>
> For 8250 bug reports we really need to bisection.

As Tony mentioned, you're off the hook for it.

I should've been more clear. After reverting the top three patches in
drivers/tty/serial from next-20230602, the system booted correctly again:

    539914240a01 serial: core: Fix probing serial_base_bus devices
    d0a396083e91 serial: core: Don't drop port_mutex in
serial_core_remove_one_port
    84a9582fd203 serial: core: Start managing serial controllers to
enable runtime PM

ChenYu
