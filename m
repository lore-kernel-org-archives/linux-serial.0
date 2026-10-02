Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690232AADB;
	Fri,  2 Oct 2026 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920414; cv=none; b=G8jK2sOPfoaLnvR5lw5A1zlUA/YoRdNM044GmXhyjxGTvvP5Asx728Rm6rO9e4Yd9d5H0Uwh1WpoylcFGtuX8gdclhF4BHsNz/3at93LArt1hdoVmVlV5YJNM6uT984wUejFVbgE760phFd4kbZnXCYDRLbidFDPyQmN+rWwRGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920414; c=relaxed/simple;
	bh=wUnwSTL0obVCpQIzVoTMTfPbw9p7g2EqvDE7PfTtMDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZzhskd+RNLE7vIAMbZPrlrzQc74yT3WwsBRgt9V6yMEjm01mLQLw2w65/oYtumyz61MrLc7XlpGlBd25XWXL2GTJRm9LN153+fC5uftznNs7Ll+/pW8r7A5FDN38kOz2qx9HlxauSAfcbdB2HCrQ6TmsfzHbA5gnCBgA06hC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IRVZ6iJX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IRVZ6iJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5011F00893;
	Fri,  2 Oct 2026 05:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790920413;
	bh=wUnwSTL0obVCpQIzVoTMTfPbw9p7g2EqvDE7PfTtMDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IRVZ6iJXfvIVZaGBFvlKMK6dLkiFf97VSaTqKVXL4nWtGFKkEVtMpxB8sOtwIWB54
	 Uyw+ZtL7crf7ExmAlDmKMPYE1vEDAH/24tXV95wmFGbQOi9Wr6x7rPiBh0wTWXGVhc
	 +Kx1g1qYK2oymPl4vT971PWhR9bicqmlDiz+QPk8=
Date: Fri, 2 Oct 2026 07:53:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Austin Schlegel <Austin.Schlegel@arthrex.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] serial: tegra: fix RX DMA descriptor use-after-free
Message-ID: <2026100213-widow-cornflake-9881@gregkh>
References: <20261001-tty-linus-v1-0-ecb8576c802d@arthrex.com>
 <20261001-tty-linus-v1-1-ecb8576c802d@arthrex.com>
 <LV8PR11MB8557D32C0AC2AB0271FC1D9FF0892@LV8PR11MB8557.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB8557D32C0AC2AB0271FC1D9FF0892@LV8PR11MB8557.namprd11.prod.outlook.com>

On Fri, Oct 02, 2026 at 04:06:14AM +0000, Austin Schlegel wrote:
> This e-mail and any files transmitted with it are the property of Arthrex, Inc. and/or its affiliates, are confidential, and are intended solely for the use of the individual or entity to whom this e-mail is addressed. If you are not one of the named recipient(s) or otherwise have reason to believe that you have received this message in error, please notify the sender at 239-598-4302 and delete this message immediately from your computer. Any other use, retention, dissemination forwarding, printing or copying of this e-mail is strictly prohibited. Please note that any views or opinions presented in this email are solely those of the author and do not necessarily represent those of the company. Finally, while Arthrex uses virus protection, the recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email.

Now deleted.
