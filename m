Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60270186E40;
	Wed, 17 Dec 2025 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957849; cv=none; b=jpPzYIX92r3sAPsdp9fdhXqAgW4j+lsLCRU3lYChXtuji7DnIoHhQzqXSSFScg60vZ0ZYROzPg/J0EdVFX+CMvrkI2PQTJXBuw30dCxFdFCfOm2ojCGCwDB52cLdNsFOCEDt4xwJzaDyMEaJlIu0YVSstKUxgtaLuPg4qJ46WC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957849; c=relaxed/simple;
	bh=J9WJlUCEjQm5gpLOyqNqcYkJSfJIPsFcBEdW7XxwL+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYfgqusPQLwTqywVfpS/WFNqnbamtu5MmWRwuKDOXjXVP1seVtWpw5gOPmfeNQbyp5SM+PECT8qQyd1RTAlsyv5A8AQJCnJSvDLkUscebIq/IwXXNPnxZakRdv4YIPbLi0lkbRMF6P44W+HtVJ03KMg6aGt/sOhx5k8mSIxXYK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nRM9wEAz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nRM9wEAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6160BC4CEFB;
	Wed, 17 Dec 2025 07:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765957849;
	bh=J9WJlUCEjQm5gpLOyqNqcYkJSfJIPsFcBEdW7XxwL+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRM9wEAzjQ/X980Sy68FX6boZYG4uTR+qG2cvG82w/ifHISD8Z3lU4zxskEa+81j4
	 xYYZ/znRnBB7v5jhC/ektyyCdnlIZ3ny2rRFRpWuBMG+RKe4uaeD3B/0HtUePq9hjU
	 /8Lcd67qS0SOG/juM7UlurBlD1NVN7eFE+IFXWYo=
Date: Wed, 17 Dec 2025 08:50:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?Q?Bart=C5=82omiej?= Kubik <kubik.bartlomiej@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] tty/n_hdlc: Fix struct n_hdlc kernel-doc warnings
Message-ID: <2025121747-caution-spectator-6cd7@gregkh>
References: <20251202063748.1210359-1-kubik.bartlomiej@gmail.com>
 <CAPqLRf18v3eQaKsaaf+wB6k5+v65=BkQG2dtS=Bcyee=isOatw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPqLRf18v3eQaKsaaf+wB6k5+v65=BkQG2dtS=Bcyee=isOatw@mail.gmail.com>

On Wed, Dec 17, 2025 at 08:35:56AM +0100, Bartłomiej Kubik wrote:
> Hi,
> 
> I submitted this patch about two weeks ago but haven't received any
> feedback yet.
> I wanted to check if there are any concerns with the patch or if any
> changes are needed.
> 
> Please let me know if you need any additional information.

Please relax, it was the middle of the merge window and just now -rc1 is
out.  Give us a few weeks to catch up, especially for minor things like
documentation issues.

In the meantime, please help out by reviewing other patch submissions to
help make the review load easier on us all and cause your change to move
up the queue.

thanks,

greg k-h
