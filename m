Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679ED83A1A
	for <linux-serial@vger.kernel.org>; Fri,  2 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907926; cv=none; b=Zbivcvjy7C7TDuF+PSjQYRA0+sy7cobG3jtzQPtW1Y011D4iW+SSylSEuVIHy6CEem4XS+Z8BZdNjFEvvzcCFPYcRdwHyFLlZd0mEUuBcUqu0kToFkaJU0e6J/tfoNSL0JU0+hLQ6gSzELoKfVIRpenEEvsOyTBcoEByf+ZiELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907926; c=relaxed/simple;
	bh=tPNHe42qhpvxWugl+y8i8cSrXsEAh6eoqotuLxhvPAM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qwN5TJBPcbajGdVqDpNkf1fU4fuXFqXAdXXVZs3SNrpG3p+HQhXzI/VhxNNyrQkCbEvwwyG4wIsBBeyqneiNWyD96vcW+pk5L3dgcpkCNCs9y/ilBguUyu4YmqqlqKrTNpwkVLnI+MkJK2n+QfnpiLztazbaUzacW0kTbEhiS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c018d53e7fso203890939f.2
        for <linux-serial@vger.kernel.org>; Fri, 02 Feb 2024 13:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907923; x=1707512723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFM4+u+D/xmqSyRabC7ssS3eRs0J/GqQmfrIhUog/SY=;
        b=b7D9xRqXCv9/lww48UmcGAerlPitNpHMlHUF3qN4ipHdUSYRbcRl3yGPWzdNwAhKxm
         m/09spWLNeOW2+y4hByOA90kg5EfZ4CzL41ocDdhFR6LauRM6LjISs/qHqy+9cbUFY05
         lk5fW3yy3Rt+ZPNvdnRvgzY6QS5PeG1aMsqgSjZ14+w0Mh/qbb5EdNMoPldbGVaCcrQ+
         sR+EQuWSeMRxI3K4vn3VH1fcgFfBUqLMbHjZHUUIy7zX+JBBwhi807UdHCpvWZ0vVMZZ
         adr2ypg7TmItPb4UZ7gYqkgGdPZEcgzj9NEA5NE8t2DKOu9W5cYLsT1y5pR+Ie+Q2Ajt
         ONrQ==
X-Gm-Message-State: AOJu0Yzj2wsGhxipyMVKLj4bdClW7t4rgunpj5RFgMqR68wiXZeI8jaJ
	PlDbJYE5CmRHbuIgc3kZZ7wq66HZf0W7w2mjtHcUO4TINuVO7c5PQxi8JRmK3E9kwIYCw1gsfy7
	StCP5UhjdCD7QANwoq9eiTXSlfUNr/DZRLk1tnzi1U5uw9OvFfMVTTwc=
X-Google-Smtp-Source: AGHT+IFZ5k2HQeFwYdOHV1q9HUo1V7+1oMT1vQYZjiKlMix4m2CzNWzvCXvj8f7jLh9vYEXkIMVXTcH/0hat8fvQIerkXfGDtDdP
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:45:b0:7c0:4a76:2422 with SMTP id
 z5-20020a056602004500b007c04a762422mr31621ioz.2.1706907923656; Fri, 02 Feb
 2024 13:05:23 -0800 (PST)
Date: Fri, 02 Feb 2024 13:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074375c06106c787f@google.com>
Subject: [syzbot] Monthly serial report (Feb 2024)
From: syzbot <syzbot+listbb8340e4e1f8191bee93@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 3 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 51656   Yes   possible deadlock in console_flush_all (2)
                  https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2> 4747    Yes   BUG: sleeping function called from invalid context in console_lock (2)
                  https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
<3> 207     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<4> 121     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                  https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<5> 73      Yes   general protection fault in serial8250_tx_chars
                  https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
<6> 60      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<7> 36      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<8> 6       Yes   INFO: task hung in paste_selection (2)
                  https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8
<9> 2       No    KASAN: slab-use-after-free Read in tty_write_room (2)
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
