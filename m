Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1AC432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5EC2067D
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wya+Ajkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKVSPP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:15:15 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:44996 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVSPP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 13:15:15 -0500
Received: by mail-pj1-f65.google.com with SMTP id w8so3343763pjh.11
        for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2019 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=TMr7GM6MiQaib+flq0fyGTNSa401iDEo8QOovoR9iUg=;
        b=Wya+AjkvGgSjdqFJh39IOuaWu4VELsZa1JC7H55xfBmwAneF+Bya5rj0w8VM9jqaTi
         AncOf6IQ5HbmHmxaAKZjoWPa1Zy7VInS2wnQD1HZOk0GEBW2s8Z9ISREJJKw9O6hA2aj
         WCsq6LsEiJh5DOPzXmLk5XOfbdZOUWVj73lXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=TMr7GM6MiQaib+flq0fyGTNSa401iDEo8QOovoR9iUg=;
        b=hQ/HPvxdKAD1huecLuWhIqv8wsnexUdn0MGszVyLcyMAe0xCOGQd0l/qYVq4pXW8vF
         CI3Py39q2CjKx+qdiHZfiJZ5aFFSwwpIf6CeiRsbC+vRoHkDwZR5vNTGgf1GJ1y0jPuz
         Lsv/ZSDEtdS+ggFJzfsY0T2TCCCyCCtO0jnFxmcN2kDzpwv1NYPz7G1hcAHRWSiysg/x
         V9Swq+8lW5RQzB+DHRWFBG72afuQc+jPirq0uutUsTFOWjzjSzvjr12rJmBDy6JglqHc
         8XWYIhSE6yEHpYEiW7O097eFXFz2dEFx2IniLXAt0vVnJFigvo7UuScoSLT9poywfuD3
         2Ncg==
X-Gm-Message-State: APjAAAWoTS0KFevLMUTe1yUhxgnc1Oh6xsx49ivH1t9dv7kVehfnwYLz
        WTatOiVGfmendR0uUGHnxJEJT4PFrQQ=
X-Google-Smtp-Source: APXvYqxkrkIDAnLzjLnMbBshTx2QjwEEdW7rVvguaPV9+kE9H5LoHtm3gqFd/7tORsAelZ6jEzwloA==
X-Received: by 2002:a17:902:758e:: with SMTP id j14mr15843556pll.254.1574446514188;
        Fri, 22 Nov 2019 10:15:14 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z6sm3940792pjd.9.2019.11.22.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 10:15:13 -0800 (PST)
Message-ID: <5dd825b1.1c69fb81.95fd6.9bc6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016e937a3f78-11fa1469-8c73-4f56-a3de-3221dcf6f0e3-000000@us-west-2.amazonses.com>
References: <1574432266-20732-1-git-send-email-akashast@codeaurora.org> <0101016e937a3f78-11fa1469-8c73-4f56-a3de-3221dcf6f0e3-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH v6 3/5] tty: serial: qcom_geni_serial: IRQ cleanup
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Akash Asthana <akashast@codeaurora.org>
To:     Akash Asthana <akashast@codeaurora.org>, gregkh@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Fri, 22 Nov 2019 10:15:12 -0800
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Akash Asthana (2019-11-22 06:18:12)
> Move ISR registration from startup to probe function to avoid registering
> it everytime when the port open is called for driver.
>=20
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

