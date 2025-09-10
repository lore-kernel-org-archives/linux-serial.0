Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C417C77;
	Wed, 10 Sep 2025 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486901; cv=none; b=utYzaLxwI/+szUlJMuraFtZY5AFXRldyzpk0r4aTo8ASwHXXeSE+G6vLrjo4ef0PIaheO+BDMk7oN/dLsNNj5uB0yHuyk1OzL5/cimr+zJqTFhACDmDEqYuLgBoUOdnW390aGPoaOvmzhKZMxy2A3kXKZQs4yfl4CyI7K10Lk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486901; c=relaxed/simple;
	bh=BQr82IEm2HzzR0RyddG06kxcr8HJUdSHOUt66sRHl74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KDd8xHvxUJeNzN9CCn0S7YexwD19Wz46OrnwgrpValqT6pCxvGeDC8BRCAdxZAxVjBG2YyRRTYAzV1TUvzSDZ/dY1LOTzkgitk0jTzCJ3pAg0oOX8OA0SapTlHphSmaWm+xShJGGGAr7rJPzqCCXSd6lk+AiH//JSxB/HQl0hbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDi/ogUs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDi/ogUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3189C4CEF0;
	Wed, 10 Sep 2025 06:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757486900;
	bh=BQr82IEm2HzzR0RyddG06kxcr8HJUdSHOUt66sRHl74=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QDi/ogUsqKp2SezNfGkOzRr5z2iQN1xQnqyKQXkAOukd4qnbOUCs1p7mICGP+coa/
	 4UaFCApkjpYJ0dfncgw0RU2vrtCXpKjgir0SElve+UvokjgC8TEp0ejoiFlAykY0Db
	 +HD11oTQsKcwMbub+A9Q33+wqfT7zccxV+WB2hJX9mAAHt0jpXjVbB9jk0D8/Moryw
	 3Cn15JgkXXHw3G+kwNwN6fs1W0OpDOG2aV2GwvSS4f1HR89PUfcUVLxnKiuAmXuwtC
	 ytQ2387dsScrrg5bjWSUgKRIk1GLVVX3FWcuiY2PzZSJWG2vh3bbL5kWdWKUtri6Pj
	 c7/ivy0YRQEYQ==
Message-ID: <39724768-c8e2-4efa-ac08-cce3d30414b8@kernel.org>
Date: Wed, 10 Sep 2025 08:48:16 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [serial?] general protection fault in vc_deallocate
To: syzbot <syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com>,
 calixte.pernot@grenoble-inp.org, eadavis@qq.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 npitre@baylibre.com, syzkaller-bugs@googlegroups.com
References: <68c118ce.a70a0220.3543fc.000d.GAE@google.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <68c118ce.a70a0220.3543fc.000d.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10. 09. 25, 8:21, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 23743ba64709a9c137c1b928f8b8e00d846af9cc
> Author: Calixte Pernot <calixte.pernot@grenoble-inp.org>
> Date:   Mon Aug 25 12:56:09 2025 +0000
> 
>      vt: add support for smput/rmput escape codes
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fded62580000
> start commit:   3e8e5822146b Add linux-next specific files for 20250908
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15fded62580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11fded62580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=69cfefa929ab96f7
> dashboard link: https://syzkaller.appspot.com/bug?extid=f6cb41c144427dc0796a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17230934580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15984642580000
> 
> Reported-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com
> Fixes: 23743ba64709 ("vt: add support for smput/rmput escape codes")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test: 
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/ tty-fix

-- 
js
suse labs
