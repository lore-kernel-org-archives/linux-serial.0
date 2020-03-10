Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E167C10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 14:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E3E20848
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 14:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teUQIA/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCJOi5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:38:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36462 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgCJOi4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 10:38:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id s5so12284847wrg.3
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RDy2qwNxAxE4yo+BK6mK/wFumMMg9KNpJsJzEedT5Zg=;
        b=teUQIA/djMx71fiTaGzIZQaPsTTDk8GDMLOOIaa50I8iKt4+cMmawQR/zvMtri3gii
         JfMVYYfGXM/KHC7/AZU/Voc4U7ivHZMQ4YTQiSsy4kG6y4xzh9Ft1I/dDeHmlD8NIyQy
         wYzH/hc/8nu4QZ7Lq54roxo5AsHtVl7sFvTHfo0zPLhNmAyy8DbO1+STQ8z9UYh6Vn3p
         PqOf0yk+/eiMLnd9wAFPKQXmm/IMyzOwIz12/AVmu5fOdZRL0jsmEXaHYFHMaCZDuqE4
         yrxr1/1SDO3/n6USLlK7op+ZkKlqPmyoPGjMv5+9aZqDKocsDq4xx/BuKE/8uT8anhz0
         PM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDy2qwNxAxE4yo+BK6mK/wFumMMg9KNpJsJzEedT5Zg=;
        b=CKUTgZX+XHqb1OnKaFx8mXaFzIOpI1VgFgyyHOpdV2Z1vMlgSb1LhLRruEU08mOQNP
         7INyV+jAYvy1D4Ogrn1fAiBegtkjB71Mc62qXOxupRPo+WfXCjKZjHYlyvfeaupZe4MZ
         5CtUC1IDarJspGAKfLjnXFs7vzFa22trNIMKAY/gtT+u7yf4A34rdj0k5dHW5WctSeN+
         LrQ/T73Qzft9Gkb7z6AMWZGYbHhOQevo0RCqKA8j3NVBe4hcFRjf3lMQhQlmoWJCxcee
         PNkSFVz03LqPOn04cAbHWa/URi/S6WW0TLh0y2M8DZoH+PdMZ7anLYS1cnM/1nR9zvWE
         l4Hg==
X-Gm-Message-State: ANhLgQ2ydzDVUumRNppv0me0mCQCl2ISmVx6c8J/k1b6hcU0eD89HGwh
        Qa0ACwqV6JcES7myxvJDVV9UQFN5
X-Google-Smtp-Source: ADFU+vtu0Eq93FPQx6G6Y2uEZkSbPYOuSbYMTTMJuxZtDK7krdXTX6wrZ1A/QtwuQhi81/kmR89c/w==
X-Received: by 2002:a5d:4e8b:: with SMTP id e11mr26444665wru.136.1583851134738;
        Tue, 10 Mar 2020 07:38:54 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w4sm15129339wrl.12.2020.03.10.07.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 07:38:54 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] serial: core: Use string length for SysRq magic
 sequence
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <64f650b7-8c39-4bef-f1d9-ff2720923c8c@gmail.com>
Date:   Tue, 10 Mar 2020 14:38:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

thanks for the patch,

On 3/10/20 1:20 PM, Andy Shevchenko wrote:
[..]> @@ -3209,7 +3209,9 @@ static DECLARE_WORK(sysrq_enable_work,
uart_sysrq_on);
>   */
>  static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
>  {
> -	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
> +	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
> +
> +	if (!sysrq_toggle_seq_len)
>  		return false;

Eh, I wanted to avoid the strlen() call in runtime for every time sysrq
is pressed. It's not very frequent moment surely, but..

Could you try

: int sysrq_toggle_seq_len = ARRAY_SIZE(sysrq_toggle_seq);
:
: if (sysrq_toggle_seq_len <= 1)
:     return false;
: /* ... */
: port->sysrq_seq++;
: if (port->sysrq_seq + 1 < sysrq_toggle_seq_len) {

if this will shut the warning instead?
BTW, is this gcc 10 you see the warning with?
I have gcc (GCC) 9.2.0 and I don't see a warning with/without the config
string.

Thanks,
          Dmitry
