Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736984DAF89;
	Mon, 19 Oct 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410490; cv=none; b=MutPdbo8fuVPYQ3++vBD4+PvbSKZLc3LePotvLBQYobxeBLQNK5ScIVeXVmC3weK7YLEU149nHhw1YPrhcMkWsfwIBDAS1W+VMHRYmjiW9QQDFcWofQQX105Ziv4JNxAJs8A4d0Hx2Nl/JdZHEnvfsl/780mBLxl30VO8iWGD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410490; c=relaxed/simple;
	bh=0YgUrRVF2KHISF+RhcWQ71dH+nvktOQ9aVvLn+JGyz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSl14Zrz3vu6/0JS1LbeNe/OuCX0KTgndBqnEjDv6+MtemY79/Az6IzKvdM0dTHexliY9JIt/wYPU53hc3N2E98VqEaVHChLHU6EDyMGcGhhxmOwE7wAcfcH9V3UXKLY+Wg0feQFPVQYn5pUo6K0lgcg41OEdtD869Wm9j0muyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e2Jr2iJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e2Jr2iJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CB51F000C5;
	Mon, 19 Oct 2026 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792410489;
	bh=l+7MC/WJtcQGt7FYzoTw7UHAKcfCqPEBqJ9fydFNENQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e2Jr2iJCVJoiMKgFnYwEt1Aw+VgMNlX2hZ9chnJMEsffW06mfhR4G5+jbi5ERDDha
	 60MSjcKFC7Iq1m4qhemfqEAapxF58QvIyp7Ph3SZGG/YPvNy8WhfS7Q+IvbDc0OmZv
	 rp0a+LTOdhvQ9TLAcghamHUDmsTK6dsXH9AJFIc4=
Date: Mon, 19 Oct 2026 13:48:02 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: LI xiao <lixiao0@hdu.edu.cn>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: serial: pch_uart: possible TX DMA use-after-free race
Message-ID: <2026101932-nibble-release-d627@gregkh>
References: <AGIADwBDLFAmWi-eqY4iK4oL.1.1792407296160.Hmail.252270051@hdu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AGIADwBDLFAmWi-eqY4iK4oL.1.1792407296160.Hmail.252270051@hdu.edu.cn>

On Mon, Oct 19, 2026 at 06:54:56PM +0800, LI xiao wrote:
> Hello,
> 
> I would like to report a possible race in the PCH UART TX DMA path that may lead to a use-after-free.

Great!  Can you please provide a patch to resolve this issue, as you
have a way to test it.

thanks,

greg k-h
