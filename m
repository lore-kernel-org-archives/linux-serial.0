Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF6315777;
	Fri, 31 Oct 2025 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894385; cv=none; b=nErIrNZunPpE05+5tV+Gm18FECSOxEYt7jlyBWN6yN0Hv+hnB7FP09yhWkw5xl9inZyo+JmP89ZiO7tGkR2BvoI7zg4D0Iyb77vPDqMzw3yBCk6uYWhL+tRBsZiIL7PqubmSJYNSwZxxA2luqddhmjkW+lgfMN3uA+8uFRblKNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894385; c=relaxed/simple;
	bh=G1ycpf3dyZ/G8sbQY6PK6OPq5HydjTWbqCPd9vt18uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzrIBVLQhA4krJKdR+vd2G2AyTYzyHW0mSqjVYrfoFXKMOY+XPd58qaoA30mcHjeczTvbnARxPBATrPb4oKoKlRyESCKCqoS4WjkpX54pGbkcmS2oUPyfkaa+ZmospMhKE6OOaT19/Y3Y6a9G3cpCGs7rLKzObjYkoG3JrfaPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGTDACZ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGTDACZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FCCC4CEE7;
	Fri, 31 Oct 2025 07:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761894384;
	bh=G1ycpf3dyZ/G8sbQY6PK6OPq5HydjTWbqCPd9vt18uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGTDACZ8gXt3w2Ze2V5oxP+HifFY0wk0uV4Nu8DVH0Xrq+x9i14qPtKhSXiPBVdZJ
	 N5hH5peN22TqRX7vQPm592HuJt9fKQ7yDzKsC4jfsSjGf9Ryr2zDJKEIRsjMvamuby
	 5x30zv4N9Exe3NCmXCtyME3/K4k4zGXQ6etOhuSE=
Date: Fri, 31 Oct 2025 08:06:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 11/14] serial: sc16is7xx: use KBUILD_MODNAME
Message-ID: <2025103109-astronaut-oblivious-ad13@gregkh>
References: <20251027142957.1032073-1-hugo@hugovil.com>
 <20251027142957.1032073-12-hugo@hugovil.com>
 <aQM_VBg_7JwyGGLG@black.igk.intel.com>
 <20251030160142.e1ae7b158216b8101582cd49@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030160142.e1ae7b158216b8101582cd49@hugovil.com>

On Thu, Oct 30, 2025 at 04:01:42PM -0400, Hugo Villeneuve wrote:
> On Thu, 30 Oct 2025 11:35:00 +0100
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Mon, Oct 27, 2025 at 10:29:53AM -0400, Hugo Villeneuve wrote:
> > > 
> > > There is no need to redefine the driver name. Use KBUILD_MODNAME and get
> > > rid of DRV_NAME altogether.
> > 
> > Actually I am slightly against this change. The modname (and hence modalias)
> > are parts of an ABI (visible via sysfs). Changing the module name (file name
> > in this case) may inadvertently break this. Yes, it most likely not critical
> > in this case, but should be taken into account.
> 
> Hi Andy,
> thank you for pointing that out. It didn't occur to me that this could
> impact the sysfs ABI.

This should not be an issue, the device name will not have changed, and
that's the normal sysfs path for things.  The module/driver name can
always change, this isn't a real problem.

thanks,

greg k-h
