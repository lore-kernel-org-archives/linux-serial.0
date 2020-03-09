Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23843C3F2C6
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20AD20727
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 06:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZlPvOTfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgCIGlu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 02:41:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46356 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIGlu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 02:41:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id y30so4242879pga.13
        for <linux-serial@vger.kernel.org>; Sun, 08 Mar 2020 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=RrX9EtA3zn4u15vVccJeX3aDhJuOUHVdQao27RU5nys=;
        b=ZlPvOTfYg8ORIBsXty84bD0rRJ/90K8uIO/uB/zt/ADLmUgqnZSsvJa7qD5c12Wnmi
         twF97bZmvCFfxUcO6sEehkFpu0ixFanK2imweMwyQbM+gjb3XtggIwWiX35PVRGvz/nA
         a5/oOPSK9KvI4Bkc5tDFy9cfr1VFsoh2VFnyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=RrX9EtA3zn4u15vVccJeX3aDhJuOUHVdQao27RU5nys=;
        b=XmrhTq23qWRnwL81JZlr+b3X7safaoRuKZjQqrTsNLLUJUcum2k4TbEGhYFvcnNjr0
         k5h6mlWvQXj2lgdkleNZRQXfgK0nDbCUlb5vyY1tgq6tWypgUji6QgBkOv+JvyWMnWQA
         gEshLg9edKhL8Rb4pydRuONHQygo7LAovdUu5VvXLnWVHnf3x6K0a5kRA8iFGZrborVx
         AsxKbQ31bl7dyy6j1Cr0BjWKeU+kouZ1uaj0ePh9QdgSR7WWfEZD3BVygE4DV98PDthP
         jPq/YvFMxJ0GQsghtor7eBu5WjUW+EbPV0Oomm+cnQXJ+946eI+QB0Msg83yM9B6ng1j
         ui5g==
X-Gm-Message-State: ANhLgQ20smqO7y2le54jRHGyESJEcxlX1T8jfhYy/yVXoNxYn1oYp/fm
        HPMh5GJKP3PNjjgaCGX4pF1tLw==
X-Google-Smtp-Source: ADFU+vuFj92YnT2uVcGJAjBivqhd2E2e1bNOkvmP+cAyeV4G04fBNTjyHqM1P5aYSHvLJ2i/lJqlkA==
X-Received: by 2002:a63:f311:: with SMTP id l17mr15183521pgh.142.1583736107615;
        Sun, 08 Mar 2020 23:41:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id nh4sm3207636pjb.39.2020.03.08.23.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 23:41:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583477228-32231-3-git-send-email-skakit@codeaurora.org>
References: <1583477228-32231-1-git-send-email-skakit@codeaurora.org> <1583477228-32231-3-git-send-email-skakit@codeaurora.org>
Subject: Re: [PATCH V3 2/2] tty: serial: qcom_geni_serial: Fix RX cancel command failure
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com,
        satya priya <skakit@codeaurora.org>
To:     gregkh@linuxfoundation.org, satya priya <skakit@codeaurora.org>
Date:   Sun, 08 Mar 2020 23:41:45 -0700
Message-ID: <158373610593.66766.7767101522459278381@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting satya priya (2020-03-05 22:47:08)
> RX cancel command fails when BT is switched on and off multiple times.
>=20
> To handle this, poll for the cancel bit in SE_GENI_S_IRQ_STATUS register
> instead of SE_GENI_S_CMD_CTRL_REG.
>=20
> As per the HPG update, handle the RX last bit after cancel command
> and flush out the RX FIFO buffer.
>=20
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
