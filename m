Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA14AC3F2CD
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 16:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7837F20732
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 16:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3yZmrrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1QhL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:37:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32942 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgB1QhL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 11:37:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so1455610plb.0
        for <linux-serial@vger.kernel.org>; Fri, 28 Feb 2020 08:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/NFEg+xGYEe7/uJwrQbwOpUOv1hOItyafkcLvnfAmT0=;
        b=J3yZmrrV3Yq1gwNk+dVNMYetlczt9oMqD4SHb1amr3kSZc/XwoiwOLXQzlyY/MXsby
         /N+/ZcDG/Uqs0Tg+hSKcFaBbSKRNKHRUIcDKfSK21ozoIaRZ6WKb4mRL3+hCdG0/mQQH
         4LYxnz97NwzMaCMuj3qYgTgWjSBji06ocb/qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/NFEg+xGYEe7/uJwrQbwOpUOv1hOItyafkcLvnfAmT0=;
        b=byav1YlcDruS6oC2N8+CkpUytHhx66cniyBNrjWcyNUvMJEYWC3YntmapcMRy0c3KV
         PCSjEKn4jT0kjsuhlQXVptoGp7iE3eOWdLUktV8K6+y5hPjOulowEzZiuK+VYXqNWD0E
         UPxBaEvRrbnX0Z9CYEUe1NEwfgj3LtN7NmvkiDBGkV8e3KRAQlzv6qVJrIJxOSpAqQnl
         M0BM0hKQDDTXq7mNP+7b+8ep+vx/SeU2eNYnmB7MUNREE6xmtjHVSbppuF/Ngsx/PPRN
         gTSf6+cRX79SzhafKaIsOMK8SxG9oxjzFc49J/UXXUAFZE02478NsWCMSxfRjkpaDmZD
         joRQ==
X-Gm-Message-State: APjAAAU2TISEUff6PC/DnmjpEh+iSXoQ7Fmmx1yFTPsYDyoMfnOup3oX
        zvTYY+crbLs+yBQ9FWFVbc+LxQ==
X-Google-Smtp-Source: APXvYqyRZ6+r8SmVVFg3L/kcl5C/KHZlU9NEagz8JNIOMLLjgjEOWOnX/B92lp/J+hoQT9XmkDZg8w==
X-Received: by 2002:a17:90a:cb96:: with SMTP id a22mr5583966pju.96.1582907829843;
        Fri, 28 Feb 2020 08:37:09 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w25sm11402209pfi.106.2020.02.28.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:37:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200228124810.31543-1-rojay@codeaurora.org>
References: <20200228124810.31543-1-rojay@codeaurora.org>
Subject: Re: [PATCH V3] tty: serial: qcom_geni_serial: Support pin swapping
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, akashast@codeaurora.org,
        skakit@codeaurora.org, msavaliy@qti.qualcomm.com,
        Roja Rani Yarubandi <rojay@codeaurora.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        gregkh@linuxfoundation.org
Date:   Fri, 28 Feb 2020 08:37:07 -0800
Message-ID: <158290782779.4688.4351067333155148519@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Roja Rani Yarubandi (2020-02-28 04:48:10)
> Add capability to supoort RX-TX, CTS-RTS pins swap in HW.
>=20
> Configure UART_IO_MACRO_CTRL register accordingly if RX-TX pair
> or CTS-RTS pair or both pairs swapped.
>=20
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
