Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EABE3CF694;
	Mon, 27 Jul 2026 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785133522; cv=none; b=Ff6R8TBJtnuijGr6/wZTaTPu4h+6BzYl1FmC9FmifXIwI4yx3TKHinHpkLko43IlAGOVo/g8LPrnDr9NPhtdoo4LHG8eOSkgx5RxzKSIxpEa0NsqVAeSnEA9taQPVlIL8hOwoYmoi0V8jhqnp38PTS3l1hFBqFJMKu+bJRJv+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785133522; c=relaxed/simple;
	bh=bE9gF9Go1KNv49uLQjcFzSG75gb+ii4/1+fU4Whzx6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUP3EFUQMdCIEVtHi8Ilj4etopZxufE631x9g69AcBPjHB11YIH0DT55hWdcSggP5OT+fo2xhfJW7gmcI14AUgte2GsBaEa4/7YvoxKTTY5ju8oEoQyVHhfnmPfnmot2A8sWvBIxqZ7skZqsbQCa1T6egjIFyPyZWsWDCfeIgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ou5KGY86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ou5KGY86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6CC1F00A3D;
	Mon, 27 Jul 2026 06:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785133515;
	bh=FHCSXgg/0aH3uXEL18SQu1nPF+l72QwnDIIHzy1jq1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ou5KGY86tgpaS/A272bcPMBXlgWQt6SulOw6cfBzUfC+at4JOU/cwPimU2TPMLAsq
	 gUxFifXRA/T+2U8mbeWG3zC2uw1b/4DsyJz+gN3VWxNWiqsP/xTLhxNqLn5jX/SbmG
	 jnfppejdQhpGtyh7k9dYSwzvBoDSR9ZFhbEYDIk0=
Date: Mon, 27 Jul 2026 08:25:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xincheng Wang <22009200607@stu.xidian.edu.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: limit TCSBRKP break duration
Message-ID: <2026072700-causal-remarry-6edf@gregkh>
References: <20260727055525.6170-1-22009200607@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727055525.6170-1-22009200607@stu.xidian.edu.cn>

On Mon, Jul 27, 2026 at 01:55:25PM +0800, Xincheng Wang wrote:
> An RCU stall was observed while exercising tty ioctls on an
> 8250 Pericom PCI serial port.
> 
> The reproducer passed a very large argument to TCSBRKP. tty_ioctl()
> multiplies the argument by 100 and forwards it to send_break(), whose
> duration is an unsigned int. That can leave the serial break condition
> asserted for an extremely long time and keep the IRQ line active on the
> affected setup.
> 
> Clamp the duration before calling send_break() so normal values keep
> their current behavior, while preventing excessively long break
> intervals.

How do we know that systems don't want those long break intervals set?
You are changing something that might break people's working systems.

What specific error are you getting when you send a long break time and
why can't your hardware handle that?

thanks,

greg k-h
