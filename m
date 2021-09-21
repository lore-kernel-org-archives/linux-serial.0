Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EEBC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Sep 2021 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1382061186
	for <linux-serial@archiver.kernel.org>; Tue, 21 Sep 2021 15:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhIUPxH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:53:07 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40720 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIUPxH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Sep 2021 11:53:07 -0400
Received: by mail-wr1-f44.google.com with SMTP id q26so40563397wrc.7;
        Tue, 21 Sep 2021 08:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SGlNyJc163VHCvQP8ZebJ632wDd/T7gsno9Azu96zu4=;
        b=0EFjw1sBfoEThUFC0K4kus4xqDy88zI0tl3EDRYK8BTGwK8O2umzS3N+StsERZnQ1x
         r6jvyxAF5nBcxVZPTrfngat/uA1Hs8oCLCKFOvDElYFk1lw91WIuDf5/oELLMguIm4bl
         ag7R3QatQwcSlOJTHEkY4m+Od6SWET4he65R1H07YCDCKp5WqOWNZadv0YJeOW3ZaDUu
         X9YTpuunOkvDxSfU8sKvrcqZehvGPO/ePhpIaIUrPwHPezyofS0U97Aml9h3A1yZ6HPp
         Wp4DFXZ3K3YdaY+K4rkgLMFeiniUxIyzuChqWeE1iB1A/xHHFtyFQmiKaYqqWA3jAk7v
         6QJA==
X-Gm-Message-State: AOAM531dtyq8MkRdv2JlgbSVozCq477f+pAXG0SNkz5QqH6IwcPEq0x6
        fuIIOl5lt610eAD4amr8UdA=
X-Google-Smtp-Source: ABdhPJyya/h/DxldyRTL4NEizyEIHfA+enxOKuJ5mY0wnU5nDP4p5OXndeVdOtUKspVUvt7KO1d2nw==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr35907174wry.364.1632239497492;
        Tue, 21 Sep 2021 08:51:37 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z12sm19515035wro.75.2021.09.21.08.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:51:37 -0700 (PDT)
Message-ID: <e3473e69-777b-8b96-c3ae-54cfbdbdb9a2@kernel.org>
Date:   Tue, 21 Sep 2021 17:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 07/16] tty: remove file from tty_ldisc_ops::ioctl and
 compat_ioctl
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-7-jslaby@suse.cz> <YUlY5pQQWf2P2fKn@google.com>
 <9049e956-2865-7309-2eaf-aa4516ab28d6@kernel.org>
 <YUnDtTEzex5/z90J@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YUnDtTEzex5/z90J@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 09. 21, 13:36, Greg KH wrote:
> On Tue, Sep 21, 2021 at 12:52:38PM +0200, Jiri Slaby wrote:
>> On 21. 09. 21, 6:00, Dmitry Torokhov wrote:
>>> Hi Jiri,
>>>
>>> On Tue, Sep 14, 2021 at 11:11:25AM +0200, Jiri Slaby wrote:
>>>> diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
>>>> index 17eb8f2aa48d..55e91d0e70ec 100644
>>>> --- a/drivers/input/serio/serport.c
>>>> +++ b/drivers/input/serio/serport.c
>>>> @@ -207,8 +207,8 @@ static void serport_set_type(struct tty_struct *tty, unsigned long type)
>>>>     * serport_ldisc_ioctl() allows to set the port protocol, and device ID
>>>>     */
>>>> -static int serport_ldisc_ioctl(struct tty_struct *tty, struct file *file,
>>>> -			       unsigned int cmd, unsigned long arg)
>>>> +static int serport_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
>>>> +		unsigned long arg)
>>>
>>> Can we please keep arguments aligned as they were? Otherwise
>>
>> Fixed, thanks. Likely, I will send a follow-up -- depending if Greg drops or
>> keeps these in the tree.
> 
> Up to you.  I can drop them all now if you want to resend a v2 with all
> of the aggregate acks, or you can send a follow-up set on top of these.

What about if you keep everything up to (and incl.)
   tty: remove file from n_tty_ioctl_helper
(i.e. the patch 06/16, the one before this one)? If that works for you, 
I will send v2 of the rest w/ collected acks. If it doesn't, I prefer 
sending a complete v2 (incl. collected acks).

thanks,
-- 
js
