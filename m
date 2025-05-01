Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40AE18024;
	Thu,  1 May 2025 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113726; cv=none; b=qGXPe454eKyHOI074ccDDsgf5PEK3PyrBmhr6O4AL5+picVOBmKN+62YLZZMf6HbpwIbCsnf/Eb1PMa7CNoCNJkoo0h1+2RvrK9dsmphevK+bWzRj63K6tFF9rAfr8g4h+wD6iR6cQzd8/jujmyjTG2d8TJR6s2E/Jw1I0Uiw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113726; c=relaxed/simple;
	bh=2KvLWosmR3wc9Jsr6+Y6ZjKOHlkfZ5m/0L+j3kWX7SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ7e1/HpBi4pUXG1MZECK/gy2MJUlSFXZlQ/3kLA3iaV+Oy9EO2fJiTHN7ySB1ebWUUvTIYLpOEsis/YbwuLyzG4u5GcZ7lCBQosEqQz+U3wM10raJJWAClf2Z38O4WL//9wiqE5ZFUFYT/faHztzeo+UZYnOy3L5m3AoLf4OmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jU0lpNK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jU0lpNK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D70C4CEE3;
	Thu,  1 May 2025 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746113725;
	bh=2KvLWosmR3wc9Jsr6+Y6ZjKOHlkfZ5m/0L+j3kWX7SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jU0lpNK1ZI9IgGnHdWQC8r7I1nyRtZPrTD1U/b8GvmnRndjBUkY8zTw64g+7GBMk4
	 sVgZ2kvv+Fz/edp1lncccmxQo1jIxvyk0sEPiIMyvZRkLAL/ayf2NR0ys981cJt/Ff
	 pyDrhZywGi/hgMjX9zzRjOk43aQ8PooxBfCZ1bIA=
Date: Thu, 1 May 2025 17:35:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Jiri Slaby <jirislaby@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: add new dynamically generated files to .gitignore
Message-ID: <2025050113-delicacy-swinger-cb84@gregkh>
References: <20250430122917.72105-1-brgl@bgdev.pl>
 <sq7527p1-9218-r845-605n-2p419s2650s5@onlyvoer.pbz>
 <47np2on4-875o-21r2-p707-rr3rp30s82rq@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47np2on4-875o-21r2-p707-rr3rp30s82rq@syhkavp.arg>

On Wed, Apr 30, 2025 at 10:52:40AM -0400, Nicolas Pitre wrote:
> On Wed, 30 Apr 2025, Nicolas Pitre wrote:
> 
> > On Wed, 30 Apr 2025, Bartosz Golaszewski wrote:
> > 
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > 
> > > Add new dynamically generated headers to the local .gitignore.
> > > 
> > > Fixes: b11a041179e7 ("vt: introduce gen_ucs_width_table.py to create ucs_width_table.h")
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
> 
> Actually, the fixed commit should be the one titled `vt: move UCS tables 
> to the "shipped" form`. And, unless Greg pushes the revert of the 
> initial series upstream, the commit hash is likely to change too.

I've fixed this up when applying it, thanks.

greg k-h
