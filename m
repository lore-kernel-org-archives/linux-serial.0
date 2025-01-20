Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C17A23
	for <linux-serial@vger.kernel.org>; Mon, 20 Jan 2025 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737353886; cv=none; b=ILrCB0kSIkAsPOS2CmsxYQ23sW0Rs/GplLbTVxS8SDCOVpaSzIX0ItBFQCdnS88AvI8JyR81YgB4q0GOoh0zl+V3VPXL9ZPmIIog2DcFVjekO3hFhVwKpq4ombyYoazLuZ9orX/YBIOvSitsxFrayXxwOJH27+rgkvmo65J5tX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737353886; c=relaxed/simple;
	bh=GMQPFqvqked+eY1iOA3unhKzw6OEBhQVi/TebLxB1Dk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OOQfTZXyX7VRwFe/Wlee+cTZQ+eZzZsous+e+Mt45Af6KJQm336+l4TCdlEPeC8PiAobK5VaARcMCxHj3HHoyjHugoIkcZTwHgcpISWdhaCIanb/vZb88fmdVLlGSrWe1+vyMYYe7Lk6+QIeuLtIQI0TRkimwVzpNbj72nzmzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso31789265ab.1
        for <linux-serial@vger.kernel.org>; Sun, 19 Jan 2025 22:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737353883; x=1737958683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfFNQFBBDbk35XhnHG5b/QslRTBXlj2ffKlfBjTwMko=;
        b=SHM1Kr4oXylRUKtxP0kQuAWeEg/kqZA3jTI1sqU36ZpFLqq96KZlp7cyqCiaDt1UpA
         9xy/dm6TdmlDN1t3YGHNSa58QWQ8kV9y6NR2OR0tttb5+wfB0+iMY9EONVDP2UQ59As+
         Q22PlG23kvCCSQWrsB/s1QpzMYfe2qQUlhtuukFdsVC325rn9PwMazd2ilANmYjXLdiJ
         oSPEo4os+m7SkKyaQmiQrQvw30U3ZpJuFtKtpLOcL60yKO00llV9dEX4Z3XBa4eRMA/I
         D6JkFJ3nDeam1Y4vDZsknFECYOzHtiNWU+SYWs3IIsUEn4TElJYK1CKQuoGgKEaczZtQ
         aXmA==
X-Forwarded-Encrypted: i=1; AJvYcCWew+BA6TVXUgPyZLJFTWdVh3/mt6T1W7CMW2y00wX2qeIFsevpKMjKT3LfoBuU/y/V1ustv0QxCV4eSpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUGFlqRi+dxsc50HpCqtC8poyJ4x7C2RyrefT8hXpJ3GUKNFpD
	Mb32+CNabEQ2L08+8TbN4PXXKyCEoGLuXnYHgJYwOqVfgkddP8wRejOIXaMIblTGnCF44s6oHvI
	f/Ub6naY9wDpL1jMJ5ihdYOE48YEEbuP4qkuo9pZeoNSJNixuUE9xky8=
X-Google-Smtp-Source: AGHT+IHwgHCvSVgduKwc8BeC/i3zUK5jz+MAx8Kng4X8f9upssbOCrucYYBdBGQwz6+IcuoljA/AQee9qLTVmuP8mpBfOxvfoPoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3bd:c7f5:41d2 with SMTP id
 e9e14a558f8ab-3cf743a9063mr98147595ab.4.1737353883750; Sun, 19 Jan 2025
 22:18:03 -0800 (PST)
Date: Sun, 19 Jan 2025 22:18:03 -0800
In-Reply-To: <0000000000004228140621a87013@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678dea9b.050a0220.303755.0068.GAE@google.com>
Subject: Re: [syzbot] [serial?] possible deadlock in tty_buffer_flush (3)
From: syzbot <syzbot+52cf91760dcb1dac6376@syzkaller.appspotmail.com>
To: elic@nvidia.com, gregkh@linuxfoundation.org, jasowang@redhat.com, 
	jirislaby@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, mst@redhat.com, parav@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101452b0580000
start commit:   595523945be0 Merge tag 'devicetree-fixes-for-6.13-2' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121452b0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=141452b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1cb4a1f148c0861
dashboard link: https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164091f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17903fc4580000

Reported-by: syzbot+52cf91760dcb1dac6376@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
