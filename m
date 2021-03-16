Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0B3C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 00:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E726C64F6C
	for <linux-serial@archiver.kernel.org>; Tue, 16 Mar 2021 00:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCPA11 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhCPA1A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 20:27:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5838BC06174A
        for <linux-serial@vger.kernel.org>; Mon, 15 Mar 2021 17:27:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 30so11564374ple.4
        for <linux-serial@vger.kernel.org>; Mon, 15 Mar 2021 17:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rZUYFJv5Y/9QIzNACfb+ndYMjACnAQceRVQGoMosV8E=;
        b=OBkNlRb6xN2ayKnNDcsEKLQ2gG31LmzeJ53uREMYQRPjArgckrti2329xjYJSuzwm6
         EXBtiaCXIiqM7X8gBMEtZHXBEQsFC7TZ9hMY4hAvLArEqEFQcZWDKPV/OtFa/x6I8uGs
         Wf2h74dXSXFFJ8Sz8u5Mnrdu/ZOdFEG6OVpbdQiNJ5edGJnJkuxycMFkN8FMINZzRRTU
         fBYgnh1oE1DYRiQYC7ysJ2+Ik7SzxK0nsZEPDKofmyAOyVEAHY5qAi5gyUjUbwwY4Oci
         LP0o81Lk1Rh6Tid+Ugt5JPPck2VD7iFJ4S7FgULsC9zKdZ9l+JoHYzPkyCpEcGl1M2Y7
         IvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rZUYFJv5Y/9QIzNACfb+ndYMjACnAQceRVQGoMosV8E=;
        b=OhepfAOKLj+aHEjoFjN1OYq1TBYhoWnHIDsCsKRPSSIchCn+sRXzJA9yw7/4hfYIy4
         IwV4xXniisWx9qJVo6kCiMw61g7U0JXooAmkwbo7TkbRljKuz1dLZrPQNlbyILah34Jk
         HYJyKtkjPOhZvBnX9+R26Co/hXWgiK+Dw4dicxDM2nsNaM3YYhbdS0oxnotIn8BpzKWe
         SSK4ERSkYNFHwbmGCIDzIEMhh/MQ8TwwldU+4oRm6i4PPgRuOVK++ZfJB3oPw5yvjgVG
         KQmO/iElPO/+tiH3iYwFwguGRFZRpGDSCV8j923nsScbTLOBpie2LUrOUAOtL5pNP0bZ
         iSqQ==
X-Gm-Message-State: AOAM533gaAqDw2yCHhuU+onaTYXBv5+x3qSprybQotHv5flcBLpbaN9C
        984lNJ8FnIxg7a+iU0sm6vQoQA==
X-Google-Smtp-Source: ABdhPJz4b0lMXsFarjs4hvv7b56QCJbNwlB5BQ3EhjhfU5mMZX5sesLrrn5nUl1ecUAXszvidaqo3A==
X-Received: by 2002:a17:902:b78a:b029:e4:8ce6:fb64 with SMTP id e10-20020a170902b78ab02900e48ce6fb64mr14231808pls.77.1615854419519;
        Mon, 15 Mar 2021 17:26:59 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id p184sm14663118pgp.13.2021.03.15.17.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:26:58 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/3] tty: serial: meson: retrieve port FIFO size from DT
In-Reply-To: <20210315083459.359773-3-narmstrong@baylibre.com>
References: <20210315083459.359773-1-narmstrong@baylibre.com>
 <20210315083459.359773-3-narmstrong@baylibre.com>
Date:   Mon, 15 Mar 2021 17:26:58 -0700
Message-ID: <7hv99seyel.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Now the DT bindings has a property to get the FIFO size for a particular port,
> retrieve it and use to setup the FIFO interrupts threshold.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
