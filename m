Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C871FE455;
	Wed, 28 May 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748420734; cv=none; b=sapfSW9/tjuRcfGx4Suy5ZO/udfrSKh5whurpJ4LCpz9C14ih3paVg8vnMm+yP34ha9R8tRQFJ/Ij6JRRqDovZ9fYeV+IkRdGkesZzyulINDSvKipWoSec2LtwQ/Wc9+VrJQhAinTTf6BI+F26o8XpaYDgk7RPFp75qpCVLqdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748420734; c=relaxed/simple;
	bh=MvFZJxUfFQsW/FlI8iMRyvLJVfgFhJUqUX3GDopno+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjCslrRPe5y0/oKm7+fyHCJKB6qGDcVBYhovimngXLhjDDiTbQliTsCowwveWINWr/EEuzUDBiGNjKsDqIPFqdIvyTt50+UTYlJ6S6iEGlF/rmd5WejDY5MMSPTPHqfUS+jaFH0OzdQVqqxea7atHos7FtAZPWZaXz9/4XikMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=120hax49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="120hax49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4124EC4CEED;
	Wed, 28 May 2025 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748420733;
	bh=MvFZJxUfFQsW/FlI8iMRyvLJVfgFhJUqUX3GDopno+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=120hax49fZxd5ZM0jw23OWbPlzIj1QoLQRrt6auTmlr4+IRQO+jgKyZKggvwcP4Ib
	 ZtXpA2e33LBgrFWZzWSgBs7qnArflmda327RbMd30qiE4ffgulfxGr7WOMnhr7eykS
	 g/xr/++ZBlvzAQre97OV+qVcHrYbMLWvemWIQ1Kc=
Date: Wed, 28 May 2025 10:23:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Staudt <max@enpas.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tty: Register device *after* creating the cdev for a
 tty
Message-ID: <2025052801-human-aversion-3518@gregkh>
References: <20250526112523.23122-1-max@enpas.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526112523.23122-1-max@enpas.org>

On Mon, May 26, 2025 at 08:25:23PM +0900, Max Staudt wrote:
> This change makes the tty device file available only after the tty's
> backing character device is ready.
> 
> Since 6a7e6f78c235975cc14d4e141fa088afffe7062c, the class device is
> registered before the cdev is created, and userspace may pick it up,
> yet open() will fail because the backing cdev doesn't exist yet.
> Userspace is racing the bottom half of tty_register_device_attr() here,
> specifically the call to tty_cdev_add().
> 
> dev_set_uevent_suppress() was used to work around this, but this fails
> on embedded systems that rely on bare devtmpfs rather than udev.
> On such systems, the device file is created as part of device_add(),
> and userspace can pick it up via inotify, irrespective of uevent
> suppression.
> 
> So let's undo the existing patch, and create the cdev first, and only
> afterwards register the class device in the kernel's device tree.
> 
> However, this restores the original race of the cdev existing before the
> class device is registered, and an attempt to open it during this time
> will lead to tty->dev being assigned NULL by alloc_tty_struct().
> 
> alloc_tty_struct() is called via tty_init_dev() when the tty is firstly
> opened, and is entered with tty_mutex held, so let's lock the critical
> section in tty_register_device_attr() with the same global mutex.
> This guarantees that tty->dev can be assigned a sane value.

As 0-day points out, I think this adds a new locking issue :(

But it's really hard to detect this, as you are doing both a revert and
a change in the same commit.  Can you make this as 2 patches, one that
does the revert which would be "easy" to review, and the second one that
does the new fix?  That way we can detect what is going on easier.

> Fixes: 6a7e6f78c235 ("tty: close race between device register and open")
> Signed-off-by: Max Staudt <max@enpas.org>

You also forgot to add cc: stable on this :(

thanks,

greg k-h
