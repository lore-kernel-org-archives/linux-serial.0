Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F728B7E6
	for <linux-serial@vger.kernel.org>; Thu, 22 May 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918710; cv=none; b=MoNg2Fxuv1mCXVzo0dQGNLo6CnNyOeNwFt3pFt3wZeSdOY0piJXBWDcn6lskzlw+qgdsW+yCW0OL51wAwMZOpd/hGPAsfAcVgH/qwaI7DwKah86mOgmYOXbWbTgBlyLp2gOkfnL1Xh4zR6MI4FZiN+LfEuS/lqcu70NbC87gw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918710; c=relaxed/simple;
	bh=XHMYQhmFPwrsZIvyn+gTBuRPSneGzE9JD1p3xnTq4dc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IHmLRFetSZM09e2C6MGQ390zT0IbbSvPFGphE58sHvwjEYNMgah1U7AWe2NDLpMB7heDQiaQt1snVYqjHqOzhaHRBfuXHTXUaLlyOTIayGQw71vqd0mtkjIo9j4nQ5cOChTBkdMthNFPHJ2K/OSZgx5f+BcyjmXNbRmjkdNt9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e310ba2f9so626948539f.0
        for <linux-serial@vger.kernel.org>; Thu, 22 May 2025 05:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747918708; x=1748523508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=go2xQ6C9Zw9PE9PibxwqAmR3fPSZ75zMGb5X+8GgYQY=;
        b=Eg7/rqvyYlO3+mld9IcvXnmxBD0FMS9JegTa5r9VPTHQg/iyVb+aKyD1Rws8wQpGM1
         W/hAUU+ZASOM5WIcUJtLH/umRUUV4au7n3I8EJcpy/SS1Ex7KW7SFZSYOwaHm24fGccp
         KaS9Twd4sjo2k2p6O+r3O+fs6htcL+h0cRo6vFX6zc5FFnWNKkoRgSorsUOclWRoASJA
         1xTD2Vr1SDYArZQA5keoMsBLQj/5ytatBuh89qgxOIU+p0xB6IWpD4uCUmEVRHDjxqYN
         ClmCnlHynF0C6fz/twJHom5HAfjveDG0T0BIJBhAsLfECbDpS9480hSagHncLxv4HVgB
         xUVA==
X-Forwarded-Encrypted: i=1; AJvYcCUyG/ILxau5AnFL1dO4Gnm+t2KIhillF+KW6kJvTaurqj1IYWoShIsFMP5pT1DYdEzheTMJKqHPQnffOs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYpxGS1h/PUTJDDM5sUJsjOqFdw6njOZZLuT44dJ1af01vpiu
	lM315PFLuw3CyClo5m7mdp0o1mSFwuuVG8U1wWWAapMRsXPB9xUCEhS4lotfcPU+Mf056xfmujN
	ZNcZxKx6TxjpgLiDxo4rayvroVpKz9S9lBAZxqVGvrddDwpo12N0fKljCPYQ=
X-Google-Smtp-Source: AGHT+IHkhaU1N+yecHaXVOWPcWKI18HgYbVxp1LfpkmDs7jKuf3ucoM6mUJZnHBKbnpC80MmfUPwLD1bjERd6OcKNJ7f9srmpf8N
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:881a:0:b0:86a:256e:12e1 with SMTP id
 ca18e2360f4ac-86a256e1661mr2291391739f.2.1747918707959; Thu, 22 May 2025
 05:58:27 -0700 (PDT)
Date: Thu, 22 May 2025 05:58:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682f1f73.a00a0220.2a3337.001a.GAE@google.com>
Subject: [syzbot] Monthly serial report (May 2025)
From: syzbot <syzbot+listd95e4dcbb735cffa7932@syzkaller.appspotmail.com>
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
<1>  1148    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2>  188     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3>  160     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4>  121     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5>  92      Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<6>  59      Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7>  25      No    KMSAN: uninit-value in gsmld_receive_buf
                   https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<8>  18      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<9>  16      No    general protection fault in n_tty_receive_buf_common (2)
                   https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02
<10> 4       No    KASAN: slab-use-after-free Read in uart_write_room
                   https://syzkaller.appspot.com/bug?extid=22c0e08c1e0f773fbfaa

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
