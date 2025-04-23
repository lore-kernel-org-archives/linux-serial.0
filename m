Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A1280A3A;
	Wed, 23 Apr 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427382; cv=none; b=SJ0tkCwfQrvsUNmw3tKGduNN1XhyuzaozJVkBpN3C2KJFR1ArGqSNGoX2tdvK5+g7h1DicTc6Pd+EMbbKQ8fUVmBrVrS8hbi7DtOmPAzkpAxSvb0XKjkVpQCS9LyooRAqv4HpRgWnBBfpuieNUUNHHe697gXWqz6A3x3vOPBokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427382; c=relaxed/simple;
	bh=oZlZ4MaUOsbSfFdBStGfmOCEH9oscue9bpyhsLiRDT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXgWZ/moySPyP0iNfUXAoKBFKIyS8I9Ho9lg9Qgdsi0t3FoKOxgOVc1rCLuFP8gPhCT8mbKuckph7beKvmznK1vrWyrQnsTsX92wfUcBZK6QqzVjKejbsEcJyL1BvuVaRbMA2BJaxTmHi96aSCSxoaAtrtGH41eCoa1F1Eg1JXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QJRWMnRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QJRWMnRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58226C4CEE2;
	Wed, 23 Apr 2025 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745427381;
	bh=oZlZ4MaUOsbSfFdBStGfmOCEH9oscue9bpyhsLiRDT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJRWMnRUu7stM7A21KH5vWpyl1UzHX1VsiKbQu9t/WNSvzKJxoCEYdOo/efF95JPu
	 7tuYaZj1QK4K+1xzS0SfkO7p15ksyuK57TVkaBD0EFjV2m+DU1wp7icyOST4VsXyuh
	 PNWrmn9iaAf+yRP2dn3Q8hIT5YS4NMHue+hJsHp8=
Date: Wed, 23 Apr 2025 18:56:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] serdev: Get serdev controller's name by dev_name()
Message-ID: <2025042306-ripping-dental-fc37@gregkh>
References: <20250423-fix_serdev-v1-1-26ca3403fd33@quicinc.com>
 <2025042354-imply-pointy-92e5@gregkh>
 <2130b658-0c7a-497a-99b4-d3a5c4ecd8eb@icloud.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2130b658-0c7a-497a-99b4-d3a5c4ecd8eb@icloud.com>

On Wed, Apr 23, 2025 at 11:07:03PM +0800, Zijun Hu wrote:
> On 2025/4/23 22:35, Greg Kroah-Hartman wrote:
> >> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> >> index eb2a2e58fe78fbbdb5839232936a994bda86d0b4..971651b8e18dcbb5b7983cdfa19e7d60d4cd292b 100644
> >> --- a/drivers/tty/serdev/core.c
> >> +++ b/drivers/tty/serdev/core.c
> >> @@ -783,8 +783,8 @@ int serdev_controller_add(struct serdev_controller *ctrl)
> >>  		goto err_rpm_disable;
> >>  	}
> >>  
> >> -	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
> >> -		ctrl->nr, &ctrl->dev);
> >> +	dev_dbg(&ctrl->dev, "%s registered: dev:%p\n",
> >> +		dev_name(&ctrl->dev), &ctrl->dev);
> > dev_dbg() already has the name in it, so why repeat it again?
> 
> i guess the author wants to print a sentence which is easy to read.
> 
> for built in name of dev_dbg(), it always happens at fixed location
> and not where good sentence wants.
> 
> actually. drivers/tty/serdev/* have other such usages, for example.
> 
> dev_dbg(&serdev->dev, "device %s registered\n", dev_name(&serdev->dev));
> dev_err(&serdev->dev, "Can't add %s, status
> %pe\n",dev_name(&serdev->dev), ERR_PTR(err));

Then those should also be fixed.
