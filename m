Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6B145B38;
	Fri,  6 Dec 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468388; cv=none; b=EfWOAYRe2XTXHJbrBV0TMluny1wO4QzUfWApql0f+WPkjKOm9Ag6+DyT/cZOG9L/SrWp4UX4klyaM7Q/nEw1GD8GBEuMSXrGbSZ2jcO6y8GoEYzMvIPjvGNwpoMey8tDcJizk7NmoCw9mFBKe6F8iMgx6Z6QI1BPfz4DaN0x4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468388; c=relaxed/simple;
	bh=qcdNoLD2JiTtTYf+zPG0MhcRXi/3k5NHDcLJnkkioyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVjsy7J++Xomshahv1aA0mmGldjQqjixOHcFtjSyNAdGo83dIiV+4nSnwLXyzmfgFj62+g4SwC5PHF8qzsUEiqgppfN8KFN9X9oQ+qdvXmPO2QLfaqWQ4XZ/UEornl4YM/29StKm2SYsn1DXwCYQcwLouOn33liRZaS5/0+svzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ETxS2Ta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ETxS2Ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C94AC4CED1;
	Fri,  6 Dec 2024 06:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733468387;
	bh=qcdNoLD2JiTtTYf+zPG0MhcRXi/3k5NHDcLJnkkioyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ETxS2TaeqeeaIey5gAnKza7I6jHZsFTjslIYPxl47eZU6fwW1ruVzKI4UMQXY4el
	 1TY9LjDa8Lu6Afg+DLTP9KSRcVViXfuSDtDuqA+Eorml4tkxj4pN9NGk6evXnTJCAR
	 o3zfEuQwoxIcGtvBw8KFB4mTdJolBO/8LlMNq2E4=
Date: Fri, 6 Dec 2024 07:59:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-debuggers@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: move dev-tools debugging files to
 process/debugging/
Message-ID: <2024120637-eradicate-icing-fe79@gregkh>
References: <20241206003100.38142-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206003100.38142-1-rdunlap@infradead.org>

On Thu, Dec 05, 2024 at 04:31:00PM -0800, Randy Dunlap wrote:
> Move gdb and kgdb debugging documentation to the dedicated
> debugging directory (Documentation/process/debugging/).
> Adjust the index.rst files to follow the file movement.
> Adjust files that refer to these moved files to follow the file movement.
> Update location of kgdb.rst in MAINTAINERS file.
> 
> Note: translations are not updated.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Fricke <sebastian.fricke@collabora.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: workflows@vger.kernel.org
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <danielt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: linux-debuggers@vger.kernel.org
> Cc: kgdb-bugreport@lists.sourceforge.net
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Hu Haowen <2023002089@link.tyut.edu.cn>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-serial@vger.kernel.org
> ---
> v2: Make process/debugging/index alpha by filename.
>     Update references to the moved files.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
