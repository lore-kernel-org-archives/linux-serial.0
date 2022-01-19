Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803EAC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 19 Jan 2022 22:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357543AbiASWhB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Jan 2022 17:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357529AbiASWhB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Jan 2022 17:37:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711B1C06161C
        for <linux-serial@vger.kernel.org>; Wed, 19 Jan 2022 14:37:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n11so3561437plf.4
        for <linux-serial@vger.kernel.org>; Wed, 19 Jan 2022 14:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dxE4r1z1cIfSGWJM621bK96VrUIyVV92x6PrrwpFRXY=;
        b=3jmCLS/O1Tvc4I9EcgW+vSU8+bHw3fiuSLb8QBBFgnjhcJ5TBVgWAsgBRkL3a3BYKD
         B38FGcRvYxRCPVi9I//mp1Op4BJClqNBzMkBUd6cytmd/QdYvSp7N0XjWzvC8oGGsiZP
         YIoTbzn7LIhb7DJlIo12jni+ncZcxIDEl1lNAtS8/IYRdIMQhyD1m6LD7ntzYNxIi4sn
         7yK8JltnuRpVwKYL85hmJpwtSbixKHx9L9ZLo7vnpI6W7mzH8+gTgQ9XuKzBg0btwiD4
         lqiBj8d7xmg1PSH6vq7/iRvjAhhGASBFqeIMA7g6mDLZ9NltVPocwZazaaUs043hvvCW
         OQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dxE4r1z1cIfSGWJM621bK96VrUIyVV92x6PrrwpFRXY=;
        b=jK84Qy4NxrIhpp73f+s4G+Kv7uOac9V88kxHjyB6vNw38B54Aef6+xTWv8BuQGPkPt
         k9FjkV8x7S/LsQrb6s24wGP3obIgDS6MVOrzRnpp+UMv6rtZz/L/++qwea5GY2xJlWg3
         vtfbIvo+KQgzMQFmnB35HLQhbzzep/1etbkvVSNxHC/ufKRVhL7V2GYcK3r84hJMQaSx
         2P+U0wBtHLIckClzMe+tL3LT6TbCDVZtLJlDlskWK6K9m00f7z/NOiPEWcjiRW76K88O
         yYHRNmb0fjAYMxdb0Cid3IBvviV5FSg9zLwJXq7vKI1eWdxz4W7HjCb79sYnFTYW+2T5
         uWjw==
X-Gm-Message-State: AOAM532rgcD52bUxpSBZRw78xbED8xUEW7ZktoqjnKlr5XzLCo7dR7/d
        CVYD4bxJe0fdrq6IeQmFYbxwrg==
X-Google-Smtp-Source: ABdhPJxv6F63q9VzJdxY0ckhpZZbC07AudfrnDivjIRxSeMR+ozHNzZi+g2TSfEoU169TmiRdyIcag==
X-Received: by 2002:a17:90a:6288:: with SMTP id d8mr6922737pjj.199.1642631820957;
        Wed, 19 Jan 2022 14:37:00 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id b9sm587995pfm.154.2022.01.19.14.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 14:37:00 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: Re: [PATCH V6 0/5] Use CCF to describe the UART baud rate clock
In-Reply-To: <20220118030911.12815-1-yu.tu@amlogic.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
Date:   Wed, 19 Jan 2022 14:37:00 -0800
Message-ID: <7hfspjqrn7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Yu Tu <yu.tu@amlogic.com> writes:

> Using the common Clock code to describe the UART baud rate
> clock makes it easier for the UART driver to be compatible
> with the baud rate requirements of the UART IP on different
> meson chips. Add Meson S4 SoC compatible.

Could you describe how this was tested and on which SoCs?  There seem to
be some changes in this series that might affect previous SoCs.

Thanks,

Kevin


