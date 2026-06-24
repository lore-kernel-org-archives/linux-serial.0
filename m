Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE021DE4FB;
	Wed, 24 Jun 2026 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297207; cv=none; b=j4L0sLmKzeqVUQhkLAguGzQG0NehOgXDBZkxdy5TdljzhdJoEU8WCUhhd+O5/46LuoahZ7R43tHsKk4EcizRGy3tw1qPVIWddZRt0+/SvxKg2irbKfeVbhhL0I0f1QPbHQZdsbkmvUku4vf2Ucl1Loz4pyone+AeURU+d8slN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297207; c=relaxed/simple;
	bh=sfKbFghXwOa6m9FCEe9X6a+mWhPg0MKNCL2ZaE+R/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW5wOxZN7ktL5fHp/FemWhJckLX7R+CFnmlZvBGBphGJSPqwhLcChIjYcu/7g9yB0Op3HuA+Zt89vX9TeDeaEBuhZEGRNwyPh4tOpGJgo+MZLVbIYBiaeYny1k3ZyjxtTcCuGK3UadQ8l8cvg3Y416aqvS0dt7E4jYa/VYrprdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI3NM/ut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI3NM/ut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9EA1F000E9;
	Wed, 24 Jun 2026 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782297206;
	bh=sfKbFghXwOa6m9FCEe9X6a+mWhPg0MKNCL2ZaE+R/AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EI3NM/utsnvg16n5T+uJRdc3D9c+IPiD3nTRgq6hy7Ynr6SCLDQyjR0lH3sIoJk/X
	 dSZCdQnPmu0NK+hS20Slx5CYlrGtGA1JOqYOnLBGNGmJUL/d/+oXyPn46ViYkYenKZ
	 754MiqW5QtFhlXP6+Q7yvOz0EEkSyoTu8WBLyu9cx+J1sw7UGIiqnLDwExfEGy6whf
	 nf2AAQbYMmA8Q75iWnT0xOow43uwDcgJRgYz60tJzdaQRF25JjhpzlZ36Ch2xjU6c4
	 JHQNc2caDS/L8N6ShKWSCKpSy7GvPJkOLxHhVIFynm8T95F6vjD6UPyEhUHzcQNpbH
	 V+XAH8USztk2g==
Date: Wed, 24 Jun 2026 11:33:20 +0100
From: Daniel Thompson <danielt@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH next] drivers/tty/serial/kgdboc: Use strscpy() to copy
 strings into arrays
Message-ID: <ajuycDgc3zUR37Px@aspen.lan>
References: <20260608095523.2606-10-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608095523.2606-10-david.laight.linux@gmail.com>

On Mon, Jun 08, 2026 at 10:54:54AM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
>
> Replacing strcpy() with strscpy() ensures that overflow of the target
> buffer cannot happen.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
