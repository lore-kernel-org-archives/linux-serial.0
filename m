Return-Path: <SRS0=YLjw=4T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915DC3F2D2
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 06:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5952468E
	for <linux-serial@archiver.kernel.org>; Mon,  2 Mar 2020 06:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCBGm4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Mar 2020 01:42:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39608 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgCBGm4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Mar 2020 01:42:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so11020066wrn.6;
        Sun, 01 Mar 2020 22:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DAG9cmWmVJzMYyOlx6UPKwvFKQax568BaQjSnLCNBOY=;
        b=SDJqrimLVbCe8o9SjkQCpW0zvwUbNiiItq1mIr3dfCs/GyB+QknN2x4TJbdMRhwMOQ
         ydLaxtQB0bJn3zKDMthulF/k6HPOaOHHfizvuY8emn6/GPRDwvQUQ2DFDbkUzRCKYrv/
         lZM6i+Pu53AtpeVfFlHpG8tOcmootBXcAQve9N0PN6c0FdEI4r50SqYW5D61dz0fiG+V
         VzvudrV5YbmxpXdvCV/fpBqB4vWghefvqp+7xmRosYes31/ZSDFHjqk8B1M0Z804/OLV
         Aydft8nh1EAYFyeunMq0xEqRe8GxQ/WDUom9NIG/w+bGtXqUAFVRdnhNnLa5xoEX6fMx
         Qp9w==
X-Gm-Message-State: APjAAAWNHslLlBYUsZBXL/cp1D2aVXA0YkLVYBzXYPavorf199OesfG5
        2tNW/mZc/dYAHJBLBTjJrW1sPLsFC1c=
X-Google-Smtp-Source: APXvYqz4uK3JkmbLgd64jVtxXhhdNhDYl6H0WhWZekAovtV+rXkSl+fsAuTWSh5n8vLSv2frSILj+g==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr21451636wre.372.1583131373888;
        Sun, 01 Mar 2020 22:42:53 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id j5sm26902861wrw.24.2020.03.01.22.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 22:42:52 -0800 (PST)
From:   Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] vt: fix CVE-2020-8647
To:     Ye Bin <yebin10@huawei.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200302023553.44792-1-yebin10@huawei.com>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <154cd686-f9fc-a709-7624-4565efc0a789@suse.cz>
Date:   Mon, 2 Mar 2020 07:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302023553.44792-1-yebin10@huawei.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

you should use some better Subject. "vt: fix CVE-2020-8647" is not
descriptive at all. Something like "vt: fix use after free in
vc_resize". You can reference the CVE in the text if you want.

On 02. 03. 20, 3:35, Ye Bin wrote:
> We must calculate origin buffer end before update "old_origin", or it
> will lead to access illegal memory.

You should explain why we must. I.e. how the bad access can happen.

> BUG: KASan: use after free in vc_do_resize+0x49e/0xb30 at addr ffff88000016b9c0
> Read of size 2 by task syz-executor.3/24164

For sure, the report mentioned a Reported-by line you should add to the
fix. Could you do so?

> page:ffffea0000005ac0 count:0 mapcount:0 mapping:          (null) index:0x0
> page flags: 0xfffff00000000()
> page dumped because: kasan: bad access detected
> CPU: 0 PID: 24164 Comm: syz-executor.3 Not tainted 3.10.0-862.14.2.1.x86_64+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
> Call Trace:
>  [<ffffffffb059f309>] dump_stack+0x1e/0x20
>  [<ffffffffaf8af957>] kasan_report+0x577/0x950
>  [<ffffffffaf8ae652>] __asan_load2+0x62/0x80
>  [<ffffffffafe3728e>] vc_do_resize+0x49e/0xb30
>  [<ffffffffafe3795c>] vc_resize+0x3c/0x60
>  [<ffffffffafe1d80d>] vt_ioctl+0x16ed/0x2670
>  [<ffffffffafe0089a>] tty_ioctl+0x46a/0x1a10
>  [<ffffffffaf92db3d>] do_vfs_ioctl+0x5bd/0xc40
>  [<ffffffffaf92e2f2>] SyS_ioctl+0x132/0x170
>  [<ffffffffb05c9b1b>] system_call_fastpath+0x22/0x27
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/tty/vt/vt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8fa059ec6cc8..1d7217bef678 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1231,6 +1231,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  	old_origin = vc->vc_origin;
>  	new_origin = (long) newscreen;
>  	new_scr_end = new_origin + new_screen_size;
> +	end = old_origin + old_row_size * min(old_rows, new_rows);
>  
>  	if (vc->vc_y > new_rows) {
>  		if (old_rows - vc->vc_y < new_rows) {
> @@ -1249,7 +1250,6 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
>  		old_origin += first_copied_row * old_row_size;
>  	} else
>  		first_copied_row = 0;
> -	end = old_origin + old_row_size * min(old_rows, new_rows);
>  
>  	vc_uniscr_copy_area(new_uniscr, new_cols, new_rows,
>  			    get_vc_uniscr(vc), rlth/2, first_copied_row,
> 

thanks,
-- 
js
suse labs

-- 
js
suse labs
