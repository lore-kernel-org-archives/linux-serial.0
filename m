Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED204B04B4;
	Sun,  9 Aug 2026 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786253705; cv=none; b=XORB2/jm+hZUm46AmO6UogzJZ+G7C97OhyI733lM8MwCzjv1eELEe3EZcreO4tHilA6zb7t5oq8C7Tye10HEHIpy/3q79bYciyTePE9vkR6n+9EBn0RYV2J3x8XVpPSi/OeWE6sWYu8SWJJrbgUcljF/bF95toJtkC3KdgWwlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786253705; c=relaxed/simple;
	bh=3oQQ4WD0QdDm2SG+ZVe7OSo9bHXxBafQ6ZC6XJ91NF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nPsPabwSYf7yPIK5kkEcL57bjQlgfLyoUD+BsCiFEd5psUER2jJ3u7DOXJxKLtZu0cEG+R6Cb/Wk3MpGZW4SJFoVUsWZqYxpNx+8UsRX3M730t2/aOW6OXWYwCaDXOo4Cy4pCxzobkwVMEDM7eA18bBZt4Mj1BUGWc35Z04fRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6795Ydsm035839;
	Sun, 9 Aug 2026 14:34:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6795Ydo3035832
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 9 Aug 2026 14:34:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <12abb320-153f-4d3d-8932-44c96484188a@I-love.SAKURA.ne.jp>
Date: Sun, 9 Aug 2026 14:34:38 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [serial?] WARNING in register_console
To: Jiri Slaby <jirislaby@kernel.org>,
        syzbot <syzbot+1ebbc20f223b99446034@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6a7411dd.9c11d2ce.289b96.0094.GAE@google.com>
 <c60f8248-dbba-4a87-ab29-ab6315a9932a@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <c60f8248-dbba-4a87-ab29-ab6315a9932a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/08/07 15:45, Jiri Slaby wrote:
>> printk: legacy console [ttyS0] enabled
>> ------------[ cut here ]------------
>> IS_ERR(kt)
> 
> Well, the creation of "pr/legacy" thread failed. Would be nice to see what is actual PTR_ERR(kt).
> 
>> RAX: fffffffffffffffc

fffffffffffffffc = -EINTR

> console_store() is serialized by a mutex. So this should not be a race. I cannot reproduce using:
> while :; do
>   echo 0 >/sys/class/tty/ttyS0/console
>   echo 1 > /sys/class/tty/ttyS0/console
> done
> 
> That's what the reproducer suggests is the cause.

A patch was already posted to
https://lkml.kernel.org/r/76bb4c1c-5d85-4635-b3bb-fc06f292c59e@I-love.SAKURA.ne.jp
and sashiko's review is available at
https://sashiko.dev/#/patchset/76bb4c1c-5d85-4635-b3bb-fc06f292c59e@I-love.SAKURA.ne.jp .

