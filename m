Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2553E49B
	for <linux-serial@vger.kernel.org>; Fri, 29 Mar 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692095; cv=none; b=dcT4Gb0lVqlkQKkhyrOny6s6J7d5D7yYaJNAbjFAeS4LIYaF4JtB+/1dlCtpnJunTnzpdgv1mnFpdjS41wdoNVFbValO4uBe6CFlUcxKlYUzgNSlmE9REp6QIBFATx/vZQVn0oGP7XFgdQDdrct9XiqfkatWDN6xoN6Yet1abos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692095; c=relaxed/simple;
	bh=4wkIc6pW5/DDOEkX8KSUtoZD31gZIPyUO6EbPQjma+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEm8I8VW+v62BGrSKd0K+WGsU892knicCoipfq2jjJquONYoVwrd5+Pb69GshYYuR2s/R1j77g96d/Y1MCxkchymABGEzmH4KXpxGDXDkMmEB4QaySKq5XOc2U/YzHb2zSB9RnGtY+AdqIRJ1QX00ZgM5ZJX7MI0WdP8Cx9szGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=drdV3qJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="drdV3qJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A35FC433C7;
	Fri, 29 Mar 2024 06:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711692094;
	bh=4wkIc6pW5/DDOEkX8KSUtoZD31gZIPyUO6EbPQjma+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drdV3qJ3In8efU70UQkQOUNy+H88B5cQQZeDFau4mlu7AibZTKtzzwJgztx1EMc6A
	 KrxTlvHBiBAAKtcS0XtW59+rgWs16yl5MCLlSRy4qwyargYdlAfJ+1iUvBSvQp63jI
	 pAB44mf6IrPHbvSLGiFyQx/JgWqJx10FtIvC4irY=
Date: Fri, 29 Mar 2024 07:01:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Droney <josh@fastcomproducts.com>
Cc: linux-serial@vger.kernel.org
Subject: Re: Incorrect UART in /tty/serial/8250
Message-ID: <2024032920-replay-ruined-d92d@gregkh>
References: <CAJqSBBNc5mPcKfFSH2jXnjp9PB6fQGWN0vB9JPKHENogUw-D+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJqSBBNc5mPcKfFSH2jXnjp9PB6fQGWN0vB9JPKHENogUw-D+A@mail.gmail.com>

On Thu, Mar 28, 2024 at 02:34:10PM -0500, Joshua Droney wrote:
> Hello!
> 
> My name is Josh. I'm currently employed at Commtech, Inc.
> (https://fastcomproducts.com/). I'm following the instructions at
> https://kernelnewbies.org/FoundBug to report this issue. Please let me
> know if this is incorrect.
> 
> We (Commtech) have several serial boards, but the board in question is
> the '422/2-PCIe'. This board does not exist, but someone added it to
> the Linux kernel at some point in the past. This wouldn't be a
> problem, except that the board ID that was used for this non-existent
> board (0x22) was ultimately used for a different REAL board, with a
> different UART. Instead of a xr172358, we use a 16C950 on the real
> board. But the Linux kernel finds our other board ID, and tries to
> initialize it as an exar chip and fails. I don't know much about the
> kernel, but I believe the lines in question are:
> 
> https://github.com/torvalds/linux/blob/master/drivers/tty/serial/8250/8250_exar.c#L47
> https://github.com/torvalds/linux/blob/master/drivers/tty/serial/8250/8250_exar.c#L925
> 
> You can see that we have a different board with device ID 0x22 here:
> https://admin.pci-ids.ucw.cz/read/PC/18f7
> 
> The 422/4-PCIe exists (0x20), the 422/8-PCIe exists (0x21), but the
> 422/2-PCIe was never created and its device id was used for a
> different board (0x22, the SuperFSCC/4-LVDS-PCIe).

Can you please submit a patch that fixes this?  We'll be glad to take
it.  If you need help making it, please let us know.

thanks,

greg k-h
