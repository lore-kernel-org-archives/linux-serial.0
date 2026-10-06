Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC445FFB0;
	Tue,  6 Oct 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294149; cv=none; b=uz5ofP6cKzcM7hx+KwYJlLhz1eKJkTTFaSD3MGc2L/0bm8zJyxnFUPmL36dZM6weMxQedLOWChOlk7sDr2c09bQk4Dlp6HqYsc3eRbRqeEEdGmHGmhbkMmmcS0JjSmvHAgTfr+PJFpBHVBNMLDUiJB6+DVAbPuxQUP5QtbYyc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294149; c=relaxed/simple;
	bh=HvH7jliIVM5NmLHOLw/VtY4dMp9sQbB8DV8eFbbRHL4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X+ulNE2o2FvPAsfthCAXGCPVmPyT0jSjgkxW1Y0w6tgy6g+SsA2qW4pLMPIPcF/S/gPxWrm/a89BSxpcp3e5pCiKG8FypkrO/v1bPerD444QtA1+If/6qM+MkZaX8RBXdQRlRE4k3c/e9KB4rwx9ndhvdKrsXCiubkxImfRn0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=NEZRQTyy; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="NEZRQTyy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=YO24heqEXj8ZXkD2uO//smgB0ZhhcNCck8M9KWsbnDM=; b=NEZRQTyynpG6rkYfKSk38K1dEA
	24VGQzCDn0fITz41KE0H12ia06WHgkvPpZdYTW0wcAnkYOFrbxpnIVwkbIjnzBhxT3ryFNMwOXVjB
	tFD5kTDlwqSCD4s5Lgn8A89mdL86inJTMNEqbmGFcSZk7iLJvJhzW+iOoaGAXzpq+lnE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xE5R0-000000006aV-2sWp;
	Tue, 06 Oct 2026 09:42:24 -0400
Date: Tue, 6 Oct 2026 09:42:23 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, Maarten Brock
 <Maarten.Brock@sttls.nl>
Subject: Re: [PATCH v7 1/9] serial: max310x: don't clobber the TX break bit
 in set_termios
Message-Id: <20261006094223.f6ebb7729377787ef43cbb54@hugovil.com>
In-Reply-To: <a69c09a9-76d8-46c2-9aa3-64b7a961cdad@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
	<20261005-max310x-rs485-sw-delay-v7-1-6ae392eca08c@vaisala.com>
	<20261005115737.3a26240eadeff00262e920ff@hugovil.com>
	<a69c09a9-76d8-46c2-9aa3-64b7a961cdad@vaisala.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

On Tue, 6 Oct 2026 07:06:06 +0300
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> Hi Hugo,
> 
> On 10/5/26 18:57, Hugo Villeneuve wrote:
> 
> > You commit message indicate only part of what your patch changed,
> > but not why.
> >
> > In this case, IIUC, your patch prevent ending a preconfigured
> > TX break when calling set_termios()?
> 
> Yes, exactly: a break asserted with TIOCSBRK must stay on the wire
> until TIOCCBRK, but any termios change landing in between rewrote the
> whole LCR register and silently ended the break early. The second
> hunk covers the leftover that fix exposes: nothing clears a break
> still asserted when the port is closed - the unconditional LCR write
> was the accidental recovery - so startup() now clears it, the same
> way 8250 does.
> 
> I can reword the message for a v8 to lead with that user-visible
> failure rather than the register mechanics.

Hi Tapio,
some other patches in your series also have a title that simply state
what is done, but not why, so make sure to check their titles
too.


-- 
Hugo Villeneuve
