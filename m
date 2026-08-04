Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA434CFD0
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846747; cv=none; b=GGToDiz4gpa2zOt6EiBBWH94xTYJ9AohYgUmpQLovVrGq7Phq6f/sEzRnpnwSKojjnAuAIe6ubbcb2vRjQ11Q3I+J+FwFCvMunYxnPNOrnrjE4UpmmIjGtrqcvkfcdr+tcNMHtttgjxzfIo+OzHTHHDBUlXBNX2YvPwq3pDvftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846747; c=relaxed/simple;
	bh=Izxj854rdaCHL2tekuNqeJcJPONMe1aBdk4dez3Pv70=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JrEyTF4eogX7jxImC97USMnXle6uG7AOXnmkwDjJ5Sa5zt5Fm9Ra6tYXI3XEFLS9ojFET3qzrzotA/8WxigJfbI5DB6w6SztTKCd8royEX+VVUam0UnTHalNY0SA+HTIOFxDwmpv4GAWmAs3ghYegLRXGLQonfJ4SDndhnqfkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a416619e8dso1397441b6e.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 05:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846745; x=1786451545;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAV0kdT+lQ97D3GWwNmaJg4s/bCkGmU2xCM+voOG8vA=;
        b=lgx7QKcfg4qMiDcmEXczAXVIoZsi69sQTGPtrAGY8mUbOFmphgaQLHkG8uiO2ICT6G
         afVOCZ3Do1U7rUxicg8K2zVdI8A9w/8vC4Hq208X5gBWR9ni2x7e6tpmyceILsNtnSxt
         4mWcuIuWCvEN4g+z3i87FWGQvd6zU+3vTo6/yDnRjk0zrXGAgjdXufRF3fUKYN3Gy6y6
         +abueblL9Ols+RdwQl9sdT/VNufemID7liIakHNdvjJJEiUvl2mRzgfcXT83m57U4zU4
         ZqWWXIueq+5e7rxY21eSkCD2QaWftZF0x+eDk5AF0o5peOatV5hVGmYcBRn6IWL8l4mQ
         YcOw==
X-Forwarded-Encrypted: i=1; AHgh+Rpzjh2YdzPq9wX1b574rTJJfef+HkaLjvahbUW6XQZZJDnLWIOX5TS6zhucmxEE7y/lSLMdiHI2cCifXd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywekn0ydkQBEEVn6bCRlF9LG2hTRM7EtNBDFmyR2p3660fBbqOP
	n4R5ps102QFfwKzSp0y3qzfjVkM0sA7uaKMHYVXWJjlVJaKiFuvZpArtNloK0Hq+v97civ0ILT+
	0xJK3FpnnVyFqGihjemZrj0mSyta77WPpUV1orvNwy27RCdPSDiy2BczuvKM=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f26:b0:485:7c46:b866 with SMTP id
 5614622812f47-4af98afa61amr4739165b6e.16.1785846744853; Tue, 04 Aug 2026
 05:32:24 -0700 (PDT)
Date: Tue, 04 Aug 2026 05:32:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a71dbd8.13623e66.bdc14.0013.GAE@google.com>
Subject: [syzbot] Monthly serial report (Aug 2026)
From: syzbot <syzbot+list7475986d99d80e9dacd9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 3 new issues were detected and 0 were fixed.
In total, 17 issues are still open and 48 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 30      No    INFO: task hung in tty_release_struct (8)
                  https://syzkaller.appspot.com/bug?extid=02452abfa3790d12a1a1
<2> 15      No    KASAN: slab-out-of-bounds Write in do_con_write (3)
                  https://syzkaller.appspot.com/bug?extid=8e9c1abac3ceb45abffe
<3> 3       No    KASAN: slab-use-after-free Read in stop_tty
                  https://syzkaller.appspot.com/bug?extid=2932e8970a6398db95c3
<4> 2       No    KASAN: slab-use-after-free Read in serial_core_unregister_port
                  https://syzkaller.appspot.com/bug?extid=9f57c1b2792029198fcf
<5> 274     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<6> 158     Yes   possible deadlock in tty_buffer_flush (3)
                  https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<7> 5       No    KASAN: slab-use-after-free Write in tty_init_dev
                  https://syzkaller.appspot.com/bug?extid=fe63e4d633540f230624
<8> 3       Yes   memory leak in gsm_activate_mux
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
