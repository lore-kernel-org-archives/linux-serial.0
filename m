Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF81DE8AC
	for <linux-serial@vger.kernel.org>; Tue, 17 Dec 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428847; cv=none; b=qYjSH0mTxl09gHM2/MMhgw0RImBz93Z8wLvLMcHGxhJr6BQfxityVeFpXdPGksurmtbDdRsXv2cmw6NzgWJGQUk21gPDaRH+S73NEz1NlX+G1DRSa+OvJlCBZMcH3TcqXFCwQyXBvCwZMfEwsH7R3xuGP8CibVsUto6DdAMMmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428847; c=relaxed/simple;
	bh=hOfImkAE2EFl4MZVd3hPvFr9MgN0yNbZ9A1uBeV3ZCc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iTLnqwXtESUkjKUCgFwkYDsLoxqF8rQ8FP6He+eM/m7LDUKn/KlVgqMiB6J7dcHVGZX109M8tQ3FpWj0ikXDCOqfl5/yv4JH6g1EOdgMhM4g9EntT79jga3MwN5gFTVR6oHBHm8nJxBIicnnbV2HMobOaYtxLpC0PQDdIIcWuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so96430875ab.3
        for <linux-serial@vger.kernel.org>; Tue, 17 Dec 2024 01:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428845; x=1735033645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3C6dwQcR8DXbDgPWAbTVRGbBXyNlVbX5Pvzym/aa2YE=;
        b=eq8RXVnRx+IynC3VhBPTrN5+3cMwlNeZ9VSHv9OVQzyeSkR9WfU8jQXW9NsQ+U9InS
         61INpMvz3+KShOKEilzjCRA3IlkP4b/+8uGdQKbUvKm0ZZDH4ljGykir1r9EroKVBoTE
         bN6ve8anVA++HH8P0BLRFl+ITCzh/qiaiO4oVrBgCEUEo5cUxoyCw8m6Kl1A+VwGbrLA
         xnYzHErorHS4ZzBA4NDDkeQGaWWVUnS+IVXmplKjcWtZ97CRbzAV8RtWD/JMdtBJHGDS
         ge6E55ZsqwVhfCBDIFnnUABCMj+MGoOvwrobaE5d3HkFuinw9JqmHKUWgxF6CSLK9whp
         Wffg==
X-Forwarded-Encrypted: i=1; AJvYcCXaT3cooVcgw/Ee41/IsPfd5jd1R2t3iQcYEIiBDKbvwV8ifW48+JOO14A0at+DmRuCbimbWaIpyZ/9JNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIv6IwWQKnQFtLI352jjz2MG0WW3XBTY0U0up/HZ9nP8HIWcaN
	ZoiBYRua9p+SQ0QzIPAhhwiq2eFfQ6xwjWLEKkAxVmY8grbP+6cnfQaE4YKgGP41hqTIuHAjFQA
	+BptprnWGVhq1Nts+xMxokqr3pj5nFWV0D0wBRBMG5kXjGfxLAXzklOc=
X-Google-Smtp-Source: AGHT+IE8yAkcoeaC0xqa7bhpt81THy6gblPyPnO88aZxjOf6qA0M1VWR9FZmjX1BW26CBU8qXtxIeYFhA3eDqqC8eZ4CRYZ+IyBi
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3aff6020017mr139728465ab.9.1734428844941; Tue, 17 Dec 2024
 01:47:24 -0800 (PST)
Date: Tue, 17 Dec 2024 01:47:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676148ac.050a0220.37aaf.0156.GAE@google.com>
Subject: [syzbot] Monthly serial report (Dec 2024)
From: syzbot <syzbot+list5c601fdf620a536bb95a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  651     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2>  257     No    INFO: task hung in console_callback (5)
                   https://syzkaller.appspot.com/bug?extid=1fb20cf68d15e7c2388d
<3>  167     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<4>  75      Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<5>  64      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<6>  48      No    KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  17      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<8>  15      No    KMSAN: uninit-value in gsmld_receive_buf
                   https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<9>  12      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<10> 11      No    general protection fault in n_tty_receive_buf_common (2)
                   https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
