Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC425D1F7
	for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485264; cv=none; b=AhlqESyylMn2cr7oHu0gyTWGXoXu9wi0Ea3njqMk7KEWIUtCB5hpcRbcAO7fkA889Pln/GsLzGZFHvShfgCuqufvZGsG9H8m3tyWHA+xxrnpGyN/GWLDQxNzE4K+PNQXNW3oeGWou4GelOcwEVCpaD9FJ70wLKs0vkIbsKdg/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485264; c=relaxed/simple;
	bh=uuQEeLlRigdsM69OGRH9h/DOpQVXiC7BiaMIHfnqXE4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wt5brFiCb+dDy412hx7OqHv84tdreJHpVhPhodR1l00sGL2ztCPmhXnSuhgJT193WnuDpxEEtqBoZplGcsSeyFJE1mHyOO+upwSz0PS+JP5TRkdd5TXQGrFxU4JfhDjPaVkP+Vk2imoSHCKyddD3BXQG40nLvx5UngmrKY37OxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-40194dd544eso47731695ab.2
        for <linux-serial@vger.kernel.org>; Tue, 09 Sep 2025 23:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757485262; x=1758090062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiRy0hqqy93BWAsD3S4bhOca7dRchHq/8VX+W6kBMcE=;
        b=pEY4pQGrtwA8zbv/vgBb3atCVBDpPLmVHXYdVf/Z95v0375iZLrTB7Hu1jBGy9y+Ov
         Jw3D9wMsCKZY9LYfZHCOJ8lUkrnk0kjffDtisGWqVK/4SgS2ARGnOOe9O0RYWLPvxPT9
         RmxJaD8oiMIsvRmwWdbp/wD7cUL3wVWKw31Nvx5cz1Iku3+xEMYKz/mDenQlOHRg4D3l
         5Ik4CgI7i+DdEGMzazgd3M57YP7m1eEOiWmGC1LoAfMHJhdqC3IilACYHG9wIpvnvAWO
         SK++sug2HbOFeei1RJXQlTdVOVRjdv/Y1NfPyh4ixj0sAD2IdX7zsNyoSoZ6Z6pw6b4D
         A9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQn3ZiAuyR22lENL4Yfh7EKjvu68MLrk478wLqO2Wny9iS3HWVY7VdV838Ku2jjnzD8UnhxNHrnzujSpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNWpNwNdcDBXwJYRsOICBTPD6JrEom3f7zwxEtPFBqTHck37F
	AH1MgxR001olNQT16uEahCuUHkzG/vNbTYDcoDylzlNVMqNppIXo+MOvTNTHTYdSmazbaPEyaee
	cX9lx9iiPhzs/TD6mokefwR5GlKJUW+/8gGxJh25Qmswyix0cQ7Bj421yS4k=
X-Google-Smtp-Source: AGHT+IFXOnvy/ocAMRfzNGQYs7tX9yqfH/SNo9ael9Ml6b5lsNySlSkVRhDobvGk0mBMzXZsEO1ywfx9+jq5WhFkFKE72YB3VppZ
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a45:b0:419:671:25b7 with SMTP id
 e9e14a558f8ab-41906712749mr4249775ab.24.1757485262225; Tue, 09 Sep 2025
 23:21:02 -0700 (PDT)
Date: Tue, 09 Sep 2025 23:21:02 -0700
In-Reply-To: <68bf244a.050a0220.192772.0882.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c118ce.a70a0220.3543fc.000d.GAE@google.com>
Subject: Re: [syzbot] [serial?] general protection fault in vc_deallocate
From: syzbot <syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com>
To: calixte.pernot@grenoble-inp.org, eadavis@qq.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	npitre@baylibre.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 23743ba64709a9c137c1b928f8b8e00d846af9cc
Author: Calixte Pernot <calixte.pernot@grenoble-inp.org>
Date:   Mon Aug 25 12:56:09 2025 +0000

    vt: add support for smput/rmput escape codes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fded62580000
start commit:   3e8e5822146b Add linux-next specific files for 20250908
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15fded62580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11fded62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69cfefa929ab96f7
dashboard link: https://syzkaller.appspot.com/bug?extid=f6cb41c144427dc0796a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17230934580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15984642580000

Reported-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
Fixes: 23743ba64709 ("vt: add support for smput/rmput escape codes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
