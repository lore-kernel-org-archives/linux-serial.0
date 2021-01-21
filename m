Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7868CC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 11:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BFA2388E
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 11:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbhAULCw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 06:02:52 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43961 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbhAULCr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 06:02:47 -0500
Received: by mail-ed1-f45.google.com with SMTP id n6so1907889edt.10;
        Thu, 21 Jan 2021 03:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n6DYcYeSLADiN6siyAF5sN2ywvVzfVTuKS3Zh4JrGOg=;
        b=PEdsYiXLsQ/glmKxl1c/RrvoMoF0wHMSpC9RWFQSWNvt5LlLy2W5xRwqx/bHlLfbo5
         c3KSbmyGqimtOESdL1ST0usFm+HYBbKK1+6lGGlm8ilHp5OaRqasW9rYUuk7xDQOD+Es
         qW7YYC4nVIeN2ufhJuTNUf4or1gF4rQRiG55jbMFFwLQ5K9sqHRNOX5Nc87LKmOgy3Rs
         TdKEPsRls9TNOKOjWRnGxyayxAbIh0/R4apQ8MKk4+AdSth+IxJlcZy7lImeE4sMsc4C
         Yr/4QA2KznC2aAdCOis6MIqHVBgM0mMc38jUFjq6v/sWu31u0G8QutP9ZKbMCwBLlFkY
         KHMA==
X-Gm-Message-State: AOAM530mu6YQw2MIS45R7IAH7uN6OxUS8nhSERTtoDQC4xQEtIJJv3ha
        ZYCiQv9J+43mC22jjjIoEng=
X-Google-Smtp-Source: ABdhPJyjvWEQNGsz5ELJZogBMc6cApHA22zZvmgRZNXo/XESvK3tkKxq6J7lxFLORMWqPslFm0v97Q==
X-Received: by 2002:a50:8387:: with SMTP id 7mr10121555edi.131.1611226924734;
        Thu, 21 Jan 2021 03:02:04 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id x9sm657673eje.36.2021.01.21.03.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:02:04 -0800 (PST)
Subject: Re: [PATCH 2/6] tty: convert tty_ldisc_ops 'read()' function to take
 a kernel pointer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ohw.giles@gmail.com, r.karszniewicz@phytec.de,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <20210121090020.3147058-2-gregkh@linuxfoundation.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <ff6709dc-bb42-1e52-b348-c52036960bdd@kernel.org>
Date:   Thu, 21 Jan 2021 12:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121090020.3147058-2-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 01. 21, 10:00, Greg Kroah-Hartman wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> The tty line discipline .read() function was passed the final user
> pointer destination as an argument, which doesn't match the 'write()'
> function, and makes it very inconvenient to do a splice method for
> ttys.
> 
> This is a conversion to use a kernel buffer instead.
> 
> NOTE! It does this by passing the tty line discipline ->read() function
> an additional "cookie" to fill in, and an offset into the cookie data.
> 
> The line discipline can fill in the cookie data with its own private
> information, and then the reader will repeat the read until either the
> cookie is cleared or it runs out of data.
> 
> The only real user of this is N_HDLC, which can use this to handle big
> packets, even if the kernel buffer is smaller than the whole packet.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
...
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -833,6 +833,65 @@ static void tty_update_time(struct timespec64 *time)
>   		time->tv_sec = sec;
>   }
>   
> +/*
> + * Iterate on the ldisc ->read() function until we've gotten all
> + * the data the ldisc has for us.
> + *
> + * The "cookie" is something that the ldisc read function can fill
> + * in to let us know that there is more data to be had.
> + *
> + * We promise to continue to call the ldisc until it stops returning
> + * data or clears the cookie. The cookie may be something that the
> + * ldisc maintains state for and needs to free.
> + */
> +static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty, struct file *file,
> +		char __user *buf, size_t count)
> +{
> +	int retval = 0;
> +	void *cookie = NULL;
> +	unsigned long offset = 0;
> +	char kernel_buf[64];
> +
> +	do {
> +		int size, uncopied;
> +
> +		size = count > sizeof(kernel_buf) ? sizeof(kernel_buf) : count;

Or simply
size = min(count, sizeof(kernel_buf));

> +		size = ld->ops->read(tty, file, kernel_buf, size, &cookie, offset);
> +		if (!size)
> +			break;
> +
> +		/*
> +		 * A ldisc read error return will override any previously copied
> +		 * data (eg -EOVERFLOW from HDLC)
> +		 */
> +		if (size < 0) {
> +			memzero_explicit(kernel_buf, sizeof(kernel_buf));
> +			return size;
> +		}
> +
> +		uncopied = copy_to_user(buf+offset, kernel_buf, size);
> +		size -= uncopied;
> +		offset += size;
> +		count -= size;
> +
> +		/*
> +		 * If the user copy failed, we still need to do another ->read()
> +		 * call if we had a cookie to let the ldisc clear up.
> +		 *
> +		 * But make sure size is zeroed.
> +		 */
> +		if (unlikely(uncopied)) {
> +			count = 0;
> +			retval = -EFAULT;

n_hdlc_tty_read will return EOVERFLOW when size is 0, so this EFAULT is 
never propagated, if I am looking correctly? n_tty seems to be fine 
(returns zero for zeroed size).

> +		}
> +	} while (cookie);
> +
> +	/* We always clear tty buffer in case they contained passwords */
> +	memzero_explicit(kernel_buf, sizeof(kernel_buf));
> +	return offset ? offset : retval;
> +}

thanks,
-- 
js
