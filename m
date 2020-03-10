Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF3DC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 17:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D687720848
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 17:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvF34kAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCJRGs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:06:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41886 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCJRGs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 13:06:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14so3203791wrt.8
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=P1JlsGdIrii9z2/xXZq3cQrifP5ziLi7H3tjank6XCI=;
        b=HvF34kAWgx8MjQclZUsaPcgw0xPvzn3fN+AXL5syeIIzGNQlk1m46Whi46QC/UYCMs
         KTSds7D+j9zQqxg3QjO5VgbmXO9pWx1+u+wFgmRy4GNpcFr++zehnh009I9H6vmAHMIk
         5Tf0YAGejL5HrsuW0SXtEf5PWU6ZbsT5RUmKimTysHCts5rrqla7TUEYNWhBxiZFGSzQ
         n1UUuPIvHEgZWX4r4iUi31wK+nIX0XklAi1BAKcIBQzI9lmljAZ993DlUYJRl1pMyB0Q
         O/xo5Y7MEVz9jkpoz5Jjf+09zjA5RiPES/UrLh8CBqbPUslcvERdju5FkUJrvs/roswS
         hEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P1JlsGdIrii9z2/xXZq3cQrifP5ziLi7H3tjank6XCI=;
        b=DyoTjYhBFanIHqJBLTRP7dS9uhD/7G72RkzYzafqDW0fpL7GYXMDzSlWamyvgPjRPZ
         VwYbHE95eNec7ZfEQZMPhiF5pVI0yJSOKFk0cuN9IIlPdSHOCjdUtFXM0JdgWliHtuY8
         vDP5p08/cZ0ijpVExYeUfi7gKmY0cK10VQ8Ldcp7340Oo56lOEOYNT4XEhbpxSIZ73Hi
         +XHdbn/1GayTY7knE73WeqAxjfhxUq+2eCmIHUtbzJTENM34lgQKRpA/WSIfZle+Q68h
         lW+tHb462XnrcKmlehbhJijr58mELOxRGQk6zqgGKPccXF4WpRuv+Ibs1cHhHY9Pj03j
         K3YQ==
X-Gm-Message-State: ANhLgQ2np0iomnzOlhEAn3Vah2JIRyQngnXfx/ISmTxsG3dyM4UonIa6
        hsnE66x8uJb7fQiK7P2oUls=
X-Google-Smtp-Source: ADFU+vuQZekKEbXfljoIQpQ0qVahU9EK6EltjmD7mELCIVwTpMLbVcsLS9w7YXh/raNP1FjRYvE/1g==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr27314441wrq.424.1583860006289;
        Tue, 10 Mar 2020 10:06:46 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y189sm5075788wmb.26.2020.03.10.10.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 10:06:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] serial: core: Use string length for SysRq magic
 sequence
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <5bd29583-5a90-8abe-123f-17f5072bc6f4@gmail.com>
Date:   Tue, 10 Mar 2020 17:06:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/10/20 1:20 PM, Andy Shevchenko wrote:
> Compiler is not happy about using ARRAY_SIZE() in comparison to smaller type:
> 
>   CC      drivers/tty/serial/serial_core.o
> .../serial_core.c: In function ‘uart_try_toggle_sysrq’:
> .../serial_core.c:3222:24: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>  3222 |  if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
>       |                        ^
> 
> Looking at the code it appears that there is an additional weirdness,
> i.e. use ARRAY_SIZE() against simple string literal. Yes, the idea probably
> was to allow '\0' in the sequence, but it's impractical: kernel configuration
> won't accept it to begin with followed by a comment about '\0' before
> comparison in question.
> 
> Drop all these by switching to strlen() and convert code accordingly.
> 
> Fixes: 68af43173d3f ("serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks!

> ---
>  drivers/tty/serial/serial_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index aec98db45406..ec3b833e9f22 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3209,7 +3209,9 @@ static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
>   */
>  static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
>  {
> -	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
> +	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
> +
> +	if (!sysrq_toggle_seq_len)
>  		return false;
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= U8_MAX);
> @@ -3218,8 +3220,7 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
>  		return false;
>  	}
>  
> -	/* Without the last \0 */
> -	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
> +	if (++port->sysrq_seq < sysrq_toggle_seq_len) {
>  		port->sysrq = jiffies + SYSRQ_TIMEOUT;
>  		return true;
>  	}
> 

-- 
          Dima
