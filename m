Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4625487B
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766995951; cv=none; b=ZzCgmIl1N6i8z2IP4m+MSfWRWC8BK/uDPwUN2OOuq6JFWMKKuJ7oMQz6x5MVmIvR3M1u6oTvQIJiB5PMt3K5Sksnd+3K0vAtrcv84dVte1bJ8ZmUU/2LNjqpf8imT42P9WDIJiQSpIDb4NT+DZB223hNdfOL0zJ6B9vhzti1HfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766995951; c=relaxed/simple;
	bh=taIfWUNVF3rSzh0PYBFI5q7Vx5RhrWfrym0Xr7JJJj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PJ2cI4saQgqCITjlcrRDSp771wXByoSsqlykGyWDdlMYOSnIBvPfjpCwtl0DBSZsGn2p/8O6QPYlaUbe5oKtxOlPtxrgvoBa+F/WQp6VuSUs6AP2MMOSLot6xxgJiPUUuJLRNToW7oGUtv5M5WoW1Fd+avgpFu1sjna1cDsE9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65747d01bb0so15528567eaf.0
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 00:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766995949; x=1767600749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vY3aZZxjVWwDjFgLHiv/0AXJxOLgPlcs7AfFYWDwgdg=;
        b=DjuJ7kKVgrR6NVVaNPl3dJDiI33xb4Af+ah/lnh7iDHgEFdE4keRfpz+h+wjJqbxCx
         dnCDRNb1KSnRv0BIK0Du3xDmWW+LfcCA/xTX47x/Z/Ansj73EJs163okZEsCXuslIooT
         bIjHvIvQ4gmHAhpi9eWXXD3SX0r8MiV0sY0xKICKfpOUsOBQzUvbTSN4L956/s9ZLWr5
         nR0bv9fJnPEg62QaqPotlZnAn0yWufgi76pnmxmXUZzjCJjwUjCqIewGd93PPBncEFtI
         WYAK+E/lybgukoyITuSEfopItTlJpA14CwDD/OE+LQMeb7HKoG3MQt2I2U2uiU/9PCX6
         9XfA==
X-Forwarded-Encrypted: i=1; AJvYcCUoHT+irdNaOHD2et2hU149m/1xmHwuDkLA39G/l7QnznFLBPxFPhH6v6p55XaJ3K+xYpuRYYoPZj8r668=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckUcO3US0obHmlUiEtuCgY55dq6UJB8cHM8azGdkWGdmY53aF
	+jPBvZ6MecWisPwTmzyF1ep+T9oUmuQ6pK87vJmOkUla3Esj2LeTqtE/ZgzJ+3HTslzsKh6ys+X
	0MQ+zw8C9+CACbPnuV4zKDx6wH+b8x9RhnQp55pfRnnUiBd7rocoKdpSP6VQ=
X-Google-Smtp-Source: AGHT+IFZzBEzyRMoobnuGlNd76ESTB2ELSt4+HC0wAiHAWy2aSWKGOc9bZWt5zXyblRuYbixkfZ3vYYp8d+wR+sogYmvGcQHquPB
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f059:b0:65d:1336:f675 with SMTP id
 006d021491bc7-65d13371ffcmr9216003eaf.42.1766995949266; Mon, 29 Dec 2025
 00:12:29 -0800 (PST)
Date: Mon, 29 Dec 2025 00:12:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695237ed.a70a0220.c527.0022.GAE@google.com>
Subject: [syzbot] Monthly serial report (Dec 2025)
From: syzbot <syzbot+list2e994c0f62c763b8cec2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 17 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3201    Yes   possible deadlock in console_lock_spinning_enable (5)
                   https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2>  2565    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3>  1163    Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4>  257     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<5>  232     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<6>  235     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  120     Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8>  47      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<9>  18      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<10> 2       Yes   memory leak in gsm_activate_mux
                   https://syzkaller.appspot.com/bug?extid=b5d1f455d385b2c7da3c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
