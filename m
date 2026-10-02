Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA835F197;
	Fri,  2 Oct 2026 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920239; cv=none; b=c3i0qiasntPeW0765a/3+ef9e9qOEvn5R0CMMRf4DND5XB3bFuGCK7dSkNCP6X+OC3vIj14oeLLI4eP3d5UltITPuSBhkuDGTtMv8d8Lw3ozwtVB/ygmS1BdNoBPPDIyh/2X3CD7OLuXwP5UBOaJyYsFmLzrYfC5AONCg19ae70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920239; c=relaxed/simple;
	bh=J8lDDjW+mOazVyUo8+w40DNU0uLvKkLkoZb2dKG/ygg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srfdu7CHtm4OHXufZRc7rWhGzu62KfAuUJfQ9pEtRYXJ/wPciX32LqWkX3ECuDeESW7ElXxOfMSaKmLPBG/PeQN6g29U8nLTE9grAHUajbB/UUB/2Mau0/uMOZClEkyH/swqGxtOGtcRPI/e9dbHGOhboxkulwOzm7l2VqiESAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GwGqzpkr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GwGqzpkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A81F00893;
	Fri,  2 Oct 2026 05:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790920238;
	bh=LiJ//V/sltvgbD9XrH3hQulh6fc1oNwkWPRM9Sb2Phg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GwGqzpkrBrBJVtFdZ7SHDV4kj3zGIb7zPkjLCFtCPSwe9zi1BkkRgJMNd8tUBCyYK
	 XAi/RsfqHMq/5fK/PhAA1+/nVTYYKWVBTihhLqw+h+7etTnevtCL4VhVc0AXBsDqeX
	 FGBOWHXr/Y1wDImxkhaZpnREFj2F5tpLYiXijw18=
Date: Fri, 2 Oct 2026 07:50:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akira Patafio <kokokoala4211@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tty: pty: preserve open slaves after rejected locked open
Message-ID: <2026100217-magnetize-sphinx-bc0e@gregkh>
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

Also, did you forget an Assisted-by: tag here?

thanks,

greg k-h
