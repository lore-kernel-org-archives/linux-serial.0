Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7634476CC0
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525211; cv=none; b=K9NY2QmXjyLUDnmJQucZXKS5bxTz8XzwYTpaDVqzvrtJ5wfQRrsnfaofogHca3pWTVOmfcQEmoReo3uLi/8t9wv+qPM8Ue0najsHkuNfXBYiL2gwHOTkJuCIZMcXu+eKWWV0eIcIliri/jkQzHOMmUJlQxdnMSUuMgDY3MQ37fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525211; c=relaxed/simple;
	bh=aVuOCE7PAht/GWSBfa89Ep4xuDVC3M56EgxqB8xQgVw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XSV+MP7h5uB85mfhmeCNyk2/I8D3mJysm3Zf5ZigLOZlURoczyYZ7vuyc+20tEz9Kf1iaa8ZHjKkxvE9uFNV86TXsBO/83csSenS7sa4/mtFnRSi5XPe/LQ4LgUx67g+O79LCeEnOkN2cuX08Bao//dZwWIZZ6S+CsdL81OfRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b3319233c2so1292237b6e.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 05:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525209; x=1789130009;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LIY36S3UYkiraL4OOsPuf53+MIpRHYVmDo+vHQVYh3E=;
        b=YcHtv2sWuHb/R8PJAkcO1T3//C/Sp06xqlu8SI84hesUjP/VJhxhKxYElrVCR+nvmA
         8TPULNkl8s9n2+hleJE5/YLSJawzgqVf92L0qLbSv8AMeLJzv87lhPYvXcjt6p8QZZEf
         8uxnB8y0I+pQ4mmUsOtbBLc4MoVTd/fPXSvcZ98PiIIYEUaTbbFi942IWwyYI+S0/ajf
         7IIZgNqTPW7AjwQ9ZDSSKRhnhVYLdCPAgHbRSnpArnbADsoQCdt0QwJpiMIk+WHE3LVF
         8xE0+VLSvSffNL7Rhy6FA9zDpxiu1AkpB5wHTLFx1yjvkHDB6IvFrcc88qQeyT9+ffg2
         5TZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxD3tt1wzuKDnplZdZ9F3lRTq82jFvEaYB1S+VjEF+DSSkjLd1I4NGo2Nq/gO1gTu4X35ad5/2DFvHkC3M=@vger.kernel.org
X-Gm-Message-State: AFuF++ljeMmncGLcPReo6rLcagtJ31nbpZHaOjz43TBel2+SdC+sJtRV
	XuSwkloe5bBjYghTDogETyeVngID3YOS0dn/k8ihexnDVliapr/33sTLjFB/tVFuWSv85MJywSB
	U3kkej3FTaKSERG+Fg2D1TWUux8Z44eELLkvTIrwm4ft5R5meVJVPuH/5yaY=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c94:b0:6b7:83d6:2922 with SMTP id
 006d021491bc7-6b783d62f6dmr1539363eaf.37.1788525208983; Fri, 04 Sep 2026
 05:33:28 -0700 (PDT)
Date: Fri, 04 Sep 2026 05:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9aba98.efa90033.8a9e.0002.GAE@google.com>
Subject: [syzbot] Monthly serial report (Sep 2026)
From: syzbot <syzbot+list9344e91579f83f443c90@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 3 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 48 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 14      No    KASAN: slab-use-after-free Read in kbd_event (2)
                  https://syzkaller.appspot.com/bug?extid=098cefc0911c68db5dab
<2> 5       No    KASAN: slab-use-after-free Read in stop_tty
                  https://syzkaller.appspot.com/bug?extid=2932e8970a6398db95c3
<3> 302     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<4> 188     Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<5> 80      Yes   possible deadlock in n_tty_flush_buffer
                  https://syzkaller.appspot.com/bug?extid=d84934b4184d7f9a1aed
<6> 7       Yes   KASAN: slab-use-after-free Write in release_tty
                  https://syzkaller.appspot.com/bug?extid=bca09f5d8b843bbf7571

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
