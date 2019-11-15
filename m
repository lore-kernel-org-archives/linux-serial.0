Return-Path: <SRS0=rp3o=ZH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859F9C432C3
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 19:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4D320732
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 19:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ynnju9j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfKOTll (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:41:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41076 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfKOTlk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Nov 2019 14:41:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so5340419plj.8
        for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2019 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=8k/Rpm0GwxthXH5gCeA9lJZ+fXztebJcMOm1koH9MS0=;
        b=Ynnju9j25BnTwhUIaGaCtuSU/cb/NDAogzyrwSJRdGJy7AXareoVyTX4zshl6mtHR1
         qZvrhWJgmPV+rZUwqFMql0uI2H4t3CyTDjlZdA9dyt/j7Mg3P1tkbVmDy7LixSvqcoNM
         TLcifOzlMCJsj2Gmi+398a12LmilMx3cDDVR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=8k/Rpm0GwxthXH5gCeA9lJZ+fXztebJcMOm1koH9MS0=;
        b=Dx8c0DZ8VFp33ti52sVTA3ed4ZHDnrwy0FILtG2KjBfk3oEgIF6AIa1uZYCr/BJyg5
         VzweT4MhXeo+f+Pu7OmwVZ59yzneyTw7POtHKBwf5lVjbvLWLLt/+vN30LKvPHGEyY+o
         sF+m80/+EivACLGgve5GGy48qquA2YQfgOqKm10xGCkvR1tbrKPQ1RgQyfV0/2A8TliV
         yqBizDVQbcXPWEH1YKLqzAykaGFDHmIf80gjoOUrJNpkhL2SPoIzcn/xdk151nwfWT5o
         7uukevhtN+XzBb2ZPfPEPSBCrMvvWxxZjCuV8NJ35XLr2Ag2z3HSu/VrXFG8ps5SSSrU
         QldA==
X-Gm-Message-State: APjAAAW3hTl24baUb9ak+PGZ1F7Ziir/EyJoDcrjo4xDq3XzTey+d89N
        In/3d9gn9t5t/hAHXMyeqQTZVw==
X-Google-Smtp-Source: APXvYqzVa+BgSbzX25GdWSjE4pYYjgH8+F18GtAt3SxUT/YtilbXuea0jzEPNAepKdB0bAAGaN3+bw==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr15416536plq.27.1573846900036;
        Fri, 15 Nov 2019 11:41:40 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u7sm9468495pjx.19.2019.11.15.11.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:41:39 -0800 (PST)
Message-ID: <5dceff73.1c69fb81.e286f.aa4e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <55a02d0f-2dec-2ba7-82e6-f21a8c86792a@codeaurora.org>
References: <1573642136-30488-1-git-send-email-akashast@codeaurora.org> <5dcd919d.1c69fb81.1c304.2dc5@mx.google.com> <55a02d0f-2dec-2ba7-82e6-f21a8c86792a@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, msavaliy@codeaurora.org
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 2/3] tty: serial: qcom_geni_serial: Wakeup over UART RX
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 11:41:38 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-11-15 02:00:44)
>=20
> On 11/14/2019 11:10 PM, Stephen Boyd wrote:
> > Quoting Akash Asthana (2019-11-13 02:48:56)
> >> Add system wakeup capability over UART RX line for wakeup capable UART.
> >> When system is suspended, RX line act as an interrupt to wakeup system
> >> for any communication requests from peer.
> > How does the RX line get remuxed as a GPIO interrupt here? Is that
> > through some pinctrl magic in DT or just via enabling/disabling the
> > interrupt?
> Yes, For wakeup capable UART node, we have registered UART RX line with=20
> TLMM interrupt controller in DT file . Example: if GPIO48 is UART RX line
>=20
> interrupts-extended =3D=C2=A0 <&intc GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>,=C2=
=A0 <&tlmm=20
> 48 IRQ_TYPE_EDGE_FALLING>;

Right. So is gpio48 muxed as 'uart' function forever and the interrupt
logic in tlmm is connected to that pad regardless of the function
selected? I thought that gpios through TLMM had to be muxed as function
0, i.e. gpio function, so that interrupts worked. But maybe that's wrong
and it can work without that.

