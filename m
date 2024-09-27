Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEC290F
	for <linux-serial@vger.kernel.org>; Fri, 27 Sep 2024 02:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402704; cv=none; b=O997klEkffLiso0vqfAYv66fxsAApDfqM5nWkVi9nr+iPR/kPA9mcJUd1TxPtjlJdtgSDdFeCxmnqaUVAYpmSV25vggwHUQqX8ARNRdhqKm9iL/IRaHmBAJdKrFv5o+OE/S8LbLfMhxPLFbnsz//HjrkoxE3qoHz16c72VPf11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402704; c=relaxed/simple;
	bh=OHyvCo9NiAIpi8C7XwA/tpWUbjNyO1z7zEGBzofv0UI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BJj/cjGTko+kLTFlt/lqSLZE0ofqUkCTbtlQiu8Md4sDQz7D5yMKKa7M/WGdSbJ8RLGgp+h+8V0HHvMThBl4ycoyzifgw1OODnPCTTBYEIHHIqJw13PCgtKcbciSSNzjQkR5qAifO2ocFCOQKV5KhWCY32DOy4CKRnuOeZIVFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cd83f0b2eso173988939f.2
        for <linux-serial@vger.kernel.org>; Thu, 26 Sep 2024 19:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727402702; x=1728007502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URDsUQT57ZVIt02dfN1M1XAVNfSaTLuQwRlPHDLTxnw=;
        b=BPhxwERhheIUsnCGUL0CfcFKlM9JGq5bk4n+ufScZXoCCrsn9RxTRHD0aaM7B/DSDI
         JumavBEPgEME5/qHbzxVdj3Bs6UActdnC3bn03dUMt76ta7zDlaudcdp21MgtwaKYGlA
         vFctJU38RZr2zlnECW3zlKUBE6+t/RQqhoeQPbkb+fohFKR0BB5eIFwFTY2muzWdC9y0
         cMM7KzJbC7sV/3Oikzw4J/ahLAxLZBbyxyWnOi3S+4i/oVfKGxpqAraybjN8b3cAomBL
         TyG/Ukr5eDkZvgxdqbWV7atvdwyhcTkiw1gNfeIQFoxXnvLhPfv5IqXBBbuJEZiAMueR
         AJLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8IC2qZctUWtMSRhpPliO/RP/li6LlBZ0ThtvajxjmkO+UcskW347OnLrzwGRRlnlV5HO4TL1vRkUEkPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNC9Ec18bDExA/BVUgl2rHccfUbZndOSmJLfvrVuXiVBmUASLV
	pAgBM48rDLwZpDyHQdz83Rp9bt8P1mIIW/+aloZUVRe/woQZkRR1rqoiD8x+r6WkhSP67hRBQ86
	+Z5R0RmjPAUOBu2SQDJ+qgRUXOthdEBalLeeA5sfQkW7lqh7Pa/PTfi4=
X-Google-Smtp-Source: AGHT+IHHvvKoVaJa3WZYWHvQJAtTmIYpqzTDBC/A3KV+fSDHUB42moVaaXXLcAcjwlIQCYmUHWIBplbmefoc68WBJ2pDs7ywEG+b
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:3a3:4477:e2f0 with SMTP id
 e9e14a558f8ab-3a3451652f5mr16621045ab.10.1727402702428; Thu, 26 Sep 2024
 19:05:02 -0700 (PDT)
Date: Thu, 26 Sep 2024 19:05:02 -0700
In-Reply-To: <20240927013806.3577931-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f612ce.050a0220.38ace9.0006.GAE@google.com>
Subject: Re: [syzbot] [serial?] INFO: task hung in vcs_open (8)
From: syzbot <syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         075dbe9f Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1305aaa9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7f1af2ec501f918
dashboard link: https://syzkaller.appspot.com/bug?extid=8a192e8d090fa9a31135
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158be59f980000

