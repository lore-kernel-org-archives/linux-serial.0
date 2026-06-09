Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7440DFC8;
	Tue,  9 Jun 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007064; cv=none; b=gs44OiAGnNl+kBman2pRi3pOwHNua04DdFa6wEkM45QalH4gNoFOQYQpPslr/e8xoMg1JV5WkeEEOk3GvAWjzTx3svKVznG2KVJMK47BxPSIn/vMySaEKw4R/ijtX5xwoQBEssgVh6I50Ynza4UGa+gAB4dn6y/RN1hX1ZDncN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007064; c=relaxed/simple;
	bh=6EweCTD/O0vt24tfslVNQXk+DD+7a1UgVdL5o51AGVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBO7XZcPB+zU4XTinTKmu4TSy4a/JVAKK03s9MnlnrzixkHE4RGGgTlhmJPjiTVPljwsOSTJ4I1A8y4D/BZTk/KzZEe1foOdD+eSJfBaClk8WNsZbnTgaxzL1yCUztrkupMkpnnWVhn7tBDvYwCSk7GoJakmKjEny6nL+U+Jo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rZDu8lg2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rZDu8lg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3881F1F00893;
	Tue,  9 Jun 2026 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781007060;
	bh=pbdaz5GE341vPEoJSXyr0aPEeXMjXkrGt478+QcH74w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rZDu8lg2WgcAXR9H7c3654ifvB3NpXT8U+uufxtkKqPnStR5Kt8F/hGfXd0IGzD6r
	 5VB6j8XhVq9VCYMGzh2gkdpZLtHidoWvP3Gl5X0GgbdVDr78SINTC/H7NBbEJQ9eJm
	 ZffmoV6dauhE+vuY4eZP8+XY7DVVIoW+FQFGdL6c=
Date: Tue, 9 Jun 2026 14:10:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Longxing Li <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [Kernel Bug] INFO: task hung in show_cons_active
Message-ID: <2026060919-unchanged-raking-9225@gregkh>
References: <CAHPqNmzFQPFCom1Ng-FhbeRm=maLsKW1T4ZasGm40OkrxJfuwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPqNmzFQPFCom1Ng-FhbeRm=maLsKW1T4ZasGm40OkrxJfuwg@mail.gmail.com>

On Tue, Jun 09, 2026 at 07:49:13PM +0800, Longxing Li wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. INFO: task
> hung in show_cons_active. Details are as follows.
> 
> Kernel commit: v7.0.6
> Kernel config: see attachment
> report: see attachment
> C repro and Syz repro: see attachment

There are no attachments here, nor any real information.

> We are currently analyzing the root cause and  working on a
> reproducible PoC. We will provide further updates in this thread as
> soon as we have more information.

Please just send a fix for the issue, that's the best way to get this
resolved.

thanks,

greg k-h
