Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708082EC558;
	Mon,  8 Dec 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765235733; cv=none; b=UUbMiBWsY2+MhNGSbHZv83yl4HiAE73AjfrddIO6Iu5p6X4zH/piuR3nQWU3B352xt3oUPUmDJtkJin+6VrGyG9gxKndssl2bjrZv6OnOwwdnKYtHv4574GJXnTcEy9qGi3zCxHcjz8/OzU6psQuGcFNzGFoli/TzORpETnL1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765235733; c=relaxed/simple;
	bh=7wPimXFr4kIGv8Gm+/60OrkpBD+ELS1Rj8YfOX+r+SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hptTnIJXWFb13YKs4l4WPIUUpRt3kCKn9IE9N2lV9RPiv05Tgy+5wG0lLiNJ95isPh2huMRf5fO0f/jU9DnkvBDlXf8rB3E2GJf1Hie3gw06Z1DK/vofSWzxmlF5emhPPginp6xaLPkzfR4e99MkHxcZM2rN9PnD+LgoUTsD12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SOKXW2YH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SOKXW2YH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31746C4CEF1;
	Mon,  8 Dec 2025 23:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765235732;
	bh=7wPimXFr4kIGv8Gm+/60OrkpBD+ELS1Rj8YfOX+r+SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOKXW2YHBFWyEHDn2Faml8/avfQUjQro2a3uHilnM01e95CgxCM5rTEYRWsZRHTVI
	 Mvirnwkh8q8x1k+X+ocebnnkQgPF+uQzjCUw3/3VQcQoS9faYbLxdtnEEoENIr2uue
	 /y39KIjXbAenUfIfF/FIs+QbBAQcUV3jGozEie6M=
Date: Tue, 9 Dec 2025 08:15:29 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jirislaby@kernel.org, simona@ffwll.ch, airlied@gmail.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] vt: Remove kdb hooks
Message-ID: <2025120914-finance-venture-8d0c@gregkh>
References: <20251208102851.40894-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208102851.40894-1-tzimmermann@suse.de>

On Mon, Dec 08, 2025 at 11:17:32AM +0100, Thomas Zimmermann wrote:
> Commit 7068d42048da ("fbcon: Remove fb_debug_enter/_leave from struct
> fb_ops") removed the only implementation of the kdb hooks in struct
> consw. Now clean up the callers in vt and the hooks themselves.
> 
> If accepted, this series would ideally go through DRM trees, so that
> it reaches upstream together with the fbcon rework in v6.20-rc1.

No objection from me, thanks for the cleanups!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
