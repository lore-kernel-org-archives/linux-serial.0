Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB26AC00528
	for <linux-serial@archiver.kernel.org>; Tue,  1 Aug 2023 14:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjHAOEQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Aug 2023 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjHAOEO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Aug 2023 10:04:14 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2250E1B2
        for <linux-serial@vger.kernel.org>; Tue,  1 Aug 2023 07:04:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 925921014D9;
        Tue,  1 Aug 2023 13:46:27 +0000 (UTC)
Message-ID: <4914ace0-f99b-b37b-9f41-63195cfaec69@enpas.org>
Date:   Tue, 1 Aug 2023 22:46:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-3-jirislaby@kernel.org>
From:   Max Staudt <max@enpas.org>
In-Reply-To: <20230801062237.2687-3-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/1/23 15:22, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Max Staudt <max@enpas.org>

