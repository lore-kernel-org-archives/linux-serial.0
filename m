Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446623016E3
	for <linux-serial@vger.kernel.org>; Tue,  2 Jun 2026 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432349; cv=none; b=Nle9N7vVA35D/x+53mo4h2el/Dzkjt7tRI6cLMsYMWSH3kCb7D1M4aujiQby9fW1tlRtz6gSaT0IyfoZkWVKd7DAUNrmudF/rg8KA6vyzlIBd2sVBNHWoVJKyHSuTdEwKLnMmQBIPPm+3noXqX0HrRer54J7YiTRYOqrfOXti20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432349; c=relaxed/simple;
	bh=H2gkJR24pry5U4LjfE9+pFHWEyrXWujhLtUcny7ZOLA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s1gw9fVgfN3tndfRTxV0UBYWwzNnmPytJ4v27I7toHgEm3QvTWEH3jJBc9JihWr8N/4H1C3LJY278B63+lazX8Y4rtWazCK74wQ+ZLwJDmVsrqBOfHlLbweI7hI/C9znYPS6af0zzVv48rEEDqrU2i1Miyvcr+BjVZAKiEJoen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-69d6b83becaso15334162eaf.2
        for <linux-serial@vger.kernel.org>; Tue, 02 Jun 2026 13:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780432347; x=1781037147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VsFzeDjTwAUyw0QkQexIXGaMwUsKu5Ktl1KgQY4+EA=;
        b=m/RooLG52UFgcZpLLobAYOkLiZJeAohJlhSH5ofK73e/tFu4BesBu5QMtgKNyRXh5k
         OCq7KoDu4aLvQU/6KUiyeTcUKWCROXbAnt2zHZVAHpKzKbDLGI5lKD+zZjwJOPk40YAK
         MQ4nFfvZoyY/RXVyRkfUKjQNXx+OekQzJBzKurOAVg7ZT7enBLzClpsgPgQvFDvEzKRY
         LpT/uVcwy0YDok2RhbbJXzm9vAb2YC3iZqEwnaw8H6z7CSOGgG/TtH0FPiykLDzD+aq/
         TZNghmPOS+tyul5f2V5lgu7rQhE5tpoOGxCdhYdyZxBDC/+gJc0el1O/guIsSJ979pY2
         w/Tw==
X-Forwarded-Encrypted: i=1; AFNElJ+SUIDUpT8wGA2+jePnJpsM6Y6p1h6EBQ8eIZaP4p7vIF45rZydC644q3KHZL/BxiRe/Dh13LoyLtJEAWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4J/oG8xQR14KjxiX97ELoFbnD6IOpuCQw2sGvL2Rxsd/7Xua
	sOb/WVOZ+zUCmhruth0yFLZfSRejYcYk3/IS/Qj5yRIRxrwVygcZVwQb/N3wLfcJWd9W8L/5Fra
	UJQgmuLFzYPFSdCx7K2irfc1G74zF+wozrkE4H3bU4KTqqAJ+gfvcpnjVYAo=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:61c:b0:69d:82e6:69d6 with SMTP id
 006d021491bc7-69e47ec335amr483722eaf.21.1780432347445; Tue, 02 Jun 2026
 13:32:27 -0700 (PDT)
Date: Tue, 02 Jun 2026 13:32:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1f3ddb.7b89b7e1.205e57.0009.GAE@google.com>
Subject: [syzbot] Monthly serial report (Jun 2026)
From: syzbot <syzbot+listf633da172023c35927ca@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 48 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 196     No    possible deadlock in kbd_event
                  https://syzkaller.appspot.com/bug?extid=781c8bb5e4d62cc883d3
<2> 62      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<3> 10      No    KASAN: slab-use-after-free Read in kbd_event (2)
                  https://syzkaller.appspot.com/bug?extid=098cefc0911c68db5dab
<4> 3701    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<5> 359     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                  https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<6> 137     Yes   possible deadlock in tty_buffer_flush (3)
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
