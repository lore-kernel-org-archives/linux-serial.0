Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9920C490
	for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316698; cv=none; b=MuqhYFYBw/EzVsz/w1OexVGIZb7qMwmotb036BnxnTmy13EcR+hHp472pCdjF++BhvW8geziyMX1g6RjNB7dht0KQxdRknALTLEL/Sv4/FMifo/z+JaI++khlLqI0BGeoNgulLcqZnpn/NIIQzVjR48hJ6xF1vNGDHVxuMy6uH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316698; c=relaxed/simple;
	bh=xbEQETEavAgOb1mz05+1Mqm0/dChsk5TpYPYgYLabb4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A5vaSeHHcsLGHbuGtCpIl696Rb421pg/xhZabVw3Oms+y+ssyBCtKBsEDRQyq1mbjQO13wjfQkZVL3sXbUAKgnBJIqvQbtHko3A8YwUGB+c1lw3M0FdRfHP2ZmRlQ2TsoCAFa8OYVoD0JGxmzUn+3Ge72pNx2SxrlCs1ZZFFiIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d8f1c1ce45so73190875ab.2
        for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 03:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316695; x=1745921495;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdtQJjOPrq8DCqo1AT2ZfsaZhvX4p2JeSA6VZPRRUrk=;
        b=KSDpWG1GWT6PBBrOJMxg43d00DK8uxc83Phxjwz+tfLWaELPzhvFcRN+oofJlj1f6E
         F7QsCzhPWoThRnpTz3e6VUUuwCbnBCZaoXfUbR7u8q5dDFhFgo9XZTtUjFq9aHMxYJCf
         ymlAQLJr+P9fdxYbqMp4L/ubBpAI8z6z+SQoRf+QNUGRTYURPJtKfdqd9kPvKKOaJBMt
         Hg5MiGcxRGMkSC0DaQFJTnXIif47vUbPgqMREBhme5DGhm4zxm9MvH0Mq8ZUVMSe7git
         cIhQD5HDuMQFwVrRtGhubwM7YZ9uTG9JuwFzDPMWlu/UJauhCnwfNDHgz+tPPLF1PcTv
         EN3g==
X-Forwarded-Encrypted: i=1; AJvYcCVn5BfNZW2XEWjnk8jMkD7qw0LlPipWrSn0DpR70TlJh3pbTsJfk+c5H5OGvKuqOFItwEG9d7cehoGM+i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfS9sY6C37rfw4etUw+0ZQsl5tpxE5qvJ5fWWXBTHDnArAGvgu
	Q8O9OyCBcMglBXX/5AJe13ayyIwEycMaV1Lpjp2DX/O2mNEqyLQkrEkCckacOPCjidq2CGk20Sq
	HNVwqSS7gG9J1gCNC0RqyKDh/y5U+CPpxdh5Iptafnoe105Uu8eldFZw=
X-Google-Smtp-Source: AGHT+IEuppAYkIhpWyZq/L2M5gBruBXxxDJZjTrRfkOYBrTUONqF54TD7nx8+MORyKOH2Uj8WyB7uHVxnPGippN2gHP70NRdSGxo
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24e:0:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d894182618mr144778555ab.15.1745316694988; Tue, 22 Apr 2025
 03:11:34 -0700 (PDT)
Date: Tue, 22 Apr 2025 03:11:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68076b56.050a0220.8500a.0008.GAE@google.com>
Subject: [syzbot] Monthly serial report (Apr 2025)
From: syzbot <syzbot+listc66c817e68b1f949e1db@syzkaller.appspotmail.com>
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

Ref Crashes Repro Title
<1> 1002    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 186     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 140     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 102     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5> 90      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<6> 54      Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 22      No    KMSAN: uninit-value in gsmld_receive_buf
                  https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<8> 18      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
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
