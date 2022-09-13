Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629C4ECAAD8
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 16:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiIMQTX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 12:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiIMQSv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 12:18:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EF112E
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 08:14:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h8so14326267wrf.3
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jamieiles.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=PSryuLt8d2S5NOnFQYaRkPd+ewmY9YOJjJlVlykIIBw=;
        b=PL6KQK4WAvTjNL4+2racF+mN5DenWrVgvTfKHYOm+TdmcOdBXajJDYGu389LYMga76
         oUHxjWLeSy9pbqbs2NWCLbFwPpAHiVTXhrc7QPnxKyrDCjUyqL35opweViGReRMLNghi
         Bw+KX6HO1tj+6pGtABPL2WSs7vcJaJ5qWQbQU2xeGWHyAh7PIxvR+zlDuuZzT8W3+srE
         hdboMRmbejnhTl8Nl6xaQsK3sWD2coMQIkTLhV6pGOgxuzJOoJ1v7luzQZSpvE6cT8DT
         gXMklK1wStxJaSEE95t3niygm91XlGX6v5/n0WFrglI0LZZnC3voDzTUaFlGqjPIVS8e
         twBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PSryuLt8d2S5NOnFQYaRkPd+ewmY9YOJjJlVlykIIBw=;
        b=QsPK/2Bya96tDhsKvezNkNKcjeraTnoZ06wBGV5S3qZcpn+cNvxpt7qkGLvxUec5C8
         Twm9tefmptczej0DYUR77n9gz6X0FNNyDzI8NFj2VryAneVsZ2ZXEs3wSIo0F/W7NOAa
         pGTgABeMiad8/3o/pqGeM0KJCP9UuALUdAFc+Dy27EZpa42DxAlKfP4YaYQFUX0vHhde
         hlSpo5sCdrWrYlQ/naQazjLAv5cM0J1aaRRwgYIS9aAUIJ65r2a+rmy/WbX1yKhhKXuo
         wrFjqPukl7dhf8/T4ap5rMmo5q8IBDToU22jceSOiMnWkQWIQldc6tMSSc6ODvTqhAFN
         fxPg==
X-Gm-Message-State: ACgBeo1wCddecJASORNSOZcrTnECgA6d6u+JqjIf4eN30mFOvUPt6tgb
        X5Ls3lBZ8J8uQsW0xmSa/PgDoBizCovqIJqS
X-Google-Smtp-Source: AA6agR4xan9LcIemBd+CCIzPWBfolAoJH5FobI9T3VFcNGbSV5nwx/8YASJdkNc6pzosk4RDb4XfCw==
X-Received: by 2002:adf:e10c:0:b0:225:3168:c261 with SMTP id t12-20020adfe10c000000b002253168c261mr18279435wrz.159.1663079845811;
        Tue, 13 Sep 2022 07:37:25 -0700 (PDT)
Received: from localhost ([5.181.106.148])
        by smtp.gmail.com with ESMTPSA id e11-20020adffd0b000000b00228da845d4dsm10633337wrr.94.2022.09.13.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:37:24 -0700 (PDT)
Date:   Tue, 13 Sep 2022 15:37:23 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, kishon@ti.com, vkoul@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        zhangqing@rock-chips.com, jamie@jamieiles.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 01/11] dt-bindings: serial: rockchip: add
 rockchip,rk3128-uart
Message-ID: <YyCVo/kHpWTbGpvx@elm>
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <4f283231-2ed4-202b-0c23-157bce0841ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f283231-2ed4-202b-0c23-157bce0841ee@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Sep 10, 2022 at 12:01:28AM +0200, Johan Jonker wrote:
> Add rockchip,rk3128-uart compatible string.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Acked-by: Jamie Iles <jamie@jamieiles.com>
