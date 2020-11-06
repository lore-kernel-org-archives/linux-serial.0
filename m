Return-Path: <SRS0=r4Ma=EM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE5C2D0A3
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 11:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D51C208B3
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604661600;
	bh=SPVAItQ2Z3Q0LhzkF4DuV2WAMYI66hDjV4zmZNm9kOk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cXAJVz2z3oE0zp5GktppJmCqtaGk4/PWjhN/SQj8SBz7H6n0qQ5cnsm6Dlxs6IBSB
	 XYMnqLDciu2h+el1uiRVAZI76j6ei9qEF7i17jcPNMicIyoalBroNLCyS8kFHWF2lY
	 k4tpB1kgv+l01gkG7vLZM/rL6egY2Lg6UDhyBKbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgKFLUA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Nov 2020 06:20:00 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41590 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgKFLT7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Nov 2020 06:19:59 -0500
Received: by mail-ej1-f68.google.com with SMTP id cw8so1382328ejb.8;
        Fri, 06 Nov 2020 03:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ziNvoLqJH7trwLeYEvENeRDUAosQ9M0r6jD8htXIwKA=;
        b=LMDoy+RUXRMGxOrEtMpxqyOvz2vIyjw8COsdIAzFGQLGQKZ8kCqSZY5PoN5tRQprTw
         7hyuYXSSH6OiqGwOY0CSNX3DBdWEQ89K90/xQ7aVILjgLC2sAtj64WrdmjEfC6Qc03vb
         VXENDVzBrMoScFprs2skJ4F6qXJ6boB0b5Sh9tSsf2t1KG67Sd1X3OQ/E35yBfW4Bjdg
         IPatvpsQFoZCx9WcY386l9vK1WnPChwMrYctlD/GyNyvod0p0bmt4BNjSEad7F28TvFL
         bKhsawYRx6zjTRIaZXrKw2xZ3SWk1BigWOTISTFJbGcjhYDry6G8msw+g9e+Zm1JbKnR
         1svg==
X-Gm-Message-State: AOAM531XdIF3s+2PUP0ZN4rd2uSOv7e7LrFbki9rFJuheed2zoD5G59K
        t3kL8qNbMRacae1UzhcueisFTH082do=
X-Google-Smtp-Source: ABdhPJxTqgVSSxfMdv+yxhaKXabYkER/oNkypnz9kcxPBcJXK8VlRA1Ga0WAfBseIQd9vPQHtTXdtw==
X-Received: by 2002:a17:906:2697:: with SMTP id t23mr1587648ejc.292.1604661597674;
        Fri, 06 Nov 2020 03:19:57 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id q2sm675109ejd.20.2020.11.06.03.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 03:19:56 -0800 (PST)
Subject: Re: [PATCH 13/36] tty: serial: 8250: 8250_port: Staticify functions
 referenced by pointers
To:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Mike Hudson <Exoray@isys.ca>,
        linux-serial@vger.kernel.org
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-14-lee.jones@linaro.org>
 <20201106095326.GA2652562@kroah.com> <20201106100552.GA2063125@dell>
 <20201106101646.GB2063125@dell> <20201106103955.GA2784089@kroah.com>
 <20201106104810.GE2063125@dell> <20201106105552.GA2810950@kroah.com>
 <20201106111251.GF2063125@dell>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <aa8356e2-a9b9-f8b9-1d10-62d75399e7d9@kernel.org>
Date:   Fri, 6 Nov 2020 12:19:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201106111251.GF2063125@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06. 11. 20, 12:12, Lee Jones wrote:
> I cannot recreate the issue or work out why:
> 
> # THE OUTPUT
> #   *_port.o and *_early.o were both built
You have to _link_ to see linker errors ;).

Like make vmlinux


-- 
js
