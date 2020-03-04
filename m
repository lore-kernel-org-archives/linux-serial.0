Return-Path: <SRS0=+90y=4V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF6AC3F2D1
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93E920637
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 16:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IN7purPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgCDQrN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:47:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32892 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgCDQrN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Mar 2020 11:47:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so1248119pfn.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Mar 2020 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=570LeX+h0QI/CfDWXttZgUJ8HCBiGXke7deYDlYUr4Y=;
        b=IN7purPgQ8N64rGTHVjT4ja2mH4kYQM27CjHKxyZkxZiRf0brOCjyUY862YeXhv9Xv
         CeFbSlnkumXNoKAEtA+NRez0L26WHQnbhuFJXs5OWKWch1komOl+pp0LPkhDaS90VcEQ
         vz3px3xKVCInINF88z4OBfS0U1+UcswXskS20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=570LeX+h0QI/CfDWXttZgUJ8HCBiGXke7deYDlYUr4Y=;
        b=QKyVlC4WUAAOfDXX1uI+SQCGM6n+IQlgIcg4A0uKAPfY8kQ9GI0Q2Kd4KdDaB50y9T
         Cs1F9dpanwpMmCldg5JHJ/mu+NGoZTyuUJR+4S8Bify/EwKwsePLUAGokFWpdHxlissY
         3+z9RiiwthpTz7NtoIg4fyK08Oy9tsXbfd3L7Bj6elTKZi125Xr8rMfxqn7A/oXapcP+
         E/5DwE81u/1TK5wyyKz4kIUU+KIVTHI7Gp469jcaXi7Z0VXa3lVcfjdHwEwfb1eFI+MS
         l2kznBN0C/vBZBbRkj7U8wKX1qBaPf7C4/HNedvcJDoaPdu0niOCjwQoiHCMnFsyFd/e
         T3Kg==
X-Gm-Message-State: ANhLgQ2NwYU0RyO+V5p00kDDmBkVGxwb90GrKUAdaL2RW8FKmzc4izYy
        cmk3ZhG1Xy++BrPkpTH/BYL9Nw==
X-Google-Smtp-Source: ADFU+vsbsy4KwjftRfu3c64Y4ez2ZG6ys4FKlLIkAg1gF0reXC73oRO0et0606w6YB7a5GpAJygtOQ==
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr3439813pgm.28.1583340432484;
        Wed, 04 Mar 2020 08:47:12 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i6sm3218494pjt.3.2020.03.04.08.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:47:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200304112203.408-1-rojay@codeaurora.org>
References: <20200304112203.408-1-rojay@codeaurora.org>
Subject: Re: [PATCH V4] tty: serial: qcom_geni_serial: Fix GPIO swapping with workaround
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
To:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        gregkh@linuxfoundation.org
Date:   Wed, 04 Mar 2020 08:47:11 -0800
Message-ID: <158334043115.7173.15372150537228946372@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Roja Rani Yarubandi (2020-03-04 03:22:03)
> Add capability to support RX-TX, CTS-RTS pins swap in HW.
>=20
> Configure UART_IO_MACRO_CTRL register accordingly if RX-TX pair
> or CTS-RTS pair or both pairs swapped.
>=20
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
