Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA419DF4D;
	Thu,  6 Mar 2025 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244808; cv=none; b=O00SojbCNXRM7JvnG3PucFG7RP8JankwRG9C1xpjFtnqmxsuY7XbBU2dbUjYJ0H+WVGwV2ujobFVz7ypdNMjulk28IGlDj9k5w3/hxv2BhC1VwzrHvPGIf9dM5IM8E+8hygCts1pL5SIjh2TJ3XaYtdLwo2Ih6XRo/rnxt0Jrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244808; c=relaxed/simple;
	bh=TPHLV7UHKuf3IzBVO5JpmSCDRfQpTpWNmkLIv6ixv3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXfUbtt7gM0aZhWIEq7xPIFj5xaa0rL/61SoHpO14eCOPm9eBI7L503IGzFIArZXS7j+k1N1fgmYoz84SmOpftSM2n43jL+/NQKhPTZPkWNBy3Pc2Y2UBPawXjQCCyfSkJDwMuD6yrIfSJ5Ot4eMOnV35IjGe+/tLf/9XI/vx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KJWQwjEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KJWQwjEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A98C4CEE4;
	Thu,  6 Mar 2025 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741244808;
	bh=TPHLV7UHKuf3IzBVO5JpmSCDRfQpTpWNmkLIv6ixv3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJWQwjEOGIt9/gFgeaCTjmeE+/X8TH4tFo2FNsDIzsh41e/Q5Tzvljo4LOrKjl/bT
	 2v9zJdVYUGyj83wp2WwjfTFD450ReFMiCHZTOr23WO9tjijfmvJc2+L+RTe4WB2TQB
	 2l3v+wsubzwWxJc8eCWfsMOwqEdXoEh/6rtojfPY=
Date: Thu, 6 Mar 2025 08:05:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: xiaopeitux@foxmail.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	xiaopei01 <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] serial: 8250: Optimize port function assignment with
 generic macro
Message-ID: <2025030602-frays-profusely-0656@gregkh>
References: <tencent_50535E8627177335AEA311C5DC0A54609008@qq.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_50535E8627177335AEA311C5DC0A54609008@qq.com>

On Thu, Mar 06, 2025 at 11:00:32AM +0800, xiaopeitux@foxmail.com wrote:
> From: xiaopei01 <xiaopei01@kylinos.cn>

Sorry, as per the documentation we need a name, not just an email alias.

> Refactor repetitive conditional function pointer assignments using a
> generic macro ASSIGN_IF_EXIST. This consolidates 15+ conditional
> checks into a consistent pattern while maintaining type safety.

But why?  Macros are a pain and hide what is happening here.  Do you
think this makes the code more maintainable over time?  Does it fix any
existing bugs?

thanks,

greg k-h
