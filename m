Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B612F383
	for <linux-serial@vger.kernel.org>; Tue,  9 Apr 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669774; cv=none; b=HnlE+lGY+oZkt8u8bNW565bMuagJp/2ABAdZ2I2+utMScZADJFsoOVPtfK6IepvLyjxMJeKOGzls7k5zaLD9rLDWX22tgqoFQnnNtzLxYa9uO0AnAMUHrshV3P9n8vpbe3ZMTeOK8ilH7BF9My8ERL3cJsaXa+r6xWm8HSLUQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669774; c=relaxed/simple;
	bh=34QtdFQAmnD0CjkqM+HOAKE3Jp5ToMMzxoKNYx5qYak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbssBtxJyIaSt/xzqLA8dDvD/mIDkJKntxF0R12RafOhxMRqB7oU/ixPAYwQhJYQLaufUjX0q2G7tkf+Z+R0IeLmt7+6AnKp7rhcl3o1yRsQ8OhjRbTTghEUCEkWD5HsL6IPDVsKt2tFg8gcUUkUEvHJnUeAgnxJeRHdAcuFxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GS1V/XMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GS1V/XMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B82AC433C7;
	Tue,  9 Apr 2024 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712669774;
	bh=34QtdFQAmnD0CjkqM+HOAKE3Jp5ToMMzxoKNYx5qYak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GS1V/XMpgYk9fQsPEq083pjK7qCCGRo4EJPQWtvZ3mUpMVnAY1/0vyHdR7TnSSWOW
	 i5aVADmrP9c0TKq2XTkippQd7qZqADAkukLgX+09pLyosKVZ1fHzh8Iaoc80e8MggR
	 rgwSCeF0zwK1nufc/3/Yc7pMw5qslDwguFVcEQs4=
Date: Tue, 9 Apr 2024 15:36:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: speed_t usage?
Message-ID: <2024040905-stoppage-sampling-b575@gregkh>
References: <ZfGTIGvFvEMrFwOZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfGTIGvFvEMrFwOZ@smile.fi.intel.com>

On Wed, Mar 13, 2024 at 01:50:56PM +0200, Andy Shevchenko wrote:
> Hi!
> 
> Recently while doing some serial driver cleanup I realised that TTY uses
> speed_t type for baud rates. What is the appropriate use of it?
> Either it is going to be killed (replaced with POD), or should / may we
> spread it over tty/serial and further?

As it's a uapi interface we can't just delete it entirely, but please,
do not spread it any further, and try to clean up what places in the
kernel itself that we can to use a "real" type that we know the size of
at all times (i.e. u32/u64), not just having to guess like we do today.

thanks,

greg k-h
