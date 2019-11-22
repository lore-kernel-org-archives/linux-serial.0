Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA017C432C3
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9316020721
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jVNkUXPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKVSYV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:24:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37710 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKVSYV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 13:24:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so3855567pfn.4
        for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2019 10:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=7hJrD72iS4CTV/eqPsnjwRrd+DhYn98Uq27ZJW54QGw=;
        b=jVNkUXPD5bIky3irD3XcBYEQIK7JcGj0S/ZADQDIQbgMGmjfzDAhNSuX0UiNNGxXVp
         easfSnO5urLLc4lWAyEwRtQZ5asuP8eWlxh6XA92LJWPOtkoRcd0BG3dT7JpZtbVWrIT
         v6sFK7x/kCmw9pHEnTnBto9MzcJKku7jB8Ay0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=7hJrD72iS4CTV/eqPsnjwRrd+DhYn98Uq27ZJW54QGw=;
        b=RAqo2lOtk1Gj2jnjT1/R/FIWWFGni7Di0svQkOj46LYAD/LbBDpVaL5TpbiwDyfMak
         l2zaQuhrah8k+qmuQpDeu8rptUbVvvMvwb5b/UuW/oJoDzupmKpTgN4s42pr0TH61S+Z
         7yeLSNrrU9f2LYxubHpb7WCU+nw0XdgrVn2sUh3gum2aWCu2CQIk/vUgW3AFoSoAAvzV
         f0HDTbJ5kvWsS+BNVgyAaAasxeOPi+mum3xihZ05NxlP3oVkPZe39tkWl+cGgdO9DtOK
         IEz3d4T+8NPJda4JIxsxippXflslnL47cop7AsFrBUUZ6LEhvAJN/4CmfPzYDTUsxH/q
         Wuog==
X-Gm-Message-State: APjAAAUF9gHyTghxXwUlzap47zjcMo9aOivudZcjbtzrUkncR0WgE3Um
        lGbjbDLieJN3xWjhanv2Pp9D4Q==
X-Google-Smtp-Source: APXvYqwCGkNyOf7R8AA7Mp1x3NFIKX+iqD3uwFFsfJ7BP7zudBzdBbCdOkwtqqovQITmU05HGDrOgw==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr19227631pfo.30.1574447058874;
        Fri, 22 Nov 2019 10:24:18 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n8sm7183258pgs.44.2019.11.22.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:24:18 -0800 (PST)
Message-ID: <5dd827d2.1c69fb81.51ab0.220e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016e91dcbb45-f54cf6e5-8ace-457a-96cc-edec41305719-000000@us-west-2.amazonses.com>
References: <1573642136-30488-1-git-send-email-akashast@codeaurora.org> <5dcd919d.1c69fb81.1c304.2dc5@mx.google.com> <55a02d0f-2dec-2ba7-82e6-f21a8c86792a@codeaurora.org> <5dceff73.1c69fb81.e286f.aa4e@mx.google.com> <0101016e91dcbb45-f54cf6e5-8ace-457a-96cc-edec41305719-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH v5 2/3] tty: serial: qcom_geni_serial: Wakeup over UART RX
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, msavaliy@codeaurora.org
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Fri, 22 Nov 2019 10:24:17 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-11-21 22:46:32)
>=20
> On 11/16/2019 1:11 AM, Stephen Boyd wrote:
> > Quoting Akash Asthana (2019-11-15 02:00:44)
> >> On 11/14/2019 11:10 PM, Stephen Boyd wrote:
> >>> Quoting Akash Asthana (2019-11-13 02:48:56)
> >>>> Add system wakeup capability over UART RX line for wakeup capable UA=
RT.
> >>>> When system is suspended, RX line act as an interrupt to wakeup syst=
em
> >>>> for any communication requests from peer.
> >>> How does the RX line get remuxed as a GPIO interrupt here? Is that
> >>> through some pinctrl magic in DT or just via enabling/disabling the
> >>> interrupt?
> >> Yes, For wakeup capable UART node, we have registered UART RX line with
> >> TLMM interrupt controller in DT file . Example: if GPIO48 is UART RX l=
ine
> >>
> >> interrupts-extended =3D=C2=A0 <&intc GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>,=
=C2=A0 <&tlmm
> >> 48 IRQ_TYPE_EDGE_FALLING>;
> > Right. So is gpio48 muxed as 'uart' function forever and the interrupt
> > logic in tlmm is connected to that pad regardless of the function
> > selected? I thought that gpios through TLMM had to be muxed as function
> > 0, i.e. gpio function, so that interrupts worked. But maybe that's wrong
> > and it can work without that.
>=20
> Yes, gpio48 is muxed as "uart' function function forever. There is no=20
> need to mux gpio48 to
>=20
> gpio function, interrupts can work without that.
>=20

Ok thanks for confirming.

