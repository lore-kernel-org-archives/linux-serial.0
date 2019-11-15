Return-Path: <SRS0=rp3o=ZH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04B1C43215
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9352F20732
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 19:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WRVlk7Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKOTp1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:45:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:43346 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfKOTp1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Nov 2019 14:45:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id a10so130912pju.10
        for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2019 11:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=4q+yuQTczIPpXFYrjST9iFAFqDLKVL3UwzUfPD0Ti0E=;
        b=WRVlk7Lr3fLjV7Nkh2tcg1k4iFKQwFFUyIN0aGmGyAL1KkdukzksmdojGGoF2AJUkA
         uCrx+HHEgAvmfb2tN5n20NzJV5BF+XrWPprdOHgtHotPhFXn8hOR9HVcJDF+lIbLuWBb
         igcwvzK7fT7fJw7OWfr/qP8daSLYqjE02ZjBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=4q+yuQTczIPpXFYrjST9iFAFqDLKVL3UwzUfPD0Ti0E=;
        b=eXRLyrlxntQIke6jXs73tG8HiQMJ+rgLXDM8ebJMZp0ODKehWbe67ja3jNU1J3ixuG
         4sOISenMlfzP095AOcAkfFH5m7RAYkOeMNk+98QGc9VncNYYl9gXFGGHB1hwdyiGMzHl
         hN4PSZDHSfLwNHXQiuqtlbuZhJO+ae6wXdjUHwagkBrbTMJ51zL6hk8W0gTUQXRT5ajL
         9d21WeXrJ48VvVQaIsVWPmsrkK3/3YjeyNBSIbELHmMlajBv2J0pa53B5hA76t8wDBwz
         6ty+fvO+ysZwIeIh2gewM86gOKk0oWPKEDBjfxv04SY70LOGqmmLDsBkhT8ulU2H7LCU
         f1sA==
X-Gm-Message-State: APjAAAUxmafyOIYyN5v68KLJLBjiweChM1oDVcH5CZL6y7SHl7hwVarJ
        QOoXEgqQW9Smdit0YYs5qts1WsIqFhI=
X-Google-Smtp-Source: APXvYqyB6QiOTnKo9LokNPBto3d0oQtY/rgpXWaemtQ96PKVRvPLaS089w/OqehgSpVlpKYTeoJZsQ==
X-Received: by 2002:a17:902:ac90:: with SMTP id h16mr17332925plr.147.1573847126279;
        Fri, 15 Nov 2019 11:45:26 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r22sm13291949pfg.54.2019.11.15.11.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:45:25 -0800 (PST)
Message-ID: <5dcf0055.1c69fb81.258d1.5380@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <04363987-0d4e-645f-87d0-79888913b8c3@codeaurora.org>
References: <1573642161-14189-1-git-send-email-akashast@codeaurora.org> <5dcd90a4.1c69fb81.757a7.37e8@mx.google.com> <04363987-0d4e-645f-87d0-79888913b8c3@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mgautam@codeaurora.org, msavaliy@codeaurora.org
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 3/3] tty: serial: qcom_geni_serial: Remove sysfs file
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 11:45:24 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-11-15 01:57:48)
>=20
> On 11/14/2019 11:06 PM, Stephen Boyd wrote:
> > Please update the subject. This patch does more than remove the sysfs
> > file. "Move loopback support to TIOCM_LOOP"?
> Ok, I will update this in next version.
> > Quoting Akash Asthana (2019-11-13 02:49:21)
> >> Remove code from the driver that create and maintain loopback sysfs no=
de.
> >> Instead use the ioctl TIOCMSET with TIOCM_LOOP argument to set HW to
> >> loopback mode.
> >>
> >> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> >> ---
> >> Changes in V5:
> >>   - As per Greg's and Stephen's comment on v4 patch, removed loopback =
sysfs
> >>     file related code.
> >>
> >>   drivers/tty/serial/qcom_geni_serial.c | 30 ++++---------------------=
-----
> >>   1 file changed, 4 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/seria=
l/qcom_geni_serial.c
> >> index 56dad67..52f5ea2 100644
> >> --- a/drivers/tty/serial/qcom_geni_serial.c
> >> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >> @@ -238,10 +214,14 @@ static void qcom_geni_serial_set_mctrl(struct ua=
rt_port *uport,
> >>                                                          unsigned int =
mctrl)
> >>   {
> >>          u32 uart_manual_rfr =3D 0;
> >> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport, upor=
t);
> >>  =20
> >>          if (uart_console(uport))
> >>                  return;
> >>  =20
> >> +       if (mctrl & TIOCM_LOOP)
> >> +               port->loopback =3D MAX_LOOPBACK_CFG;
> > How does this work? The loopback is supposed to be the max all the time
> > and not match some qup number or something?
> port->loopback is unrelated to QUP number. However we have different=20
> modes to run loopback test, 1(rx-tx sorted), 2(cts-rts sorted),
>=20
> 3 or Max(rx-tx sorted and cts-rts sorted). In our internal testing we=20
> only use mode 3 hence we are initializing port->loopback variable
>=20
> to 3 and eventually it will be written to HW register from set_termios=20
> call.

Ok. Thanks for clarifying. Can you rename this macro to
RX_TX_CTS_RTS_SORTED? I imagine seeing something like:

	/* SE_UART_LOOPBACK_CFG */
	#define RX_TX_SORTED		BIT(0)
	#define CTS_RTS_SORTED		BIT(1)
	#define RX_TX_CTS_RTS_SORTED	RX_TX_SORTED | CTS_RTS_SORTED

or whatever the bit field names really are.

