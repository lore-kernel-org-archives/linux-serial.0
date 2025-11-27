Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972B3314D0
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247416; cv=none; b=SBT2qqDItEPU05vWk4NRW+Vld1XuKGj1NpBgoNVq4Ich3IYuXO4YyvaPFJ67Z16f+T+3e1qfUAY21YjU6VNQhPDChAPgA+atj0FuBFFK80as0s7G2pBifBSJi+4hW5QQM2W39WH+9e25TOCAnpIo7HTZB5LooJ1aD1PzPVxQbzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247416; c=relaxed/simple;
	bh=XUQkhcssr2+hKTZBZ0Iw6Fsn0YM4ZI9m9w9Yi9VmXgk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bSK3xGbKkzePdOhPC292vu1SEI85/LUddHkpE1QorbeswwLXK5cxBEpU0agV+D60OKFr1ASWprAQzOY/D1RG4ZDv3i7CsKHnDbXNWXdGIKZv4w6UmPgb6Rc9fERSfIyFow4Czq4CHHFes+rLHra5teCNcU5Eqk4vEbqUbrV9zeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433783ff82aso6246245ab.1
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 04:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764247413; x=1764852213;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmJvKc0ngNMmCHYenga8E2cEDiXaXRhGIq9CuNfMUhU=;
        b=uU2pvc6NPKxI/B1at8feMdID9lc1IEN1ClBkaW55taAGukVJUOXsVa7nZXA2iXMfPg
         zwYBpMssozwncDds64Q4nv2l/Wg2I3lQfGkMg1G401zcnxS5XFYsH3RqGdQBlqjqTgZ2
         G9OrwU4xEGJ9qpgl8TSDIz+Mp96m33b04+jHu7fI4AUoQPzXyJpwn6z1EFkmzjjabOFF
         YOyyLgQ24/PELFjQ2uOoaBSUuHKZw36EILeimW+XLdxo9CVheoV1pv/WJA3jOOJWHzJj
         woh0N6AoGeAF9SFgV8cyu928fTMCgLQC+iaGuAm3i3e1PHIX+vTPOSwwxvANCZ0ld1uQ
         FO6g==
X-Forwarded-Encrypted: i=1; AJvYcCVKvHaRN43QOeVw5Vbtty0KA2eS6Q3OymC+F49HO6nIWJstdT1XvmeAEinvyp5SKrm27RDyrIvlLUFrhbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLrYIwCc2pdeYEIOtaptVjZZX7oiXFY0BYx99sZRa586ELBun
	Gzl76e1QG1Iix2KR+GR1595u8AohoYyTe29FaZSJEsgUkxYJPjnPcHnwKZRE9y3BLp2P2aLNCbP
	JjKvBW28chPKJ9SbXxXi8bBxCx1hiYz89Hy5lhjvrKqlLkUFODNlu6ARO29Y=
X-Google-Smtp-Source: AGHT+IE3Pz6++lW1So5OrL9s0oBipHo+baYtqby6MY75C72DVHqE/lRhKhFaRvbj4ij35v1QWDShDMKklulvxx04unECgCxXZ6Ny
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:351e:b0:434:7d59:cb21 with SMTP id
 e9e14a558f8ab-435b8c11a70mr182267975ab.17.1764247413578; Thu, 27 Nov 2025
 04:43:33 -0800 (PST)
Date: Thu, 27 Nov 2025 04:43:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69284775.a70a0220.d98e3.0105.GAE@google.com>
Subject: [syzbot] Monthly serial report (Nov 2025)
From: syzbot <syzbot+listb3c2fafc8b21611fec16@syzkaller.appspotmail.com>
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
<1>  2655    Yes   possible deadlock in console_lock_spinning_enable (5)
                   https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2>  2113    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3>  1101    Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4>  232     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<5>  225     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<6>  203     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  166     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                   https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<8>  117     Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<9>  88      No    possible deadlock in kbd_event
                   https://syzkaller.appspot.com/bug?extid=781c8bb5e4d62cc883d3
<10> 41      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
