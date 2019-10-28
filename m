Return-Path: <SRS0=1MuI=YV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6914ECA9EC0
	for <linux-serial@archiver.kernel.org>; Mon, 28 Oct 2019 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A4020873
	for <linux-serial@archiver.kernel.org>; Mon, 28 Oct 2019 15:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IO3JNKK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfJ1PAS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:00:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45908 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfJ1PAS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Oct 2019 11:00:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id c7so5863488pfo.12
        for <linux-serial@vger.kernel.org>; Mon, 28 Oct 2019 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:to:subject:user-agent:date;
        bh=MTTVVCGnYYa+0y7u4ASzLEPiU17XRxSToavC2yaOJYI=;
        b=IO3JNKK/w9Pw+TBvaaeDL+vHVoIXi3Bca/2/Pih7WoSBuzCqtP7W1mBQLha0Q6fZTH
         1/tuL7aUzLgbrahGTyKjk+xJ3iScXtIz64qoluta9k/H8Ga6Pe042pgsaOMpEvJoZluh
         aNPyLeU8NNFBD1X09tKqOe09KVaIfBowwLpg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:to:subject
         :user-agent:date;
        bh=MTTVVCGnYYa+0y7u4ASzLEPiU17XRxSToavC2yaOJYI=;
        b=UGc1R0BYXKKY2rzU9J2K6qivFq20MGFFJmotRPfg2dxPT0jCMiroNCkZMdXk3P0LD7
         wNJYalfSzPRsj5idRXAG2iEGbiPs8fzJDJtv02Rmi3vm+XxBXGQF5rs6z8XPZqHwOEfx
         QCZyIaxYfDUjzgoAPv3SWxPcsmNQ9hvyuKIDjrXYI8lMKj5cZdgCrqcRCaGyjuHhgtdT
         Nj1ULOoceQNqoyrYyaX9HFKn6gq+ocoJb0gIMKRzhDF1U3PLCwQGLEh77eMv8WW5Ntzs
         t+qF+TECkFJIO/tmn7y9nyd7TEmksuOx7kUlZpP8WZ+CebYVm4oKNVxt1Ix6aRf4RdHb
         FrZQ==
X-Gm-Message-State: APjAAAWE5jOF4k4A8801dhtMV9nu+ngDERG6IN5mlH4/tP6ndIqUKfoK
        XNClXWxM+Oc00+A78aGgcfg2Aw==
X-Google-Smtp-Source: APXvYqzBoVFd0sHisLrTISIXTJ2g2OheAr8faUVDpE649aEq5i8UVcr2ktpqDSPiVqc2A6BLLgnnWg==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr524532pje.128.1572274817037;
        Mon, 28 Oct 2019 08:00:17 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r33sm3125806pjb.5.2019.10.28.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 08:00:16 -0700 (PDT)
Message-ID: <5db70280.1c69fb81.c9f08.a848@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c20319ce-77e2-a4ea-5d7a-a84b8858a938@codeaurora.org>
References: <1570700803-17566-1-git-send-email-akashast@codeaurora.org> <5d9f3f4f.1c69fb81.5120f.b90e@mx.google.com> <a7dabb1d-b6af-acc5-ba4e-923ee5fc6ee3@codeaurora.org> <5da627aa.1c69fb81.e2d51.203d@mx.google.com> <c20319ce-77e2-a4ea-5d7a-a84b8858a938@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, bjorn.andersson@linaro.org
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
Subject: Re: [PATCH V2 2/2] tty: serial: qcom_geni_serial: Wakeup over UART RX
User-Agent: alot/0.8.1
Date:   Mon, 28 Oct 2019 08:00:15 -0700
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-10-17 04:10:10)
>=20
> On 10/16/2019 1:40 AM, Stephen Boyd wrote:
> > Why can't we make this driver use runtime PM?
>=20
> Currently there are no plans to use runtime PM as we are interested in
> enabling wakeup irq as part of system suspend only.
>=20
>=20

Does the wakeup irq code require runtime PM? I thought that any wake irq
attached to a device is armed during system wide suspend and disabled on
resume. See device_wakeup_arm_wake_irqs() called from
dpm_suspend_noirq().

So why can't we use the common code that manages wakeup irqs for
devices?
