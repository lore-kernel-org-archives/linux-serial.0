Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF4EC6FD1C
	for <linux-serial@archiver.kernel.org>; Sat, 25 Mar 2023 12:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjCYMXh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Mar 2023 08:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjCYMXh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Mar 2023 08:23:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698ABC2
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 05:23:36 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d22so2582686pgw.2
        for <linux-serial@vger.kernel.org>; Sat, 25 Mar 2023 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679747016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXaYnL0rcCCbdgTS3groOrFcpcKdW5+Zoc1W2GQbB+Q=;
        b=N7Ocaw4mk+eabyQ33Tyv+gyq0qW3e6j5s4p4Dpuh0OyKiS111rPO3th2yoV2y8Hw3q
         CDBu/r7LsJZH6p0PpOx9FgGSrr7YELpIUdIiz4ZEDDSpQFEKJwCnH++21ti9AT9LDtRn
         uUq7bJd/bK59S6GF4palbt8tst66r/NbAKYJi+A/9Jum9GRDLoxb2nkbSiPf9OzMNQxU
         ZSoTHXA6rT2JmpWxwomrbfMEibEXVlMeUnTxu6owjjKACXjB1p95NknaaZtDcMNwq6Xd
         jStIT+NCgFAYXShpcb8a9A6fEYCaVMsC/T0Uf8FYRQQtqXntGlYe/XnTazv0fAE46GfE
         VjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679747016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXaYnL0rcCCbdgTS3groOrFcpcKdW5+Zoc1W2GQbB+Q=;
        b=zo+6cK/wZX7fWoKQFIXUCBQqTWeYNCvyiIrdgPdz61mY7E6bheis0ZjR6jnttqLQqc
         q60vuLptAsFGEQpQbgqVc567g7j5KsXw7vSvRB5AqL/btK6H3r/poax7HvQ2mlIdNZO8
         Pjk7VjpAp6INy1DLPunz5q2opo707FHuCC3WlQ9PJInq8nXqZJZWcVY0/YKhy67ZiszS
         /Va8yMxOGf7oVSYjhNuGeVlj3wYIPtWsD6wC7fvq5+V9SjEwt5exVijssVYBVM7GfLVs
         E5vDmQ06/sQi1jKf4Y3ituU1jf2FR/L9NZK+7k/oNQHLflAUwkZvVhNziRL9/zf/g8rz
         V+oA==
X-Gm-Message-State: AAQBX9doT+R2Rc2msUBoBhcoKaOmG5ZRZiwST0BCRk2B0Of6//eqbGv5
        FaGoU+Hn9LDsrKPrpkWftCiFMc+wiRghN7/G/Gg=
X-Google-Smtp-Source: AKy350aSRrAID6waI0iLmepziNni3RXpNeAckTkoaOh0Wz9Z3Hh5x7XEOyCCJdl2RGyRwAT4o6q+pxYVGQ0cqAbfnMk=
X-Received: by 2002:a05:6a00:10c2:b0:626:1eb8:31d7 with SMTP id
 d2-20020a056a0010c200b006261eb831d7mr3178301pfu.1.1679747015866; Sat, 25 Mar
 2023 05:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
 <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com> <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
 <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com> <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
In-Reply-To: <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 25 Mar 2023 09:23:24 -0300
Message-ID: <CAOMZO5CA=RLHGF8SoXLTt9NJp-OwRgKD98d8E_BKVP=9KRcczA@mail.gmail.com>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Stefan,

On Sat, Mar 25, 2023 at 8:31=E2=80=AFAM Stefan Wahren <stefan.wahren@i2se.c=
om> wrote:

> based on your patch, i successfully tested this:

Great, much simpler :-)

Please submit it as a formal patch so we can get feedback, thanks.
