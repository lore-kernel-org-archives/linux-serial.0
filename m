Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED26FC433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27B3610FD
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhKFW2j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 18:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbhKFW2j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 18:28:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346C3C061570;
        Sat,  6 Nov 2021 15:25:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bi35so26639972lfb.9;
        Sat, 06 Nov 2021 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ExOX3IowQ8INcZw1paGjxy/2n0XOkzYqt1pGuppdVYo=;
        b=Is7uJO7TaD1cDlCjUSu4v0jPTk62J+yMaj+MD9c8qtNaXLbL7tA0jOn/SkeFYZhsS2
         vvxt9sbTOKF2Kve8jdTvpTXJPa1HAwzYl1tDQbP8Z8/Q26qNx43lJ/TYaN/uqG9llv6e
         CmZgJZtXuDvn2A4QUolg3/Rrgl9X5GgD4dU35qBz+TtJJwmT18P4refdbRZ9oBFN+1SN
         cVYGliZ5aQG1NGx4tsv3iBz9ReecCRQmQCWm/dC7CviQwb7afYuWD95i5Wja28+2k5DG
         dHoYg2Ke5/nLrmAr/efSb1Vz2nfW24y41G7kbAEzuAIXHVFxqgFhno5nz5Er3yYdVt/1
         CJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ExOX3IowQ8INcZw1paGjxy/2n0XOkzYqt1pGuppdVYo=;
        b=pIpP6YDc3829Qh1FAv3pEpAMvtYvQK/odYcx75aqYgs5DLs9WF1vHmtGLcc0HIi1Pz
         LCIl9fqDjAZiqJ2G9vPgcmAztyEF5pNsrW7gLKae5o4uiMKh4f1X3KpOp1DAF+eypuT1
         nOC0bHbgpTjOiMbO2OBL9fJhsRzpAQutqFW85mRIn+ehYYWrVNsPN4Q8i/kUtv6T5BQR
         kT/fguOAJGLUdzZfbkvzjGV83eA28HKa5aQ+IXYX5dSkRd0des6FX6ZIsQ8+26xbBMF5
         gZwq7+guYtOV+tE5x5ypXlzqor9Nx0RFce7H89A1+t7ciwyWYvMUMBngJr3yA79qzz8V
         PYmg==
X-Gm-Message-State: AOAM532aTnD9Zvvcpv4TsPMVLNKI1+CeLM7sR1HVeU6+N/MNhc6aRIdN
        /ZveTbGopWELwsuOaOs5dVVK3YQeKxg=
X-Google-Smtp-Source: ABdhPJz8Jupw9jWo/VPIIESTHwqdJmArD+CIBkZV7JxJcyHzLq9OSUNhvAUARnfBWn5VN1oB4r2tUw==
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr33043362lfr.231.1636237555427;
        Sat, 06 Nov 2021 15:25:55 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.207])
        by smtp.gmail.com with ESMTPSA id o23sm1163763ljg.70.2021.11.06.15.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 15:25:55 -0700 (PDT)
Message-ID: <b7520698-44ef-55db-2b0f-ed47cd7d8b71@gmail.com>
Date:   Sun, 7 Nov 2021 01:25:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3] tty: vt: keyboard: add default switch-case, to handle
 smatch-warnings in method vt_do_kdgkb_ioctl
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211106220315.392842-1-ajaygargnsit@gmail.com>
 <8d0346ba-4819-c25e-f208-0b51116d9147@gmail.com>
 <CAHP4M8VmPTiWjVa_PEMs+XT0VzsoAw8BuO-KBo08Uwuf=T1WFw@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAHP4M8VmPTiWjVa_PEMs+XT0VzsoAw8BuO-KBo08Uwuf=T1WFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/7/21 01:17, Ajay Garg wrote:
> On Sun, Nov 7, 2021 at 3:42 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>>
>> On 11/7/21 01:03, Ajay Garg wrote:
>> > diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
>> > index c7fbbcdcc346..b83e7669658d 100644
>> > --- a/drivers/tty/vt/keyboard.c
>> > +++ b/drivers/tty/vt/keyboard.c
>> > @@ -2090,6 +2090,12 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>> >
>> >               ret = 0;
>> >               break;
>> > +     default: {
>> > +             kbs = NULL;
>> > +             ret = -ENOIOCTLCMD;
>> > +
>> > +             break;
>> > +     }
>>
>> Are these brackets needed here? There are no local variables inside
>> default case.
> 
> Hmm,
> 
> * case KDGKBSENT: uses braces.
> * case KDSKBSENT: does not use braces.
> 
> I based the layout for default-case on the same lines as case
> KDGKBSENT: , as I prefer explicit braces :)
> 

I am not against these braces, but I, honestly, dislike them, because 
`case : {` syntax looks ugly _to me_.

KDGKBSENT uses it because of local variable `len` and not using them 
will cause build error.

I didn't find any strict requirements to not use brackets when there is 
no local variable, so it's up to maintainers (again).


Anyway, thank for respinning :)



With regards,
Pavel Skripkin
