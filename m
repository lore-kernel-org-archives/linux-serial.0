Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789401;
	b=j8vLcAwYBPzLBSgA2uLnH5qoQJlnPEigQrByn8P1/LQ8NcKxpVLs4eLx4jtji0xh03ZN
	 6WbMEcYCu+ZpCncV7OuMXz0MWXH8MK7KlWvkas+2x1oOvv/5bzemWF0aR0P2dMcgIl0TE
	 /8POR0bgoHViB0eeGBU+KA4T40Fp/GaA54hhaavpxU/Dn8rwvuonlc5QJSA3hZmgJ+pUQ
	 jC5C4Tcm1N4wGx/RBXWMJdDCcJRo7ZAq5kD0gE2zfIh7pDgGXpKszyZvwKfMp8qTxjLOx
	 iy1mLmzJz7ruQHz6qh7kihIY0fJ6mGy9WwOpg8kXd1aNKVZ6Z2+TiInwuobuPV7cM8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789401;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jSpBDv8YD607sbMHNbPAeaBjk155ellTG9O/QhQRzvg=;
	b=CFYO5IuwkVMLinlvS5At34EHuLmdmfbFe8PT2+Vwa7J1VxRQDglAj5PhC02p78nmzGdr
	 6ODFw223xP4vxEHWeCUO0HbbVjrBwjWnw5lf9mn+Hs/YRD4UmXvRrMYzt3iWghi/BWgBk
	 RSFkRcAG5PvMVEd4vP7sAhu6+ZBhID2kh0meOLCjsM9pkdfeKE7xU3XXNammZDG69nodO
	 G9ShckzOiAX6je1g6og3vYllbA/Yc2axLoBH+Sx5+FkQhHRyy0oialUFWCBUGLfMy5lrJ
	 brOwyBVsP0JLKzDkTvzAg2lYVplEOgEtfkUcHrgWR0Pxv2haM5yTOP9RjJvBV9sqMGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lbUKFsIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BD606A328
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lbUKFsIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6751F00A02;
	Wed,  4 Nov 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793789400;
	bh=jSpBDv8YD607sbMHNbPAeaBjk155ellTG9O/QhQRzvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lbUKFsIunVUGOZSNi7sWqUHwAzZz4PFAb4KlEAuVuOkIKPbvA60P86o7vO8vQEVPJ
	 vZU3/om6CYPX5NLvN99Zq1RDRI3nc05sOqTWuuTBsop8cqhUkMoUktOJa66QL5gVpQ
	 uHz7ZcOUjgJkNtS8JUaI3060JJzTUqYeqEur+dpY=
Date: Wed, 4 Nov 2026 11:49:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] serial: meson: unregister the UART driver if port
 registration fails
Message-ID: <2026110413-delegate-antitoxic-1264@gregkh>
References: <20261104021501.1468500-1-vulab@iscas.ac.cn>
 <5b741c90-4e57-425e-b3ef-b8d10eac1f33@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b741c90-4e57-425e-b3ef-b8d10eac1f33@kernel.org>

On Wed, Nov 04, 2026 at 08:02:33AM +0100, Jiri Slaby wrote:
> On 04. 11. 26, 3:15, Wentao Liang wrote:
> > meson_uart_probe() registers the shared uart_driver on the first port and
> > relies on meson_uart_remove() to unregister it once the last port is
> > removed.  If uart_add_one_port() fails, probe returns an error, so remove
> > is never called and the driver stays registered, leaking its tty driver
> > and per-port state.
> > 
> > Remember whether this probe registered the driver and unregister it again
> > when adding the port fails.
> > 
> > Fixes: e71aab9d6132 ("tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs")
> > Cc: stable@vger.kernel.org
> > Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> makes sense to me:
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Nope, this is a bot, I strongly recommend that everyone just add this
address to their email killfile as they never respond and spam out tons
of crap.

thanks,

greg k-h
