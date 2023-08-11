Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F35C0015E
	for <linux-serial@archiver.kernel.org>; Fri, 11 Aug 2023 21:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjHKVey (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjHKVex (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Aug 2023 17:34:53 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B0268C;
        Fri, 11 Aug 2023 14:34:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id BA634FFE0A;
        Fri, 11 Aug 2023 21:34:40 +0000 (UTC)
Message-ID: <b5d19734-1998-b8e1-9b3c-04d5d1f54fd9@enpas.org>
Date:   Sat, 12 Aug 2023 06:34:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Max Staudt <max@enpas.org>
Subject: Re: [PATCH 15/36] tty: make tty_ldisc_ops::*buf*() hooks operate on
 size_t
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-16-jirislaby@kernel.org>
Content-Language: en-US
In-Reply-To: <20230810091510.13006-16-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Acked-by: Max Staudt <max@enpas.org>

