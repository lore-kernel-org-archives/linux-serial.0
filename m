Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E338424F
	for <linux-serial@vger.kernel.org>; Mon,  6 Jul 2026 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351075; cv=none; b=Xne7OugnShx0Whi47TTKiYK0CJeKTAaNvAkgoQCUzMbYUUXMwXy/1rRWwgfaIC8Heoaye91FkvyoIKY3xeej2XSy/gLm2YOzwJ1FRr6QX56GkVfnh65YgJyVqQigoznwuF4adaPGBET1XOGnO3syIQhHZQhkbzCj6Ov/cNw69gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351075; c=relaxed/simple;
	bh=MvQuiOMRPr3zBMOqmRa07lQ+GxdXVdQQiDB4ywCQpmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwtlxG0iZTNcDCLoraOYPxVFX0BS/HgD/h2+i2bI2649cgdD0Dt7SfAG/q86nIw/zmwynNUAZS2mQMv6MALpIHeBhnSE8aUplYoV4LBjsu7B6ftFqo1pFP5mAPVAIP8aK81LojtboqHxV+xGr2uLqeS89Zcsy6by49pYYl40rv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iNJ7Sxy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iNJ7Sxy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBDC1F000E9;
	Mon,  6 Jul 2026 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783351073;
	bh=qST0LKt9CYIq+AJaUaxoZu2S0I4CCRoCcq2eDuQBNv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iNJ7Sxy4+Liq7LdJ/ZiMcyLMOuFoYaZ013SxGJfXHkFQGPEUiGSD1S+J94C/VIbQG
	 l2oEOw49csORQKc142cgbgRGlvEEe+pWeY+5ao2wxmSgB90r2ZXwBFLwQF86+xDFVv
	 wyIuSp+2uunOyDMjuh3j3bQLx6yqw7AS07W+1slM=
Date: Mon, 6 Jul 2026 17:18:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] tty: n_gsm: avoid reactivation without previous
 cleanup
Message-ID: <2026070616-handsaw-careless-c428@gregkh>
References: <20260706142016.3385636-1-dmantipov@yandex.ru>
 <2026070611-pamperer-traps-84d4@gregkh>
 <16b08a3e-4b31-4941-a0aa-0b53a0dc4cec@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b08a3e-4b31-4941-a0aa-0b53a0dc4cec@yandex.ru>

On Mon, Jul 06, 2026 at 05:49:38PM +0300, Dmitry Antipov wrote:
> On 7/6/26 5:35 PM, Greg Kroah-Hartman wrote:
> 
> > We've had loads of syzbot "issues" reported in this code, and unless it
> > actually shows up in a real device or operation, I'd just leave it alone
> > please as there are lots of subtle issues involved in it.
> > 
> > Have you tested this in real hardware?
> 
> No. But I don't see any practical reasons doing ioctl(..., GSMIOC_SETCONF_EXT, ...)
> more than once (without GSM_FL_RESTART) without doing anything else. Worse, an
> attempt to do it simultaneously from multiple threads is obviously racy.

That's why userspace does not do this from multiple threads :)

> > Why unlikely()?  Can you measure it with/without that?  If not, it
> > should never be used.
> 
> See above. IIUC "real" userspace program which talks to the device is unlikely
> to bomb the device driver with the weird sequences of ioctl()s like syzkaller
> usually does.

Again, if you can not measure the difference with/without unlikely()
never use it as the compiler and CPU will always do the right thing
instead.

thanks,

greg k-h
