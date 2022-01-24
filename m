Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A26EC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 25 Jan 2022 04:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S252286AbiAYE0q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Jan 2022 23:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3414260AbiAYDAo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Jan 2022 22:00:44 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB11C06173B
        for <linux-serial@vger.kernel.org>; Mon, 24 Jan 2022 15:56:51 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id p37so17644984pfh.4
        for <linux-serial@vger.kernel.org>; Mon, 24 Jan 2022 15:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9hh+6kugkeSiiQht2Ofo5ci00bQAsOJV63pvvuw8MqQ=;
        b=Ukv/t2/v46npEGOCYlu/PQxt/5PPgr9L3wwbh32tGPkO+YO2T+VJNjvx/2Ufx2IDOo
         KdkMlmQVWADKCI9yA9KGUNMzC12xi66LkgJ3RYXSMt8izjguSQ0iWZv3bEY3ysJASemY
         V/LXQj5ay+6HDNGxLs6CnB2pV8Rss6mQ/rh31n0vjP+fwjhPBEP2Kbn8k3ovBrukXfYZ
         sn/HZ1MPfzl2yw0ihxsYut5/00Ug8WLHlesy2IG23bklrSrsLLxXOajPt4JZDTnb5d81
         e1U/Gb35iiFXl2SDNs7I9Ac1hRuzc9nYoMFDhpCt/cGQ76SKOKJEPrfgvIvNhQBomloJ
         F0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9hh+6kugkeSiiQht2Ofo5ci00bQAsOJV63pvvuw8MqQ=;
        b=UZJISYOwZL2P7DSC6DmN8fnKs/807KOlOj7158UIhx2eu5vQQ3HNOQCsFf4sZm7iSm
         KuRU+JaSSY7GHeWnH5etBXsrxMoa8eaLb06PT/uSqZwP55mDGJHfp/5evwecKHClZnjr
         JHJ7hZxvLTm2VVgGA8jfbMQmi6czQjsKyoC7YrxHHCfUaqjgmROSdGF0RLMKJDohkoXu
         ryJGXlldlDHinSCnu8RIXrt7J3uln85ayaegUHi3Ep2GmIFwwTA5hJJoN0ldrJC7Mtso
         xIaAGV/ivTvq1p06iV4HehOuBYLn0UKK1bK6iw+rPgGyvu+/S3Fh1UOQRyyzfwOxuglc
         Qi/w==
X-Gm-Message-State: AOAM532ztl1nmJAifOSwET+hAv3drZ6Uwrpsgdx+HXSHCpFFCITf/JAD
        2Mg3YNqepdRJbFJFYUfmXQmioiDgcqyiILHbTsp0QA==
X-Google-Smtp-Source: ABdhPJxL0NFnx0J+3UH5ghjwPitZ1MFPKyL7y1dwOOSJIzpGtIoMIoWPO/jVyu4eJweWcKyDzJKfzKlEgnhZ/Mtr/Uw=
X-Received: by 2002:a05:6a00:728:b0:4b0:b1c:6fd9 with SMTP id
 8-20020a056a00072800b004b00b1c6fd9mr15756421pfm.27.1643068611375; Mon, 24 Jan
 2022 15:56:51 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
 <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com> <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com>
In-Reply-To: <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 24 Jan 2022 15:56:40 -0800
Message-ID: <CAJ+vNU27VQR6Bwp_KtYLubr_CBd30Ewgm6xxZtPiVXOFw8sEqg@mail.gmail.com>
Subject: Re: Modem control lines for RTSCTS hardware flow control via rts-gpio
 and cts-gpio with IMX
To:     =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     linux-serial@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Huang Shijie <b32955@freescale.com>,
        Dirk Behme <dirk.behme@googlemail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 13, 2022 at 10:19 PM Tomasz Mo=C5=84 <tomasz.mon@camlingroup.co=
m> wrote:
>
> On 14.01.2022 04:08, Tim Harvey wrote:
> > So I believe in order to support using gpios for rts/cts in the imx
> > uart driver I must find the right place to call imx_uart_rts_active
> > and imx_uart_rts_inactive when the FIFO is not full and full
> > respectively. I'm not that familiar with the Linux uart driver
> > framework - am I on the right track and if so any ideas where this is
> > best done?
>
> It is not really the driver (and thus FIFO level), but rather the amount
> of free space in tty buffer (checked by Line Discipline workqueue) that
> determines when to throttle (set RTS inactive). This mostly works fine,
> but fails [1] when the RX interrupt frequency is too high [2].
>
> The throttle/unthrottle request, when termios CRTSCTS is set, is seen by
> the driver as the call to .set_mctrl (imx_uart_set_mctrl) with TIOCM_RTS
> bit cleared/set in mctrl parameter. Currently imx_uart_set_mctrl() only
> controls the UCR2_CTS and UCR2_CTSC bits based on mctrl.
>
> To support your case you would most likely have to add the gpio handling
> in imx_uart_set_mctrl(). However, I am unaware what other issues you
> might encounter (i.e. if it is not done there yet simply because nobody
> had that use case or if there is some deeper problem).
>
> [1] https://lore.kernel.org/linux-serial/10e723c0-a28b-de0d-0632-0bd25047=
8313@camlingroup.com/
> [2] https://lore.kernel.org/linux-serial/20220104103203.2033673-1-tomasz.=
mon@camlingroup.com/
>
> Best Regards,
> Tomasz Mon
>

Tomasz,

Thanks for the info. Currently imx_uart_set_mctrl calls mctrl_gpio_set
which does toggle the rts-gpio per mctrl & TIOCM_RTS.

Also, there's something in
Documentation/devicetree/bindings/serial/serial.yaml that puzzles me:

if:
  required:
    - uart-has-rtscts
then:
  properties:
    cts-gpios: false
    rts-gpios: false

That would seem to indicate to me that if you define 'uart-has-rtscts'
you should not be defining 'cts-gpios' or 'rts-gpios' but I found that
when I omitted 'uart-has-rtscts' I could no longer enable hardware
flow control. Is my understanding of the yaml wrong or is this just
not accurate?

Best regards,

Tim
