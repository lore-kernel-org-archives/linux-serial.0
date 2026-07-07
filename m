Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F827466A
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403891; cv=none; b=GEYIHH2UMKduHONeC8OLTVZoKHEfLR5oxMIljdKqQ4S4BUolbQmghKO24xIRP+FsvFJoV9XZFZaRs/a/jiqW4hhyJ58OBO/G/rBUpRB0T3TaGybD6GQHn/ccsfK1PaVaKDmm+3zrgRNjTcxm9NvEdHjcogrKXkBoz1t+W5hSt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403891; c=relaxed/simple;
	bh=387kmmBAcfCwnUaUlGGCTaoXE5/NQZaCgRU94itHu/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6Ss+cbr/HNUUnoGRv4/Wmn6YypuPEu2ahI0qXTTwWP7scXrJoLWjGZ6nNafa11bA6kpm5ZZmYJfmuF4d1iW6RNxklTW24B2p+/XdS9ODtrM+u/VQuCxtM/Yf1G3VMYIjMiZlIwtSnu+h7oGQf102JsAggacEGvoZCsdcw12IbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ysYgHrx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ysYgHrx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D1E1F000E9;
	Tue,  7 Jul 2026 05:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783403890;
	bh=JViUMcoaokAAMRTpX49i6k/gFG+B94Elonm67jeg7AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ysYgHrx9iXg8rw7sbjSV0J3rgr5ySj8q77jbqqqcQd6hQhMbbx0ucKOunvn8Mt0Th
	 zv4EkltnylweOMxXZcV6M9BTE2mZdLJ/0v+p1yGVi3yJ6mvcKdCJuNJV0gT/UTlx1f
	 i5DFOouvKrILPV1QtqA99kT3n2OAqndPAZDJ6spE=
Date: Tue, 7 Jul 2026 07:58:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] tty: n_gsm: avoid reactivation without previous
 cleanup
Message-ID: <2026070734-risotto-onshore-a30b@gregkh>
References: <20260706142016.3385636-1-dmantipov@yandex.ru>
 <2026070611-pamperer-traps-84d4@gregkh>
 <16b08a3e-4b31-4941-a0aa-0b53a0dc4cec@yandex.ru>
 <2026070616-handsaw-careless-c428@gregkh>
 <3ca834d7-1ee0-426c-89d1-b52dab0b0a24@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca834d7-1ee0-426c-89d1-b52dab0b0a24@yandex.ru>

On Tue, Jul 07, 2026 at 08:47:46AM +0300, Dmitry Antipov wrote:
> On 7/6/26 6:18 PM, Greg Kroah-Hartman wrote:
> 
> > That's why userspace does not do this from multiple threads :)
> 
> What about malicious userspace like https://github.com/fff-vr/n_gsm_exploit?
> IIUC completely unlocked 'gsmld_ioctl()' makes such a things relatively simple.

The gsm code should never be loaded on systems that do not have the
hardware for it, which is why it requires root access to do so.

Systems that do have this hardware, are properly secured to not allow
untrusted userspace programs on it.

This has been discussed numerous times in the past on this list, nothing
new here.

thanks,

greg k-h
