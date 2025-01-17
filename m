Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6851FCFF3
	for <linux-serial@vger.kernel.org>; Fri, 17 Jan 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110189; cv=none; b=YMEtAYn6q8kXbpG+9m9Rg4YUC4vD2jtt2M529l0WFXe4nPJXwQ3KsaXSsSADFIZXrFyuDx4efHmHOUly5e6OiXC0vmL2R9Xx7961t0QamO6NCej6OO7mTdSeldE5K6TQm+npppu7wW4Zl0oNIc4iHPv3oLGM7jNvwEuaDYiYj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110189; c=relaxed/simple;
	bh=mvMhenXHN4nEV6Ty+NwSTgQe3ZYepoE2i1mmLiDGrbg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UcvtZse4GVq70nLzWZq5qAonkvhw4gkyT2eMkZKfU70BdsYQ59mT0sS6kJeU7t3LktfHLyze8j+7nNFgZ0MWX2FJu8+ATD5M6kGDHDGq7jU+He6rQjqD8Iv5lA3XmORm1wljYvq/ANEvJP9QO1Doo05FTcTsPfqP1FWPUCpgybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce7e5d651aso16527285ab.2
        for <linux-serial@vger.kernel.org>; Fri, 17 Jan 2025 02:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110186; x=1737714986;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6tr4e9Nggu8MROBd2DNUjngNQWaL6TBjiVhWS+iWEI=;
        b=iG5ImEuTnvbv0IeAJ54L3Krn9XMU40Prrwd0Et8gTaM1DXXxbW2KT3fqw2l1q+f9ij
         AUSo3jWOlStcUoJN3y44K3mFELvrEAMdbZNcRYLLza4ll115T0t5etUCt+9Uo0+RP96g
         /U1uxgdGkJalDaAi9V2SP1HMBfyDLF1G+kSn9AouAgqIZIdYnynNdu4hYFf/dkP420V2
         B/Bqx2VBzcKqp2ktfWTKGnDFGbJz4QI1NXMI8huIE5UR2WmbaNJXRGQyweqqq+l+9jQ3
         1bOYRPSBVP6Z6+g3EjbnXGuiw36aA2Fyya5p0PGy4A7HgH5hbCEpFBFsV1AVor7zot/0
         NqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwKSAQR6KslW3xXHRKcpZ0Iuo6A92MAdMgpySx4jBKBssMZX1LZB7OFhswHD0tONzPgBQa699EWInrfx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTG3W1jPPP8Wqe2K/w/Wx3HOdNCptNfR/LKXX0BSMjZUXtg1Ps
	vNJus2YyJWmBK/+gBv6/b0ztgKeVWkgPX4t7P53BvuVc6SF3HSGhddH2YBI9rHGLm6WeI921TKV
	h43JKpUh2cdUGnVyRFwtrQIMlVzK39d70GaWUL8h16ZSyBSwD9fksngE=
X-Google-Smtp-Source: AGHT+IFUxno0jtvXzbH9cAeYa2FHIUa65wZRdbJ6OYUhpgYtD8OAKEZjZlkF/zhDEwvUMPFJAb71J8s2CZHdTOieaCUeewWEjDBn
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2161:b0:3ce:7d8f:3d75 with SMTP id
 e9e14a558f8ab-3cf743c9a02mr15724915ab.1.1737110186246; Fri, 17 Jan 2025
 02:36:26 -0800 (PST)
Date: Fri, 17 Jan 2025 02:36:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a32aa.050a0220.20d369.005b.GAE@google.com>
Subject: [syzbot] Monthly serial report (Jan 2025)
From: syzbot <syzbot+listd50f3c6120445dc61e8f@syzkaller.appspotmail.com>
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
<1>  704     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2>  469     No    INFO: task hung in console_callback (5)
                   https://syzkaller.appspot.com/bug?extid=1fb20cf68d15e7c2388d
<3>  172     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<4>  86      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<5>  77      Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<6>  55      Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  31      Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8>  14      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<9>  12      No    general protection fault in n_tty_receive_buf_common (2)
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
