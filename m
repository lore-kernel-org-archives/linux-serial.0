Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1795425CF5;
	Fri, 10 Jul 2026 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686760; cv=none; b=IGDFpBugGrWD0/nTYxM4ZUjsHn0d63pPtIoDDSVEdCLnjW9hFGpc1uo/k5M64242w9NbsQBVdY9cKwlpQn4UKUtrzug+4S+uvMu4B8wpF4cTn7oEJtLcRlpJA8kO5wxmPPhrkUHjitY5ojUgf63Y0V1SGi6zv2OC8eVDyCTW2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686760; c=relaxed/simple;
	bh=6pIZ9v3XbIAuzCCduMdh7IqKzxWpIzxGkrtTpxOo/lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfIzzO6DMOAZq56j9DgTUiRBhcHQFSOzlwYw0ghycKWIRgW9l2vQ9C5g2d33X+W0WHT64XyM6gOvatXzrYKVwCh5z2ujyVqmxWbFJN7TgtOWPZIwG+wg0PpiBlHLFlTK0AfIpuTep+QTl2wIhdDlNaqV0X7lDqqxc620Po6uX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZR1huUfK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZR1huUfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD4A1F000E9;
	Fri, 10 Jul 2026 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783686756;
	bh=wu1wVFniMKCEx0k3VDMYdo10BIiii4dThzUzd90n9SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZR1huUfKHFDlIIu8L6klVmNslkSibSCj21NecyI+R2uV2ZBB3CC/vZkf9C/QimFAL
	 /AGKxo9QhJtdi5F5XMlbiK6z437z4ci3Z+0UxFdpYMPubSmkm5KtT4pLXSZLdi+kj4
	 S4/gUVEUbYpBNQ6oDWObvKfJNvXRUc11ig9pwOPg=
Date: Fri, 10 Jul 2026 14:32:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCH] serial: 8250_pci: fix -Winitializer-overrides for
 Brainboxes UC-260/271/701/756 entries
Message-ID: <2026071021-game-sulfur-c62a@gregkh>
References: <20260603232651.8580-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603232651.8580-1-rosenp@gmail.com>

On Wed, Jun 03, 2026 at 04:26:51PM -0700, Rosen Penev wrote:
> PCI_VDEVICE() expands to set .class=0 and .class_mask=0, but the Brainboxes UC-260/271/701/756 entries immediately override those fields. This causes a build error with clang -Werror,-Winitializer-overrides.
> 
> Fix by expanding PCI_VDEVICE() manually, omitting the trailing .class/.class_mask zeroes so each field is set exactly once.

Please properly wrap your changelog text.

thanks,

greg k-h
