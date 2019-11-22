Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD57C432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351E52068F
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MsZagEuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVSXq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:23:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38773 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfKVSXq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 13:23:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so3853495pfp.5
        for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2019 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=Pn5jJxprXgy+eMJms58Z8Kvldo76KRPuED0UpzQINWQ=;
        b=MsZagEucv0b1WmIyy2pAgo6HNfHf96/ht0J3UUI+XUbJfLsvjYD5fAijLUvI3bkLNs
         Mu3pU9HGy8duWXhPQKCe5OzB+uIKrhQslC2xPiVLwtBC2lKZYr8aAQdvpmg5kgyvg5bv
         Mu5t4i+XKnuSxVpY8umE0wEFSqHRfj0G1Uyl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=Pn5jJxprXgy+eMJms58Z8Kvldo76KRPuED0UpzQINWQ=;
        b=fU7J1qrIZunyakQIU12MR3oUbefIob3aoV4DjKb7SdpXrPm3iQ+ZaWZn/vucfmTSqN
         x0e2enqVo1zmQdTEphtfCCGWfhzVfYKQz8eo7mPVYjVddz+J++KtxfkKw7drjZucFxZ5
         dus/Ja2fe/d/u2PJdwiNjD/lzbstpQaFwWb28rURtjSbIGsnQ8RVJ51aarO0361v/1v0
         uwztfAFdlmrHRxL27gHZKczkS2Tt5v70pECD4PAKFTe9TNfHZh6d5jD9PAjW+rUhBXcF
         XsGetRjCmrB/iwPRQEVV7DVY+aZAqM5BkMmahRcSpS24VEGAkkFgCeY4DRYaECWENbVF
         W0Rg==
X-Gm-Message-State: APjAAAVjNjZuij5vxx0S5uNqfqxOd1BpKncMx7ko3anWmmLiEXYRPYBh
        Z5jzYALlXUcEvsfzFB9QU0F2vg==
X-Google-Smtp-Source: APXvYqxThAGBPYAmlS74a6k+TSUsn6Id1iZNQo5lX+fHhLjHbRfexunm0aWgT6XZhNHknylCzP8GBg==
X-Received: by 2002:a63:1624:: with SMTP id w36mr16201097pgl.404.1574447025927;
        Fri, 22 Nov 2019 10:23:45 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 186sm8726638pfb.99.2019.11.22.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:23:45 -0800 (PST)
Message-ID: <5dd827b1.1c69fb81.a7ff0.5ab4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016e937a0ef9-36754afa-105c-416f-b308-b5bed0cc0ccb-000000@us-west-2.amazonses.com>
References: <0101016e937a0ef9-36754afa-105c-416f-b308-b5bed0cc0ccb-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH v6 0/5] Add wakeup support and move loopback to TIOCM_LOOP
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Akash Asthana <akashast@codeaurora.org>
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Fri, 22 Nov 2019 10:23:44 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-11-22 06:18:00)
> This series adds wakeup support over UART RX line and moves loopback
> support to TIOCM_LOOP.
> Patch 1 & 2 reverts the V2 changes for wakeup support on tty-next tip.
> Patch 3 & 4 adds V6 changes for wakeup support.
>=20
> Akash Asthana (5):
>   Revert "tty: serial: qcom_geni_serial: Wakeup over UART RX"
>   Revert "tty: serial: qcom_geni_serial: IRQ cleanup"
>   tty: serial: qcom_geni_serial: IRQ cleanup
>   tty: serial: qcom_geni_serial: Wakeup over UART RX
>   tty: serial: qcom_geni_serial: Move loopback support to TIOCM_LOOP

Maybe the reverts aren't necessary? Is it possible to fix up the patches
that are already merged in Greg's tree?

