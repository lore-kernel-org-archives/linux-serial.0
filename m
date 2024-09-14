Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA291CEEB3
	for <linux-serial@vger.kernel.org>; Sat, 14 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311508; cv=none; b=p9bOaJm96F6V+k3V15cWRR/IlJWZ5+ToWlvpLKDW2mEtInvEa3Oi9HPWFpmsIyrVvbJHMgxkeez5foqOyLNDv3x/YlemmuXo16j/rxZ7aO1rX5DA3vdZUH+wlGcLJOBl9JzO5VHzvVCIs8XXAC6pKq3ST4n1uIC67/B4k6Ol32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311508; c=relaxed/simple;
	bh=S3EHlT4pj65GnBkMEsNwf341ydw7Jg8R5ZcGRxNIdak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aHHptiiHX/dNHCHMRSYL2Tdbq4JwaSYNtWEz7Li9Y1fHF/px3Q6EqMNsJhjy/7i1EUrZIzsrfECfdTXx3pXULXG4GBMNkOhWaSQh/0h6dinbfiwMn4K3mcfSeP9m1pgV1IK17rBX6LsFQh6DGluOLBvWxaZriPVnMqRbGuE5VKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a047cb2e7dso57012955ab.3
        for <linux-serial@vger.kernel.org>; Sat, 14 Sep 2024 03:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726311506; x=1726916306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNsanaAnUqKnJPrB9ujnMWafkXbSugNGS//lVxE3QOI=;
        b=XtcF3NA7pEkGQ/1nF5mP6q7DoqvPitXq6CEDk5+Z1DHmm6D1wdWV6gMM0Ypj4vZxKE
         /CA69bPXojstryhI23yQsSsoYq35N2psPGrpkz8aOFFgcKESUzPBKqK0hUEOIgWGyApk
         sCkHgbpCYIITwZ2K2y/RcpcLtzr3q6/Wfx+c+c9ZwmLfldj4ltA+xN3zB+FmpXo+SRda
         JDNM3rVy6dNBAvPUGXix6CLJhG9pqLhJkqDarsdkHzLou7cVHhxxyLYTsTkPM3pIF2sr
         JtvY+58Y6YiudKhv74VapSS+D0KCdAL2+7zLOVjZ5zatuf4cSrUzy0bsWqWX+v8BRS9c
         bq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwrXuYjzqvuwN9Nd5hW7+28nUqeGhQVbGYOqgevuIHZ26B9dALv2+VcwFnP9UJZF6rdRD64eDH6PVaK0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5e9Tey5RCCGWt1UfGVRy1HGf8umLhiEHGOEGHfWYdj+VMVymx
	0WPPxDBxPfAxIDyhPHtKakm9SP8IWXW9cH04HRLMQHqms+qqZHkC3OzTs7ZUrXQXvdflK80B1sQ
	7f41xjexJLKm9EjMpg3nrvpESyqmwcfOvOvg/JvGXfSaw5UGd36Vvv28=
X-Google-Smtp-Source: AGHT+IE7cyEMFXq0PLoldynD4nLYkoTuyeUjye9q3jPn/FRYgLjwv8eiyTn2khxvdRdMQWeUBbBXmR1qe8E0+JvcgOMLwFwciUPH
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:39f:500e:2ffc with SMTP id
 e9e14a558f8ab-3a084941b35mr98911775ab.17.1726311505991; Sat, 14 Sep 2024
 03:58:25 -0700 (PDT)
Date: Sat, 14 Sep 2024 03:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e56c51.050a0220.3a9b1.0030.GAE@google.com>
Subject: [syzbot] Monthly serial report (Sep 2024)
From: syzbot <syzbot+list1e0c4845fea51e9130ce@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 393     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 152     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 15      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<4> 12      No    KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<5> 8       No    general protection fault in n_tty_receive_buf_common (2)
                  https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02
<6> 5       No    KMSAN: uninit-value in gsmld_receive_buf
                  https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<7> 3       No    KMSAN: kernel-infoleak in tty_read
                  https://syzkaller.appspot.com/bug?extid=aa7ddf2352c316bb08d0
<8> 1       No    possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
