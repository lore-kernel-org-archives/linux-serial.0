Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C03CC18E5B
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 17:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D2E20724
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 17:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UeVDrQE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbgCPR5k (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:57:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46974 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbgCPR5i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 13:57:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id r3so306992pls.13
        for <linux-serial@vger.kernel.org>; Mon, 16 Mar 2020 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=y2Kd4TE6UO55m6P+gqiknz16qTQ+UJhgoGPrT0zGvfc=;
        b=UeVDrQE395mmEkElu79pTTFh+bwZ/PBoqyZNZfqMpjrEs3+R7+ittS0/ZEJSOX/aXQ
         eUsZegOIunpxfZffe6Dt/HoK9AHmP1I0yWNc4pewzczh7CPSS31yD94roMfMbStZ8zlb
         oM0Std+omZCX4OL/A3GvBdXcA7R89KAz3nT80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=y2Kd4TE6UO55m6P+gqiknz16qTQ+UJhgoGPrT0zGvfc=;
        b=clidTBkiEQWZHcvyVbqIfc1qs1YyuI4vpy5MeKmWlDeUjOybmCxfW5AcI395oMRiei
         Rn8KcbjiT0CrbVePmIrFvtLjQjKK5s53Gi7V6MadbSeJCn22rdRIsnlt+3eyjppnshgn
         rcOPa0r5vk6QrYR8h2eVqxefreSjI90SluJ4MOZRZl5+rCeSZ3DG+Rd8978sK9fjBLSO
         h/YCn7mI0MNozQivP9OESesT7ljhQRtEcjslb9zWOUNTxs3i8T89f5nqkc3ShKh4RirN
         VLTE41McXC3M9i5Fp/W0yP8qPPyM2rJ0EsU+EVkI9UX+EMxWmZ2y6f9f/0R24iGnrQRe
         cYeA==
X-Gm-Message-State: ANhLgQ3UwibCkpBp9dbFGBlxvecUGccVzeRQXPT4Gyo78aRBMqtC+sJT
        s2jqVrumZ9Bn3yk0tB8fZNhlMw==
X-Google-Smtp-Source: ADFU+vtGkAGPzfs2Lcaw+Lf1d/gFf4IoLaEFY2uZqdkv9gwTNEfdgFe9USJ5kxzL18VQKskc/oqGxw==
X-Received: by 2002:a17:90a:d103:: with SMTP id l3mr752589pju.116.1584381456977;
        Mon, 16 Mar 2020 10:57:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 5sm538423pfw.98.2020.03.16.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 10:57:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200313134635.1.Icf54c533065306b02b880c46dfd401d8db34e213@changeid>
References: <20200313134635.1.Icf54c533065306b02b880c46dfd401d8db34e213@changeid>
Subject: Re: [PATCH 1/2] tty: serial: qcom_geni_serial: No need to stop tx/rx on UART shutdown
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        bjorn.andersson@linaro.org, akashast@codeaurora.org,
        skakit@codeaurora.org, rojay@codeaurora.org,
        mgautam@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@google.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Jiri Slaby <jslaby@suse.com>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        gregkh@linuxfoundation.org
Date:   Mon, 16 Mar 2020 10:57:35 -0700
Message-ID: <158438145518.88485.3909168358047756949@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Douglas Anderson (2020-03-13 13:46:51)
> On a board using qcom_geni_serial I found that I could no longer
> interact with kdb if I got a crash after the "agetty" running on the
> same serial port was killed.  This meant that various classes of
> crashes that happened at reboot time were undebuggable.
>=20
> Reading through the code, I couldn't figure out why qcom_geni_serial
> felt the need to run so much code at port shutdown time.  All we need
> to do is disable the interrupt.
>=20
> After I make this change then a hardcoded kgdb_breakpoint in some late
> shutdown code now allows me to interact with the debugger.  I also
> could freely close / re-open the port without problems.
>=20
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Matches what is described in Documentation/driver-api/serial/driver.rst

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
