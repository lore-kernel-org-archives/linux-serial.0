Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D186301472
	for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881044; cv=none; b=SfVg0CdZh850lW0CdESeB28Nw5hBwBr/yStuqa6ahmxLHHGAUWUyhmkLftgBgAd2TKO4ki5r4BlWkj3lANgNSzynZjKqtuh9NAXBMibEH1msFaW998w7tC5lOOvc+znBrHKcH0gg3AS0UdTL9YpW089UMIMehgTNOoH7senPbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881044; c=relaxed/simple;
	bh=cAaMqoJBYyjyROFndlY9LzDba74gTflyplo04zoEagY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J7InS1ynA8rI7jheN9OrwOqzIqOCMqzJiCPoLPFWpmn+3QbqQQVm0QGo0hy/lf1jTj+JxMrWRMGQdRZEvewJrIwdoQKqxeKcKjLNmgeEAiIVSO1iEguFZt9i2TGvwKUWK3GbSuVRCJ53AcKZbjyude1vOmnYWzPaiq7rdeJxezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4639f4233beso7552736b6e.3
        for <linux-serial@vger.kernel.org>; Wed, 22 Apr 2026 11:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881042; x=1777485842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5rmNLcGJICZvzxfID7OeIDr/CbQ38qvrQT+PToZyWY=;
        b=UR0shbI5jIhrDzMYDYbyrnu9Li5p7Htr7WEXV1GZYAiNf8G4Yvvxv1B7BAkbSTyNuq
         czJSQpekHH5IZMSLS8itmoYfge37NH/zzqDXRjCkQd4MKHIWcT6FY1vgF/N/SPU6DZnL
         ttQQkLYmFqQEZULnxLklGhayKg1gzBpfVXmRAeP8imRPbSakx9yoNCSc2chozga+aF64
         4huz7MpXAzhxQ50cCWGMoZqlLr1/BxCvWIkc5QLhxz5L0dMj/ZtMn+3oa2V00biDrDYN
         EGTAnrTam2MDFMuvTYEYRzx+P84oVSwoeC0jhpQ17LlHVfo7bSdMqjJT93KcLIyE5xaz
         lueQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0tzasZgczQqcCFBsketnTSV9KaGGIm9P4ysMqkv/80MhCOXiKtj33kw/i6RzrPAcigK9kCqrxR8nTHh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6plWKSCp93zfkYZT6xR/l/FHnFfR2z2CaAqr3hEAc6RNtX+S/
	aomWw152zdlWd9qzko9n0bTsGB1o9RyTHyJAQlE5gkpmLsbVZIIOFKMAVGtiSW/aw0OFB9wVoSy
	QLGjHyu2icwWuerulsSg26P2TrOVzJSU0O1TFor0gs6+3l4wrCWO92L845TA=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:e3d6:b0:479:ef66:44d9 with SMTP id
 5614622812f47-479ef66476dmr3642250b6e.42.1776881042531; Wed, 22 Apr 2026
 11:04:02 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:04:02 -0700
In-Reply-To: <aekHPX4zEYZoZFOp@JMW-Ubuntu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e90d92.a00a0220.9259.0020.GAE@google.com>
Subject: Re: [syzbot] [serial?] memory leak in gsm_activate_mux
From: syzbot <syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, s9430939@naver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com

Tested on:

commit:         6596a02b Merge tag 'drm-next-2026-04-22' of https://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b574ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=943968b43250a7da
dashboard link: https://syzkaller.appspot.com/bug?extid=b5d1f455d385b2c7da3c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1117ac36580000

Note: testing is done by a robot and is best-effort only.
