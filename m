Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664771EA84
	for <linux-serial@vger.kernel.org>; Fri, 21 Mar 2025 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517882; cv=none; b=rTMCgspv/xh9wbJ3fnmvrYcBJuzPdheD5ImJGfKID8OPqvJMtJ2PDtCivm4PbVguHIm9PMsPpAdgDsWUYLgF64L1roO3H3cUI4y3TLmlN5SDovIYyVeeEOHX5uPgcTa95Vmowlu3bUW6mde+i8wFug6c6Ium3Ss9s7Q/KIrRtJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517882; c=relaxed/simple;
	bh=kUE3XcrhEmwai0vTcZPheXrXbOay9kMH//hPx8KGXa8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r+D3fzAUWg8UqJRRPNTu9RldbbBrQhXe+/Ya35+VyHoUlRCzSJJxr9PBwLluUEoXzVLj6iOARw4Oa4w/iGXJB3cVf/lNyAT8PTBm5aph9szuiP57HzBBuUgmOztszAmQwmIHlBvujUdki8funymbZD9NTg3vUchm2OTauABxHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso26369225ab.0
        for <linux-serial@vger.kernel.org>; Thu, 20 Mar 2025 17:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742517878; x=1743122678;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiux3QslEvXRyeLPLg16tLOU0yhFteFXkbcas4hBzGk=;
        b=muJf512JX202w7KV2vRgCtTxAK9NE115BV8/aH0iUH0BOmgo2fqar3/SBGgz5GdFyV
         v+tSl/nd56TZ+0Al+WCoRB7/U5rHAgjfsUrfVorjpzfLLEOx/nEmUqQ6iHGAoQHZvRyC
         RpHZAHYxKodW7f8R/Z2DRuWIjlVU92BC7H638GhCWiq+oruN1kr6i5XwGSsBp7d+i+Jx
         h5XPXAXGock57eyxLVa9yP3RNL7VU2ACtB/mnDamPHiOCYSaQuEpwTsuQxf2rbdye/vv
         ek7t43//rmi/wFqb1F4DS6tILBh8prXYkgoa3BWcixLEOVUKY766+tZ2jLWCnEuSAxbd
         icMA==
X-Forwarded-Encrypted: i=1; AJvYcCWlFJZpY6hZ+DyV6udevfJQvP/uP6Qa4T9U1q/z8UClZc93cZnVQ8GSoRWqWgDDuXhOkjAP4nMr9YgSfqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvXKUsxLeDb+elYHwrzlD0UReeN1iMOjXS0oY7V76T2o4CH/3
	dio1L55Unkg+KiXO+WYedwEhyRLSUM/0hMYYqW4TTR7mxXn0DZu7oLf+iWiBbeTm9AJ+AdAhxot
	xAHMwPr0uxOk4OIujjuPVK7tkEj+jvOf9TvOjLrb4UHaOm6J9KeS1d3s=
X-Google-Smtp-Source: AGHT+IGeQr+Ks25Z+y+VBWToJi9YuwsKICJHIucttlI88aXt/OTUh7dbiuniviUAEK5TsCn8wxWwlNvrIj36MgoEZApemmK4zAo0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9d:b0:3d4:44:958a with SMTP id
 e9e14a558f8ab-3d595edd857mr19747435ab.3.1742517878481; Thu, 20 Mar 2025
 17:44:38 -0700 (PDT)
Date: Thu, 20 Mar 2025 17:44:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dcb676.050a0220.31a16b.0015.GAE@google.com>
Subject: [syzbot] Monthly serial report (Mar 2025)
From: syzbot <syzbot+lista1d9ae974973bddc29e6@syzkaller.appspotmail.com>
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
<1> 837     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 182     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 123     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 82      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<5> 78      Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<6> 50      Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 17      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
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
