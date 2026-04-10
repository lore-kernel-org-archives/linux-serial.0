Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC5396B9D;
	Fri, 10 Apr 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818163; cv=none; b=iag7sbei07AHLL0RkXS+vbc5D4ZO90kUCZa2Jlq8z2Ts6q1zTSim2FI/15gq11RA07sb2V+fDIOlA5NzSDUfhR6tnM9mxPeB4WECXdMDbYX+hH8Qr93DdT/NAasv8N0QiAp5VlqXhyGVfgmwnWTykQtWSiQodYI8sJbOkOH7Hro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818163; c=relaxed/simple;
	bh=oCnj/bjG8tyKWBClbiYTShYh2ujQcklwTUEwoVZAa/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuAlxCC4HxYi64eYTC5q1AVlzbXUnI2kw7q3R/tUm2y8ZSnQGz0Nurn1O8lBSunWzYabMnrqg2CM3UEOpaP6uDOia/SYbEjEKopvHPeJcI45/0meVon9pcOOHvvzcrZPwQOzM/7x4XFEipzuSAy8ZRQD7O2AQr+xJAEfV0osikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nhqzxFvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nhqzxFvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EF4C19421;
	Fri, 10 Apr 2026 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775818162;
	bh=oCnj/bjG8tyKWBClbiYTShYh2ujQcklwTUEwoVZAa/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhqzxFvnO7PWcR0eYBeQ366AyCDXwu1xyOq1YOMj+6AUcdEahLVrD5yfIwTux2J9B
	 qLQntFTO0kZWfXdrn8Nwague3enYmSWm+DZC/7ADTH4Cdm721wz/1aksYRakK/NUjE
	 0UcJNMh0k47QklSJyJ25sMzNqXgnI9mfQSD9LQ8k=
Date: Fri, 10 Apr 2026 12:46:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zenghongling <zenghongling@kylinos.cn>
Cc: jirislaby@kernel.org, geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com, wsa+renesas@sang-engineering.com,
	thierry.bultel.yh@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	zhongling0719@126.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: sh-sci: fix memory region release in error path
Message-ID: <2026041009-pulse-scored-ea8f@gregkh>
References: <20260410092143.30971-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410092143.30971-1-zenghongling@kylinos.cn>

On Fri, Apr 10, 2026 at 05:21:43PM +0800, zenghongling wrote:
> The sci_request_port() function uses request_mem_region() to reserve
> I/O memory, but in the error path when sci_remap_port() fails, it
> incorrectly calls release_resource() instead of release_mem_region().
> 
> This mismatch can cause resource accounting issues. Fix it by using
> the correct release function, consistent with sci_release_port().
> 
> Reported-by: kernel test robot <lkp@intel.com>

The kernel test robot reported this?  Where is that report?

> Signed-off-by: zenghongling <zenghongling@kylinos.cn>

Can you use your name please, not your email alias.

thanks,

greg k-h
