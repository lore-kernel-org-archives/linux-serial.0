Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2D8C10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E1A2146E
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 14:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHOIYTND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgCJOs5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:48:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37281 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJOs5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 10:48:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id 6so16256210wre.4
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QAzF/c92TNrQIznQQivQ+E0DmFiwBiewfoGCSBRPB2o=;
        b=mHOIYTNDqzWXMQR+NcS2ZzmW6zR/ZS/O+Afxv3n1K68d+5WS4GxD+/ATMzSiOV1vkq
         zCMR/ZA6WRjVkGA0172h266XcWT4VufPAcfDaTS3iA1/c4PVS4jk/64LpAy3pAJBv2Kx
         mtCykZAYRYh1W6d84JbpQZYXZA1xzF9MQSRigXV4TOPFWbmyDcQtkMh0J9TqmOr+Do/I
         AcLjZgI8Cy4LFEllhy1OzpM6IW5e+1xUJ02stOax0ES7uvuwaPkIGKUX7AsCnHv9mhfC
         9ivHM8DPC0L9eIwbwmxA/QwML++ZugRLgOCzzIxz44jMNinKm0mVOUoMkd0VwiV69Q2+
         B2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QAzF/c92TNrQIznQQivQ+E0DmFiwBiewfoGCSBRPB2o=;
        b=fSi2CoNaqIF/rKNdKNAld2woZ2s1ry5djl+aEj7R0lQ+ttKvfP8d1q9bxCb+M1GMwF
         sT/FDFaTejOxJtuGPQQBiLG81sjeZPormQQfSEJET0lyLQATLZSSkMyCj711VJtoVEWA
         RaQXb2IDay8dgZcNtFkpWlSFDTSLyk693dzWDtAEreFgOJxpG9xfOhXeq7O4cYbTm/77
         3VhGNoGV75qL/jPTq/u9ji6aAPLPCmWwoAAvZxw9WkLnU6hlp7tikh84P1mUbdd+a946
         RG8z3AJtmMgNJc2+9gUapnn2I9MwAky8XNDcTA8iwPtrzumQ2+Ko0IudHlimoYrrVdib
         oIBg==
X-Gm-Message-State: ANhLgQ1pZ94h3aIYKdNFT9Tboqj+LZM73eQxhBxkef2ZsziytYfEOQzp
        6knsM2DqkuZpYkT0jv0nCEo=
X-Google-Smtp-Source: ADFU+vvQnP/2pzmvFSo8fdyAmebWNGJhN+c32ensOkTEJi9OlUQjmYlis4Sp7PfrjlalEnOp1lo4oQ==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr28408617wrv.308.1583851733380;
        Tue, 10 Mar 2020 07:48:53 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 98sm5073277wrm.64.2020.03.10.07.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 07:48:52 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] serial: core: Refactor
 uart_unlock_and_check_sysrq()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
 <20200310132004.86367-4-andriy.shevchenko@linux.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <4f6ca0d6-f1dc-5757-2ce7-b2b4f64f10aa@gmail.com>
Date:   Tue, 10 Mar 2020 14:48:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200310132004.86367-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/10/20 1:20 PM, Andy Shevchenko wrote:
[..]
> @@ -3286,22 +3286,20 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
>  }
>  EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
>  
> -void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
> +void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags)
> +__releases(&port->lock)
>  {
>  	int sysrq_ch;

Probably, you could move it inside the condition it's used.
Though, I wonder why you decided to rearrange the code.
Otherwise, LGTM.

>  
> -	if (!port->has_sysrq) {
> -		spin_unlock_irqrestore(&port->lock, irqflags);
> -		return;
> +	if (port->has_sysrq) {
> +		sysrq_ch = port->sysrq_ch;
> +		port->sysrq_ch = 0;
> +		spin_unlock_irqrestore(&port->lock, flags);
> +		if (sysrq_ch)
> +			handle_sysrq(sysrq_ch);
> +	} else {
> +		spin_unlock_irqrestore(&port->lock, flags);
>  	}
> -
> -	sysrq_ch = port->sysrq_ch;
> -	port->sysrq_ch = 0;
> -
> -	spin_unlock_irqrestore(&port->lock, irqflags);
> -
> -	if (sysrq_ch)
> -		handle_sysrq(sysrq_ch);
>  }
>  EXPORT_SYMBOL_GPL(uart_unlock_and_check_sysrq);

Thanks,
          Dmitry
