Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0E739282B;
	Wed, 18 Mar 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843561; cv=none; b=ctk7FqVfEbD2/RaJE91QkOVJE9lgKLANz4wIBEy5kK95MfaEWL00hK94SY/U6QeoDW5TzW96V00L/R33vg1whmn1C2fKjP0zr/pX8yidZZbdIz0Avqj7SVrRXGMFjMp+d/HltxUgKgddNyduoefp6UU80tYqDLE6y1iQyUEvUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843561; c=relaxed/simple;
	bh=pL+9AgAL3F3wRdPCa1QHTuK609k/1f2ZWXG3gFuWVY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIBVRmYmBq2bYVS887JkKqdohttqUpHfp79FktadEY3QA0PjPQ3qC+Wf72ugUPBZNWXWq2JcgfnslAo3z5VyjRrcc5yW7zpqpCN2azV+Z18yOF09g1OuXI04xGbTC6L1zyjlupjcU12kJAZ4LszltwgojERljSwlE+m4Rh+zVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZhaMIifP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZhaMIifP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06A3C19421;
	Wed, 18 Mar 2026 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773843561;
	bh=pL+9AgAL3F3wRdPCa1QHTuK609k/1f2ZWXG3gFuWVY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhaMIifPFwUHxTAEClEjhWsFQcrgE2R4GXTqotwrcKE6CEPnVIq49gX8JLo3S9uSd
	 J5/G1kwmw74trSok0ANAT/+34bMR/39Lcrnrq2f7xWnz93cezeKVnAMI2MYC4tqmaR
	 nJg2BffI1I/l4lRG3IF639GaCiUERhKaKl3E72JY=
Date: Wed, 18 Mar 2026 15:19:16 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Zhiyong Tao =?utf-8?B?KOmZtuW/l+WLhyk=?= <Zhiyong.Tao@mediatek.com>
Cc: Project_Global_Digits_Upstream_Group <Project_Global_Digits_Upstream_Group@mediatek.com>,
	"fred2599@gmail.com" <fred2599@gmail.com>,
	Yenchia Chen =?utf-8?B?KOmZs+W9peWYiSk=?= <Yenchia.Chen@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Vasanth Reddy <Vasanth.Reddy@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Liguo Zhang =?utf-8?B?KOW8oOeri+WbvSk=?= <Liguo.Zhang@mediatek.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Message-ID: <2026031837-slimness-playset-a62b@gregkh>
References: <20260105024103.2027085-1-zhiyong.tao@mediatek.com>
 <20260105024103.2027085-2-zhiyong.tao@mediatek.com>
 <2026010643-ladybug-tiring-7f3c@gregkh>
 <434e34f05bb5f87b59402811012e3a2f56f2182e.camel@mediatek.com>
 <6478a71ffca65e58fa19a5edbc25eb5f51a8cc12.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6478a71ffca65e58fa19a5edbc25eb5f51a8cc12.camel@mediatek.com>

On Wed, Mar 18, 2026 at 12:12:36PM +0000, Zhiyong Tao (陶志勇) wrote:
> On Wed, 2026-01-21 at 14:23 +0800, Zhiyong Tao wrote:
> > On Tue, 2026-01-06 at 11:02 +0100, Greg KH wrote:
> > > On Mon, Jan 05, 2026 at 10:39:55AM +0800, Zhiyong Tao wrote:
> > > > From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> > > > 
> > > > Add ACPI support to 8250_mtk driver. This makes it possible to
> > > > use UART on ARM-based desktops with EDK2 UEFI firmware.
> > > > 
> > > > Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
> > > > Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_mtk.c | 23 +++++++++++++++++++----
> > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > 
> > > This is a resend of the previous version, right?  Or did something
> > > change?
> > > 
> > > confused,
> > > 
> > > greg k-h
> > 
> > ==> Hi Greg,
> > Yes, previously Yenchia Chen helped to send out a version. Currently,
> > this solution is specifically for the GB10 project and was made to
> > support Windows ACPI settings. 
> > 
> > In actual application scenarios, the apdma clk will not be turned off
> > in normal mode. It is only turned off in the SSPM microprocessor
> > after
> > entering standby, and when resuming, the apdma clk is re-enabled by
> > SSPM.
> > 
> > As for other Linux projects, apdma still uses the DTS node.
> > 
> > Thanks
> > 
> 
> Hi Greg,
> Do you have other suggestion for this?

You can't just resend something and not say why you are resending it.
Also, the authorship information seems to be backwards.

thanks,

greg k-h
