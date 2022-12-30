Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08033C4167B
	for <linux-serial@archiver.kernel.org>; Fri, 30 Dec 2022 13:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiL3NEn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Dec 2022 08:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiL3NEm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Dec 2022 08:04:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4318B07
        for <linux-serial@vger.kernel.org>; Fri, 30 Dec 2022 05:04:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w1so7742976wrt.8
        for <linux-serial@vger.kernel.org>; Fri, 30 Dec 2022 05:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5y32Pwzonf3CvozRM4PbPvchTD4/JJcNSUxK5NgDiw=;
        b=MiC76c5v65Pcm6BqsYSlUf9eYBhZoqPc3E4li4ui9tz3xsMKSzaO3kDZQbpquQ+lVD
         4cUWq33Psv+D7/luW993MrT2eRTbta4OIM1hbegtIQuHqoanOOi4f2W2w76GR+sTUk+h
         zLZPBRyYbZW+MD2YP8dyPWoKFY9ZO/GonwNfUN8UYs3+7qY65dmdzVWmQZ4+/Gu03TS4
         bYmNW+1zcjgsVxz6XYAGHESUmb0aEiZNOpuf3G9Xt/2qqjxqX/uf1e9Sn6HS5C7D2wa1
         ctiQahjDbIgu9J0R4Ik2SBTZdz9AP+f/JLj/Wk/BcTmEZ2pjNMDB80udsERz6rVa48yJ
         TcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5y32Pwzonf3CvozRM4PbPvchTD4/JJcNSUxK5NgDiw=;
        b=cCsVTqT/rL22ThAyyBsds39yaksXghdPAvusGXim3uRATK80STlSsfLAquEnMAJ4Cp
         oEG8NLZ8ckdCgP807NzGEIbxNnrrr3n/mZEHZ8PU7wdPUUDqCfH8rNmUig8UQzCvnOKY
         ceLOuPEbB66/YSmLFet7j4NanZ1GOo88g7AfovDeDJGLADd8whDia3+nYqfEjU0FJrg8
         aH1nVxBYl3lB6J7RWxlc6TYS0u6pkLgETmfD3Pk23nrdghu3DoZC1gfEtcFvb4yQNZ+a
         mXCAs4QGce0Tf9GzPgfcsLwntILNlnQhKBN1OwqogKv3sBCYT8IBY96c1qlIZ9Zsvujo
         7NJw==
X-Gm-Message-State: AFqh2kqMHSiWD7IFm2AdpD8rAs5aPcBGqOVHMv1mcHiybLQQjuDq1Ayz
        o/xBxUksfyz96Io8+jlzYMPMZw==
X-Google-Smtp-Source: AMrXdXv91qDvoe0E3LEX2Nuy9saUPb8byz4g95rRpux1Byxvl4qHdzte7BwNCRiTG81APPPgHaNKjQ==
X-Received: by 2002:adf:f010:0:b0:242:4c28:c9b3 with SMTP id j16-20020adff010000000b002424c28c9b3mr20611808wro.43.1672405480108;
        Fri, 30 Dec 2022 05:04:40 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b00281b594c725sm10978387wrs.38.2022.12.30.05.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 05:04:39 -0800 (PST)
Message-ID: <d62f206e-f5c7-b0f0-d0f1-516669d31352@linaro.org>
Date:   Fri, 30 Dec 2022 14:04:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] serial: 8250_rt288x: Name non-standard divisor latch
 reg
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     inux-kernel@vger.kernel.org
References: <20221230114603.16946-1-ilpo.jarvinen@linux.intel.com>
 <20221230114603.16946-3-ilpo.jarvinen@linux.intel.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221230114603.16946-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30/12/22 12:46, Ilpo Järvinen wrote:
> Instead of a literal, add proper name for the non-standard divisor
> latch register.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/8250/8250_rt288x.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

