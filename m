Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C8C2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 21:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92816208E4
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 21:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGzNgmQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIWV2Y (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 17:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWV2X (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 17:28:23 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A13C0613CE;
        Wed, 23 Sep 2020 14:28:22 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gx22so1613075ejb.5;
        Wed, 23 Sep 2020 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NhcHxkvfB7BL71DayU4kKwQuHllId4i9VfQatxYCkY4=;
        b=sGzNgmQ4o+F9PW63vKdOE90jc5Bt/m2DIz1adWlm72MOtvEx9pugeR13iq605nZ69b
         BN3h87PkxSnIfsDKFu1qDUyAeQ8DW1Ug1Qq3LtG1HEhjRm6bz0wv0tjKvs3Jnv4+vlBu
         rG134aYGFQ274iWtg8wizDQgDNzNNFtHvDDovs69XT95Z6FB2SqLBf6+JGM2q6ZLLmqB
         S/Fs6PXgX7IK6gk3WCknl35jkavJK83jlSfCIgDTN9ilDJCsbjG0i7CO6MLN/C1kj0ks
         spW5LjbN47jbEwRIfVcC2Ukp6/wObP2reaCPDzTzt+k5BC+2VGWptNTSyHS0HS/vGuAQ
         D4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NhcHxkvfB7BL71DayU4kKwQuHllId4i9VfQatxYCkY4=;
        b=R4ooa0EqyvPfv46tWfC7dZXF+l4L/qUUxiKqH169bSrytXMh2pRgDc6oCwcJQ71YNe
         fWBvFEsI4rQpL84Nq9+qsaus0yZAJyqY6gpsELaN1EPgJEKq+j9wp7SiUaHlroSvTgU6
         RVlGovXy6Pkpc7tBmVZ4xKaZBDXsMUNrIywo5EtPMHMUh50zkabhisEe+U65N9LP9iof
         u7PnX1OfXYOsG3uAIGIrHDnx4HAJzf7Mwi/09YOIuignJt91jdYSUzH0xkSUMdKywCZ+
         EW9wE/5C/Za9X9wRvVYCMRNmvqUhdYpI6XWzrILNG7fD4nIMHOYF2qOLq19X1ciBpwCQ
         y/LA==
X-Gm-Message-State: AOAM532/4ivlDCqKBgS+1IVwjJGNcPuuogO0wd31AI9IfcDnt3+YDJYC
        Zo3DfKeN/ROVz8m/FvQ8JlY=
X-Google-Smtp-Source: ABdhPJxmf0fYMWqadHpL9xa1inOmNLhb5ekbyxuMikA1fzgYflwmAgvC8315ZTi1DzaRt4TSrrXXdg==
X-Received: by 2002:a17:906:c113:: with SMTP id do19mr1392188ejc.219.1600896501643;
        Wed, 23 Sep 2020 14:28:21 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id o3sm795193edq.63.2020.09.23.14.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 14:28:20 -0700 (PDT)
Subject: Re: [RFC PATCH 5/9] surface_aggregator: Add error injection
 capabilities
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-6-luzmaximilian@gmail.com>
 <20200923174543.GA102853@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <11657eb7-88a8-0c24-f7ee-fef9679c7837@gmail.com>
Date:   Wed, 23 Sep 2020 23:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923174543.GA102853@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 9/23/20 7:45 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 23, 2020 at 05:15:07PM +0200, Maximilian Luz wrote:
>> This commit adds error injection hooks to the Surface Serial Hub
>> communication protocol implementation, to:
>>
>>   - simulate simple serial transmission errors,
>>
>>   - drop packets, requests, and responses, simulating communication
>>     failures and potentially trigger retransmission timeouts, as well as
>>
>>   - inject invalid data into submitted and received packets.
>>
>> Together with the trace points introduced in the previous commit, these
>> facilities are intended to aid in testing, validation, and debugging of
>> the Surface Aggregator communication layer.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Ok, this is ridiculous.
> 
> You are dropping a whole new subsystem on us, with full documentation,
> correct driver model integration, crazy debugfs interactions (I made fun
> of the patch, but the code did work, you just did more work than was
> needed), proper auto-loading of modules, tracing, documentation for more
> things than is ever expected, and now you are adding error injection
> support?
> 
> You just made all other code submissions of new subsystems I have gotten
> in the past 2 months look like total crud.  Which, to be fair, they
> probably were, but wow, you just stepped up the level of professionalism
> to a whole new height.
> 
> I can only dream that "real Linux companies" take note and try to follow
> this example.  I think I will point them all at this in the future and
> say, "go do it like this one."
> 
> very very very nice work, we owe you the beverage of your choice.
> 
> greg k-h


Wow, thank you very much for those kind words! That means quite a lot to
me.

To be fair, I've been working on this whole project for about two years
now and a large part of the code has been rewritten in the last half a
year, specifically to get it ready for the kernel. So I guess that might
relativize things a bit :)

Thanks again,
Max
