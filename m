Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB55308F1D
	for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488807; cv=none; b=FkBt5l8jI3h7fsYhjPysty3VWM8IZZMIXu0JLIlot8YJxzbmjCPhMzl213BtusAFJBagNPMATofaRboUT3nSFUEawyHZ+1O3pj3l70cRACxxxrifDCoLkx/TO65uuoUH1ZkK7Ys/ePiif+rjpuxqq6A7g7L/XRCHEfxZE8aLGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488807; c=relaxed/simple;
	bh=g4qx77pmzTOAF7BwlpF+LAkOzRB35kNRI5WXxTMn37g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lzbOGKYCj8FHwJJEnfcskk8TjEmwfelCdxSiHdWWIk2fic2iOtCtzq8T25pQfzm7H9yDNFR3u1fmG2dhWCZelRn1a5rl8OEfQ7FOCa0MXLyQMPF5Dt7RWdi9hj36XLtVUyifnCQtSVxvaUmjumbUrPXa0dtl3wr8i0fJf+p3Q0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4143cef1ff2so26739325ab.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 00:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757488805; x=1758093605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tq2Nm8mOpiYO3aZi6xQsbBBXx9UxleJOPne87mDiqow=;
        b=uaX1y1l99vqCXYiebmeAx+Kafr/Zb1nIhHFgue3rCqEjLKHGpM8lsvUETfhFOsNeOl
         aR4ahXmGDI76jzB61x4oZD1lLVl4pVjqcwn1Fs4eKq3BN+hF+wpQTdTUZSKPp2LIp5uG
         6zkPAYqDJWhg3kxQn/JdvhfAiviczUlVBTeZN+aLVJDyNmishJb9JDzMIwsIF7RMTuBu
         zBJseKYho3YXdXLS2lytkp+KD+uq9U5iM+dOqLGGXjqx1yZjMp+tZF/KyxMl8IzmfhjI
         Ql2L/8i1+2oO/ox3DHi+95t9CUQKYfptPHX7HWjbovit09Nwiy5yIeBU95bkqb3QRD6p
         nQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCWD227k3k6/EgSwVKcaGysb38felTsoo0NOFQ/lCPPjYd8OwqrEyjhagQ3zwDGnp2Rd3jaPIFSPfhO1NXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYv/fpRq4Ei0Q3u/VJ8vAeXbmAwcD3csL7tPORWaOWIv9qaY3
	80gNTKpgvwZ0nReJUsQsWTxpni4nL407sJnASvqQAbp+fL6mp+A2580SDhvB4y6XRAiAypBsWAl
	CGsggss5AvYfxSqs5yvU0tKShnpppyYt0JwwFYRus5zNnIgekkKWUwF6HfqA=
X-Google-Smtp-Source: AGHT+IELFz2CwDc37xjKVFddkK2kiM7V9nBPIUHCiWHTinTwwOIesxbjHp6JGPP0KExChwDhfUQPjMClYMH93LIBYKh5KcKi4ore
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2703:b0:416:5159:b34c with SMTP id
 e9e14a558f8ab-4165159b4a5mr32996505ab.6.1757488803973; Wed, 10 Sep 2025
 00:20:03 -0700 (PDT)
Date: Wed, 10 Sep 2025 00:20:03 -0700
In-Reply-To: <39724768-c8e2-4efa-ac08-cce3d30414b8@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c126a3.050a0220.3c6139.001b.GAE@google.com>
Subject: Re: [syzbot] [serial?] general protection fault in vc_deallocate
From: syzbot <syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com>
To: calixte.pernot@grenoble-inp.org, eadavis@qq.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	npitre@baylibre.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
Tested-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com

Tested on:

commit:         55196010 vt: move vc_saved_screen to within tty alloca..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/ tty-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=159bed62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69cfefa929ab96f7
dashboard link: https://syzkaller.appspot.com/bug?extid=f6cb41c144427dc0796a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
