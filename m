Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204C7C2BABC
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 06:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AAA20730
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 06:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586240822;
	bh=BTYWetTUiQk9SfcfoL7YS7jNUZgKoItq1aX4zUJ8kd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XtZLqOC/y/9CBdM8lGZKzfx4SYg8vjwQH9jL8yYBwsKVM/6Q9dqLWeVEt+eMTvRWw
	 wJopTvm8h742F8vS3BAkvdQlObGd08Q9knEGzUuI8sWSVYHFIioob/s2YoNzmsk6ix
	 lG5rAH64N8itK1fW7AD3bj6bxf5CPl4+Sfdd5gSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgDGG1B (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:27:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36072 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGG1B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 02:27:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id i7so2638620edq.3;
        Mon, 06 Apr 2020 23:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjsbhZ/jJSHwlg183aq1g5KLg6FSzbMim//7rih2R08=;
        b=UnNrN7R0eOzvKfYLld50t3EHkF8FljGvOuFr6yCI9jarThWWqTaeX60es/HqXkPlcE
         C0jlwNs5S/JYdzI263InNLCphqPwaOOJkNv+lJF6lCK7BRwnX/+AKqMcOZQLEp3KP2T3
         ywtkEX6h7uqslHXCWgKmUT/rdI3+U3alJKSJw4hQBu9Kyb+tr3bbCTs+fJqQORPVU6lK
         QioHTN8x0mHn9rLhcIW5XwDXyjtAD8zAWA1knoABprpG93p3hVqSlUqiemlldCoeaPXu
         XPwonLreVClfamAys4SM+QLWxHxbeuOdaK5B2w3tHJ7TBo5egSeQUssQ9tzosZp5ZA9J
         z2uA==
X-Gm-Message-State: AGi0PuaQtUPQ7vrclqDTAlS0RTWzCjyeBWSVsnO0YJ1gL2YJPiKUafrX
        OHGOJ34K1cCIfKB39Jf9OG0=
X-Google-Smtp-Source: APiQypKb22JBzydu03DDJPTCS6ihOeLvWWTF1K5nm4hTcD6KJe7da/1XFoUc9qIO+cbAbVPWdg7cYA==
X-Received: by 2002:a50:ab04:: with SMTP id s4mr650641edc.174.1586240818777;
        Mon, 06 Apr 2020 23:26:58 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id oe24sm2472942ejb.47.2020.04.06.23.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 23:26:57 -0700 (PDT)
Date:   Tue, 7 Apr 2020 08:26:55 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     gregkh@linuxfoundation.org, Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Message-ID: <20200407062655.GC21995@kozik-lap>
References: <20200401082721.19431-1-hyunki00.koo@samsung.com>
 <CGME20200406230902epcas2p19a8df6805dac59968d664efb9bc9419b@epcas2p1.samsung.com>
 <20200406230855.13772-1-hyunki00.koo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406230855.13772-1-hyunki00.koo@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 07, 2020 at 08:08:49AM +0900, Hyunki Koo wrote:
> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---

Why I am adding these for the third time?

Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
