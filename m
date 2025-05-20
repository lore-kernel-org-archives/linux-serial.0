Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D172248895;
	Tue, 20 May 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758883; cv=none; b=IpgQ6z+YdN6fxr/or2YN7X8lmhIpvMmtR4PyaUX7vS3u1ifIWSkwVG4PuHC0L5p9HV9t4WmpxXiyQeG1uKV3fKs+rO9OPRchAqH2tvdn/+dxxMqw4hiu2cJKU2xwEm9YqlfnRk9PDAMwU01mQNacHNAUUYOjJUVRoocoT0O26nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758883; c=relaxed/simple;
	bh=P2O37HzNh0Nda2elBwcK/r/ztmkVrVoMjJoyPLYWE04=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VcTXMA/qpC2ytmx8uRBcHWMTBztlPP6hX04YKY6noXY4C5Xrt86+UrYqwzTIrDGGqCszMFVNIFFML+weCG2x4BCxIcVnDzzauunegjXA3CmDMFuQ6BGuNvaPBl0cTdpk7H9ojgEx0dj8pYrfns/R97uzX/S9fbccEOxOipe7W9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=kNbZy5an; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQN6erTe; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="kNbZy5an";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQN6erTe"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47DAE1140116;
	Tue, 20 May 2025 12:34:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 20 May 2025 12:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1747758879; x=1747845279; bh=QnFTV+24z4
	RnwaKMJjOmGrH2cprdkqCWnr/+fNT7CHA=; b=kNbZy5anszPa/LXxo0OCr3hdCo
	Im88AN+u1xZTgpm4BWMgs/4/Iokt7C1CwThFHmFP2o7WgzdHV6X8hW4crt/O5da7
	0rA5+70/7YDrGXys66jJNJ4M0roXzzYuYEkPQhPBbltAYJkIg2/qIOUiGcS/HAQd
	UW2fQF6Pfe51d36uES62JGt0CGv3Olrx0WIMnz6ytI+BtuLEDWhSSo3n6xKqTvM9
	XzgbfXsnM9fPYUnWpcuzB4BWqTvbx5cduD18mAq64YqHDF9Yh7ma2TVPNJrGG31z
	lBSbzaRg1inVlJbHMgxHzf7U6NwlCDNAOi0KwYS0QiAcxrohE3wh9iMCcfIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747758879; x=1747845279; bh=QnFTV+24z4RnwaKMJjOmGrH2cprdkqCWnr/
	+fNT7CHA=; b=aQN6erTe2q7U6T4Avgg+5XPNpDTiNk+uZio/0RGFzt1DhSVyG6E
	Njha/w5QnZ5sSmgDLd0iMBVra0QEt/XYEqA/6XP0lGGH6VXdIqlINfu/l8aGYp2n
	RhvjsRGhopPXAIO/9nvIAvyye5jGjJS2K4jcgDGuIpCkQxVKHQjyMut/SRiSbgkQ
	VNmSjBnU2RwNe8dPPoruaNhvi9OoIwWMTj1pHb1bY5+Vtnx/RI5sgsdplpG/BO9N
	UhZbzmlO3UGMc2AZKsm/osnbvypwMRdKA0JFFdshDDRWM7s1hIrqcyLvvps8lCae
	RLJ1Q9xz7+IclzkNKPJceGf/DAfYiWv/8tQ==
X-ME-Sender: <xms:H68saLWB0cgtzKFzCX7fT75TcuWrKVGsfkR3eS2HX08l8vrl1tbk2Q>
    <xme:H68saDn0joy_67idtBBDsF4KAHYJEYzVjbs1Fa72w9mxmCcAaq-pBbP0qE5-AOSKi
    Shh_tYXmAjagvzda3I>
X-ME-Received: <xmr:H68saHaKNdJWvMcUdD4MgZ1F9uKoogxaPSi_fOpo2JaEUNLhVri0p3rCp797rtTp_zNeJdbWjLmxDiwYOxfODRVURxsUz4ucBPE9G8TiV0_Jn0Oy4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejudculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefujgfkfhgg
    tgesthdtredttddtvdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtoh
    esfhhluhignhhitgdrnhgvtheqnecuggftrfgrthhtvghrnhepgfevvdfhfeeujeeggffg
    fefhleffieeiuddvheffudehudffkeekhfegfffhfeevnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvght
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjih
    hrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhi
    nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghr
    ihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H68saGVk3dhVGf3Ii5grgm3jY8h5e8HFNSo7CKdGjzPe4X0tRgySUA>
    <xmx:H68saFlB1p1MuBgZAaCN1PZY-6Z_l7aNmw32LswM__UQI3BYBABC7w>
    <xmx:H68saDdl4p9Sc8wNZ7SfnrE8sOevCt20GC3s855pcgRaSYi2SgOR4Q>
    <xmx:H68saPETpu3mg3Ta_esOyUm_E1QlVuqeTIxhcQA4UdwuxxjY3ZGbow>
    <xmx:H68saFaRGSFxsZToI2eOpBy7ETVHzoTV9MYInx2u2GikcbiuCrplVpVc>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 12:34:38 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 4C18111B0C33;
	Tue, 20 May 2025 12:34:38 -0400 (EDT)
Date: Tue, 20 May 2025 12:34:38 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jiri Slaby <jirislaby@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vt: add VT_GETCONSIZECSRPOS to retrieve console
 size and cursor position
In-Reply-To: <3o3q5896-8540-nro6-534o-307nn81r7r5r@syhkavp.arg>
Message-ID: <p7p83sq1-4ro2-o924-s9o2-30spr74n076o@syhkavp.arg>
References: <20250514194710.6709-1-nico@fluxnic.net> <20250514194710.6709-3-nico@fluxnic.net> <8fb2c16f-0e9b-402d-a7f2-4881de8c7bd9@kernel.org> <3o3q5896-8540-nro6-534o-307nn81r7r5r@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 May 2025, Nicolas Pitre wrote:

> On Thu, 15 May 2025, Jiri Slaby wrote:
> 
> > On 14. 05. 25, 21:42, Nicolas Pitre wrote:
> > > +#define VT_GETCONSIZECSRPOS 0x5610  /* get console size and cursor position
> > > */
> > 
> > Can we define that properly as
> >   _IOR(0x56, 0x10, struct vt_consizecsrpos)
> > ? Note this would still differ from "conflicting":
> > #define VIDIOC_G_FBUF            _IOR('V', 10, struct v4l2_framebuffer)
> 
> Similarly as the reason above: given that no other definitions in that 
> file use the _IO*() scheme for historical reasons, it is preferable to 
> follow what's already there to avoid unsuspected confusion. The VT layer 
> is pretty much unlykely to grow many additional ioctls in the 
> foreseeable future so I'd lean towards keeping things simple and in line 
> with the existing code.

OK... I found precedents for a mixed sheme in 
include/uapi/asm-generic/ioctls.h. Therefore I give in.


Nicolas
