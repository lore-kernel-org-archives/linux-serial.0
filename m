Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9A3C07E9E
	for <linux-serial@archiver.kernel.org>; Mon, 12 Jul 2021 06:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9939610F7
	for <linux-serial@archiver.kernel.org>; Mon, 12 Jul 2021 06:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhGLGUQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Jul 2021 02:20:16 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:35651 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhGLGTs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Jul 2021 02:19:48 -0400
Received: by mail-ej1-f44.google.com with SMTP id gn32so32412879ejc.2;
        Sun, 11 Jul 2021 23:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7N3COHVanOoq2NqDALRISOxelpiFVKDsdjBIXAkabCI=;
        b=OAo/3RVfUAnbWkPURwCcEjs2YF8/+SxGNKULxzad0FpD2fd3DjTPfoF+Xn361aCB2w
         5W060tDF0l9nNZVojpnI4kGq5kuzxngLpNEXBM5DIrsCtKOzEbwqSNVd4oRPUR3owJ3V
         mwIJ0mX+kLX9oDfVXblBSiu7X6jdlDNLiyhHv5sSZoBbMrkR8lfa4a9i2BFjd59bf/tF
         6e313DhlQbXqhHzGMemvVSsRGKQeIZ2ZH+LpKVMAVBcxybDbQISbppJDzUWBKwjCOzeX
         1GLJlTRT+eoLGPtjHGLmVIuVh//F9XvwN7/kzidjROwCrJW7sqbLCRzidQnE+FvxnwpA
         PUWw==
X-Gm-Message-State: AOAM530A/ewRxHshkchKxtAnesnVHFDj9XA+qjo3zqwlitr7nH1ZdjBG
        Eyj6Ii9a01Tvtl6b7Bzkl6czGb+gQ+jIPQ==
X-Google-Smtp-Source: ABdhPJwogpbLDNWeijXHKxO8znPZm1ZbJ2A0BBQN27+YhZ6AhhuTnmzbJzL03GX4M02ygocQ7E4pjw==
X-Received: by 2002:a17:907:70c6:: with SMTP id yk6mr22255241ejb.42.1626070619226;
        Sun, 11 Jul 2021 23:16:59 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id y17sm5759163ejd.16.2021.07.11.23.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 23:16:58 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: jsm: hold port lock when reporting modem
 line changes
To:     Zheyu Ma <zheyuma97@gmail.com>, gregkh@linuxfoundation.org,
        rclemsmith@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1625925959-11086-1-git-send-email-zheyuma97@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <014b511a-0542-d85d-e1dc-943e5463da17@kernel.org>
Date:   Mon, 12 Jul 2021 08:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1625925959-11086-1-git-send-email-zheyuma97@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10. 07. 21, 16:05, Zheyu Ma wrote:
> uart_handle_dcd_change() requires a port lock to be held and will emit a
> warning when lockdep is enabled.

Please attach an excerpt from the warning to the commit log.

> Held corresponding lock to fix warnings.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   drivers/tty/serial/jsm/jsm_neo.c | 2 ++
>   drivers/tty/serial/jsm/jsm_tty.c | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> index bf0e2a4cb0ce..c6f927a76c3b 100644
> --- a/drivers/tty/serial/jsm/jsm_neo.c
> +++ b/drivers/tty/serial/jsm/jsm_neo.c
> @@ -815,7 +815,9 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
>   		/* Parse any modem signal changes */
>   		jsm_dbg(INTR, &ch->ch_bd->pci_dev,
>   			"MOD_STAT: sending to parse_modem_sigs\n");
> +		spin_lock_irqsave(&ch->uart_port.lock, lock_flags);
>   		neo_parse_modem(ch, readb(&ch->ch_neo_uart->msr));
> +		spin_unlock_irqrestore(&ch->uart_port.lock, lock_flags);
>   	}
>   }
>   
> diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
> index 8e42a7682c63..d74cbbbf33c6 100644
> --- a/drivers/tty/serial/jsm/jsm_tty.c
> +++ b/drivers/tty/serial/jsm/jsm_tty.c
> @@ -187,6 +187,7 @@ static void jsm_tty_break(struct uart_port *port, int break_state)
>   
>   static int jsm_tty_open(struct uart_port *port)
>   {
> +	unsigned long lock_flags;
>   	struct jsm_board *brd;
>   	struct jsm_channel *channel =
>   		container_of(port, struct jsm_channel, uart_port);
> @@ -240,6 +241,7 @@ static int jsm_tty_open(struct uart_port *port)
>   	channel->ch_cached_lsr = 0;
>   	channel->ch_stops_sent = 0;
>   
> +	spin_lock_irqsave(&port->lock, lock_flags);
>   	termios = &port->state->port.tty->termios;
>   	channel->ch_c_cflag	= termios->c_cflag;
>   	channel->ch_c_iflag	= termios->c_iflag;
> @@ -259,6 +261,7 @@ static int jsm_tty_open(struct uart_port *port)
>   	jsm_carrier(channel);
>   
>   	channel->ch_open_count++;
> +	spin_unlock_irqrestore(&port->lock, lock_flags);
>   
>   	jsm_dbg(OPEN, &channel->ch_bd->pci_dev, "finish\n");
>   	return 0;
> 


-- 
js
suse labs
