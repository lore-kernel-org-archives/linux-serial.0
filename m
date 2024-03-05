Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0D52F68
	for <linux-serial@vger.kernel.org>; Tue,  5 Mar 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637030; cv=none; b=QFeEByi9Oz26S9IVXbr7JSBot9IlwEMVRD8ICba/7AMTzDaF8LITGt/sQYdQ+pdinS5/jn/hbYZdssZOqFNvTSejcxlq8sWFKHeuw4BSb8Z8MC/QmgvchDuAloVZQ/RtrSszs/XoYVCKlfuNa2IdvbcEP45Z/Vs0us0XdJ2nHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637030; c=relaxed/simple;
	bh=QdedY/MUtdPYew2UtoXQQZq7W8eZj45MkqVOtzMgcak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kwLM9XKjmw3ffFlmykia8CxAtYVivk1QK0e4jXeEuBDa3+mAwBG8zrgBqpr7ppGDILcxnz8uIQhuS0l7h1UPb+SAA1Q4BOuxMKp/lYn2c2+LTbXmVD/aupKTVQqu8mOCPgO9xs4+ykEw+uytIAftuyrN5XUOW5w200LZAVMji+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c495649efdso716512539f.2
        for <linux-serial@vger.kernel.org>; Tue, 05 Mar 2024 03:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637028; x=1710241828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2R1WIqVBRG6442yw7vjn9+5OhQFpW9A/GTiTm4WvqB8=;
        b=kSISACkpYJhIHEYiZkKNkI3XiXYCpNwl8YashPbhTs+prBE7Uw+cRNLZjAkRWWKYLR
         AHsTT8WluvN4S4uSR6msb47oT8jBiY2VXtYMhntLEcpZpdzShC00jj+sWMdAnF14ko0s
         YPFT88g618qC/nJZmA9lqJ7vYZkdbpqUg+LkmNG9+44A+TE/lSB2UvsVYCWv9jwR4Jnn
         q+lgixFIvZtwfD1+CK+U6vp1UNMzeu8n2XOcpBhohTxkGXUyHH69yzVJYQ1rPz2BbTyz
         Y01CTzGd77qLLhdCDvatSoS9cbefYsoaHRlKqPSptPSkfr1JfPDxmdkFD2fzQHpKhQC9
         d5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9Fragbp9G03NIayI8xuMGkamyDJypOC/iVHoOk36A+sUwDGRNsTA8EbQfKsYH0Qua87nzmiYTvxsGlrlvkNSzfDR/ar3LAIw5dPmR
X-Gm-Message-State: AOJu0Yw/NaH9MV8GxhK4FABaE0vcptTJl1TS+0yIar+kF8PVkw4gYSIf
	QQse055xP1TiumDLrMnpaoO5N9XvN2maEIepiAQJBYjoXxkYCWMNkz8nS0LQDMPljkZptRzsWzZ
	t/xa200NsEcV8DCkQkY8l5Uyrv4PXHccrVdZXuWLXACDFxBlG+2unoME=
X-Google-Smtp-Source: AGHT+IFQZMZXuQZFDtC6pA8mQYOrH6pqBHZlIrJ1O9F2wg091ORDRY0Z9DKNqYmj6uOx75rlKIj1eAl8GnhuS46j4nmp+6Gexxzu
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c9:b0:474:f25a:6fb with SMTP id
 l9-20020a05663814c900b00474f25a06fbmr317105jak.3.1709637028211; Tue, 05 Mar
 2024 03:10:28 -0800 (PST)
Date: Tue, 05 Mar 2024 03:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2fbf10612e7e3ae@google.com>
Subject: [syzbot] Monthly serial report (Mar 2024)
From: syzbot <syzbot+list97f3ea5e2a4b53b98e7c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 51700   Yes   possible deadlock in console_flush_all (2)
                  https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2> 4959    Yes   BUG: sleeping function called from invalid context in console_lock (2)
                  https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
<3> 156     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                  https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<4> 41      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<5> 16      Yes   BUG: sleeping function called from invalid context in gsm_send
                  https://syzkaller.appspot.com/bug?extid=b687fe9bf10db0839715
<6> 5       No    KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
