Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB72FD1A1
	for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717578; cv=none; b=f8nVMbWKtrOMsZnjvArMENds+6HEV6+vX3ocX9sRsE5n/X5js5t6i0aGKBYrIkJf/cRX3kI1fck0sIfqsf1nXNXVAppkAKQxckxH1TLSwkopouDrXE/iGvaPpmVyDrWUeXLp1zb0emQPag5cJ9XtLXULHyyylX6dtg0FgPoF+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717578; c=relaxed/simple;
	bh=5BwmEdgvAJeOLJOLJEyAwxDLf/GBX79xvmdWxwHrbtE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IosD05wiNosZCJZldC4gfBe7umqx7W7CDlkbzp1woUeT+XbHFEZeSDe11kIrj5hgakGhSqB5xu/X9Hu9lLPXSSMCkw2wb1QGxaqdjleAN7vVUCn8V8ZFThABJNtMOY0GGSLWxOH/Ux4O0zQLytLx5RyvUnLB5WUpTHnyJTExli8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257ae42790so45454595ab.1
        for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2025 05:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717575; x=1759322375;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvO3WHZV4cUjsOPSkxBuW5KvvwCRHLzz8NDfDahuqGI=;
        b=ppCoHXqu7SF7kefxZGpd+lhLT+IkZAkOPlv/fIF8aT5HExKWLK+kv/wGUgxZ17e0i3
         G+oStlniRs94pTZebjmc6HpJYL4EkYDypagexTCg+mjfNCWthMcsDI/ZcOOyX+/P/KEZ
         YopqPCI1D60wmvxymxtTbFSG/KiTGGtC36gsJSsgNZYiPuRkDw7I47rPCcHjtqNlNv+T
         mqj9fvC3dxjnQ7iKLIsytdKgWSJA7eJC3rT/R+rRZ5YhdSKyXXDWbWwQ6DGiKglw6i95
         hPlYaWcxdDHhUUkZ0kjmEA0wwv8oolBwnXQL7FMZ/jG975u6X7kqdM9URHsXsi6I8UAO
         e5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB9sMNq7EbrSXnoQwOQgXhsERiZDkv3vIV3wqiPbEYu4oi/hU+lAFM/W8nARv9iLnu9CSrccKmjDpEZ3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JZv43WsXdTqaReVMcbWcUizxDk1uAK1v2xiTIiGE2foSPbCD
	RBUwZgn/rD9Wpqs1xw4X+GJ2RheO6BoZB7LO84cuW1NlrYYM4WZHCkT+n3mEH5lvf+62YXJdxOC
	kmmRkOXuZ22uUNcA7ENnF/WyxymuQoCIsdMJnyhhdFWpidDQZn6CXI0wxTx0=
X-Google-Smtp-Source: AGHT+IEGveIykwsH6KF8mV4UM8C3AOfoVJfD8lgaDmGPexiehp1Ex32ruLFEFEaX22tmDxjG5SfTXRlc+IYEJiXDODgE/yqrm128
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1948:b0:423:f924:c885 with SMTP id
 e9e14a558f8ab-42581e283d4mr108709865ab.13.1758717575504; Wed, 24 Sep 2025
 05:39:35 -0700 (PDT)
Date: Wed, 24 Sep 2025 05:39:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3e687.a70a0220.4f78.0026.GAE@google.com>
Subject: [syzbot] Monthly serial report (Sep 2025)
From: syzbot <syzbot+list3b642417f17c4ad05039@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2398    Yes   possible deadlock in console_lock_spinning_enable (5)
                   https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2>  1662    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3>  398     Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4>  219     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<5>  210     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<6>  167     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  105     Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8>  31      No    KMSAN: uninit-value in gsmld_receive_buf
                   https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<9>  31      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
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
