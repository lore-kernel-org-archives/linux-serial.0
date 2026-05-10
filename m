Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5963B9;
	Sun, 10 May 2026 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432158; cv=none; b=Fx6iNg8QSaAyguTVoXk0bIJX2Cp1neYn+D1sQnXMK2BuwBvybrYyfT84xp9Yn2wQeCjVC0RMYOhEsYLao8idrqDR+mS53LFGkfHmlZrWAmOIueuQkW4pbwnYEltLWJU8uY4BAwIU12Vr/DJsSg6fOwcq4pH1bHL1RPXE9JisxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432158; c=relaxed/simple;
	bh=noWsFd44NCbIAMlXBLFHbyuvxWfAb6Ic9C/int0sqo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8CcSkc/sHJwS58ylz87XJ5hJ/yVFLO5pSb4K9NhA34Y0EY/73BpaAAkKvN4/KDTnghY8re9hCjoaXCBkYZbqGFyzY0yWSZJ27U4G9qbr/IcX5OKvl1ZdYVRRLMmMqEGrSNZZwTaKcSaHnapQD96k0oLt/yQWNMv4/4kJtEHjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RI6tPu/V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RI6tPu/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27F2C2BCB8;
	Sun, 10 May 2026 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778432158;
	bh=noWsFd44NCbIAMlXBLFHbyuvxWfAb6Ic9C/int0sqo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RI6tPu/V4GCjy4o08AT+f8bVsbB8Cl4EQAmdmJx83hzRabCscZiCGIXe5p6bcltUV
	 QNrjmMLYAXR89+77aeG2Exxj8Gb0KEnB/RwAewnHjcVV3sh2aMdd5QR4tmoZgCIn2N
	 m3KmLlalzMpkInvBLSkrIF593en8QwykuzgmQZKU=
Date: Sun, 10 May 2026 18:55:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] vt: keyboard: serialize KDGETLED with keyboard_tasklet
Message-ID: <2026051039-snitch-attitude-a67d@gregkh>
References: <20260510031348.1922157-1-zzzccc427@gmail.com>
 <2026051001-peso-enamel-2e62@gregkh>
 <CAFRLqsUeat=rUj7aCSAku=A9NBNj3Wxd+xi8xzzBtRWqCxp18Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFRLqsUeat=rUj7aCSAku=A9NBNj3Wxd+xi8xzzBtRWqCxp18Q@mail.gmail.com>

On Mon, May 11, 2026 at 12:43:26AM +0800, Cen Zhang wrote:
> Hi Greg,
> 
> > On Sun, May 10, 2026 at 06:22:xxPM +0200, Greg KH wrote:
> 
> > Why is that an issue?
> 
> Thanks, that's a fair point. The issue I was trying to describe is not
> that KDGETLED can race with a normal LED state transition and return
> either the old or the new value. That part is just the usual snapshot
> semantics, and the value can of course change immediately after the ioctl
> returns.
> 
> The specific case I was concerned about is the VT-switch force-update
> path. vt_set_leds_compute_shiftstate() sets vt_switch and schedules
> keyboard_tasklet, and then kbd_bh() does:
> 
>     if (vt_switch) {
>             ledstate = ~leds;
>             vt_switch = false;
>     }
> 
>     if (leds != ledstate) {
>             kbd_propagate_led_state(ledstate, leds);
>             ledstate = leds;
>     }
> 
> That first assignment is only an internal old-state sentinel to force LED
> propagation when switching VTs. It is not a committed LED state intended
> to be returned to userspace. Since KDGETLED currently returns
> ledstate & 0xff without quiescing the tasklet, it can expose that
> temporary complemented value. For example, if the real LED state is
> LED_NUM only, a read in that window can return the complemented low byte
> instead of 0x02.
> 
> > stable for "what" exactly? This is a snapshot in time, be it before or
> > after it changes is not always going to really matter here, as it can
> > change right after you "enable" the tasklet, right?
> 
> Yes, I agree. "stable snapshot" was too broad a description.
> 
> By "stable" I only meant "not while kbd_bh() is in the middle of using
> that internal force-update value". tasklet_disable() would make KDGETLED
> observe either the old value before the tasklet runs, or the committed
> value after it finishes. It does not make the value stable after
> tasklet_enable(), and the changelog should not imply that.
> 
> This is a small userspace-visible consistency issue, not a memory-safety
> problem. If this behavior is considered acceptable for KDGETLED, I can
> drop the patch; otherwise I can send a v2 with a narrower changelog.

In the past decades of use, has anyone every noticed or complained about
this consitency issue?  If not, I would recommend not worrying about it :)

thanks,

greg k-h
