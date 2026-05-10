Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF113AD520;
	Sun, 10 May 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430152; cv=none; b=S/wmCgz6MJM/YkYNwYFWDAkzI+2hj6hY3S64ObDKr57Fizfh2tNJ2eB2ROkHynH55XJXjKY7p/y06VTqah3TxwIeHqTqL/b9ZgTiZfmNmJ+3GWhXzSRDsAiBlgwmMgkN+CkCD9XmvyUODgE9k/KZp+aKz2Nfx2Nj6OAe+Pc1Q0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430152; c=relaxed/simple;
	bh=TUMDm2AQ5R3KC19Kx6TWztIDEhdsOOfAYmHF+quFkMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPKad01lZri5LGOEmLGBCf6ggVdnq2W+h2Mw8S4wlYyBJykj1w8izdHOm1Tmz17CeFNB975BhS0qyfhS8LwkmJV4iOWz57FC/9UI5GfGwYzCsVnCaxca2NoglaV2aE3hZURTkfzDGphJNCcQF2uxxttPQyutPKQVAvlHi1QEDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ra+MNMPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ra+MNMPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F04C2BCB8;
	Sun, 10 May 2026 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778430152;
	bh=TUMDm2AQ5R3KC19Kx6TWztIDEhdsOOfAYmHF+quFkMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ra+MNMPSoi/CyORvnoCe/728IRvCOFmKqKYxRD2g2nc1yV+5htbFxLJL5mAhU+SUy
	 ZvQigaih4P2YbfLtg6YFUlAYMoW9/PI5lAXqO4LLtNiDL4q7u+lK1BD7Cecb7JeWXd
	 w9oliMC3S9kDhSdR/d2k72bhRXzWhxOribrG3stw=
Date: Sun, 10 May 2026 18:21:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] vt: keyboard: serialize KDGETLED with keyboard_tasklet
Message-ID: <2026051001-peso-enamel-2e62@gregkh>
References: <20260510031348.1922157-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510031348.1922157-1-zzzccc427@gmail.com>

On Sun, May 10, 2026 at 11:13:48AM +0800, Cen Zhang wrote:
> KDGETLED reaches getledstate() and samples ledstate without serializing
> against keyboard_tasklet.
> 
> That is problematic because kbd_bh() temporarily stores ~leds into
> ledstate during a VT switch to force LED propagation before committing
> the final value.  An unlocked KDGETLED can therefore observe that
> internal sentinel instead of the last committed LED state.

Why is that an issue?

> Other ledstate readers in this file already quiesce keyboard_tasklet
> before sampling the value.  Do the same in getledstate() so the ioctl
> only returns a stable snapshot.

stable for "what" exactly?  This is a snapshot in time, be it before or
after it changes is not always going to really matter here, as it can
change right after you "enable" the tasklet, right?

thanks,

greg k-h
