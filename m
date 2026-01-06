Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894C30DEC8;
	Tue,  6 Jan 2026 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693724; cv=none; b=dQx2e/HvwHXZFC3g4EG9Of3iMyv5UoMxOTR8HqYCO09bfWThMSiJtBkfMhyP+Zz/AP3ISihrgu6hxQt1i7XfdNAREgSvwXK2meH2/oKYiKLps8fmmWewUsqeAzmah9B5IOdFq3NFWvNd0yYA/bTcvRQcFXTBs7vEipgTutSYqkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693724; c=relaxed/simple;
	bh=j1gUdKmv3XuJj6LFBGkTEJLtEAa3uiiwtVctcrQmZ2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxnefnGSSe44xdZbK1nt45ClovEgSwards/rhN/VmXCMkBgYScF/buKoWKVJeCsGcN43kPS241jxTfx8OBNHZzcCMfVwUA3aJTa1mC6ODVz4fINFwgv65Z875VHQsrrX5PbGCOFugYnAgxxkXc37TxZ0DABj3Muvqo6DL+gsO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OHg35A2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OHg35A2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B692C116C6;
	Tue,  6 Jan 2026 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767693724;
	bh=j1gUdKmv3XuJj6LFBGkTEJLtEAa3uiiwtVctcrQmZ2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHg35A2cTOmiu4D+xyXdaYjYdPwenE7p5dv5Z/wEeSS5MhiimugcUswAmK5dhUeQP
	 iaSFiG3xHl1nc6FAk2J31iBlehdnYPZPLwlbFnaCOmbnEHgEXjnQwewAgJBlII0KdO
	 SHaaRDACENjSgKg7SNYisEtDJC+N/U6xeyQ7xhjM=
Date: Tue, 6 Jan 2026 11:02:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: jirislaby@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, fred2599@gmail.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Digits_Upstream_Group@mediatek.com,
	liguo.zhang@mediatek.com, Vasanth.Reddy@mediatek.com,
	Yenchia Chen <yenchia.chen@mediatek.com>
Subject: Re: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Message-ID: <2026010643-ladybug-tiring-7f3c@gregkh>
References: <20260105024103.2027085-1-zhiyong.tao@mediatek.com>
 <20260105024103.2027085-2-zhiyong.tao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105024103.2027085-2-zhiyong.tao@mediatek.com>

On Mon, Jan 05, 2026 at 10:39:55AM +0800, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 
> Add ACPI support to 8250_mtk driver. This makes it possible to
> use UART on ARM-based desktops with EDK2 UEFI firmware.
> 
> Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

This is a resend of the previous version, right?  Or did something
change?

confused,

greg k-h
