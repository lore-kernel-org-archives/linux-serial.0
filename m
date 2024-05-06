Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C676919
	for <linux-serial@vger.kernel.org>; Mon,  6 May 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001516; cv=none; b=sG8KWZFKZnyGlBHjcQkTqcuqAF6rdV0wQAkVMfDfKaNyFki0fqWtA4JXBj9dUAeaRbYOXZxbjI6sfy7L57r7VUaKq3ixh6/aV7r8Nuw9q86RGBJZ3xQ2qHiRTcnc/Jk3HInFS4hwYtngjhRYF66WIzheEDpEv1MN9S5wNZdb1qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001516; c=relaxed/simple;
	bh=SPL6PJWIpsLY8Xy/Y4ayHd7F1Fw69EcJJXevh46cttg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EdNLtKBJkcABYLmm2z1XMfqaQ08Swe8EXKzLR+q+TIX2ypsFy03+9ZR53xrGE6VCMERQl4yahlo4QU/Lar4i/39T+fpZ/Sf0GT/0lJ7sJukgHLk5twRnBgnYzaOIWFjuqTbHuudBAe1Bajhe560EhwNK4bKqT+M1Xf/V7Db7VZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c5d1c48d3so19098585ab.1
        for <linux-serial@vger.kernel.org>; Mon, 06 May 2024 06:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001514; x=1715606314;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0qWpy7ps78v20CovDf0DA27e0024le/brm/KkAT2X0=;
        b=EawUYSJrKmadereXu1K76J3ob9Ir7bik2YpvSOjOdGiH9V7QzNvc5lucSa1C65xYPE
         lz1YE0G9f3784QXkZhFiMcCrwKBwrAlJonsFRMQuFybEPisXCS4oV4OeapuFSkdUoE7t
         W0zX1YmvoOsUL9ONYi4j5yJftT+8o2n7mjqf+qU/VtRC7cXIDeC12AiYcuDLA09E4DI5
         l2tO1LsB5uh+KEn+GQnhKIUvgJ9dggpHekH0WZBM1A18M55zVkruAjuu/k3I9bH9uvbZ
         6fvmJ8XBPPy+/8zKwZ+Tf6Y7PKe94NJhYCXg5mX8BfJlF2nd41jrHikUd6U57CFS9xyj
         tfjA==
X-Forwarded-Encrypted: i=1; AJvYcCWXzGQZyvTku4VKSIPFUSQnIKeThWSQxQ6YMqbKh5gDndk0GSW0Jehp0f/Gc3fAAXXs/ZYvLtXfgs2iLnRsmofQZnwd1NrJJuUKw9KJ
X-Gm-Message-State: AOJu0YxU+qzq/ADu1I/gzvutydJMNkX45xDxZfzP7liLOeC0OdhfWBq5
	T0WRMfESuZNuoclJVQsDIdMYto3KRm6ziOlnOZRLWWxFtM9tLoW5CjsRDYuYbt/WjEx3ufUUBFn
	nYQOl0ta8ftHsL7Kirv/R+fL/EBBgmo9/9AdMN1OFtt3AbvTZTHu0isI=
X-Google-Smtp-Source: AGHT+IHFjMQ08FM1JETVO23sPsergRuWUM2m1KGHjHW3l55IVPCyrLX1HE2oY+K2F7IO6md5R5woFFWQx9BIWCc0yE5n6Mb9i1j7
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:36c:4e5a:50aa with SMTP id
 i2-20020a056e02152200b0036c4e5a50aamr414383ilu.0.1715001513874; Mon, 06 May
 2024 06:18:33 -0700 (PDT)
Date: Mon, 06 May 2024 06:18:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000624c60617c8e8a3@google.com>
Subject: [syzbot] Monthly serial report (May 2024)
From: syzbot <syzbot+list833879ac7b0793dbc06f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 3 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 41 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 166     Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 75      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 66      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4> 6       Yes   INFO: task hung in paste_selection (2)
                  https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8
<5> 2       No    possible deadlock in uart_write (2)
                  https://syzkaller.appspot.com/bug?extid=57cc2f20a84cb4346354
<6> 1       No    KMSAN: uninit-value in gsmld_receive_buf
                  https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
