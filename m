Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FE1E4BE
	for <linux-serial@vger.kernel.org>; Fri,  5 Apr 2024 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355916; cv=none; b=ekAgzPXatev6qXuHO72HDKZK0yxCDvAbiFPLxtUHrl/0FK0CIOXuSH6Xjl/BdmUlrQsQ8FKXg660rejOCO6e9oa5B70fJSjp4okOTkfc8CjuXmttVSrcyWtvw4MP9P9YY1ccDY1s5cVmfDyIfYf+4BLGi36Py9k7PUXzBsjdDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355916; c=relaxed/simple;
	bh=9hz1CacEtBqBR2tMlHhXU8XFj54Ot+LLOeUrP6Vf7yY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdEtvfmpLtPfwKNkQuiY8zhAS88K7wy2qJNgZTGiC4YSqhi8G9eI5J4VW+8ygYfqv4NZzoPgpwGLGmp92oPfs7t07u5HBWGr8VxhqnwqUg+zU2l46TEEKl+JDPvS633OquRCCaJbO9Y4ugMgbvjhN4G3BzU9hFZ1FyVj+89EVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 5ade748f-f39b-11ee-b972-005056bdfda7;
	Sat, 06 Apr 2024 01:25:06 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 6 Apr 2024 01:25:06 +0300
To: syzbot <syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] general protection fault in
 serial8250_tx_chars
Message-ID: <ZhB6Qt48rkC3zMUb@surfacebook.localdomain>
References: <0000000000009e2dd805ffc595a3@google.com>
 <000000000000706b5c0601125945@google.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000706b5c0601125945@google.com>

Sat, Jul 22, 2023 at 05:16:21AM -0700, syzbot kirjoitti:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d03ff4a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4507c291b5ab5d4
> dashboard link: https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e4fe52a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/517e5a5be15c/disk-d192f538.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/59d41b43c30c/vmlinux-d192f538.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/99ed26179ccf/bzImage-d192f538.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+837b8c9032c053262db8@syzkaller.appspotmail.com

#syz test git@bitbucket.org:andy-shev/linux.git test-8250-pm

-- 
With Best Regards,
Andy Shevchenko


