Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D9136195B;
	Fri, 24 Jul 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882271; cv=none; b=AqKdZA+Ov61ydb73Dzyuwc1jnA4vL2MGo2alj3g+CtxMaWqJCwk4X3cBXht9xoI7jduqG3v5n71YYFx0gHa/q0xEGHCtDR7vG2c4ToJJAhmGiN2lc9elOIRF5Pz41k9wksyY2VeuVWioAqnXa7rYCFVWdXRUw791x7zOyVj/4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882271; c=relaxed/simple;
	bh=8isZBauqtMHjFSwXUTKiZ3M/NExuFddDPrHLgRdxYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTaTxB0Ha2wXQAxNXQ3VGWtmhOCbxJqNwhzZW4w8YHqbk55xfeg1aqP96s3IkDKgE/ZKVDlER8yCZB+BG6zWMGvrSuWXVoEGOU/19ZIUiB0CZdGLKUdgPgl7WhGCxiuMnuj/XLHwwYl4GIzqIF2bHDehrbRnbe7pesVGh2k+tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cppoTVXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cppoTVXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E90B1F000E9;
	Fri, 24 Jul 2026 08:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784882269;
	bh=LQdq8w8Hmj6o6ktAxzSwRUjV40VngUkleQMuiR6yd7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cppoTVXNY7OFm/lfLlg9dPnvcfG68nj4HZyJt2DRJbZ86fpVnClenZUv007XzWYVN
	 g+yMVFTHRsrtpxuM17zCmS1cLLBgA8t5Qryj2G4M+PL7oZGCY9WJs0R/qldbCmFmhy
	 b6TMrSrCbgnopWb82HJiqQN4+XBmMDLrIDp+JKHA=
Date: Fri, 24 Jul 2026 10:36:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: jirislaby@kernel.org, john.ogness@linutronix.de,
	osama.abdelkader@gmail.com, jackzxcui1989@163.com,
	asrinivasan@oss.tenstorrent.com, andy.shevchenko@gmail.com,
	broonie@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>
Subject: Re: [PATCH] Revert "serial: 8250: Clear CON_PRINTBUFFER on port
 re-registration"
Message-ID: <2026072454-eccentric-flatfoot-a6b4@gregkh>
References: <20260724072452.40455-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724072452.40455-1-fushuai.wang@linux.dev>

On Fri, Jul 24, 2026 at 03:24:52PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> This reverts commit d338ab1d90603f875c4f7ed223406535378173a5.

What tree has this commit?

> This may cause some boot logs to be lost on some platforms.

Can we get some more information than that here?

thanks,

greg k-h
