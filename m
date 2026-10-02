Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477B263F5D;
	Fri,  2 Oct 2026 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920215; cv=none; b=OdyGUdei81FXQnOcg0euWfhA2wpn9JihHxwnlwAoXgPnPmM1SK33PlYJfT4eKVsM1qWM69R6+oDi3WAZnvbRyXWhRJ3blNvxLUyTpXRup/K+6EXLSaLJgbMfRZn0Vb/8bZCFkDOJslBcjXgC3oeYkvuOsd43+W4qgQ2IWlOWEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920215; c=relaxed/simple;
	bh=gIZh2F2d8h8R83jmoZvwIoO6H2xHiqD8u7KQm9SMMoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKd3O4Z4GKhqeM2PgiRUa+LBmWSoVCsDPW+MYXzdl0sytbLHlcqdHho81D4/se71WXmPvhSB6lY5wUoPR9VCvhN6aziOKSJwul1R3xA2M4YEJt3xbCKoetGqCncLKJFgY+QuMF+W566tpvTxBkRwKdnLMOPj8GjNVPjIzIxTzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uzAGVHnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uzAGVHnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C381F00893;
	Fri,  2 Oct 2026 05:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790920214;
	bh=ivYYGau2RywVD8fvjNpD9aeYQeee6/9me7U6yBxFET0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uzAGVHnnVeRfMQSe0WQcmDfrbUaz8b+sxnyyke6JuTLqFS/OLrYNRduGNzBakifLt
	 YN/T0s77XQ/x8u1S6x6xFqHRdM3R/250oYMYOrNdUo6pV4aT0f4cDkn9V5HoTn0whp
	 3vAQDsRwNpYeIEATmo9+eydl+OyQQgYc6KZsjxzA=
Date: Fri, 2 Oct 2026 07:50:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akira Patafio <kokokoala4211@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tty: pty: preserve open slaves after rejected locked open
Message-ID: <2026100230-antelope-engraved-8832@gregkh>
References: <20261001165552.2439-1-kokokoala4211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001165552.2439-1-kokokoala4211@gmail.com>

On Thu, Oct 01, 2026 at 12:55:52PM -0400, Akira Patafio wrote:
> Opening a locked PTY slave fails with EIO, but the failure path sets
> TTY_IO_ERROR on the shared slave tty. Previously opened slave files then
> fail I/O even though their master is still open.
> 
> tty_open() releases a file after the slave open callback fails. Merely
> skipping TTY_IO_ERROR on the rejected open is insufficient: pty_close()
> can mistake the failed file for the last slave and close the master.
> Counting tty references is also insufficient because a real last close
> can race the failed open and its release.
> 
> Track which slave files opened successfully. Ignore failed files during
> close, and mark the master peer closed only when the last successful
> slave file closes. A selftest checks locked opens with zero, one, and
> two existing slave files, plus ordinary last-slave close behavior.
> 
> Fixes: 699390354da6 ("pty: Ignore slave pty close() if never successfully opened")
> Signed-off-by: Akira Patafio <kokokoala4211@gmail.com>
> ---
> The pre-fix EIO transition was reproduced on an Android 5.10.240 device.
> The new selftest cross-compiles for arm64 with -Werror. I have not booted
> a kernel with this patch yet.

If you haven't even tested or tried it yet, why should we?

{sigh}

Please test your work before sending it to us.

thanks,

greg k-h
