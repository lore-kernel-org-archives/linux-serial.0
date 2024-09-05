Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75939193062
	for <linux-serial@vger.kernel.org>; Thu,  5 Sep 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524762; cv=none; b=Sn8m/eabapJqqiIUqLFxCm2iXPKRrZhdF6nxw0q+o+/erxoJxxmf0v95vCifDYYQaTxw0IJK80BEEsgHBDA3QPZReauT5VBFTCHtbMOSHIooPgclMz1TB2U1/VbkEEUW47VLWJbleHbq5sVrb3tQcOr0r3YAXRD9D27jiVSVOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524762; c=relaxed/simple;
	bh=pbx93MrqsIt70cukyRfMc+V3+K3qJVVLWq8JU33+iJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/gB8nsj1CABSSTZ0scF7hBsPTtrsaY+5svol9w1CRkFayJdit5CJB7gfamPvZaV3Aw27bhAKEprJ0ccBQ3WmQP2DzcGvc4xFZL4HqU5RJt27dKc+9ouYAaCEwEfgrtIM8pdcUG9Uuu+dXmfq7zSLPxCjycpeQa9p9T6ZCuBJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ju2+cVSj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ju2+cVSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ECEC4CEC4;
	Thu,  5 Sep 2024 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725524762;
	bh=pbx93MrqsIt70cukyRfMc+V3+K3qJVVLWq8JU33+iJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ju2+cVSjeDNHMzA0+qfXmcRny58I2Iq5Z2FmLEN6h9jbKDHPLfZeCh7zbALoAs9CI
	 5TTnEa0ODuzlhVOtS1xSIeNmqlr4wNYr6nnUcWxzlMgOe5dgjD/GggFqVQ+awcx3qz
	 ck/fG034MXmyCxB6Ru8jpBD1hR+P+Pu0pONwtGeM=
Date: Thu, 5 Sep 2024 10:25:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Radisson97@web.de
Cc: linux-serial@vger.kernel.org
Subject: Re: possible regression with rs485 usage
Message-ID: <2024090555-dispatch-recent-b3ad@gregkh>
References: <trinity-385b45db-ce89-419e-a226-4e10351f0c0d-1725524112044@msvc-mesg-web108>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-385b45db-ce89-419e-a226-4e10351f0c0d-1725524112044@msvc-mesg-web108>

On Thu, Sep 05, 2024 at 10:15:12AM +0200, Radisson97@web.de wrote:
> Hi, i am new to this list because i have a strange problem.
> 
> We have an embedded board based on the omap3-design with a rs485.
> With kernel 3.5 it works fine. Since 3.5 is ancient we are noe trying
> to get a new kernel up an running what is 5.8.

Any specific reason why 5.8?  That too is ancient and obsolete and not
supported by anyone.

> I turns out that the rs485 has issues (it seems a lot of ppl have
> the same issue also with other boards). We enable the rs485 via ioctl()
> and nothing seems to work. Several restarts, playing with Marcin Niestroyj's
> rs485config it suddenly works. (yes hardware is ok, works with older kernel).

So it does work?

What exact hardware and drivers are you using?

And can you try a modern and supported kernel version please?  We can't
do anything with 5.8 :(

thanks,

greg k-h
