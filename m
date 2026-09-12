Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255436F8F5;
	Sat, 12 Sep 2026 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789239701; cv=none; b=DPBe0u7hmUDZ/vxNETyIrSjgHPer75DCafTCTUobp39g2ikRHmpAY0iorph9VrAjE9mXPg0Gm4cLJll3TZOVvptWweAPf1kE6OOO6ZoaHLJ32fSWFXrLqUn8B2OxtqWXqftKRu5BRaGE2lX1v3DePG2Ue/tbcXu6ds1LLKJZgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789239701; c=relaxed/simple;
	bh=8KGygAJf0dnMmax4Kw9jmHDblgzbTM68+spt+7IdtN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZMXnfC8FJeJJ+XiAJJ/N+rVsrtsGwpbHAGLSs6qC+/TEhcbsS0pllv+weAVDNyCktCtUDPKsmv4WctNS8GvrQug/2xLRQd708stZCRJCrXcDGoeEHNnsRx/5p3XUVX6Yhiu/58BiNxezc6o+4oEwTjNxMMBNDw0PH3mkkjie5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ls4+rWzN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ls4+rWzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789239676; x=1789844476; i=deller@gmx.de;
	bh=/6Gtr1pFz+/wQvsCAm1SpGpbxSpPvyHyKvRXhn1mkYc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ls4+rWzN+D5qreHXuh6VFXwE5hPH7wFZR+qAXYEf326P8O44qKY6y25nBvR0tiS3
	 jea51cbR8MVKEmNP8qcVP1FIzW/Wkz50ty0fKNfGtJYFQmMGaefd3O8AJf+Jijgff
	 FWsePrZPzrYvsfiFCGcDJgX+iIagVaVh8ZL6OHZ0Zjk8ZDDb4FA56slkzn/MoWoOI
	 RnlefNUCkI93s0zmUlCJgMjUR7RlH1a+tF9jSKJZ/JqOyLA50YddPAe5xUqIGTs0m
	 HoN4OHr+1nsyDM3Btq5RjF6NBAZVz5e8LbSnDZmMXgE+zNY47UEHyYLJgtBmlTYoJ
	 ZPxowI/tMKvofeaI9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1x1bLS1PFq-00CXbO; Sat, 12
 Sep 2026 21:01:16 +0200
Message-ID: <31dfff58-f3c2-4265-b34f-e40bdc61e18c@gmx.de>
Date: Sat, 12 Sep 2026 21:01:14 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vt: Add cursor-size helpers
To: Thomas Zimmermann <tzimmermann@suse.de>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-2-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260911094518.78093-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D1XXeHkcVaszmx/fGe7AdhataYq31L/qEgalTEoGiZwpXGyqK9F
 wOh8KAlFmoLPhmnN8lnw/x/vVQ8aFMB4wvttVucfv+77C2eKHrxft+4z1wPz2kVdH3c8aGW
 RDBfeFqhn2niKsdDSg4rp1f8WAow9glbFeFAano87mtz07QaZnzniIacQDXGkIHEzz9A9/2
 IR/NklpyGCfPKEQr6kPuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2fLDNSRRLiM=;Ufvdl+zg/y+cWt5HEhaHzgpDybN
 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
 E=

On 9/11/26 11:25, Thomas Zimmermann wrote:
> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_font_cursor_start()
> and vc_font_cursor_end() return the scanlines in which the cursor block
> starts rsp. ends. This is compatible with VGA hardware
>=20
> In terms of cursor design, the new cursor-size helpers follow establishe=
d
> styles in fbcon. The only exception is in underline cursors for fonts wi=
th
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follow=
s
> the style used by vgacon.
>=20
> Similar code in vgacon and fbcon ignores the cursor's default size store=
d
> in vt.cur_default. The consoles default to full-block cursors, while vt
> defaults to underline cursors. The new helper fall back to cur_default a=
nd
> then underline cursors; in this order.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/tty/vt/vt.c            | 90 ++++++++++++++++++++++++++++++++++
>   include/linux/console_struct.h |  2 +
>   2 files changed, 92 insertions(+)
You may add
Reviewed-by: Helge Deller <deller@gmx.de>
to the whole series.

Thanks!
Helge
