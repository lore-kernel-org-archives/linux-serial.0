Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE90B4AF9EE;
	Mon, 28 Sep 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595902; cv=none; b=tyhxHx8MnhffYRK20wmApAWVuLi0sHYsVmB0yH0X9asNh4TE0mKWmMaAQ/u73033H/GE5lT6mbGxULKGMaoL7Ulio7MXJ3vtnxby/1LFcfLmtCvMOOp4TK0MU6fkTgqdRxKueB8PxH8n/qHxYkNYmgpC0WAMK0VHRdaVGIbR0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595902; c=relaxed/simple;
	bh=WWDxZk80AASfYpuiwhPQo/7X/jq/jxxUsLJB8BQ+IRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anDJTqjj6NWTd//5A9bR3WQbBs7SMwkiush/Jy6xPaCHj3r4AecoiDwBA1UXfnMmu70f+9LOdxzGrup1NU3z572ISjnI0uqR6HtcxaCeW+Re7e2CYU2ZKdUvNNSlmPgP9fdnWjYrl9rwjcusr9hdE9XH6nOihXCGEfwI8410R8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EvySaEK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EvySaEK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64581F000FF;
	Mon, 28 Sep 2026 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790595901;
	bh=Fqfq+mIsBuLSVALbOuV8Adk4pXmffGguDIDfBXsFu2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EvySaEK6KQbBJzHWD6yAmxq4/fQOqXuVCEMNrIpmImcLrFZ7Az+3ZhbJRDDRT+hBk
	 gSBghGmzyfkFYjERy3jv2Pcb0DT59PHlNVDVHMkVeuT5sTM9HctI/Ov8Ai5/zw/vTr
	 saa2B2/XQLGXMyo0lZ7coFTSfXO2FDlg5PCOu5Ek=
Date: Mon, 28 Sep 2026 13:44:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the gregkh/tty tty-next branch
Message-ID: <2026092800-clustered-unlighted-a54a@gregkh>
References: <20260928105940.2186243-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928105940.2186243-1-matthias.goergens@gmail.com>

On Mon, Sep 28, 2026 at 06:59:40PM +0800, Matthias Goergens wrote:
> The T: entries for 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER and TTY
> LAYER AND SERIAL DRIVERS name gregkh/tty without a branch.  The
> repository's HEAD points to branch main, which mainline already
> contains.  linux-next merges the tty-next branch of this repository
> (Next/Trees).  Name that branch in both entries.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> This is part of a cleanup of all T: entries whose repository HEAD is
> not where development happens: one patch per repository, sent in small
> batches.  The plan is at [1], and why it goes out in batches at [2].

Why is -next the valid branch here?  I was wondering how you were going
to deal with all of this...

Hint, -linus is for bugfixes "now" and -next is for the next release.
So why pick just one for this entry?  50% of the chance of getting it
right?

{sigh}

greg k-h
