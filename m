Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1CC432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7952520715
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/+JAA2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKVSHT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:07:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43251 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKVSHT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 13:07:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id 3so3819932pfb.10
        for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2019 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=QHcCLOTHDrwSpwTP8rFeltRMoHfX/0xc/q7sN/Rx9ro=;
        b=N/+JAA2o5L5PXyYbMc1Ds+tfIppGwLuENAvgZ2IibduBi162AeQKB8wpJv3y+3C+t7
         LUovV1cPCxYV0fUIg/Sa7BnzG+sjccvOPyLpm6XEY2eSlFtDxALPyHDpFwe9qWLi6Lcv
         hGuPBFaRQDON153lzs6nPlYifkwak7G4sVMUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=QHcCLOTHDrwSpwTP8rFeltRMoHfX/0xc/q7sN/Rx9ro=;
        b=scPPdUIm7DlqdtQFaxGdzKuGaB8biyCY7FW4e0+aOl3u+In3oTvd21ICStkJfw0H9k
         iK1bccrhXe3Wzo/q+xs2Jb5c7pOQXvshtlZ8HUKMUys4zY2uozMlRy3MX0/GHWlx/lVj
         gPXC3QSRTz+uTkLXbtGaYSOqtP5XrN3eVnxT2QkeTPvgSeTejZ3SLVme1u1QvvGKWHxn
         G05WIdwyOM8lmOD6vMDSpRJ2Md0AcGvzAhswqNb3AC+LYrAwGjJJgtmKbRxqJZl2iMrp
         dYtCF+2WAQIirIAv3c9iu4VocVgofEe1jxffaMGnyXHu1fB/49izIBGp+8FdNCNTHPri
         7eWw==
X-Gm-Message-State: APjAAAUhlxBGkBaAe4T6mlhNs3SaTqeB8fEcKC6SkO5CktAGlw5E3VHY
        Y3A/ZPoM+nQEf1BFkRMrgDm+ng==
X-Google-Smtp-Source: APXvYqyHNTAjmGEhUHYEdxjMp82zyO+vvo+z6lJS77Es0eUHhRtq15UVwTA/TGgZdWVBJylLYFzoZw==
X-Received: by 2002:a63:a5b:: with SMTP id z27mr17799362pgk.416.1574446036741;
        Fri, 22 Nov 2019 10:07:16 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i22sm3480907pjx.1.2019.11.22.10.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:07:16 -0800 (PST)
Message-ID: <5dd823d4.1c69fb81.25a59.914e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016e937a6c00-b8cf45e5-aedf-4e03-bf23-47d7810a0b23-000000@us-west-2.amazonses.com>
References: <1574432266-20732-1-git-send-email-akashast@codeaurora.org> <0101016e937a6c00-b8cf45e5-aedf-4e03-bf23-47d7810a0b23-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH v6 5/5] tty: serial: qcom_geni_serial: Move loopback support to TIOCM_LOOP
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Akash Asthana <akashast@codeaurora.org>
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Fri, 22 Nov 2019 10:07:15 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-11-22 06:18:24)
> Remove code from the driver that create and maintain loopback sysfs node.
> Instead use the ioctl TIOCMSET with TIOCM_LOOP argument to set HW to
> loopback mode.
>=20
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

