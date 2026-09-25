Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6D48C41F;
	Fri, 25 Sep 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330531; cv=none; b=Lc01N+ISHkSj7NO/6DJyvWHBP3SW7I/xdAoqygtqO1vWp8R+rlJKH+X5dof4aZUuQFSOLdRlcjCUIapc8RRuxRZlYJiblBWfYDRKybWgpfi3Ke1K5E6ts2cBBZFAGhSOyWXEnjWEwr5pWibLNg7G3j8HgPdzRPZQ67qp36A2eeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330531; c=relaxed/simple;
	bh=B3rdrfnv54WZ49qINmAlzSZ6jGggCXw9kLGs7XPsLPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swfepyecDpb8fss3I47X3Sj8M1FE/0UV5ULRzc5srqpXEu2BqsL+Bo5zN/8LJwA8EWHGiBsi6NJ8pBb10aekPgu5czQpup/FUPK9GV5rr92OgErQMf62hkTz8u7PxZ/g2cMXV9cERAlPwVKmuLEqQfxfEvbZtyAMUspNv/HyxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHMnEtLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHMnEtLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB4A1F00899;
	Fri, 25 Sep 2026 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330522;
	bh=B45rqpR/eaQf3u6GX+wJz8kSl41jR/ejZEj+uiBeSug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DHMnEtLFQzuZKru9N/8ERZ5RIhoFZVWVeg2D3sq4hQ8B1krO8qDQOHQMjFGQMaFsH
	 OZz22w3Ep9SH6pgAHwZpmGRGHCvhRCzq5lZcXxB11VXBXGNy8CjMAy1Nz2QR6rtmPL
	 RMYMJBWkgZWOfBOqx/iakNJv7W0uBvYm5RgyJTbnAFa4glQMX+eP2/6Wwi+q+sivro
	 Qqy/XG78sdAbsZmrhavHw/HbwRfto0E65OS1A8dtIQn1f30J/Nuvqi6P5+yog4bTgY
	 JfXqAoOUjk8F32veWH6d0BX1M4Oo8007T83Pi6apHswft1VwthZSlrTH0lRRfNNzPc
	 BTidVw59CtVEA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xA2ki-00000000E7o-2DBY;
	Fri, 25 Sep 2026 12:02:00 +0200
Date: Fri, 25 Sep 2026 12:02:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] tty: add break_wait kernel-doc
Message-ID: <arZGmBW-hG7Vv66M@hovoldconsulting.com>
References: <20260925094222.18303-1-johan@kernel.org>
 <2026092538-available-multiple-6b11@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026092538-available-multiple-6b11@gregkh>

On Fri, Sep 25, 2026 at 11:55:48AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 25, 2026 at 11:42:22AM +0200, Johan Hovold wrote:
> > Add the missing kernel-doc description for the new break_wait field in
> > struct tty_struct.
> > 
> > Fixes: c7e9bff9b4b3 ("tty: abort break signalling on hangup")
> 
> Don't you mean:
> 	845a2737e0f5 ("tty: abort break signalling on hangup")
> ?

Yes, sorry. Can you fix it up when applying or do you want me to resend?

Johan
