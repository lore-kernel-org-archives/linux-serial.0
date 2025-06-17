Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965872E06D0;
	Tue, 17 Jun 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750160320; cv=none; b=RGSpUJeomradSkIkKox7qL0zi8znqoVQIoEGCmK0ZBE1LwfbBHFIIutsmrjM8LmVArfbQ9y5sMuPxD4vRvMiNctQrriJcHxCmaL2Htn2UtRWGT/l8NgPJr/pW7IN9wU/OGvcmHJMwI5pHxbf4oBGDodBPCdNOa8FXSczT7+axPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750160320; c=relaxed/simple;
	bh=fllwykX6hHfEhv+mLpuPo9l2X/Ngge9J44t9X9fGQGc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VDHAOefORlp4NLU3FXD4VY1C6/b+rIhKroq3kg2dPMWgeBB7e+Xt/+3XDq2F5ncS716ZAxFVC5RjupRw4sx9JbI87ZsW0UuYaFuZfKuYrOkOnE1yTiN59qjmHAeGEt/cNA3pz0kghW9UTYED8Jr1zg6gp9BsUwcalZ8xbV+B9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id F307692009C; Tue, 17 Jun 2025 13:32:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EBB0D92009B;
	Tue, 17 Jun 2025 12:32:48 +0100 (BST)
Date: Tue, 17 Jun 2025 12:32:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/33] serial: 8250: drop DEBUG_AUTOCONF() macro
In-Reply-To: <20250611100319.186924-30-jirislaby@kernel.org>
Message-ID: <alpine.DEB.2.21.2506171216090.37405@angie.orcam.me.uk>
References: <20250611100319.186924-1-jirislaby@kernel.org> <20250611100319.186924-30-jirislaby@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Jun 2025, Jiri Slaby (SUSE) wrote:

> DEBUG_AUTOCONF() is always disabled (by "#if 0"), so one would need to
> recompile the kernel to use it. And even if they did, they would find
> out it is broken anyway:
>   error: variable 'scratch' is used uninitialized whenever 'if' condition is false

 This is removing useful debugging aids.

 The issue with compilation is related to commit 3398cc4f2b15 ("serial: 
8250: Add IIR FIFOs enabled field properly"), which removed the assignment 
of IIR to `scratch' (although a path did exist before it that bypassed the 
assignment anyway), and can be trivially fixed by bringing the assignment 
back and moving the debug statement next to it.

 I agree that "#if 0" isn't very useful as it requires patching the source 
to activate; changing it to "#ifdef DEBUG" would make more sense nowadays.

  Maciej
