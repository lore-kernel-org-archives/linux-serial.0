Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360A3DA7E4;
	Fri, 25 Sep 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330158; cv=none; b=lwUJxVRwdlrelVHd6ls0rxGuRkZc1P2d+ivQQh2xVvzqqgk83n9irfOx1sENHLhp9odIoKJl7YmqV3uNQVrSXA2BieHJ1oGsBh/hRHHVICMMOygh7wlOTfCAlSIordG4T5eGyDtl4/O0rDX+hHzXeCndYEOq+M8M/Q2KlXT7yOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330158; c=relaxed/simple;
	bh=TtCPv5j0FfuVBsrBosv8ajuI1/0gH0ruLdN8rHOBOV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxrwKWs8dnOfnWlNauQOhGpi+6pxr3W8pIvnDgcEauOOulyeLTPNiJZH4c9Tz7BgGs9rPjnhrYqZs9+7mf5T2+gLsUQT+HpXMWQQ7hhMRbX+7ARO8ekq96HVmQ3H6El+i72H7Bsl9P+jbkt1jRAiXTmg7aUieUw0RiH5J7mGvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nwiZ4ywX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nwiZ4ywX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48EB1F000FF;
	Fri, 25 Sep 2026 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790330154;
	bh=qgtTWC/JNqE6bUlE+4GyLWszQl0ErXt5bIvPwL8SK/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nwiZ4ywXQcPQmBdAUjMSYMaDTlsQ2M5Zuz70/UDVmdrRaiJ7+QwiXuu26H7Ku8rSD
	 qasFIayMAFB/Y71aUHhXZdd54/QaDlh+0AoQcMLMcAJ9nJ7bdIBuvU3lyHoZxos4Ve
	 Ph/ettrjwpcmhiWyxztx3meeCOZ3VW+3ntMzBdDU=
Date: Fri, 25 Sep 2026 11:55:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] tty: add break_wait kernel-doc
Message-ID: <2026092538-available-multiple-6b11@gregkh>
References: <20260925094222.18303-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925094222.18303-1-johan@kernel.org>

On Fri, Sep 25, 2026 at 11:42:22AM +0200, Johan Hovold wrote:
> Add the missing kernel-doc description for the new break_wait field in
> struct tty_struct.
> 
> Fixes: c7e9bff9b4b3 ("tty: abort break signalling on hangup")

Don't you mean:
	845a2737e0f5 ("tty: abort break signalling on hangup")
?

thanks,

greg k-h
