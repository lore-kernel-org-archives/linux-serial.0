Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347C2036E9;
	Fri, 16 May 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414523; cv=none; b=O6hrX1hx+amypKD/m49vU7CPKz0lFK8ddG7E7Z0qyY6fcHT5GeKPY/qkGNXQLSLhutVnTZDlM7YtwQOOGvyAjwGQyx/AdPfx/W/5NiKzJEUHCOn04Ho6R3ccJTJm9Szw01+3rMLNf9z+vvGeMglFughi29c/GTAkq922SkV+A/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414523; c=relaxed/simple;
	bh=5i5dnuOFiMUcmAevAnumChc4aLcSGt9e0j/oa7bf8YU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KVXx4Yf3ifpkrUK/Hw+IIF8+ibRbBXJ0I25nsRmDqLJBXyzITHTwIs/K64+zllLUxL3dq+cWjO5FAMBJtd8/Zy2zUGdQCDrWqY513g8WHd1o8yiY71uXjoxVnWesrs35Jx31656UwS2XwF87Onju0F4x7aV40EJCHxWzTi+OjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=hunQSilO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f93RQBDe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="hunQSilO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f93RQBDe"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0902B13803ED;
	Fri, 16 May 2025 12:55:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 16 May 2025 12:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747414520; x=1747500920; bh=rLcBjkz4gm
	noBTZdaz236vUnDqE7ECyGd6Qxi187HXc=; b=hunQSilO73KRRmjkzcaDHdhJ+w
	B1jstAHhuojOc8jP+9YXLuq1UVbhAW+05DRUS+nTTWK2500esTxgRqnV4+xqGLCT
	I41ApCzXCx89Q5s/stGlTkjOM6luc0HxSv9Jb9KhqhHD2EfrYAK+ZF4/S/8ShR7h
	6edMFScaTLlXXp/nJc93p0RHewVkZ4zdCVpKLXsnZHsJOPZV5U8991zwljrjcFTc
	ZyQcdXKQzTpMLucjrJnBfKSgWXlChyuWZ9VHQiguk9VyrJjoSEln0e0duUJaXsJQ
	bnZyLgLZ9B1QE2L0MPknPmp5v3z/U77YRzEFDfdkjbc6R8qmtPhzgJeL+Hog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747414520; x=1747500920; bh=rLcBjkz4gmnoBTZdaz236vUnDqE7ECyGd6Q
	xi187HXc=; b=f93RQBDeF88aRz+hFCn2zVxbm8znLz+prJcIQt4OX5PYgZNrSrw
	i0/vC7o54N3zL+NYqNrakSvowxWAYaWScZExUlJz3nAUIf6t0vCqZL+7CoEc3NOV
	0jjoXL4f27LsnQ8sUoQYc6YQzIy0CNY3ionXc/Y5xOJ/rANpkY/ViNq21YVs/xLI
	QydgGRqyxThUJMP/qDenNVP2k8VKAznRjBRUitbVAVzMNPJxJn1hvwiB7g+/2Pzc
	gp7T5JUp987H4idpZBuWahF5empwYwmKFhEwXEgRWlE4c6EwLcxT37ql3hZ1zUfI
	ytD8aaoRs8/ZPy6kGixAd7mcVRx2zrBFYCQ==
X-ME-Sender: <xms:920naE0jPjnaNU4N9Ktsp7Lnk4laPtn_eymkX8_mcyOCgfUK9IHx9Q>
    <xme:920naPFRHszKBbULDFz2gt0KVhhi0RxX4YWIhJ2YxmeMMW_NMYt-d-fIsUXGl7lu-
    8AzaXdleHdMgvLbZz0>
X-ME-Received: <xmr:920naM7BE6anIv3vvSA77Fj1RSFrwhsnIEtAOlRYM3MtPm-3I28kpFT61QQu0N6WhzPQjzWQVH8EADH8CGqE-94urwKDZj0MXn6ks900VjqhIiddGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpeevueffuedvhfefudeuheeljeduveehtdejhfel
    ffehteelhfekheeiudehiedvhfenucffohhmrghinhepfihikhhiphgvughirgdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgt
    ohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:920naN0EVAn6QQHe2hHRBRvsAzoPFP-1W20o4nNXOLmksKDUyBy6sg>
    <xmx:920naHFkJNNFqOCQj3ITcsdZjaODzH4h37p0_MUF7V7_Id8wE_SqMw>
    <xmx:920naG_mzq_X8pzAWfNirtQJqfTxoCWp0kNSBJUr7HtCXPzlOlMvLw>
    <xmx:920naMloEeEuHhyhrmkbTJFU_tbFlqXC6oV7F_rjrqKJO8Irv0LGjg>
    <xmx:920naDbFbwXOJIOIqdq2PjGx2Byq2zrMsEzzt278sFnBU_F-TC9hDWsN>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 12:55:19 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id D8AE211A66FA;
	Fri, 16 May 2025 12:55:18 -0400 (EDT)
Date: Fri, 16 May 2025 12:55:18 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vt: add VT_GETCONSIZECSRPOS to retrieve console
 size and cursor position
In-Reply-To: <a5463522-1fa8-4ede-aec9-73f8a0aee196@kernel.org>
Message-ID: <404p9o2q-123s-94qr-4o27-77s5o7np67r0@syhkavp.arg>
References: <20250514194710.6709-1-nico@fluxnic.net> <20250514194710.6709-3-nico@fluxnic.net> <8fb2c16f-0e9b-402d-a7f2-4881de8c7bd9@kernel.org> <3o3q5896-8540-nro6-534o-307nn81r7r5r@syhkavp.arg> <a5463522-1fa8-4ede-aec9-73f8a0aee196@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 May 2025, Jiri Slaby wrote:

> On 15. 05. 25, 18:02, Nicolas Pitre wrote:
> > On Thu, 15 May 2025, Jiri Slaby wrote:
> > 
> >> On 14. 05. 25, 21:42, Nicolas Pitre wrote:
> >>> From: Nicolas Pitre <npitre@baylibre.com>
> >>>
> >>> The console dimension and cursor position are available through the
> >>> /dev/vcsa interface already. However the /dev/vcsa header format uses
> >>> single-byte fields therefore those values are clamped to 255.
> >>>
> >>> As surprizing as this may seem, some people do use 240-column 67-row
> >>> screens (a 1920x1080 monitor with 8x16 pixel fonts) which is getting
> >>> close to the limit. Monitors with higher resolution are not uncommon
> >>> these days (3840x2160 producing a 480x135 character display) and it is
> >>> just a matter of time before someone with, say, a braille display using
> >>> the Linux VT console and BRLTTY on such a screen reports a bug about
> >>> missing and oddly misaligned screen content.
> >>>
> >>> Let's add VT_GETCONSIZECSRPOS for the retrieval of console size and cursor
> >>> position without byte-sized limitations. The actual console size limit as
> >>> encoded in vt.c is 32767x32767 so using a short here is appropriate. Then
> >>> this can be used to get the cursor position when /dev/vcsa reports 255.
> >>>
> >>> The screen dimension may already be obtained using TIOCGWINSZ and adding
> >>> the same information to VT_GETCONSIZECSRPOS might be redundant. However
> >>> applications that care about cursor position also care about display
> >>> size and having 2 separate system calls to obtain them separately is
> >>> wasteful. Also, the cursor position can be queried by writing "\e[6n" to
> >>> a tty and reading back the result but that may be done only by the actual
> >>> application using that tty and not a sideline observer.
> >>>
> >>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> >>> ---
> >>>    drivers/tty/vt/vt_ioctl.c | 16 ++++++++++++++++
> >>>    include/uapi/linux/vt.h   |  9 +++++++++
> >>>    2 files changed, 25 insertions(+)
> >>>
> >>> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> >>> index 4b91072f3a4e..83a3d49535e5 100644
> >>> --- a/drivers/tty/vt/vt_ioctl.c
> >>> +++ b/drivers/tty/vt/vt_ioctl.c
> >>> @@ -951,6 +951,22 @@ int vt_ioctl(struct tty_struct *tty,
> >>>     				(unsigned short __user *)arg);
> >>>     case VT_WAITEVENT:
> >>>    		return vt_event_wait_ioctl((struct vt_event __user *)arg);
> >>> +
> >>> +	case VT_GETCONSIZECSRPOS:
> >>> +	{
> >>> +		struct vt_consizecsrpos concsr;
> >>> +
> >>> +		console_lock();
> >>> +		concsr.con_cols = vc->vc_cols;
> >>> +		concsr.con_rows = vc->vc_rows;
> >>> +		concsr.csr_col = vc->state.x;
> >>> +		concsr.csr_row = vc->state.y;
> >>> +		console_unlock();
> >>
> >> Makes a lot of sense!
> >>
> >>> +		if (copy_to_user(up, &concsr, sizeof(concsr)))
> >>> +			return -EFAULT;
> >>> +		return 0;
> >>> +	}
> >>> +
> >>>     default:
> >>>     	return -ENOIOCTLCMD;
> >>>    	}
> >>> diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
> >>> index e9d39c48520a..e93c8910133b 100644
> >>> --- a/include/uapi/linux/vt.h
> >>> +++ b/include/uapi/linux/vt.h
> >>> @@ -84,4 +84,13 @@ struct vt_setactivate {
> >>>    
> >>>    #define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a
> >>>    console */
> >>>    
> >>> +struct vt_consizecsrpos {
> >>> +	unsigned short con_rows;	/* number of console rows */
> >>> +	unsigned short con_cols;	/* number of console columns */
> >>> +	unsigned short csr_row;		/* current cursor's row */
> >>> +	unsigned short csr_col;		/* current cursor's column */
> >>
> >> Use __u16 pls.
> > 
> > I beg to differ. Not because __u16 is fundamentally wrong.
> 
> Fundamentaly wrong -- for what reason? These types are exactly what should be
> used in userspace APIs instead of bare C types.

Sorry, I meant "__u16 is not wrong fundamentally but..."

> > But
> > everything else in this file uses only basic C types already and adding
> > one struct with __u16 would look odd.
> 
> The whole file needs to be fixed, eventually. It's no reason to add another
> bad entry.

Nothing is actually _broken_ now, is it?

> > And adding some include to define
> > that type would be needed since there are currently no such includes in
> > that file currently, and that could potentially cause issues with
> > existing consumers of that header file that didn't expect extra
> > definitions, etc.
> 
> On one side yes, on the other side, sticking with ancient coding style while
> being afraid to include basic headers would be moot.
> 
> > So I think that such a change, if it is to happen,
> > should be done for the whole file at once and in a separate patch.
> 
> Let me bite the bullet and send something. (Likely on Mon -- now queued up in
> my queue for build tests).
> 
> >>> +};
> >>> +
> >>> +#define VT_GETCONSIZECSRPOS 0x5610  /* get console size and cursor
> >>> position
> >>> */
> >>
> >> Can we define that properly as
> >>    _IOR(0x56, 0x10, struct vt_consizecsrpos)
> >> ? Note this would still differ from "conflicting":
> >> #define VIDIOC_G_FBUF            _IOR('V', 10, struct v4l2_framebuffer)
> > 
> > Similarly as the reason above: given that no other definitions in that
> > file use the _IO*() scheme for historical reasons, it is preferable to
> > follow what's already there to avoid unsuspected confusion. The VT layer
> > is pretty much unlykely to grow many additional ioctls in the
> > foreseeable future so I'd lean towards keeping things simple and in line
> > with the existing code.
> 
> I tend to disagree. We should not follow bad practices only because they are
> already there.

Sometimes it is better to leave things as they are, especially when 
they've been static and stable for so long, as disturbing stuff in the 
name of removing "bad practices" may bring unforeseen consequences. 
Perfect is the enemy of good 
(https://en.wikipedia.org/wiki/Perfect_is_the_enemy_of_good).


Nicolas
