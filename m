Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A003C10DCE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CA320848
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Wc1YnfGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgCFOu5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:50:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39886 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCFOu4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 09:50:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so2690408wrn.6
        for <linux-serial@vger.kernel.org>; Fri, 06 Mar 2020 06:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkdm0GhCO++/nQ4VT9YppiVp8lDUJySwc361AwdjYfU=;
        b=Wc1YnfGDuJ9VpbVek3V1X++yakDjHxIzXn6x9UaX8t9KQN5bruqPFDsJFxxRpmGdto
         PlpnXAJSyWQTTc9vbjG7mdbpNC4peXoX0SuzM/koRM06/LABtjG+woAvfHvExApjKrkc
         bsarCq+sFlB/Ho+Oeug6JM21WEjDEiiMpHawME+FcWdjDi0KrnG3CxTQPV92tirKsDW5
         aEH588YAOFRYaQ0HgCRdTlN5QcMJ5OAQsVM6PSOZdSOQKbXcAPCrH93Pn5Z7vfZCd9mT
         0ccvu3XDH9Cc/HFXqiVrFxBSJv//J1DUA99WtPPom0kIHqkZSyffYCrbwZ1cyt51IqMA
         a/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkdm0GhCO++/nQ4VT9YppiVp8lDUJySwc361AwdjYfU=;
        b=MB+a0FZAVuQyUY73Y26exkf/66mh/1m3Z7owgZJvUV32oRoL1zDM88vkBVUeDg6+yO
         4DMEekFu0fPIyS480LhvOr6K0amhVS84NygKBfodwNNHgdB918U5aBwQ36kyMehIXQH7
         nGpclFK7Q3LICxjYQfWZ0JqcI0WFPKrZ/Gu1T/n1/4F2GbvSEbqXuiEUR2qBQhHHkh8C
         HkSFnU4Ip/a5z6wqNT4YaACwlaI4VVk+APnDwhv397TJQjaWpgjwkLptkOonk/5kgbKg
         Whv9oafAjqN+9J3FtfA+hyzdv3MAqJ+S6jcNP0v+syV3FrsWE91rkiZ3f3M8wsA5VPgW
         G0Cw==
X-Gm-Message-State: ANhLgQ1sPf8EONrLJPaVjPlHeQltpP1UlG/cPZR1CI5PCCu5CXObfSxT
        rniJewCIgyKvcp/QYLPHKkifOA==
X-Google-Smtp-Source: ADFU+vsa1D0obuQITxRQ/CMVVhL4xz90VRuA7ecM53JXflQonfIFp6f1Tdy6OrQkndLmgc9FUWNBdQ==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr4553618wru.398.1583506253020;
        Fri, 06 Mar 2020 06:50:53 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f127sm14302305wma.4.2020.03.06.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:50:52 -0800 (PST)
Subject: Re: [PATCHv3 2/2] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200302175135.269397-1-dima@arista.com>
 <20200302175135.269397-3-dima@arista.com>
 <20200306125531.GA3754466@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <b48021b8-f881-49c1-fee6-dfbe0c74bb37@arista.com>
Date:   Fri, 6 Mar 2020 14:50:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200306125531.GA3754466@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/6/20 12:55 PM, Greg Kroah-Hartman wrote:
> On Mon, Mar 02, 2020 at 05:51:35PM +0000, Dmitry Safonov wrote:
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 69def4a9df00..38a8f3c99579 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -431,6 +431,14 @@ config MAGIC_SYSRQ_SERIAL
>>  	  This option allows you to decide whether you want to enable the
>>  	  magic SysRq key.
>>  
>> +config MAGIC_SYSRQ_SERIAL_SEQUENCE
>> +	string "Char sequence that enables magic SysRq over serial"
>> +	depends on MAGIC_SYSRQ_SERIAL
>> +	default ""
>> +	help
>> +	  Specifies a sequence of characters that can follow BREAK to enable
>> +	  SysRq on a serial console.
> 
> 
> Can you send a follow-on patch that adds some more text here.  Something
> like :
> 	If you do not know what to do, just select an empty string and
> 	the option will not be enabled.
> 
> or something like that to make it more obvious what almost everyone will
> want to do here.

Oh yes, makes sense, will send a patch.

Thanks,
          Dmitry
