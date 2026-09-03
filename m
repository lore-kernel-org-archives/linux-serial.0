Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339B2BDC1C;
	Thu,  3 Sep 2026 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416572; cv=none; b=mnmOqwv39XYQBw+35CyV4RgRIODq4u1k4Ei311W3sSVjC1o94R4RWAxa2Qd+7iXVVJs6DL0qF/LJRjf5zi0PyY/o3oHztxOvNfgxLYep1fO5gAQxLF58jwIT26pkOfHEI9JN0HLl9Z9460gFQcDLYWyTwCkDpGmB3gKdKI9GKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416572; c=relaxed/simple;
	bh=SPjbvjqFzPYXc/5jyw1jOrHWb439uS/VAFjAOJWepVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwq0a6P91sHubq1OFz4qBKA2RlXcMEZzipfOH4fEGiacqIjkWT8jw3Z5OjF5ycg9ucZkA09etxWjmfs1J7BUcHYJNZ/uXbWt877NOHocoJLxuxo4/FRk3h/GNkFz2I0GULEM5CEn3Nct70UBZmLHbDcuVCwAiDKM+r96rRFsIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNayyroB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNayyroB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85561F000E9;
	Thu,  3 Sep 2026 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788416570;
	bh=LNn6FhP4Ixqm5wtWc/cWwD5g9WnADR1+htVn+9RzmaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oNayyroB3ST+gfb2pdnh6jgIbbOmB6eVHjuIfTwrkksflS8ToI08LlOcwUVwBpZ95
	 rJD/Yl+iwRukoiXaYH7D+7xtJX+COZiK+1AojT/PaQ4XcOlWf98ApV/dPUAEOS0acV
	 o2MI4htsYOAB+gJXQhLAodFIiSMvRzYJBMSsncheABkeG/ulp4SXXeDIKt6CLvrG+B
	 bxGybsVoA7jVAJ75Z7RXEAljFA+WzYu8vo3wWHBPjh4LNOJ6B577DAeu2DUeHX2WpE
	 No3S9m8Xj+CIVavxB42zANtceD1PNvaNuM4JflWB9fx55GfRIZwGQZmWIm2O8wHkhf
	 JjxewzvzzZ+Jw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x20qW-00000005jsG-29wj;
	Thu, 03 Sep 2026 08:22:48 +0200
Date: Thu, 3 Sep 2026 08:22:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Adriano Cordova <adrianox@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 0/2] tty: fix break race
Message-ID: <apkSOF1l7VYTpzul@hovoldconsulting.com>
References: <20260903042429.130320-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903042429.130320-1-adrianox@gmail.com>

On Thu, Sep 03, 2026 at 12:24:27AM -0400, Adriano Cordova wrote:
> A timed break (TCSBRK/TCSBRKP) and the unconditional TIOCSBRK/TIOCCBRK
> can race against USB disconnect and call break_ctl() after the device is
> gone, dereferencing freed port data in keyspan_break_ctl().
> 
> Both patches are needed: the tty core must not issue break_ctl() to a
> hung-up tty, and serial_break() must not call the driver after
> disconnect. This is the same two-layer protection read and write already
> use.

This doesn't work and as I said in my reply to the syzbot report I'm
preparing a proper fix.

Johan
