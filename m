Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A942D6608
	for <linux-serial@vger.kernel.org>; Mon, 27 Oct 2025 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544475; cv=none; b=LtGk6TJpSJC/v4DnHoUAj6mgTO2buWPE1mtoP0Tl3yegOS4ggK9Qe8AjosIFIrGAhEXa5A5Uq6qqfLAIF1mMhT/NGjThKL3ezcWD2VI95anmK2u4BeKOrv7Sd+ZHcdGAMTQ2qUcQtyNudOVgVpmxUgIKGJwrtQATUI5JiCEVulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544475; c=relaxed/simple;
	bh=PztpVAs3drt48jvt9eLs4KEy4sHiRmkCetB9IDuYzdY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bEI9+JI7Y2VPTWTuxgldgO50pbDBBUNvw6hNj8MfiKJMEn3YhA8F/eFvC25zUpp0UhKmb5c6BN281MwV6+jL2w13aQhLcfQyJ+JS7HlkpylPAnJkg+5zASrsDQuSIzlS0V+vUr63gpuQDr0Q+qD55QAljZE1fK2J9ouwdy3JUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8092427aso428115439f.0
        for <linux-serial@vger.kernel.org>; Sun, 26 Oct 2025 22:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761544473; x=1762149273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHSw8fUQiPVOwSm1qjuED0GSm7e0skLcOl1YEGJaMZc=;
        b=Cpn/2qEmjfZYVCyEBvjEteSPiZFp6qVh5fu6FKihs60ovYVNXB5T5Qy+bNaGBaa3am
         AAy+Dhx4ZY/6XjpXRlJtWM5rRoYyYyTTDJyDTFVpFO2k40c6jZTou4TPvPk03jSt1vM+
         jW22Xc7eIkhGSjNTIHkN0gezLqmDdiQG0iSmgmvJc7md7D2uB670S5+oKgLxTiYhIeI/
         W9wXXnakCR47Jy/UKd134ezJyy4MLbE4ZCsH/e/p3hiP7FfsmVUjZFomo/Dpp3hAEIIQ
         qd7sQEV/PSgzH8hV0cQW6HvjlFEXXvthy0Ij+G3js5goYDVM64CpLFZWPK9NtUKamTBO
         P8tg==
X-Forwarded-Encrypted: i=1; AJvYcCVaaffLg/9nJf9cyyp+2t8HqZhhggt/Oe8WACBxALa0R/QPStBT+7LvZ7Gzv/mmX3nGI2Pv8cf7tZke6dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqGhXEWwcXIUx/Ts8ZHBx26EtTguNM0hI8Rb3SmUQCWlj7dDJ
	W0KD/mcjdPn474VFYw9jCjFEfnQCcXZy1VxlRTazAnHNGEWFnRvvzJe31bMKYo4FyC92cihRjWG
	0r83mj83NmWwp7NpTpPl5QF7OZvi9BqmqRHUf9F59HzGbavhNemygRsHQBAA=
X-Google-Smtp-Source: AGHT+IElPz7lInqcyPE0acwJcdaaoIb5AJ3HEuFkfO6w744ftpIW8TXqSBX4XNn5UEURG4vVydUBvRs6Au8X+MqpJKccAKZ8g1ZB
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c5:b0:429:b49:7351 with SMTP id
 e9e14a558f8ab-431ebea7a17mr119796285ab.19.1761544473174; Sun, 26 Oct 2025
 22:54:33 -0700 (PDT)
Date: Sun, 26 Oct 2025 22:54:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff0919.050a0220.3344a1.028a.GAE@google.com>
Subject: [syzbot] Monthly serial report (Oct 2025)
From: syzbot <syzbot+list4bcc9e973f97dc44b961@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2490    Yes   possible deadlock in console_lock_spinning_enable (5)
                   https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2>  1829    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3>  908     Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4>  223     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<5>  221     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<6>  188     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  115     Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8>  36      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<9>  31      No    possible deadlock in kbd_event
                   https://syzkaller.appspot.com/bug?extid=781c8bb5e4d62cc883d3
<10> 18      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
