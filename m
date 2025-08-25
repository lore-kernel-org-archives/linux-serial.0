Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F27080D
	for <linux-serial@vger.kernel.org>; Mon, 25 Aug 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111480; cv=none; b=FuwmtAxja7sWKxeV4fPZaWzqd2+REABQpRB3RMtRPYf3D8ghw0P4pRKY8H66H2gyrqfvmDtB3thPD2HfZ0pyDhWMy6l2Js/V5Z+XHX5rws8gPqvA0LrU9zb3alGmuLXAo7t/yzAiBoH3p7SEP8BsOgZk1ij5Vzh4tYzirpJx8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111480; c=relaxed/simple;
	bh=Qx0EHnxhtjRTgy0Yc6CzMXRY5epJDTWnoDhJh5mpf7k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MptR+chNdoT2UOh/aVj7aac+s128rJt9Q1GlBVJdzFufpPuecxoqnMCS431cdz7ys9ZNU7Oxl2J0tsUvLchIRRh0oeoPVRluGPfY1+3EXxCrrnWgk0kF2qqcY6sOYydYvcl2ysI4cewgwoKp6CtR5X9W+oCpXhEGCyFsU/KnbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ed8c5ffa82so2878535ab.2
        for <linux-serial@vger.kernel.org>; Mon, 25 Aug 2025 01:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111477; x=1756716277;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QejM8CXnArY2Z2VtT+tzHm/yfYtQ1A2A3xEkQg/zxAs=;
        b=FrLhp3aHE5zxt7+ckuFM4Ok9bXwaJhDH6WOvokV1kmbzbPCwLBkUScJkc4/Np6svth
         5+DnRadV2cdNbVipIFtFZVTN75lYEaHvKUbnx9X/hsNsfOsioKuRegPz0T6gMcTaYX1r
         94ZxAtjt1yXSn2qxJBG3M8RmYsKDFQkjB8ec2GZvKXwQUBSEBeSHX6U6sDHSev7ApzWV
         lrAZiY/SyIe6WQ2Wu5o3vatxpFcXq6Ws6RCz5joMkAZta6GD1jtcN6tR9pi57LvMcjPA
         boHi6g3S3b0Ciqm6BsUeG3jGYPESfSFyTNYShN7ZCNkwmlMrF1xlROj8NdPwkPmFAfbb
         cvQw==
X-Forwarded-Encrypted: i=1; AJvYcCW3ObPhSNDjYMCBE9w+2t9L32TjuPCDSEGKBKXfbNOqszV/cW82W19eHKKTCNVKgqBJHEH5EHa0TenxqWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwopI8Lu8TKcQRM2W9wUssRUI22vcZpseh2tj0q/GKv3YysCdKp
	OObDRMXmidjoSKH1MLB8Xwbd5gCG8oD4aDtBWJ7IdnUoXORkXzGx1zn/WldO7RhkJIp/lTkZvri
	87U35Y8naDBJnNMFnfa3J/EHWHDOABd6b5dlZo6La+5RHubENX1Sug5r3BfY=
X-Google-Smtp-Source: AGHT+IExklVy4RkzKLt1k1C9yMIcJKDJGXqHdt4hcHiXrGxSYT3tvBS0hk1y8LwOXjRNNcgBcbzg8ObZd7lis7tJrnS+wxk6WZKt
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3ed:684e:ce05 with SMTP id
 e9e14a558f8ab-3ed684ecf4bmr11871485ab.4.1756111477622; Mon, 25 Aug 2025
 01:44:37 -0700 (PDT)
Date: Mon, 25 Aug 2025 01:44:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac2275.a00a0220.33401d.0404.GAE@google.com>
Subject: [syzbot] Monthly serial report (Aug 2025)
From: syzbot <syzbot+list55834a7fc215ffb76396@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2317    Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2> 1530    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3> 215     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<4> 196     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<5> 166     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                  https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<6> 149     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7> 97      Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8> 27      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<9> 6       Yes   INFO: task hung in paste_selection (2)
                  https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
