Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26C340A57;
	Mon, 30 Mar 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884941; cv=none; b=lztWUyL6sP7qypm4jd5+YhoOK/tGhWCkUrpshrvd1XIOg5CR2Z4zDuLj2kgGd9b5tzS91wsPamNn2kD/PqFdUrH+yoPffAETwfqXWiSQp60ef1td+oB1ynf0dSJtubfCaTQyANqh2EQYiWJmochTgiPreQYO/P4iHfJ5/rNB8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884941; c=relaxed/simple;
	bh=SFWhW5IngPq2RWPWqZZkfO62PfaT7Kz3LJAdVJHZ4m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot9mAKPQLYb9F33twHYRaOPHDdClGdSWaL691w5sC6bIUaxmUiJJy/0nXAlLv8uCRs+dX/1ODkZlwxocIkK+gyzORtw3JwjO1gn19xWChHQr7TzZcBmZ0mwKA1K1HamCjGXcjc/B2duutVEzs5/fmGpJfXxKkt0uBSg/k8txkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tuqUIN84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tuqUIN84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EECC4CEF7;
	Mon, 30 Mar 2026 15:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774884941;
	bh=SFWhW5IngPq2RWPWqZZkfO62PfaT7Kz3LJAdVJHZ4m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuqUIN84xTYo69rS0gAN1QtD1pNp+Upc/joQRZ+fi8QsZ5NSSJRnKOiEvTYjZACh4
	 uTUnjJ/vFCeaOW8AwF/NxhOw6+K54bdJG4E3VMU9VQw1KkY7HsZ5JBZ1Es05gCen5E
	 ez/RYJ1CnwT36J+inPaQWKulkmN73dNB7ydkd/cY=
Date: Mon, 30 Mar 2026 17:35:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, jirislaby@kernel.org, simona@ffwll.ch, sam@ravnborg.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 02/10] vt: Implement helpers for struct vc_font in source
 file
Message-ID: <2026033030-roundworm-daycare-deac@gregkh>
References: <20260327130431.59481-1-tzimmermann@suse.de>
 <20260327130431.59481-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327130431.59481-3-tzimmermann@suse.de>

On Fri, Mar 27, 2026 at 01:49:35PM +0100, Thomas Zimmermann wrote:
> Move the helpers vc_font_pitch() and vc_font_size() from the VT
> header file into source file. They are not called very often, so
> there's no benefit in keeping them in the headers. Also avoids
> including <liux/math.h> from the header.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/tty/vt/vt.c            | 35 ++++++++++++++++++++++++++++++++++
>  include/linux/console_struct.h | 30 ++---------------------------
>  2 files changed, 37 insertions(+), 28 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
