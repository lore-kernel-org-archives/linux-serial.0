Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EF1C82E3
	for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981208; cv=none; b=uCMLBJLMS8lJeOS2Z7I2Pk2eo9sXlUAxaHkyiur+GYyVb9t/FMhMu/CBc5U/LoeQWrwKj+9Nb0rBqOXC20qwLh9uN63l879Xc90LI8sIPY8Os/bfZt4khvFgqBYAqhDx81+P3VmhqHqFBsYvVBDdTbOY8GOvD1pDFy3e2BZX/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981208; c=relaxed/simple;
	bh=l0KnU1jEnOmVtqvVeeOzYzZ+gH3uccCWi6iDMciRvAw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iHN6QYfhNUZAkMvL9CqjqsrrfXKzMhwmeGbsF1qx36sS1yosv3z5b9cuZkPfpE9dhrj9wXcR0AV3Z1hIorU6Bf+J58ICmSo5/jSJRgMT5sNuWgbtegTHsYCJj+F029g0kviFFOdehLwX9oqo+FoCcwk+GzFNDXtkLePhGEv+/1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83780092c0eso319418339f.1
        for <linux-serial@vger.kernel.org>; Tue, 15 Oct 2024 01:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981205; x=1729586005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JG1+mKjuFX1R5St19IEjhFL/nfMVyVLuhi5QnUBNr2U=;
        b=uGplYtqagd15577TlaanW0QErGILH8VfczBcXOvSRDcXAPYH4f4criRT/YVVnxRFZM
         zWUtSKZVZSnqKHDOhqiuvbQnpKroRffTk+TmifqAaSA2E/Js9GEiALepmntf+GvbWRXP
         zq7Pxc+6GpaPUa7BBruB4OeKY4teWJ/88O8vk766StVvgNKF0e7+HG4S1XzFO/F/ocrC
         0aW4G8zdXl/o3DIjtZi0Ydqe5Xwvs3RYx1nPBoX2lS8PdoKoVk+HYNMqAVoWvdX140Lc
         x5PpFuVPr1vu2ReZ87uJDNuRbG7aImo2wZ9lV5wDIgzz30Qj4wCI/HNLmzphueE05zkw
         0EhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYgCAoMAGjM6M9m6zvaj2RFT01TQL6ymG3MiquCpKGhsjhaK659efd7c5wgAgsAZ7XrXn3T181qwOZQK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDeybg3yfaGt3zQiR9oGjnSUmrbqkejA8JdznNlgxOZu2zvQv
	5L9NOh+xky8U0F3hrJzr6D2yomUHEWaFqjyU1HXzTz+DtFtYdzxqFDlnTuRpeq+0oiT7B+6Xd7w
	gxxW6gZzokYgkxskWmXxdku5p3bmG0YhKwCTadUd7ybqAK+iKTRl8lsw=
X-Google-Smtp-Source: AGHT+IEMyuaPYAGshOPlblIJqFJISjdqEEjpzojYE0wgROrTk5FGNj5JIoyMr/Oj7268qeO3d3r2lZh6bBYa9S14mGh5d4z4jkoG
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a0:9159:1561 with SMTP id
 e9e14a558f8ab-3a3b5f233e1mr126389635ab.2.1728981205184; Tue, 15 Oct 2024
 01:33:25 -0700 (PDT)
Date: Tue, 15 Oct 2024 01:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e28d5.050a0220.f16b.0007.GAE@google.com>
Subject: [syzbot] Monthly serial report (Oct 2024)
From: syzbot <syzbot+list171ab5036cef2d0e0705@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 494     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 156     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                  https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<3> 28      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 26      No    KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5> 10      Yes   INFO: rcu detected stall in console_callback
                  https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<6> 7       No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
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
