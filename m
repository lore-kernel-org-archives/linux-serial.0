Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADEDC43381
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 12:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10271239D1
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 12:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbhAUKw0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 05:52:26 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46054 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbhAUKpn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 05:45:43 -0500
Received: by mail-ed1-f43.google.com with SMTP id f1so1837176edr.12;
        Thu, 21 Jan 2021 02:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ygQUO6NbrhOWf1oJZ0jT9Svf7/NfQfzJhvUcVNbY/7s=;
        b=TTtFjMuoxDp8bYRH/jkHIYinDx4fbNw5nU3faJpgf2+cbb+3xc8P6LIRyK+aOtD1zW
         M6TsQAzBq4KPObhnv6WDIAIhWMVqkF6xjVKt6d8s4XxWH0audnmwPyz82eAG8lhTa31h
         qssUAXIXcxIlpPJ7lBRxpgSguo2oRX3rGCmDz5NluI9meTu7T4u3xALOS7VkjAWb7EPj
         B9AxAW70ZNiaTPfocaLpDDiOEIR8RP/XMKAY++p6OmYx844OStVKR0/Iy+gyK0oIFiRH
         WhW6tLcX+CII6UExUinASOPickHhVBQgbhSXnMPWURJulgOohcr6VspYK41GyzkARFm/
         ekoQ==
X-Gm-Message-State: AOAM532K5gEaRe42xZoPQt82zMWpjtNXr3aBs0gnZs52h/Kze04Dv9Lh
        aW9yJxZ/CoZzSkXmVUJfokk=
X-Google-Smtp-Source: ABdhPJwr0r3oVl1Fple6H6IaKgN8QE+zD8SScco1POqfxL+FMhA7p6/kaAJUcg5dNqeoUvbkkFk0Sg==
X-Received: by 2002:aa7:cf94:: with SMTP id z20mr6269014edx.75.1611225898788;
        Thu, 21 Jan 2021 02:44:58 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id fi12sm2075626ejb.49.2021.01.21.02.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 02:44:57 -0800 (PST)
Subject: Re: [PATCH 3/6] tty: implement read_iter
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ohw.giles@gmail.com, r.karszniewicz@phytec.de,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <20210121090020.3147058-3-gregkh@linuxfoundation.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <72c5fa0a-b0e2-740a-54d1-07e806a53024@kernel.org>
Date:   Thu, 21 Jan 2021 11:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121090020.3147058-3-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 01. 21, 10:00, Greg Kroah-Hartman wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Now that the ldisc read() function takes kernel pointers, it's fairly
> straightforward to make the tty file operations use .read_iter() instead
> of .read().
> 
> That automatically gives us vread() and friends, and also makes it
> possible to do .splice_read() on ttys again.
> 
> Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> Reported-by: Oliver Giles <ohw.giles@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>   drivers/tty/tty_io.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index a34f8bcf875e..8846d3b99845 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
...
> @@ -907,10 +909,10 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty, struct
>    *	read calls may be outstanding in parallel.
>    */
>   
> -static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
> -			loff_t *ppos)
> +static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
>   {
>   	int i;
> +	struct file *file = iocb->ki_filp;
>   	struct inode *inode = file_inode(file);
>   	struct tty_struct *tty = file_tty(file);
>   	struct tty_ldisc *ld;
> @@ -923,11 +925,9 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
>   	/* We want to wait for the line discipline to sort out in this
>   	   situation */
>   	ld = tty_ldisc_ref_wait(tty);
> -	if (!ld)
> -		return hung_up_tty_read(file, buf, count, ppos);
>   	i = -EIO;
> -	if (ld->ops->read)
> -		i = iterate_tty_read(ld, tty, file, buf, count);
> +	if (ld && ld->ops->read)
> +		i = iterate_tty_read(ld, tty, file, to);
>   	tty_ldisc_deref(ld);

Here we have the same problem as in tty_write.

And also the other one with hung_up_tty_read not converted.

thanks,
-- 
js
