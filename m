Return-Path: <SRS0=oIqV=4B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68841C2BA83
	for <linux-serial@archiver.kernel.org>; Thu, 13 Feb 2020 07:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C28F2168B
	for <linux-serial@archiver.kernel.org>; Thu, 13 Feb 2020 07:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgBMHJg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:09:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38872 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgBMHJg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Feb 2020 02:09:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so5290704wrh.5;
        Wed, 12 Feb 2020 23:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J3K0u5WWat7kpFEhwrqazkouqt3s/kS3rmr7MpKdoBs=;
        b=g1J4FQc/zwFfTklteRywxbWbs5Krq9sPmF/G+Yiy/qbkoOEkpAGKuyamU305bO3p6m
         7Tes28Dve2Zcb50n3SC/exBlvOUbyV57B7WVOaS36MEoY3UDcdHwRZHksfUW06o6LQMm
         M+jSsRvmZIpBDSx9Nja6x9VWQInWlBbiQs2D9kJ437cIeEXt9AUKFCnmBZ+O/kN4Sxwu
         FtN+OpOn1lXKp7PA2iwzz9o6JtIkE8MV9j/PA5TaJO7xZG2MdFUez4YAwTMMfCI4WE+y
         JMVrl7p6tZ5vyM9buMi0iPSQSTqRQiqqAsXjQaI2BUFKbp/7OtawrbldEo2d8GUqTGI9
         MvuA==
X-Gm-Message-State: APjAAAWizCuvVKu/1UsycOS7hZgfqnYEqrndKrpeMeyFAxiWUp9aGU+D
        vIjqjyKZGe4obl20JD76Z+c=
X-Google-Smtp-Source: APXvYqxFG4bxdSx7K4piV8BoVGgSCUzHCMMIpsl3kVnTobwd8EV5D168tj/DUH/Oy3V7VoOBsuy1Qg==
X-Received: by 2002:adf:ee0b:: with SMTP id y11mr19688393wrn.62.1581577773513;
        Wed, 12 Feb 2020 23:09:33 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id q3sm1628699wmj.38.2020.02.12.23.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 23:09:33 -0800 (PST)
Subject: Re: [PATCH 2/2] vt: selection, close sel_buffer race
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+59997e8d5cbdc486e6f6@syzkaller.appspotmail.com
References: <20200210081131.23572-1-jslaby@suse.cz>
 <20200210081131.23572-2-jslaby@suse.cz> <20200212195909.GA2081344@kroah.com>
From:   Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d293a76e-5385-9517-8de3-4281b0bb804a@suse.cz>
Date:   Thu, 13 Feb 2020 08:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212195909.GA2081344@kroah.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12. 02. 20, 20:59, Greg KH wrote:
> On Mon, Feb 10, 2020 at 09:11:31AM +0100, Jiri Slaby wrote:
>> syzkaller reported this UAF:
>> BUG: KASAN: use-after-free in n_tty_receive_buf_common+0x2481/0x2940 drivers/tty/n_tty.c:1741
>> Read of size 1 at addr ffff8880089e40e9 by task syz-executor.1/13184
>>
>> CPU: 0 PID: 13184 Comm: syz-executor.1 Not tainted 5.4.7 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>> Call Trace:
>> ...
>>  kasan_report+0xe/0x20 mm/kasan/common.c:634
>>  n_tty_receive_buf_common+0x2481/0x2940 drivers/tty/n_tty.c:1741
>>  tty_ldisc_receive_buf+0xac/0x190 drivers/tty/tty_buffer.c:461
>>  paste_selection+0x297/0x400 drivers/tty/vt/selection.c:372
>>  tioclinux+0x20d/0x4e0 drivers/tty/vt/vt.c:3044
>>  vt_ioctl+0x1bcf/0x28d0 drivers/tty/vt/vt_ioctl.c:364
>>  tty_ioctl+0x525/0x15a0 drivers/tty/tty_io.c:2657
>>  vfs_ioctl fs/ioctl.c:47 [inline]
>>
>> It is due to a race between parallel paste_selection (TIOCL_PASTESEL)
>> and set_selection_user (TIOCL_SETSEL) invocations. One uses sel_buffer,
>> while the other frees it and reallocates a new one for another
>> selection. Add a mutex to close this race.
>>
>> The mutex takes care properly of sel_buffer and sel_buffer_lth only. The
>> other selection global variables (like sel_start, sel_end, and sel_cons)
>> are protected only in set_selection_user. The other functions need quite
>> some more work to close the races of the variables there. This is going
>> to happen later.
>>
>> This likely fixes (I am unsure as there is no reproducer provided) bug
>> 206361 too. It was marked as CVE-2020-8648.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Reported-by: syzbot+59997e8d5cbdc486e6f6@syzkaller.appspotmail.com
>> References: https://bugzilla.kernel.org/show_bug.cgi?id=206361
> 
> This needs patch 1 in order to work properly, right?

Not necessarily -- the patches fix two different bugs (endless loop in
kernel vs crash). If you want to apply them in the opposite order, just
let me know.

BTW I completely forgot to add Fixes and Cc: stable tags. Both of the
issues come from 1.x times. (But the crash obviously needs
SMP/preemption, i.e. 2.x.*.)

thanks,
-- 
js
suse labs
