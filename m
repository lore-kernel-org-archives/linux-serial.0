Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E1C001B0
	for <linux-serial@archiver.kernel.org>; Mon, 14 Aug 2023 06:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjHNGcU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Aug 2023 02:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHNGcG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Aug 2023 02:32:06 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10872114
        for <linux-serial@vger.kernel.org>; Sun, 13 Aug 2023 23:32:05 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-317744867a6so3564720f8f.1
        for <linux-serial@vger.kernel.org>; Sun, 13 Aug 2023 23:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691994723; x=1692599523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNpB4dzhoH7Uv8KV/Z37AHda1sPJ+XsRhVvh+VoHnxE=;
        b=jVuR0maJyzGJjIXBuwH/GzdakOvQH1JtBTpeSmIiccsyXJJoFkysu20YX1zHdyZlIs
         5poo6NX29CMEh2/1jVfHamJh7WK9htq85vw+plRfPbX6MPW1Q4mVDBygZYaYGIorTxUG
         Ow/7U369g2h6urkat00zsXhKmRKu0nPHcsebe4Nz2VLhbCLsP4ptPfHCjmeIOIruNK6I
         uEgDJkRKupZc+ps2VWDtfOuvHpABpdrn8SJft6mqA2yLGt1KjUFwOxS5vgB4BfRj5c+N
         jwLMTxkZNNrIBf7cfxqZE2qWrgibddyZaSfqZ6bPxCwATyUv+5tHxnHFc5zc88S5Ghf9
         GYcA==
X-Gm-Message-State: AOJu0YwiTVLzCpRuiQ+KxjngCWWOC1+pJuDHxKZ+CDOY3mlo9d1CYDJk
        cEmp9IzXbWgVa4+ryuk1c7g=
X-Google-Smtp-Source: AGHT+IGTUQR1sLEeHoHLQ/j5qk0U1vrOoxrMhGb/9CdIipo9hxapBKL02ZgBIAAeuHQentBEVv1flw==
X-Received: by 2002:adf:fcd1:0:b0:319:5bde:df70 with SMTP id f17-20020adffcd1000000b003195bdedf70mr5612951wrs.42.1691994722976;
        Sun, 13 Aug 2023 23:32:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id t11-20020adfe44b000000b0030fd03e3d25sm13549363wrm.75.2023.08.13.23.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 23:32:02 -0700 (PDT)
Message-ID: <16025ce7-e0f9-fbcc-a961-9f729cf357c8@kernel.org>
Date:   Mon, 14 Aug 2023 08:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tty: vt: selection: fix soft lockup in paste_selection()
Content-Language: en-US
To:     Yi Yang <yiyang13@huawei.com>, gregkh@linuxfoundation.org,
        alan@llwyncelyn.cymru
Cc:     linux-serial@vger.kernel.org
References: <20230814040131.79439-1-yiyang13@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230814040131.79439-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 14. 08. 23, 6:01, Yi Yang wrote:
> Soft lockup occurs when vt device used n_null ldisc, n_null_receivebuf()
> is not implemented in null_ldisc. So tty_ldisc_receive_buf always return
> 0 in paste_selection(), this cause deadloop and cause soft lockup.
> 
> This can be reproduced as follows:
>    int ldisc = 0x1b; // 0x1b is n_null
>    struct{
>    	char subcode;
>    	struct tiocl_selection sel;
>    } data;
>    date.subcode = TIOCL_SETSEL;
>    data.sel.xs = 0;
>    data.sel.xe = 1;
>    data.sel.ys = 0;
>    data.sel.ye = 1;
>    data.sel.sel_mode = TIOCL_SELCHAR;
>    char bytes[2] = {TIOCL_PASTESEL, 0};
>    open("ttyxx", O_RDWR) // open a vt device
>    ioctl(fd, TIOCSETD, &ldisc) // set ldisc to n_null
>    ioctl(fd, TIOCLINUX, &data.subcode);
>    ioctl(fd, TIOCLINUX, bytes); // cause deadloop
> 
> Fix soft lockup by check if ldisc in paste_selection() is n_null.

Ugh, no. What if another ldisc returns with 0 too?

So instead, what about checking for progress instead of checking a 
particular ldisc?

> Link: https://lore.kernel.org/all/000000000000fe769905d315a1b7@google.com/
> Fixes: 8a8dabf2dd68 ("tty: handle the case where we cannot restore a line discipline")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>   drivers/tty/vt/selection.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 6ef22f01cc51..9ba7f66fcf05 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -388,6 +388,12 @@ int paste_selection(struct tty_struct *tty)
>   	ld = tty_ldisc_ref_wait(tty);
>   	if (!ld)
>   		return -EIO;	/* ldisc was hung up */
> +
> +	/* tty_ldisc_receive_buf() will not do anything when ldisc is n_null*/
> +	if (ld->ops->num == N_NULL) {
> +		tty_ldisc_deref(ld);
> +		return -EIO;
> +	}
>   	tty_buffer_lock_exclusive(&vc->port);
>   
>   	add_wait_queue(&vc->paste_wait, &wait);

-- 
js
suse labs

