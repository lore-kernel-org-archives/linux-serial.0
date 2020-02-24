Return-Path: <SRS0=FrDw=4M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1591C3567B
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DAF20714
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 09:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBXJ0z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:26:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56230 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgBXJ0y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Feb 2020 04:26:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so8203203wmj.5;
        Mon, 24 Feb 2020 01:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=20Q5cxgzoMb8nDIhMyIGzGnGFsJl1Kj/bajwVttwp08=;
        b=TiglPdHyR8++Bmeyhr31wr8OZMcwkIrdgd7mzbbgBuCTV5GUu5oJ4H4B7GnTwKlqwH
         FrGqaPFiWRtYMw3WIf6A38Uy9nMjuuBtq5umxRrcNpnE/q1u1EfNoUORmqZNItTd1tri
         ijBB/DpC9TdyXBVCfOYy62dpVLEI76FWDePW/Uai8zvU9ybeovJCSvajDFucjWPDIBld
         zuv4Kjt0ZyoVx1xwNW+c4j6616mxdWwWzlXNyD24z/H1FgMupH8ZWsiRt5TklJrdo0Ui
         QNOH6dTjMbbveHbbi+oDOEkoxrsGErljYff9U91OaL6n1zp/IIwIzbDhnKUknVT6jvlB
         YDYA==
X-Gm-Message-State: APjAAAURahzsPR9VDZpqojEhtEXNs2ih+06qDT50zDVXTnZR+JFkcVIA
        lZmFZvNgE7upgx/RG2xVEZOb7/92m7c=
X-Google-Smtp-Source: APXvYqz/V2X9bckLbnmKWQwxtfddFxtlfDfFWc43keh3pg+X6toEDlyFZjlcTPV0FcCPyyocOHwABA==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr21591837wmi.116.1582536412413;
        Mon, 24 Feb 2020 01:26:52 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t3sm2752752wrx.38.2020.02.24.01.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 01:26:51 -0800 (PST)
Subject: Re: [PATCH 3/9] vt: selection, remove 2 local variables from
 set_selection_kernel
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200219073951.16151-1-jslaby@suse.cz>
 <20200219073951.16151-3-jslaby@suse.cz> <20200221093251.GA90355@kroah.com>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <75287ce8-d2ce-9c00-601a-486757e8860b@suse.cz>
Date:   Mon, 24 Feb 2020 10:26:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200221093251.GA90355@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21. 02. 20, 10:32, Greg KH wrote:
> On Wed, Feb 19, 2020 at 08:39:45AM +0100, Jiri Slaby wrote:
>> multiplier and mode are not actually needed:
>> * multiplier is used only in kmalloc_array, so use "use_unicode ? 4 : 1"
>>   directly
>> * mode is used only to assign a bool in this manner:
>>   if (cond)
>>     x = true;
>>   else
>>     x = false;
>>   So do "x = cond" directly.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>  drivers/tty/vt/selection.c | 14 +++++---------
>>  1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
>> index 714992693974..6541c09d8bba 100644
>> --- a/drivers/tty/vt/selection.c
>> +++ b/drivers/tty/vt/selection.c
>> @@ -191,9 +191,9 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
>>  	struct vc_data *vc = vc_cons[fg_console].d;
>>  	int new_sel_start, new_sel_end, spc;
>>  	char *bp, *obp;
>> -	int i, ps, pe, multiplier;
>> +	int i, ps, pe;
>>  	u32 c;
>> -	int mode, ret = 0;
>> +	int ret = 0;
>>  
>>  	poke_blanked_console();
>>  
>> @@ -224,11 +224,7 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
>>  		clear_selection();
>>  		sel_cons = vc_cons[fg_console].d;
>>  	}
>> -	mode = vt_do_kdgkbmode(fg_console);
>> -	if (mode == K_UNICODE)
>> -		use_unicode = 1;
>> -	else
>> -		use_unicode = 0;
>> +	use_unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
>>  
>>  	switch (v->sel_mode)
>>  	{
>> @@ -312,8 +308,8 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
>>  	sel_end = new_sel_end;
>>  
>>  	/* Allocate a new buffer before freeing the old one ... */
>> -	multiplier = use_unicode ? 4 : 1;  /* chars can take up to 4 bytes */
>> -	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, multiplier,
>> +	/* chars can take up to 4 bytes with unicode */
>> +	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, use_unicode ? 4 : 1,
>>  			   GFP_KERNEL);
>>  	if (!bp) {
>>  		printk(KERN_WARNING "selection: kmalloc() failed\n");
>> -- 
>> 2.25.0
>>
> 
> This patch fails to apply to my tree, so I stopped here.  Can you rebase
> and resend the rest of these?

Could you be a little bit more specific? After the rebase, it still
applies cleanly for me. Perhaps the tree you are applying this to was
missing this 5.6-rc3 commit:
commit 07e6124a1a46b4b5a9b3cacc0c306b50da87abf5
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Mon Feb 10 09:11:31 2020 +0100

    vt: selection, close sel_buffer race
?


thanks,
-- 
js
suse labs
