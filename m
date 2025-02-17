Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF7218842
	for <linux-serial@vger.kernel.org>; Mon, 17 Feb 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796259; cv=none; b=iz2dn+b8JKGiNiofChjbdrNFPbzF2LSSS/C1DsvMCCtO+eQFXSRD+9dWV8C1cF8ve1tIfx5RWX8lTR2NSlJz3OmZYWeKemdRON5/RARLjxlOZepjx4gPcOxr99zzSVn/kugGXiKg/AzehHm7scKcxm5SMEeX8NgI+MCHGwGdNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796259; c=relaxed/simple;
	bh=aejBspab98kEMu3idWjPVw2s5cEoKFhrIZKkhW31lLo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tohJKwkn2yvGdUy45HIWA6xcFyRP5hsm/XAvz23RbCVfsEzwt0v7Ly3FP8mq24OF+jesrM4ueOcXlPv+ZcTmgEVucKOaVdsY4H0BqJdoRyeerVy55YtFbU44upxORKIKSAkhc5mdHxp81XShmnWJ086+4LigdwjcVqxhLuKaAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d18f21d202so31445305ab.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Feb 2025 04:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796257; x=1740401057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKIOjDj7Gj5x+iyQAQD3IBIaAOD34KuOpgNlpMmspaY=;
        b=rY2ImPj5/elyeNS2H2HUHXdXZbwTwtizPlvdoQaUt+GeFXlK+DKZbZ3HQPmjrqVNET
         UZE3PsJpcSKCrEilRkfiJzxBdEPscDrGXQfIMfmv9S7/LJM+pN0Xt1Pxb6gFkoAjmOBL
         iigajEWFd8MWzq/Gea9gDD+ajfemeDVOLd5X871Q38EWTKDamcAFU5touQosPFtC5PPJ
         NZK0aAUeM7R7cjpK0OcqD+kHUQxGvnEkWzBGSLqu32IE/Ve08BDsgNaojxxhg/a5Agzz
         v/PvJu46XHSHcO9OULiii5CC+zKi9Yq/JcLDN+epmQsIgr0Yf/8/O6sQbJiejn/zorTY
         dLdw==
X-Forwarded-Encrypted: i=1; AJvYcCUlJvnIR+P82BGk8BQJuIl0QOC277B0xOM7y4ZtFN+hsyF/Px2DtlLPgA79Jv6YrHswHimGK1KttPU2VXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNepijPh1HgJAdn59/pdnziNrn/mb8vQpvWMxttGgQCDyhm57
	vByDG6Ve/QZfmrznT4buMEtfCtPrXQYD99YinxCljQZhZnZUlEXPbNbp7IRswqC1/zSheWR97Ex
	KxU9k7V6lhw0cxnQNpqKjkAjLoXEFyaed44gZcUSPw2vM8CSnP5SSFh4=
X-Google-Smtp-Source: AGHT+IEhwCub75T21RkKxTH2EPpAzGzMTmnjrPf2VUr+FPlZpsEHrImG3Tns7WMllPdPHD6sg4u/jRxUWEiYKutCdCb+1u10EG0E
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:3cf:c8ec:d390 with SMTP id
 e9e14a558f8ab-3d2807707b2mr87834055ab.4.1739796257588; Mon, 17 Feb 2025
 04:44:17 -0800 (PST)
Date: Mon, 17 Feb 2025 04:44:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b32f21.050a0220.173698.0033.GAE@google.com>
Subject: [syzbot] Monthly serial report (Feb 2025)
From: syzbot <syzbot+list67224c95d908c00ce68e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  758     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2>  570     No    INFO: task hung in console_callback (5)
                   https://syzkaller.appspot.com/bug?extid=1fb20cf68d15e7c2388d
<3>  177     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<4>  164     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                   https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<5>  104     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<6>  66      Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  44      Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8>  19      No    KMSAN: uninit-value in gsmld_receive_buf
                   https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<9>  15      No    general protection fault in n_tty_receive_buf_common (2)
                   https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02
<10> 6       Yes   INFO: task hung in paste_selection (2)
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
