Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC623FC66
	for <linux-serial@vger.kernel.org>; Thu, 24 Jul 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349563; cv=none; b=MJYECcKjEvOc4TkxQR6BdFfLtoTpOExcPK/8o00i9jyGq66cxvHRr3l47Yr14ZeuZMLbh21mBbb6WWrKGbOWYnelI6O2GBRtre+vwe8mlx0X5Y1xj/M0rJ64rzWYRt/EToONc7jxbwIluEOklgMZsAwUqZavaRjRxhtSNy72XFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349563; c=relaxed/simple;
	bh=j4p4THpEVFUK46+TOZqx0eQQ+UWYfOVBiPoxtJt273E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T+p+nUjpfOFiRv6e07CLjLs6GCePeULHfGhkvnQUrcIikWdEfNFKhcfkqat39IwESzqX6DnjM9zxsITe6z2+tlf2oCGeXFRP6P/+GcVY8yOCxrnFvVxtYel42VK56KUwxl/dmkp5eWnOOVTZOFHJSGU3YTEw4UIuGMSNCwaxXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c3902f73fso104979339f.1
        for <linux-serial@vger.kernel.org>; Thu, 24 Jul 2025 02:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349561; x=1753954361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2H5dzT8NL0tMEJpZJfICvEHpJw1At6ZGLFZ40FERow=;
        b=Yx6TXCq8lIR8j89C5cT8Atm1nZsg5oyhBXa14+Cot17+iDTjba2IdeQ4/j/SptuId4
         V6ThwgseXgpcFJ8AT6FWrcnUDtFC5HFSsKaNrqDUTNnrCKtdqmJnYLTn2Hhf2mvzN+fD
         hXOOIqYnWmT3q457q3gPMWdb7SOqVqm0dBIPkwh2qlIrB+lMOwiIR3ktFvFn77vI1Puw
         1ie0L3sYls1ilnI2BdQQ8XfM4QVJVutEcmKLMmNATEdEpLXhXPM9Q4v0jdqATAoZBd1z
         7n4onvE/eeIYmyeplYfUjfGZ8j+4ZU0ljrVH20w/t8oUPAgbkbyyErkeF36A2qc7OCk8
         T/kg==
X-Forwarded-Encrypted: i=1; AJvYcCWRHbM7pyA3FSea8E2heTv+Xz7RbiF4YlqTKuHUuotnUn/KjJyivg3ROQOny4kHUf/6MeuwDhe6FPAXQJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySlOn0X7U4RmzfX5ixhD6kfIYTpmaV/sXxAzwl2Qpb47QXUiL4
	D/HRBIGbj0+yb+2nOyph7HstfMtveOXx5t4sqEj1sq3OruHqu9lilpTtsSpymeKZPBCZK4GfTeJ
	BRHdWKtdSki6CyWQPjlq/6LHDsd4fQ/LnbpYmcyXXgjw+gS6XGUF8ZLJK5qU=
X-Google-Smtp-Source: AGHT+IG5QFzKoITOD9BpPcKom45fYQPXGIT20DHfeLB2FlHkxEPv6nWtvHnXD/mqjlKGh2xecliL6OJl73tBFvifT/bzybj1u1/3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1503:b0:87c:1c2a:3cd2 with SMTP id
 ca18e2360f4ac-87c762076c3mr181596239f.5.1753349561400; Thu, 24 Jul 2025
 02:32:41 -0700 (PDT)
Date: Thu, 24 Jul 2025 02:32:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881fdb9.a00a0220.2f88df.001c.GAE@google.com>
Subject: [syzbot] Monthly serial report (Jul 2025)
From: syzbot <syzbot+listf09721d34cbf05dcddc5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1359    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 196     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 189     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 138     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5> 96      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<6> 77      Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 24      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<8> 18      Yes   INFO: rcu detected stall in console_callback
                  https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<9> 17      No    general protection fault in n_tty_receive_buf_common (2)
                  https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
