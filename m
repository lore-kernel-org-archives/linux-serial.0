Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E866385516
	for <linux-serial@vger.kernel.org>; Thu, 29 Jan 2026 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687491; cv=none; b=CXiDBl3j9L/KyMCO/TdVz9iFQel0HyuWRvHeRYvYiIpi3PzfoNf3jZj5jHuOT75iJqO+bwuCLJ76HAYXJxL8Oy0HYtU7yM7T21CtnrOY0xZM33WVjq+6pXVihgns3sAnsNsi9ao/i0misFzVfSp0WhexYFWqoOSDmbEnR/EbApg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687491; c=relaxed/simple;
	bh=lIUDlXObb5uEF//k43KhXjonJY7/eMR3MoOZwQ+ASjw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zw/wKvF3FKxeBtUXteUn6OZEQUxMRK6UGmrvodgue0Q4aD69W6cq5mPOOz7P1WvMPqeVX2pVA1UiOI60faGMmyDorjFzSpxCb3Fl8FqFNEgvoObJk5nE2+d9dOqQTM+1fslYBhW0rybtBwK32thfJEnn8elEcW1O+q7WhoMp2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-3ff590953b1so2542203fac.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Jan 2026 03:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769687488; x=1770292288;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0NG2LGgo/HRDPw+ohIUZo78HxQ4jjxW86wJXLvVSKY=;
        b=AF4p67XSb/+agqjXOh1mzduWPaaeUMlV4uijul9VfbMW/9SFeIJtIS1kZ6yNhPC4TL
         XwemHlrfJs8+aXwP/MjGjp4DjMVYVVyukcdRt/fmtn9rWGpEmTESIRUG9H8/txwkqm+/
         8KYhk8oB7ID+j0nsBtx8sR29SNZaEW8H8Nc9qolAabW0n51AmlkB8gdx6SbdJ0iBhYy+
         q//KxpZRfyeZ0Twb4nfp0juvxVwIXzA70eFI9Q2hH7/i0ISH9rx1brEkilXIRPgHNDkd
         PfInLWSv2yoCLv0YXClcYzIzLHB15eAPetu5GSEKquvjfosXY9ZcWiTEhhhNf4oLR8lR
         frSg==
X-Forwarded-Encrypted: i=1; AJvYcCW1fiDPsBHqllxshaxrHFviclybJISDF5k/MB8gyS+5HE7ABEhuet9k9EEvofhODRmF+dJ1e1wzbNdOBc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7nWrrdwS8MXpcTqQQvHOLrr3Elozx7iEu2wbLw6zrInMx4Ui
	xSQSWjhrhUeoOLhkZdUClb15UJKyVuCV/N0Ov/fRUyoYqEHF9RbhVEczsxOtH7DFLGhaqH5kbrx
	sqp4hw32DNwJFHepqTeVgFpzq8X8cF44VydNfuxH3DZ9nSJveJJlS+N9QhV8=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:488c:b0:663:3ad:4c2d with SMTP id
 006d021491bc7-66303ad4c73mr1541410eaf.60.1769687488551; Thu, 29 Jan 2026
 03:51:28 -0800 (PST)
Date: Thu, 29 Jan 2026 03:51:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697b49c0.a70a0220.9914.001b.GAE@google.com>
Subject: [syzbot] Monthly serial report (Jan 2026)
From: syzbot <syzbot+listac358ce31459004989d9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3669    Yes   possible deadlock in console_lock_spinning_enable (5)
                   https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2>  3002    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3>  265     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4>  261     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5>  238     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<6>  120     Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7>  53      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<8>  18      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<9>  6       Yes   INFO: task hung in paste_selection (2)
                   https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8
<10> 3       No    possible deadlock in stop_tty
                   https://syzkaller.appspot.com/bug?extid=7ca5a40e8164fe2609fd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
