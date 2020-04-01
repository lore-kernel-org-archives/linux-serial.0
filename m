Return-Path: <SRS0=XHY+=5R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37493C43331
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D26720719
	for <linux-serial@archiver.kernel.org>; Wed,  1 Apr 2020 14:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hILXlyNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbgDAOlh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:41:37 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53701 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732997AbgDAOlh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Apr 2020 10:41:37 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so25688pjb.3
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2020 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HfPFNwmDkfOnPIp3KtUBPjXsLI4JkbyQkGj/q/lYOhA=;
        b=hILXlyNm5rm7/90fu4LZHfY8txVlENFOCqA4PZl86jm8x2OBMfsHvUZ5pdiUliB7Hu
         cv9JY4xBiLTe6uc2ub02+xaJuTc3BaebPjgHNOKmxUeJ//gdmwM3Hl/A/iwgyKHSGleO
         a/QJNazm72wndR0thboWymnLEjA3/IpeYzEmAoToZjCeaKvcA5BqRXR2mjMFi+rvs49D
         Z3CMHZW8kq+WVp3psWkogqjtIOmZVmz210VSzg/08nAZbEk9H5nQQ2gcsHFWKgv2hBN+
         qbMqlyE85zkniXlwJEWqR72C9LcezWglQ1OddmoyVuNcqWOaUzQx2IGOiCfh+LTz/ur4
         mp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HfPFNwmDkfOnPIp3KtUBPjXsLI4JkbyQkGj/q/lYOhA=;
        b=sHqNFsTkcwBIklikuqLlNHjwgSeg8LHxArmU45rz6WY+XuepMU24tKcSgWevsbefUK
         yMBLvVRqHbACjSR/x+pAoIYtoTlHkbEWTyftyN58oLwIZXSWm/ANeFvCItQgrAh52Hn1
         biFoMa6KPHEKCKet7wnnquFrFgW2suTLJOXFYSCfufYVniZ4yUpkBa2zQEGkFnKBpZUK
         gH6cTY6dNnKikxKDQAUd3agujJ+fdGPH6CxORTMNNmjTtQ9BMZ9KMQyPbIrs6djdAPND
         ZelSrOcvDbnlwNlRGk0YunOUzZWUi7zIgrbsOqEGJuqUl5Tg1ryerhN8poFPfUD2vdTP
         d5fA==
X-Gm-Message-State: AGi0PuZ8sAWifN62QMLNQWPEmzg1OPG4dMMZ/G9uOiCmLzge0ZEKZzMf
        2L/oe7L9p+LDV0jXKbe8QNmogw==
X-Google-Smtp-Source: APiQypJHLsC2dVtdtQ3xLsn8BhVe1AEHtj2of90gLEdROpcJkWt08CvYqtJlTaMbh5SGXzO/+fyCwQ==
X-Received: by 2002:a17:90b:3747:: with SMTP id ne7mr5091522pjb.181.1585752095779;
        Wed, 01 Apr 2020 07:41:35 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id 135sm1779210pfu.207.2020.04.01.07.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 07:41:34 -0700 (PDT)
Subject: Re: [PATCHv3 1/2] sysctl/sysrq: Remove __sysrq_enabled copy
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
References: <20200302175135.269397-1-dima@arista.com>
 <20200302175135.269397-2-dima@arista.com> <87tv23tmy1.fsf@mpe.ellerman.id.au>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <daf484e9-7f3d-9c76-d4c4-a054dcf236c1@arista.com>
Date:   Wed, 1 Apr 2020 15:41:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87tv23tmy1.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Michael,

On 4/1/20 1:22 PM, Michael Ellerman wrote:
[..]
>>  
>> +/**
>> + * sysrq_mask - Getter for sysrq_enabled mask.
>> + *
>> + * Return: 1 if sysrq is always enabled, enabled sysrq_key_op mask otherwise.
>> + */
>> +int sysrq_mask(void)
>> +{
>> +	if (sysrq_always_enabled)
>> +		return 1;
>> +	return sysrq_enabled;
>> +}
> 
> This seems to have broken several configs, when serial_core is modular, with:
> 
>   ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
> 
> See:
> 
>   http://kisskb.ellerman.id.au/kisskb/buildresult/14169386/
> 
> It's also being reported by the kernelci bot:
> 
>   https://lore.kernel.org/linux-next/5e677bd0.1c69fb81.c43fe.7f7d@mx.google.com/


Thanks for reporting this,

I've reproduced it and sent a fix:
https://lkml.kernel.org/r/20200401143904.423450-1-dima@arista.com

Thanks,
          Dmitry
