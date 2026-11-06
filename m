Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939631;
	b=nnoFnSczqCaGcNwIjAUHNOCZznNUqZ2W7EoaZC+VDycD/xSfTIIPadIiL2ZQz0UQp+gL
	 egr0laTp4mNhytVQ4oiOB93Gkdv+iD9EWr1W5oAlJ6DKxyk99j/0taOPNtL2azxcbdE2U
	 YlextMJ4aGuIEbh/msq8Rnf880K2KrO9lKTenola6kcO/6C3ziiqNiFIW2eLoVS0AhmXK
	 Tnaj5Qi7rB33/+LfINm7xoHhlIJUl6z+EN8WUVfrm7TRh2sJWWwFfqRltoaTLBbaNI+1H
	 oWQGjn5DcHhYf/jWKyCYXzQlW68KJUGrabXcbrAVhuvEkS7h3gxMT9tukGZ7XUJM7UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939631;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=u8F47qY4IABnzW1SD/iDt/N1xrxNvhOSu8Bvnim30K4=;
	b=XMCzYR0DrbgJ5DYTIiQ5HhdGtGR630vc9K7kt9ixHm1N8b+Mih1Wzfe/N4TWvVYclBQ3
	 ASGptxsdGQKBTH7N+LGwta/vPINpYrR4Qxcj/Hctl7IuMnum5VMW2h3dLTaEeAZqlgyW5
	 amz4Di/IP+AIAW26BtwyBF4Hg6Pr7C1QLmNPdYXObXV7W4xkooVNHRHqfulofrQUwu/PY
	 1T08OSS9MJ1oyFkpCtD/bq614qK2+83gqP+B4Tw+eSL6+K1iw6Z2f52+S7SjC7u2ctC5Z
	 32Z+u5UIwAR9VDJBoc2K0Ep9jaRQ8+jfei8Bcc/oSyvihM9mNbyFEtTq9c7ok4wywUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33C606A33B
	for <linux-serial@vger.kernel.org>; Fri,  6 Nov 2026 04:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C33C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a45b3f0bdfso308032b6e.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 20:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939630; x=1794544430;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8F47qY4IABnzW1SD/iDt/N1xrxNvhOSu8Bvnim30K4=;
        b=C43KHR5KJt8knvwsC/nzouuYXNQwKtSbUdrSvPBpISnPqgBvt4pfmBGwmwDBJHKJvC
         IqTko+pJ5mpfzrZQhF4R3xJO8C8AWBwhxWrEWM7MAvT4QOFdrn+I1+TGEYEV9zL6ByYW
         MJbipZti/GdMPpWDvtom2hDtINqnxBjR6B9FZNHCas4nlOCEq4H0mPFDWLJ6dCxNmt0v
         j3x1Uuy9F+tlOLaLezjN5htp1trUj+B8rxTDc3CCXTRtu7U+6A5KBBkl60fbuuHztpjJ
         s3L7rAsOgjtb8ZPrSvIV9Jn8ceBxUu83PI/W89keyB1buxdh8aYisxY96cUdoIugWvCl
         EWEw==
X-Forwarded-Encrypted: i=1; AKwUvBwUjVQMmxESyuDFHLVhdIAL+hBp3sT3QxWRaqeW0Hej5zN/QO+jt24ags6DX4P4FxdfZJLWHVUjY6cejAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eI/s5+DvrM+Kb5Fl/VNAPOwiXQp++DeZsuPG4V/mzGzslXkny
	TkF5OLFxcD4vTLJ/iF4niZATPCnYw3AdnZmcfoYsW3zZY8GUyfXRJHbscpysldhItqy1wVqGKtz
	FafLwHsw1HHtxE4kqXPJ2dR1wUTq1utVeyrNa+FS6R6wpy7a488Q0WvMBeYo=
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f04:b0:4f9:595:b80c with SMTP id
 5614622812f47-567e160ad12mr1206021b6e.41.1793939630402; Thu, 05 Nov 2026
 20:33:50 -0800 (PST)
Date: Thu, 05 Nov 2026 20:33:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aed58ae.02d3f859.2829d1.0005.GAE@google.com>
Subject: [syzbot] Monthly serial report (Nov 2026)
From: syzbot <syzbot+list13132b08837edb44a184@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 50 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 19      Yes   KASAN: slab-use-after-free Read in kbd_event (2)
                  https://syzkaller.appspot.com/bug?extid=098cefc0911c68db5dab
<2> 305     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 211     Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<4> 84      Yes   possible deadlock in n_tty_flush_buffer
                  https://syzkaller.appspot.com/bug?extid=d84934b4184d7f9a1aed

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
