Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960A13C907;
	Tue, 25 Jun 2024 04:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290531; cv=none; b=qucAFLWhaz1fUMvD4O6w3X6UUwO2JQwsMT0rbrtC7hqRLvCS/8Ab9HLAYCR+8JjLz+6n/hPhUU8JSbOAVZHiP1x3sgxAY8ughgHonDHFqzdwyqAqQ/FpSWk87uStjEM8KDww4A00QT5E9ZLbtw6SNrQ2iAWAOMYwfKO17NZ+O3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290531; c=relaxed/simple;
	bh=5Iel3gIemmTqgmdoFgLDuJp3DyqVPqYisMuF5wmmuwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPOkJNDwyu7waOa8FcRTO1b74Uxt7HOwDvTOVHee8GCteg0U+tHPz04Yt1Agu3JaqJ3uLv6/5qgAiTSnbgFNmUctYybP/ol7SiIMPemyzj25rhLFZTeeIG1enSWM1EK5Zse83hfwKa0VC3W/TATcX5pRQE0MOG4jjiTm1w+wIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PG5ERh9C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PG5ERh9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB6C32782;
	Tue, 25 Jun 2024 04:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719290531;
	bh=5Iel3gIemmTqgmdoFgLDuJp3DyqVPqYisMuF5wmmuwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PG5ERh9CDjtbjgjSLU4sWpSTqrx9siGeKsNo1P1bjON33MURLWvEfGm07b1tL1RBO
	 AmQFvaPNrOAkdoRWbeEf2XHAriMfXIm5vHEpBkFSODYx2h/r+1y9E1KBSkEj2dwBFr
	 jMx+7eRZo45R+4HL3JsgJeveQnelFCUB+EZj5JJQ=
Date: Tue, 25 Jun 2024 06:42:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacky Huang <ychuang570808@gmail.com>
Cc: dan.carpenter@linaro.org, jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v3] tty: serial: ma35d1: Add a NULL check for of_node
Message-ID: <2024062539-juicy-movable-0e94@gregkh>
References: <20240625032919.73-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625032919.73-1-ychuang570808@gmail.com>

On Tue, Jun 25, 2024 at 03:29:19AM +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The pdev->dev.of_node can be NULL if the "serial" node is absent.
> Add a NULL check to return an error in such cases.
> 
> v3:
>     - Added "Reported-by:" line.
> v2:
>     - Added "Fixes" line.

As per the kernel documentation, these "v3:" information goes below the
--- line.

Please fix up and send a v4.

thanks,

greg k-h
