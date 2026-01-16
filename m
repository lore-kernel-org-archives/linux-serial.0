Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7F1E98E3;
	Fri, 16 Jan 2026 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569660; cv=none; b=JO8P6PFAXR5AuxKwMty+7tTry5ZrpfM5DhcsMh8570qTJoXcViEdXrU7u/EUCCjRok2bcJDujHr9L+62aPUragk9kK9KURCPJ5RCpcLWBeqLhK8A/4SZLvENFfzqdF+6pkkVc9xiLj12ZmSJtdeuML6ZazFnDeXjhpHA97LX2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569660; c=relaxed/simple;
	bh=Hx4B3T9G5r+JB4ec6LfcWHU2oCBwD0uTryYJxy1Wf9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AucqTwTXDPmjg8Pugw2w+Wp5Y2+MMkXhXwJ5oVRxJSQlv6HiCE519E9P/JgaNQWYFdqcmZO1CJ/RBeFsf9bx01H8FZMh+VdQBby/dwikc06krM+CgA7YDtE+p+Wh2jxq6nOehstVB57OIc5fnRjtNL2shsvCioylD5yQA0OVbLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JloTXoYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JloTXoYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB169C16AAE;
	Fri, 16 Jan 2026 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768569660;
	bh=Hx4B3T9G5r+JB4ec6LfcWHU2oCBwD0uTryYJxy1Wf9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JloTXoYVvtfKxl1hJbr00aWwhaiTXTk8fFT23QLrRGFuMlow83TmKzKQKCQJqsdd+
	 Sc23iCplWQBcBy1Gv4YYjgO1X957ZqGGkretMDHbH455eGe5kSQ+Fj/l+V5r4dJlfL
	 8VO70YnOc2K+006PEhLXW1+B4JaB3/agMOFCRdvQ=
Date: Fri, 16 Jan 2026 14:20:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: jirislaby@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, fred2599@gmail.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Digits_Upstream_Group@mediatek.com,
	liguo.zhang@mediatek.com, Vasanth.Reddy@mediatek.com,
	Yenchia Chen <yenchia.chen@mediatek.com>
Subject: Re: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Message-ID: <2026011631-zips-provider-6c46@gregkh>
References: <20260105024103.2027085-1-zhiyong.tao@mediatek.com>
 <20260105024103.2027085-2-zhiyong.tao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105024103.2027085-2-zhiyong.tao@mediatek.com>

On Mon, Jan 05, 2026 at 10:39:55AM +0800, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 
> Add ACPI support to 8250_mtk driver. This makes it possible to
> use UART on ARM-based desktops with EDK2 UEFI firmware.
> 
> Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>

Please use your name, not '.' in it, like your email has.  Yenchia did
it properly here.

thanks,

greg k-h
