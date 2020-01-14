Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E967CC33C9E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 18:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3CD24658
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 18:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dPsIjRXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgANSnz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:43:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40568 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANSnz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 13:43:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so6789010pgt.7
        for <linux-serial@vger.kernel.org>; Tue, 14 Jan 2020 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDQt/cQPOA137MrPt5eSVBozZBl/+1BwFFxlqLBKbOc=;
        b=dPsIjRXHMSHLSJgKJS6IlOKG45mt4OickHQCbNPv2Y1az5i+Fjoa4XnxpannAjAkYW
         u3iX4BtqDbExD+jyJgMJZtLHTZJO0pEhs9jcOKFy0Nyxk1u4WdkB8/gyXT58mE2ggi8D
         GCetuAvTy3lEWf0Untzov4pQKK740ZJwW+7LkknNJMG74pEludMT7DGpv2Em8WqVMxx6
         7BlgJKaPxg3EBeNXsQIpV4/NVGhDk7cGGaX3BJb/qfh6B2bYknfH75XF0c7L9rF8Wonn
         N0lW9/A8H+VHpCCYStdaEKz79PMeqztbdDLG1txXjSeteK3wiFNNEx2qTgG9f23XLk45
         ZK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDQt/cQPOA137MrPt5eSVBozZBl/+1BwFFxlqLBKbOc=;
        b=JE50419e4zxStbTXlcGosUdCrafLS/04aobJNgKjCaK3JY5hckTIw9wgq45u6Ftcic
         EXjqSchszxKtL1iOPpW/Z4VA0NBINXvWO9Zxm8iEZf5vnXRSyVXCZCcHq1Zm/Ne4aydy
         xhRcNRzswCz6R7S4EvjVH+jcZ65dd6owdM8U3eS3yUa6L3cUcmV+ssANFbScW2LmOISF
         san2z0vmSxAe+bFd9zn7aOBPL2sS4XCQ8sBJWnXDnI6KvliPctZr1HbBaIoPnNGKrWUN
         1+2JAjenqU4RejVr28EiXmdBaH/JkQ0L4TqyhlFqQopoOhE62+9XhoU7TDZBiAwDz95C
         3ssg==
X-Gm-Message-State: APjAAAXL/No84AhSoCKf/VUysJmRQvkr6UwcEalcXp4GXQcslmREZoSj
        Jrfo49kATiWj7LTupKuyeShFjQ==
X-Google-Smtp-Source: APXvYqzWPbLeu1M7MD0gjc1MsfdtZch9eGBK94JXAMePruRkq0w/DODcH78ZkVC/dqzIm/evPe3WsA==
X-Received: by 2002:a63:181a:: with SMTP id y26mr29235053pgl.423.1579027434446;
        Tue, 14 Jan 2020 10:43:54 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w20sm18920336pfi.86.2020.01.14.10.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 10:43:53 -0800 (PST)
Subject: Re: [PATCHv2-next 3/3] serial_core: Remove unused member in uart_port
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-4-dima@arista.com>
 <e1b3cccb0814ba4b0c99592715776ed48f343795.camel@perches.com>
 <8f11e2fa-495d-fe25-f5e4-52c9580240d7@arista.com>
 <20200114175647.GA2055173@kroah.com>
 <805e5dbb1f28e8f8b8f2599adb56294d3225c2d0.camel@perches.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <4290527b-0d67-1b92-3820-2fd519099e6d@arista.com>
Date:   Tue, 14 Jan 2020 18:43:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <805e5dbb1f28e8f8b8f2599adb56294d3225c2d0.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/14/20 6:32 PM, Joe Perches wrote:
> On Tue, 2020-01-14 at 18:56 +0100, Greg Kroah-Hartman wrote:
>> On Tue, Jan 14, 2020 at 05:47:33PM +0000, Dmitry Safonov wrote:
>>> On 1/14/20 5:36 PM, Joe Perches wrote:
>>>> On Tue, 2020-01-14 at 17:19 +0000, Dmitry Safonov wrote:
>>>>> It should remove the align-padding before @name.
>>>> []
>>>>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>>>> []
>>>>> @@ -247,7 +247,6 @@ struct uart_port {
>>>>>  
>>>>>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>>>>>  	unsigned char		suspended;
>>>>> -	unsigned char		unused;
>>>>
>>>> I suggest this not be applied as this is just to let
>>>> readers know that there is an unused 1 byte alignment
>>>> hole here that could be used for something else.
>>>
>>> Heh, 2/3 adds another `unsigned char`, so the neighbours look like:
>>>
>>> : unsigned long sysrq;		/* sysrq timeout */
>>> : unsigned int	sysrq_ch;	/* char for sysrq */
>>> : unsigned char	has_sysrq;
>>> : unsigned char	sysrq_seq;	/* index in sysrq_toggle_seq */
>>> :
>>> : unsigned char	hub6;		/* this should be in the 8250 driver */
>>> : unsigned char	suspended;
>>> : unsigned char	unused;
>>> : const char	*name;		/* port name */
>>>
>>> So the hole became 4 bytes on 64-bit.
> 
> Ah, perhaps the commit message could state that
> there is no longer an alignment hole instead.

Fair enough, slowly improving in my commit message skills :-)

Thanks,
          Dmitry
