Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3766C3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 12:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBA521D56
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 12:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oez3uqjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBSMZx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:25:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40994 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgBSMZx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 07:25:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so17269291lfp.8;
        Wed, 19 Feb 2020 04:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vym7cnw2UswPy4mXXSErcySNdTESMC8KufR8ycUGU5w=;
        b=oez3uqjO4V62x8YIYF5vSrd4T0ApecZAop66yE0oWlbRoOBzXF14svDpFD/Ng2lwwh
         MCkn1LskfRITwXoyRp0xOmwHk67ybaAX4EciOuyLfZGtHWFWI9bjcJmRUxZRCeNltUtI
         5002JRuke/Egc6Lp8iyOvY9JiSvbiuEdHqpyVfEF/WsPcfn4ClYnIZtUpyRO35QkyiGu
         f7xtL1pRRS+lqqShdssORi9j3o3WiJExuAoe5pWnl++josbuHO3HzwcpIP1NDkV6aaxH
         2+mbI6l985QaghxEZZgLMN5bsB/fAuh8pRSj4ATC6llE7H4pbDDy4QaVswKus/ta6d4A
         vE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vym7cnw2UswPy4mXXSErcySNdTESMC8KufR8ycUGU5w=;
        b=hr3VgRbzK5OdJ87WDDe8ilLlbq2LUEPDkllwrR5X5OYIjsYYQq+Xh7cheKDGiN3NBr
         lIrZ2TnUVnIfQ0MCmlbA/pdeHgBEo+9iRGwKlDGMdjW1aDNs0QS0w2Uyjz2DFSunEcHG
         sHXtZoGARCkk+vChtAbusGxsF3dCW0laCijH6W5R93MaR1F91Xn6XDTDyurtTZi7vv+D
         TtJHYVDfYCnj6+zJuv8A2A0D5hqfGihKsTWJJo+xJcQYLN7BYKiRGEGC4tSnjaO0aM8z
         Dt9LW1K3ekTOD3fFsvphiChBL57KfZnyTAvHn4KoXquYut2VswUPjsTvtoP03YtKyT22
         oCgQ==
X-Gm-Message-State: APjAAAU5dW+/iEjvfJMO2n0oc7yhHOMqmL3JcGCUJ25umX07ycURO0tM
        /UJSxQySyzo1ICN0if/A+/CIfmWZ
X-Google-Smtp-Source: APXvYqwOXJJ7XlulCRTxrAdarKdKzkJYyE1YSvY/srBtjmnhMW4P80vG9t1erIHkDK0fASgisa/SAA==
X-Received: by 2002:a05:6512:407:: with SMTP id u7mr12956722lfk.146.1582115150261;
        Wed, 19 Feb 2020 04:25:50 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a9sm1236930lfk.23.2020.02.19.04.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 04:25:49 -0800 (PST)
Subject: Re: [PATCH for 5.6 v2] tty: serial: tegra: Handle RX transfer in PIO
 mode if DMA wasn't started
To:     Jiri Slaby <jslaby@suse.cz>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200209164415.9632-1-digetx@gmail.com>
 <15b01f79-007d-09bb-03be-050c009ceff6@suse.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4d9a2352-6daa-4dcc-376b-175b1398ff6a@gmail.com>
Date:   Wed, 19 Feb 2020 15:25:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <15b01f79-007d-09bb-03be-050c009ceff6@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

17.02.2020 10:37, Jiri Slaby пишет:
> On 09. 02. 20, 17:44, Dmitry Osipenko wrote:
>> It is possible to get an instant RX timeout or end-of-transfer interrupt
>> before RX DMA was started, if transaction is less than 16 bytes. Transfer
>> should be handled in PIO mode in this case because DMA can't handle it.
>> This patch brings back the original behaviour of the driver that was
>> changed by accident by a previous commit, it fixes occasional Bluetooth HW
>> initialization failures which I started to notice recently.
>>
>> Fixes: d5e3fadb7012 ("tty: serial: tegra: Activate RX DMA transfer by request")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v2: - Corrected commit's title by adding the accidentally missed "tegra: "
>>       to the prefix.
>>
>>  drivers/tty/serial/serial-tegra.c | 35 ++++++++++++++-----------------
>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
>> index 33034b852a51..8de8bac9c6c7 100644
>> --- a/drivers/tty/serial/serial-tegra.c
>> +++ b/drivers/tty/serial/serial-tegra.c
>> @@ -692,11 +692,22 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
>>  				   count, DMA_TO_DEVICE);
>>  }
>>  
>> +static void do_handle_rx_pio(struct tegra_uart_port *tup)
>> +{
>> +	struct tty_struct *tty = tty_port_tty_get(&tup->uport.state->port);
>> +	struct tty_port *port = &tup->uport.state->port;
>> +
>> +	tegra_uart_handle_rx_pio(tup, port);
>> +	if (tty) {
> 
> What's the tty good for here, actually?
> 
>> +		tty_flip_buffer_push(port);
>> +		tty_kref_put(tty);
>> +	}
>> +}

I'm not really a TTY expert..

Jon, maybe you have any clue whether TTY could disappear while port is
opened?

