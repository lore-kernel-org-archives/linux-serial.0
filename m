Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD59EC6FD1C
	for <linux-serial@archiver.kernel.org>; Fri, 24 Mar 2023 09:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCXJD4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Mar 2023 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjCXJDz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Mar 2023 05:03:55 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8DA3C3B
        for <linux-serial@vger.kernel.org>; Fri, 24 Mar 2023 02:03:53 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.35]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvJsF-1qWDxt1O1h-00rDzC; Fri, 24 Mar 2023 09:57:56 +0100
Message-ID: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
Date:   Fri, 24 Mar 2023 09:57:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Wahren <stefan.wahren@chargebyte.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: Regression: serial: imx: overrun errors on debug UART
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZEjzmc/onqBH6bcTalMaZKTG+xLG8wrB2968B2R5xruAGpYk+mW
 70HyPSvCr0eBujHYn8IbubEvrzMJPN4dq9c4RoXsUzA7WT6Dv7CmU/znAaF3XqPkCA3Ocl0
 0LoPGq/aaWTCqmMeSn6DvX3U/+pT31fuMS9RlIZYQK5jAXhRFC7mgYZsicqjNFHhlsFcGhk
 Yry8Lrjmbw+JC+KLvxtjA==
UI-OutboundReport: notjunk:1;M01:P0:WSlttC6mHVY=;9luLpjd9jqceH7mrTr2v0DQ+lCK
 uq2vhOsxJlVVabtw1t9c2d4kDIFfj3KE8vUUMETf212UQBvbZVvJgWDmIfNbsc0oztMN/jgnn
 wjQc2bM6RNfsARwuoqJuC58sx7Yn7MXzmXV4cnd8d9s47QxKIVbSsIfpI7UH43YPAPiBs5dBL
 h1mP5MUuuJB2yhg2W/MwbNvM8ehYVd4hS75g9rcMDSSmJp9dUZ/OHevWikJoOupU0seyCxt4p
 UbJvyC6uZIzSo8yXli23McsCMLYGdxNWuWwPtNziA45OBBRa/uj1fcHGZ/7egvhvJa+9d4l1O
 lbqV4LOh62bnt5gRs+WFqBMAAU4keHa7ys2P9K2cNfw4Byb5necMp7IoR40Z3lFJX+DvEpGdY
 WRyP3hEIVFIIC0XveyNd+WEhfkj8HLDpBeHO2LB7PuxYcisMaC8laeynfqi46gHuVk5Q9oFcO
 pfw3vUcr1+ilV3K+y7UsZGljDlLPzOGY6mNNixr2q4xkRirSQA7dWvOuBMgMLKJGeK6m9IUlD
 DD0Ioc4PZIjCXzC6I362EhMGS8yMklor8w2D/GL5NCLpA42MOzJ/yKv4SrnnEmQZStttuht9b
 B1MQTdKJROGLriHdumo5zQLf2EB3b1E5yTWai/B45LRuCa9jLEKMCZPpFzVGhrSn5DzA+vc5K
 F12ABx5xOltOI37SCqG9+aZDgh1zyqldMTkH2L8NQw==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

after switching to Linux 6.1.21 on our Tarragon board (i.MX6ULL SoC), we 
experience the following issues with the debug UART (115200 baud, 8N1, 
no hardware flow control):

- overrun errors if we paste in multiple text lines while system is idle
- no reaction to single key strokes while system is on higher load

After reverting 7a637784d517 ("serial: imx: reduce RX interrupt 
frequency") the issue disappear.

Maybe it's worth to mention that the Tarragon board uses two additional 
application UARTs with similiar baud rates (9600 - 115200 baud, no 
hardware flow control) for RS485 communication, but there are no overrun 
errors (with and without the mention change).

Best regards

