Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416718B0A;
	Tue, 18 Aug 2026 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033236; cv=none; b=DPagQXW62ThQfOpNsGw7IKrZR5kv53M6MFjGNeh79fB9HHouUIRIuv6zhHtg7Rb22W82w3+t7mxWlBpfjSertrsusnGBBMWELA3DCkwQi+0krwe+G4EbIipmRyerZCuvscwcG7H6wclZc0nm3mYWM+MxVkldpdgYLo5xsHwbLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033236; c=relaxed/simple;
	bh=RoySH6dB0OvKgun5nOawpDgflh+lHqlh7A1ef1+dchA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWySfo43nimTphYlnmS30w9OJN0oeUwqKOaWNfQ6tVLBAMFXXyUkEyxGX0VYWYm3mKfmn2EgB2UAHXEumNubjuWWdwp+bk6RSr5pp6ERqctJLUUwJoBcmZCvHTXynzgfhoVozC7ZgBMrkLaZkCk3jY1iHE//d6mGdaS3/bC6C40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1esydxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1esydxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A62E1F00A3A;
	Tue, 18 Aug 2026 06:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787033235;
	bh=5eMNGyLAkIKXZrZdD3P+L+Jz0eniYYP6cxseDt03pDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k1esydxNsmaN7RgIpNeB2FQdYDCDFusMgTLlmiWoQefYbBDqIor/R759vK21ft4Jb
	 u0D8JEErvhSePEtR9TDVM9aJnvvLjv4wMUsSXT7pp1DIENoiUePZKBItEYaXxP0r/f
	 5bZT+DYjhb18u6q1svhuuboT4celRdLl5i42AzNQ=
Date: Tue, 18 Aug 2026 08:05:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Chen <xin.chen2@oss.qualcomm.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
	cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
Message-ID: <2026081849-camisole-enchilada-f5f8@gregkh>
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081744-vision-coherent-8b62@gregkh>
 <03ebb6a0-2a3d-4260-afec-15e7e9925842@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ebb6a0-2a3d-4260-afec-15e7e9925842@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 11:09:49AM +0800, Xin Chen wrote:
> 
> On 8/17/2026 10:14 PM, Greg KH wrote:
> > What do you mean "target kernel"?  This is for 7.3-final, right?
> 
> Sorry for the confusion. This patch is based on linux-next 7.2.0-rc7,
> targeting 7.2-final (or 7.3 if the merge window has already closed).
> The wording "target kernel" was poor; what I meant is that
> kvzalloc(sizeof(*ldata), GFP_KERNEL) is used intentionally to keep
> this patch cleanly backportable to kernels older than v6.6 where
> kvzalloc_obj() is not yet available.

That doesn't matter when getting patches merged, otherwise no one would
ever use the newer and proper apis.  Please write code for Linus's tree
first.  Worry about older kernels later after changes are merged
properly.

thanks,

greg k-h
