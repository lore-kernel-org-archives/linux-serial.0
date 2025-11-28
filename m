Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383AA2C0F8F;
	Fri, 28 Nov 2025 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764309188; cv=none; b=hdYT94x/xPhvZPtG3eWozT5RC52QUn1kyA4QoiGxP0n57SSdUY8JTt3BLNyVyL0+XFNH1IJh79y3s5TgNSljwS0opLLAogz6VQJt03aExG9aw6Ac9J3BBmtv9jZKGE+vPJRGmk1A5Kf+boxHmeNrqRPcYU1sDL8NOdHIGR5ODBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764309188; c=relaxed/simple;
	bh=sJNE2EqQudNagDwT3Ypqk6yAIXr51FigU3Oyf0BdWoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xhbm5Tusx4wQZjTeCc/Gz/xTVwrW/UtdTQKHGgdqw4Mz3sknaw/gT2U6RzqvrqtD3a7J0iWbHjOxGWt9W6BfmEX2iY/2AeVMU25AEuUqC+yxH602zV5mv4CKQTPGA2iJEsmhy7RM7LTuefZd7ki+5Txjsg18YZctrYmQv6Hyi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCSSY75y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCSSY75y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48709C4CEF1;
	Fri, 28 Nov 2025 05:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764309187;
	bh=sJNE2EqQudNagDwT3Ypqk6yAIXr51FigU3Oyf0BdWoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCSSY75ySualVp9wBNgXvvKLuS2BSTX5ytSYtZe0YgcNmAPcIrVRfY553O65O9OEw
	 K3oDE26LaWPtGvTIl0WcGjW9v91M4KJPrHfxMYP9LVuMIIrLxpjbDWhCsF7K/MNPGI
	 bY8AoNZpm7MjduStHW7SqvEt5ErjRSpVuBoF1AkY=
Date: Fri, 28 Nov 2025 06:53:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "zhiyong.tao" <zhiyong.tao@mediatek.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Digits_Upstream_Group@mediatek.com,
	liguo.zhang@mediatek.com, Vasanth.Reddy@mediatek.com,
	Yenchia Chen <yenchia.chen@mediatek.com>
Subject: Re: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Message-ID: <2025112812-encounter-breath-8948@gregkh>
References: <20251128021850.3459387-1-zhiyong.tao@mediatek.com>
 <20251128021850.3459387-2-zhiyong.tao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128021850.3459387-2-zhiyong.tao@mediatek.com>

On Fri, Nov 28, 2025 at 10:17:56AM +0800, zhiyong.tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>

Please use your name, not your email alias (i.e. drop the "." from the
name portion.)

> Add ACPI support to 8250_mtk driver. This makes it possible to
> use UART on ARM-based desktops with EDK2 UEFI firmware.
> 
> Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 5875a7b9b4b1..e6a56cf54ae0 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -19,6 +19,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> +#include <linux/units.h>

Do you also need to update the Kconfig dependencies?

thanks,

greg k-h
