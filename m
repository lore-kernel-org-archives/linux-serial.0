Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB82366056;
	Thu, 12 Mar 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325267; cv=none; b=BZiBj9DQmkP58EMbHqt+eGHnQDFtCmcwFSBrH0u8gl81i96Bu0Ma125DD7ziOum3nmyoeWNdfh7KlQQ+aIx/y3AMN/+GgSm7LWDD6d+S83LfpwrdTr6MVofxfzCpMNAPzoKPAPotq3m3RMtulRk8nMm/94qJQhUPubK/ViVSaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325267; c=relaxed/simple;
	bh=Rkv978xRVIsaPU9yrPiBIwj4rxUumvpVRowxUuHRMZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm5lMPLgturB01UT1L8sOmuz1K9IkvCtW8+IF2JeLwbkTLNmkmDSUaKJK2q+lEbvgV+F1md0z3Fn71gkORh2dzRQ5sLIt+H2DfwX4A4iODKr9wXnmr46ASNQ1d/4AQZKVCUYoy3/u2ixuj/uuLSFYkYAuJBP75UQK7rV+zpzXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xKnrFl+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xKnrFl+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8484C19424;
	Thu, 12 Mar 2026 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773325267;
	bh=Rkv978xRVIsaPU9yrPiBIwj4rxUumvpVRowxUuHRMZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xKnrFl+KkEXjtkDAXoKjUX5eJ2jaxl0yrioFD6zSS6I/nybyVpV/OTTWhDcZGrZDj
	 hr9n/O2YQAza9X4buXS4X8BdZozADabpKxeymWLENgSZqPJclsgPyfGrYfvXHIrIG5
	 VI0HlWKxw1pf3VUiCzcL2fd1gSEy62cwE2R8NWmI=
Date: Thu, 12 Mar 2026 15:21:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	syzbot+80806cf7508e92c7cc86@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: n_tty: fix KCSAN data-race in n_tty_flush_buffer /
 n_tty_lookahead_flow_ctrl
Message-ID: <2026031211-scared-riches-6a52@gregkh>
References: <20260211210838.45127-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211210838.45127-1-osama.abdelkader@gmail.com>

On Wed, Feb 11, 2026 at 10:08:38PM +0100, Osama Abdelkader wrote:
> n_tty_lookahead_flow_ctrl() accesses ldata->lookahead_count without
> holding termios_rwsem, while reset_buffer_flags() in n_tty_flush_buffer()
> resets it with exclusive termios_rwsem held. This causes a data race
> reported by KCSAN when a PTY is closed while flush_to_ldisc is still
> processing lookahead data.

A data race of what exactly?  lookahead_count?

> Fix by taking termios_rwsem (read) in n_tty_lookahead_flow_ctrl(),
> consistent with __receive_buf() which also modifies lookahead_count
> under the read lock.

This feels wrong.  I would like to see a LOT of testing and validation
that this is correct before being able to take this patch.  How was that
done?

thanks,

greg k-h
