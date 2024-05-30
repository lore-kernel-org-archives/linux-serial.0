Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBB21A19;
	Thu, 30 May 2024 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717046338; cv=none; b=hmS2dMkFbK4nd6qjyxseaqe86CPJOHu2PCB1ToSa6NwACova+KvYdctPzG1Fd7ycFle03EvcGRs+mDZtIo0x+MxmVwwztSutuvQUFrJUaxYHI4ucEHIBmmtUW0q4SD8xJ1DTLFP85Aj9OL41TK40ncBt9Xl31T+TfzmYpRWcDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717046338; c=relaxed/simple;
	bh=pB/96JTuRoro7LJvuDUAX1gz1MMHuzk0wvh4zz3qcYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayaDVTCvxTyqIgZOb7LGZB3PSHdPz4oSBwKpeJnlaevLb0lJuA4VK0fsKDqYAZSX5bsGPoj5V56/vl3hJK91zJFBQQutLTRlo7ON6bzm8BrJ+egwrI5HKEfcxejMjQTBWF/pHyA0REp3hLuJTxOLN/8gRfWvfVsEjSOOT8Ltvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=miPpxzI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="miPpxzI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC56C2BBFC;
	Thu, 30 May 2024 05:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717046337;
	bh=pB/96JTuRoro7LJvuDUAX1gz1MMHuzk0wvh4zz3qcYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miPpxzI4OTYb1l3r1n90qJsxQVL+atcvaro2og/zgPEzy4uEfNng1Rwqx3ZfRf/ny
	 LwtTWMX99mHCz/L85on2LtNJPS6fAj2E7HkXgDiOudZN/RoG5DhIleC4+hw03ofWYA
	 q0GoJksCAdGY4VdJziGDG0geh3X/WTcBecxxQUzQ=
Date: Thu, 30 May 2024 07:19:02 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Kuzey Arda Bulut <kuzeyb.business@gmail.com>
Cc: security@kernel.org, jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: Subject: [SECURITY] Vulnerability in Linux Kernel
Message-ID: <2024053036-villain-backlight-d92b@gregkh>
References: <CAKmisHAUUqQ-7F+7BOymY7_3XBT1FE=gskraKDC1OmySZgS0yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmisHAUUqQ-7F+7BOymY7_3XBT1FE=gskraKDC1OmySZgS0yA@mail.gmail.com>

On Wed, May 29, 2024 at 08:25:18PM +0300, Kuzey Arda Bulut wrote:
> Dear Linux Kernel Security Team,
> 
> I have discovered a null-ptr-deref security vulnerability in tty driver in
> the Linux kernel. You can find the detailed descriptions of the
> vulnerability in report.md.
> 
> If you have any questions or need further information, please do not
> hesitate to contact me.

As the n_gsm is full of known issues by the developers, and the ldisc is
not allowed to be loaded by a non-root user, this isn't all that serious
of an issue.  See this thread for a list of problems that I think you
might have already found here:
	https://lore.kernel.org/r/DB9PR10MB5881D2170678C169FB42A423E0082@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM

Note, 2 fixes have landed in 6.10-rc2 for this driver, can you verify if
these fix the issue you are reporting here?

And do you have a proposed fix for this issue?

thanks,

greg k-h
