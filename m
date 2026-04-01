Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611940B6E7
	for <linux-serial@vger.kernel.org>; Wed,  1 Apr 2026 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049271; cv=none; b=XeECatmJfGuPZwpIZ5+w/NpFrSpBHO+agb4KErmLQjwDf/RfaQWsFhuIZLJMi8+KQsLrkhtsNi43MFn6++8QqiMXrgG8CC8kV8WmObfJWzYMqo87WkO740Ny6gdpjXaMRfdnCaqFkDeqGghgnCbhsKWK2cqHvDHPuMiJSnRfSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049271; c=relaxed/simple;
	bh=aurErjz5N8eVV+6pZqtKgNk7CL9ADjutQL02OUnahR8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DXpFtdv4FvwXyd0lV3Q4MHl7IxdqJ5ikjRIYJHlj3KpN2LoI55rqsxDdMaRxPP+eSG3pJI5NwcrsoJeRifQfjON2o8H/H2cKsRv+LznQe6RApQKcye7Fm0LzHBoaw+YYfOmJAZDl/0LXbcRiMJYF7WVGHhkFyBLkkzHJB6iNeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d7438fc7f0so10320060a34.0
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2026 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049269; x=1775654069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0eSM/KFvj+mG1XoEaq4GvWFKZLaWUVmlxIGm6V1KJg=;
        b=gmg7ySCe1bdT64mu9U/0f8TJpyazRKezGu3XVIhC4ypjFAGA3fODPcMR3doMbsqJHa
         z5YgoksxiDnNQrGozThKWcHSxyk8lp/mtRTNoFLdu9NZPkGMGcxwj2QQgZA1wVxKRXE2
         IWRPM8DVsWtDutJExcRIKmh/K6CD+yJuot+/A5gB57enZgYH4vXxxGbU0c9ibkheuU4o
         WPPe5EbU7XTMkZJG+3wYm/SzXQsP887aDhd+Gxe/ND1TPXEscY6O8UbVfgRrQCmTj/3z
         m/lexo2zlhMXvAzdalFLPvqGEtp0C4bWcIos7qSlodxsoPsZ3smIjkI5HbbDBbjYKbgg
         buwg==
X-Forwarded-Encrypted: i=1; AJvYcCWuuno+G2qc6+XuZHtTjbsSRBJQ+Cxa8Ax9TuTn/gDJ+2M0CRf3HxyaWLk6p+BUGUxVaQKOfLpP1hCzhPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytya1bqwazMsjReHDqo3F5Z9Stj88PFTF9SM5jusZNHbW+Eabg
	THRQoYKbQGymEbtxGaoMpGg5Z0xcnK9/W3Yk1roOrmAqI6O4gq7iEXJR4ThAuFB1dtm9s0Hp/67
	hWyXzpVjAgpNfeFN+1ThpmGvxPmFuX66nA+nPdh1RSGqdMv54K5Xk5rnLb5U=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1992:b0:67b:b47f:6d7e with SMTP id
 006d021491bc7-67fabd09ed1mr1762189eaf.57.1775049269104; Wed, 01 Apr 2026
 06:14:29 -0700 (PDT)
Date: Wed, 01 Apr 2026 06:14:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cd1a35.050a0220.31cfc4.0026.GAE@google.com>
Subject: [syzbot] Monthly serial report (Apr 2026)
From: syzbot <syzbot+list175ecec2ec17ab87fb41@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3911    Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2> 3418    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3> 310     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<4> 250     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<5> 151     No    possible deadlock in kbd_event
                  https://syzkaller.appspot.com/bug?extid=781c8bb5e4d62cc883d3
<6> 126     Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 9       No    KASAN: slab-out-of-bounds Write in do_con_write (3)
                  https://syzkaller.appspot.com/bug?extid=8e9c1abac3ceb45abffe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
