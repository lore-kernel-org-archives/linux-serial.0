Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4102FF164
	for <linux-serial@vger.kernel.org>; Sat,  2 May 2026 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777753943; cv=none; b=togMADkVtWvnWA+p/L4F64LHNvh/M2aFPQvhJZMd39QB+YJdANfuhtybwKVxaEYpnG1VoZt4GA1KbC3pwMD1UbRaIgzIUSEYXDBdGFggQGpOak7YrXhYWwI2bEWdwU1s2PPriyZldqEThj0VEyEMjthuLmmQcP9lwTqihunvA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777753943; c=relaxed/simple;
	bh=HEuNmcdjhdJ67y29j2xTVlAL3u0fiYJ76v2VK3T22/c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YfbWzhuSxX/HKgQSih/hHRW2ERSKyR/UwMFCxrmhi5y1jgSb886Bl8ELSHW7Z5fJkaeDWokniEHiv+Mud3rKrg2yqpRT+nIYxZ/0IbfgIvmxNLABgkGknbOEJmFJd65a4IO8bXOAW2+zZ3m6CjklCL8DhKvlp3lUDNctfJJWB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dee7dd974aso587564a34.1
        for <linux-serial@vger.kernel.org>; Sat, 02 May 2026 13:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777753941; x=1778358741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8fAS0akfFIw5Z5PJsOybNse0UQnkV/RekeCnDOGpQ0=;
        b=bTo2eJoxj0tekEbB0tP6qnXlGUa3o1O3/PFvmYBx5YVCqX9XtdoMBT7tmP5M8zE4Pw
         z+z9zL0lGE58kIlkKf2EH1ZnjwwRQ0x4El36gxBWhPjBtcDvVh19zALZ+Siua0sLsWGO
         i6MQRulE+hsYhYUrr997lXGnvI623e3kTKUVWzhgkx4A1hWX1MczxXujxaiBrv10Tixd
         x6MfHHYfbfGIGct+fjjAC8lRG2F96BDH/z3eFgQyBfY7sXDmax8F+1IkUzlLbbJkIfQz
         mQsq1X5CFhUro3KWgx0TFDVSdA+IJpMP8gWFa7giB85iXJZ8lhSwnqpngGITudDkUwvK
         bjNg==
X-Forwarded-Encrypted: i=1; AFNElJ//zSrsKpl2HQmS7i9AVoq/TmXEYJoylrm4ioNXCAGIqPHc1paNHODtLZDPuILRJ5of8+iiDT6yd92eqZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFC8sV8XNeivkWmOGqIEvcgo8pC9UEKeTwP3GuEvalBvXfmr6
	utz+iKqF8jNHCSJIaxzCMG4Joqr+PMm2jzFENvAp+aecYPNsP9egnVLcVtdjiLl8ntGvZnOplmM
	aj8eMDHb93zTa5KHkPv/bCyxBFAsTrLLBnjLJGDTUBB1sXFaNMOcIis36Ikg=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:bc12:0:b0:680:9b1c:8d8 with SMTP id
 006d021491bc7-6967bcc87a2mr3938514eaf.4.1777753941530; Sat, 02 May 2026
 13:32:21 -0700 (PDT)
Date: Sat, 02 May 2026 13:32:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f65f55.050a0220.312cd3.0027.GAE@google.com>
Subject: [syzbot] Monthly serial report (May 2026)
From: syzbot <syzbot+listdede244ed5607ffa38f5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3947    Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2> 3513    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3> 1194    Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4> 255     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<5> 177     No    possible deadlock in kbd_event
                  https://syzkaller.appspot.com/bug?extid=781c8bb5e4d62cc883d3
<6> 131     Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 61      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<8> 10      No    KASAN: slab-out-of-bounds Write in do_con_write (3)
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
