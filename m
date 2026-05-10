Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278A26CE32;
	Sun, 10 May 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430255; cv=none; b=ewTRZ8BPnx7MJiyIRr6EwBQ+UXnH+sIkYiX115yaOq8yEmXlfBOy9UPIMhPnoubVO+687UO9Auk1ixPnHtenQ8jfwptfyePKsIit5KwkgqfBECXSkXmzUx/b6PEsSqJZOE9hDHkemV1GQRXmonUdJ+/4Zm2FiYM4btwQe3wcOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430255; c=relaxed/simple;
	bh=Jf1CZZSSB7I15cVb5f+fTJJDymeO4gM4wWCdPNG+YTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsKrfEoqdjliW6n3MxxC9nz+mM+oKfS6tBNV93A415L81AGd3DJbquP/oNzLGHFq8djoefrTCdcg8d7Hkh4I8Q2yaXIBKfF5zX2knNy/LjXIikTFhNSwsCI+/cPgIzW7V4LdNCwOa9BqttWfCOs76pXJOLkliPeyXTzMhgwyPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DC4awg1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DC4awg1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4128C2BCB8;
	Sun, 10 May 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778430255;
	bh=Jf1CZZSSB7I15cVb5f+fTJJDymeO4gM4wWCdPNG+YTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC4awg1C4iCN0IRt4LvTZZ/QbPHy/aBE/xO9XXUNSQRWrDYDYu64vd7s3SVrnMM+2
	 h/A3MbAalbITDzQVlmksd8CbUL/kHJaStifYD5ilBvT9XMnoJsLd4lWw+EvEPXNwUb
	 UBsAJnGgrOyaR1Nca7xcnkdoxyC5/GKR57424njI=
Date: Sun, 10 May 2026 18:23:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] tty: n_tty: read termios under lock in poll
Message-ID: <2026051002-dish-upturned-54e7@gregkh>
References: <20260510025940.1884932-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510025940.1884932-1-zzzccc427@gmail.com>

On Sun, May 10, 2026 at 10:59:40AM +0800, Cen Zhang wrote:
> n_tty_poll() uses input_available_p() to decide whether buffered input
> makes the tty readable. That helper reads termios state through
> L_EXTPROC(), VMIN, and VTIME, but the poll path does not hold the read
> side of tty->termios_rwsem.
> 
> tty_set_termios() updates tty->termios under the write side of the same
> semaphore, including c_lflag and c_cc[]. n_tty_read() already takes the
> read side before reading the same termios fields and before calling
> input_available_p(). Protect the poll-side readiness checks the same way
> so poll observes a coherent termios state when deciding whether to report
> readable input.

But why does that matter?  If it changes right after you grab/release
the lock, the data will be stale as well.  What userspace logic is
broken because of there not being a lock held here?

thanks,

greg k-h
