Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7554FAA;
	Wed,  8 May 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192918; cv=none; b=Z2MztvaQmh2z5Dh4plTQ2MSppKNrTcqW+Msywj+3mEjdyjEh4hl1cPCo5nG9Oajc8oeUGAAtwMTcPjJQWxJNJxbnqh1JNABEk2/MdDkx5Px7WkXoVEJ0XwvbDoU7r6OhU3Ko/LHPBS5pGPM123ePs26vmO8hu2ccrmOhTWOKjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192918; c=relaxed/simple;
	bh=1LiUAsIu7ZoR+lyJaytyhFZGTLv8Hl/goMcLYkrxhbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9E7JAlgLz9A+iT3K2RToGh1Ahqml8P6deXsYZT46UjPmL9xAEQJmx1jOnID6DmmYmIVbEu36ibXm6Bme2hzb10WWVPoeSWj4iShq0Gl/qIplQhbx6Mv8Qyw20Z3ZD5eYUxy2aGelZe/dEjjxUPq5zBzB4DxgTOLx3JDS8741qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Anj8qY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Anj8qY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE154C113CC;
	Wed,  8 May 2024 18:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715192918;
	bh=1LiUAsIu7ZoR+lyJaytyhFZGTLv8Hl/goMcLYkrxhbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Anj8qY/ZhH7l79YULGHVhot6HgTIeIvGkgL97BHg9z7bleQnE+hh9/bLJgUA0lzW
	 Y1xc8RnN5O1CQOgNPnCIf7+/rlhNWJHISEOc+cET5jQ+3JPTRkQaoNQplIYXitzNVB
	 LDqUtYEzrDEMVVE39Kgr0VtrLknF6/Zkti6drvdI=
Date: Wed, 8 May 2024 19:28:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>,
	Elvis <elvisimprsntr@gmail.com>
Subject: Re: Fwd: Add method to allow switching kernel level PPS signal from
 DCD to CTS serial pin
Message-ID: <2024050853-basin-salsa-32bb@gregkh>
References: <Zjra2GZIDC7BPoZx@archie.me>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjra2GZIDC7BPoZx@archie.me>

On Wed, May 08, 2024 at 08:52:24AM +0700, Bagas Sanjaya wrote:
> What do you think about above feature request?

We will be glad to review any submitted patches for any features.
patches in bugzilla are not viable for obvious reasons.

thanks,

greg k-h
